Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD350C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E9E2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIL0GvhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E9E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEje-0003VI-M0
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihEiz-0002vc-2l
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihEix-0000Fj-CL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:25:24 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihEix-00007K-67
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:25:23 -0500
Received: by mail-oi1-x244.google.com with SMTP id a67so5644639oib.6
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O1r3TUAOg93CqYB/EqAX5MDLFd3UQVOc322Wa0FEsFo=;
 b=eIL0GvhZlsZfWhCqXhOuOjIlI/H1KiFYYdsdfwqzsfTSkLm/nMGu4AmJLRBQ93oh4F
 NjWewEWYr9bXQHGC5ETYFY7YpnfYDpW321rVzuRvAIpscY+Y/i88jAHlWIC3yZIXmAsh
 uReP53ITxTynhp93oBw0xr4QWNHDA+R3HYdSUXiQatErkfxq/FmNgjYBr4UaLEZsPKYh
 JmNV82E91rGRa5Adb6cMqzn9D3Zlzpk+rGblS7+Of7KUfmyhHCpEzLGBoh68jTMf5o9e
 9Hzh4wTlin/5V51LBqX1AVQW/HyWTupfmYrGGj9ikF/R1YTuVDBqgSmWjOaV4iSCWwCB
 T4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O1r3TUAOg93CqYB/EqAX5MDLFd3UQVOc322Wa0FEsFo=;
 b=ELRiWo82dEMV3ntoth4w6OE3dun9ihCD6cLJFYJ42N7BQahSPweubhAL215Hah7kFR
 yzS+7vv1fS4f4xiom0H1os2z/NPy+HFySGJMwYIk4DeLKLKSd7TfyxO1S42BAQsBi/0J
 BBi66s/212+QufIRxitXebeD0VAA4aRQ7CiUlzsK1iGl/eXoBEox0MjOcRX4lAy1Gtxh
 l/BuxK1IQXaZdKkoxNPmiVkGO+Xp41AqZ8s7LJQKOMCMzh38m0IndNEJMpGLPwihKxDh
 txrcNincdnE9NX2dT7ONx4vOU+2bG/1JjpB+9Lkawt+ADT5WbjaaF3ibTQB2EJDiLyyd
 hgSg==
X-Gm-Message-State: APjAAAVhooPybpsRCoJ08YrcKOsSatDsjHvqFByWf67ja/HDeH9Z+tQT
 JvYC2Q9OoG4yb84AUak5krTcz6Q9mjD6sbaej3Finw==
X-Google-Smtp-Source: APXvYqzB0L7+zB5wZq+qzxFGi71HyTkNBnmrBXnv95tupDZwv3uCZSD/pAuvxBU6/h0ku3PA2dxE29PlgH0cGzqtzOY=
X-Received: by 2002:aca:3182:: with SMTP id x124mr1903142oix.170.1576596321508; 
 Tue, 17 Dec 2019 07:25:21 -0800 (PST)
MIME-Version: 1.0
References: <1576509312-13083-1-git-send-email-sveith@amazon.de>
 <e0a55905-e76e-40d2-3d9b-06ea5b917001@redhat.com>
In-Reply-To: <e0a55905-e76e-40d2-3d9b-06ea5b917001@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 15:25:10 +0000
Message-ID: <CAFEAcA9PcjQq_0b+ho70ydn4gew7xE3o3CeSvdW19v5WdkeJow@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] hw/arm/smmuv3: Correct stream ID and event address
 handling
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Simon Veith <sveith@amazon.de>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 10:04, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi,
>
> On 12/16/19 4:15 PM, Simon Veith wrote:
> > While working on the Linux SMMUv3 driver, I noticed a few cases where the QEMU
> > SMMUv3 behavior relating to stream tables was inconsistent with our hardware.
> >
> > Also, when debugging those differences, I found that the errors reported through
> > the QEMU SMMUv3 event queue contained the address fields in an incorrect
> > position.
> >
> > These patches correct the QEMU SMMUv3 behavior to match the specification (and
> > the behavior that I observed in our hardware). Linux guests normally will not
> > notice these issues, but other SMMUv3 driver implementations might.
> >
> > Changes in v2:
> >
> > * New patch "hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value" added
> > * Updated patch "hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE"
> > * Updated patch "hw/arm/smmuv3: Align stream table base address to table size"
> >
> > Changes in v3:
> >
> > * No changes, but sending again to correct a patch submission mishap that
> >   confused Patchew
> >
> > Simon Veith (6):
> >   hw/arm/smmuv3: Apply address mask to linear strtab base address
> >   hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value
> >   hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE
> >   hw/arm/smmuv3: Align stream table base address to table size
> >   hw/arm/smmuv3: Use correct bit positions in EVT_SET_ADDR2 macro
> >   hw/arm/smmuv3: Report F_STE_FETCH fault address in correct word
> >     position
>
> The series looks good to me. Also tested against non regression.
>
> Tested-by: Eric Auger <eric.auger@redhat.com>

Applied to target-arm.next, thanks.

-- PMM


Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E4C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E6A2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHHXGiKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E6A2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRJ5-0006iv-Og
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfRHa-0005P0-GR
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:57:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfRHZ-0004R2-D6
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:57:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id x202so6559640oix.11
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=an4idvbVjxKI9oDVrr7PyWEyI+EJXYh/iGRBCr2J3zI=;
 b=UHHXGiKaeHMEQRTNyTaTEm62Bxft7/4rB50b+pVVKsWhxEOkit9BhppUCpzqdYePDI
 mlXZd35TQbPlgNEMT6RzcZwxf786V/ksRwdurEDDQhwEmInsYpwV43q47Ds6PIxmNNN4
 ZDxGYUzbrAkhP5igo1APer+Hbrf525TQ5urDZLKBnZmsIzu7wkGTTF9vgDnvoxyYx5Kg
 AdEBQACNcL0JNJKy50tfu9jF5tSAHRxSi85wx9cIXnaqyDP7Umq9Kse9jQyV5N7CfEte
 oWuYaJtx2AkxIBh+MfszYxyctA6AtLjekwvPAFeUqLHhnw6aCOCmGEIyXA60c1anrj9W
 CR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=an4idvbVjxKI9oDVrr7PyWEyI+EJXYh/iGRBCr2J3zI=;
 b=F6nWFiDHZmn/y/+T4nS+v9DWIYbYXEMdX064lxTVFSTyFfHtdPhIMV8s3i67c9mHra
 lT4isJ3msnKuFCiMyrfaxwyjgMaFRgu+PC/f2GtEzIyGnDLyY9dD0rSCbbw7/wCuIaJj
 hT94t1lAN2z5b9YhJLwdmIV/AtsDE2topJR2kbEVljcBGzPyDkhijNNJVS3rRryRuQFt
 lqJsbHCTxOXtg0O1ZEApJPhN2aOw2MEERsMyvpQqEAZH45rtau1TAACXN2zmpPlvoPyt
 9RXxI2NYeEs4Ksk/9RkLBG12fy3fpLBoE+4ZEEltIWr4H0temWgGa+ebhUKN8xOeR3T6
 cGLA==
X-Gm-Message-State: AOAM533NwoC74Z+eOtM8FazXDy1c3ppIgm/H86WI0lPtILFh7zag/qpt
 nGfsaPJmpZMD8K5CQzYmcmMC8sd8mnwT4RfWBB+EqA==
X-Google-Smtp-Source: ABdhPJw20m/dRDtTHyeCS/1NTC09r9isPGdzy5k0NSNmmBojPg7x1yO3GzrQeChSlRKsH9opD45YWJ/rxh/8PiAEJ+g=
X-Received: by 2002:a54:469a:: with SMTP id k26mr12032357oic.163.1590944275855; 
 Sun, 31 May 2020 09:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153016.2959-1-f4bug@amsat.org>
 <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
 <f1fd3384-8653-c2e2-7248-457ae873cc27@redhat.com>
 <CAFEAcA_BJf3k-O4j73kNaPtSHfhqmgtm9LH=nAmNj46kMjbkCA@mail.gmail.com>
 <d5ce42bc-a236-512f-dbbe-7327527419e0@amsat.org>
 <20200531164236.GF3071@jondnuc>
In-Reply-To: <20200531164236.GF3071@jondnuc>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 May 2020 17:57:44 +0100
Message-ID: <CAFEAcA95hfnjBjUT0hCxPUzBnGL9xKDkEjBqDcyVBD6spVZ_4w@mail.gmail.com>
Subject: Re: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
To: Jon Doron <arilou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 31 May 2020 at 17:42, Jon Doron <arilou@gmail.com> wrote:
>
> On 31/05/2020, Philippe Mathieu-Daud=C3=A9 wrote:
> >On 3/30/20 6:41 PM, Peter Maydell wrote:
> >> PS: do we have any documentation of this new command ?
> >> ab4752ec8d9 has the implementation but no documentation...
> >
> >Jon, do you have documentation on the Qqemu.PhyMemMode packet?

> Hi, there is no documentation for this mode, but in general the idea was
> very simple.
>
> I want to have GDB the option to see the physical memory and examine it
> and have this option toggled.
>
> This was useful to me when I was working on nested virtual machine and I
> wanted to examine different states of the VMCS12 and EPTs.
>
> I used this in the following commands:
> // Enable
> maint packet Qqemu.PhyMemMode:1
>
> // Disable
> maint packet Qqemu.PhyMemMode:0

docs/system/gdb.rst would be the place to document QEMU-specific
extensions to the gdb protocol (there's an "advanced debugging
options" section where we document things like the single-step
stuff you can also change via 'maint packet').

thanks
-- PMM


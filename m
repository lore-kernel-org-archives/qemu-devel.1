Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C19C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97AB2467B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/7fV+kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97AB2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwObf-0006Ae-0P
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iwOaS-0004mN-7W
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iwOaR-0000qm-CV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:59:16 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iwOaR-0000qE-6I
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:59:15 -0500
Received: by mail-oi1-x242.google.com with SMTP id j132so8781870oih.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 02:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pf7eaZKLcykzv5YZVmlfAWZvxYouEa7qWG2IX0om23c=;
 b=u/7fV+kEc4082Xu/zXeBLxbhysD+bJv4HsWcQ2+Fn2havJmtvFrLBcGtEn2M/7dBPl
 6W25JVEHawF9/KsmriQyjzuPAAS2edFOkO4rzAH5BdLtVm/F7pdOZVNkhr9IxjuYo4xp
 lCQmV3G+vDxdFoQy1btFrTpmms6LILufC9MZ94lOZZ42ljR9vdjbuOw3N8xwGldSEty6
 lT5zlr/ce3vPb0kuKD+CRiwE8R4mDmZoYroiUf2hRjEVBcj1lByoEcBORnEsSjo2oaMN
 pjVWQ8OOtFk1UfyFuv7LWDZ91lznED9NX+weWsB0/4FXRlM89VsF3OJurOZ5qi6SeGpN
 266A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pf7eaZKLcykzv5YZVmlfAWZvxYouEa7qWG2IX0om23c=;
 b=nLmQVCnjSEkr93B6+nLiXT57ckT4DpL1H5ACE6RIKodT1Vx1sdrVpsg51OmCtHrEAA
 99H6IY8TzaAlY9E6RPzKuLZZU8GCuk6+gqaVc8730/EHb0u38wC1T0nKJbgkG7IR/Uy3
 lI9xmo9rZfQzNA8Y/T5jnj61HjzUAMvBExojMgGLPI/J0GVFjYeVvovKywJmn81WHu1F
 5gDpfgpoGdG4xcI4S2A+k3/56EqKuCvpFYYJJNG5SUZ2bTxv64mg8/nPbFbRVCalKlmX
 BsxikntIYfbW2fh6O4PIcAmrgryh/0KiLWv5SM1kC3oLSvd5hBk0xZcm0Je0tPRjSilX
 fEKA==
X-Gm-Message-State: APjAAAVf+FjOAx9ZNlrtxHrY+80Su2vUrWGkbgl5GvaA1KwGSTX8tu6w
 yerTEg2pqQ/NKjrBEvcPptLdNUcKH0Zyxkmk6C/n+g==
X-Google-Smtp-Source: APXvYqzl1M4z38mzLP9AqMmQGHlABQG0t5TqHhTQAjuwxYaYfceusIP3xA/K4zLHM/kcdWKNpXtWBMGqyS2QnTAmzX4=
X-Received: by 2002:aca:3182:: with SMTP id x124mr2461998oix.170.1580209154191; 
 Tue, 28 Jan 2020 02:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <1b718429-c74e-fbac-84b8-379f3291db40@redhat.com>
 <ff78ed012e7b8fbd656e7e4b477ee0a4@kernel.org>
 <3ae0557c-c289-8a23-d62f-3dc2a12c0623@redhat.com>
In-Reply-To: <3ae0557c-c289-8a23-d62f-3dc2a12c0623@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2020 10:59:03 +0000
Message-ID: <CAFEAcA92URHhhm8TiGqijig_jM1=94PZz5Ptmfg1JrWSP7mSHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Andrew Jones <drjones@redhat.com>, Gavin Shan <gshan@redhat.com>,
 jthierry@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Marc Zyngier <maz@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 at 10:56, Auger Eric <eric.auger@redhat.com> wrote:
> On 1/28/20 10:25 AM, Marc Zyngier wrote:
> > You *could* try something like SDEI [1], but that's a pretty terrible
> > interface too.
>
> Thank you for the pointer.

There was a patchset recently that had an SDEI implementation,
but I would strongly prefer not to have QEMU itself take
on the job of firmware API implementation, and the facilities
provided are somewhere between awkward and impossible to
implement from within a guest firmware blob :-/

thanks
-- PMM


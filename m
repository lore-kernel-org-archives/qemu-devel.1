Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD998C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE9920732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhWKFNZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE9920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9xVu-0004b9-SX
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 15:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9xV6-0003WW-58
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9xV4-0003h5-Nq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:53:47 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:44497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9xV4-0003gh-H0
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:53:46 -0500
Received: by mail-ot1-x333.google.com with SMTP id v22so237797otq.11
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 12:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ovRJuS5lpqzO2I3RYDpFkTFNY68Ypwj0SYNGuuBtE80=;
 b=UhWKFNZOHcz+UoQx8eGOLIHWhqYPKMZAS0Z/uKqHMeavGLSjMeQHTcj4QUQuFWLnHB
 BqXD8uHmQHpbbejAdH+1npYCt4p+2RDgxRIsl9W08C65iS6rK5g9keJ8xWtnOpUQPUxu
 VyuYP+iLUNLc1CJ47tBMCpld8+P6IZrH7LeNRgBuvCQBq3xsja0LSADVQ1YtZj2U9l6M
 bDkz3zkKUZLFN12p2fDUA1K4Jk2PcBLhtDOYT/FBbJNwXJ/9GYR66J4loKt3Wic3lm5L
 feHBMvgWdtRqX0GFrIr3PvsvgHaiuT2WDThJg5uyvilSVumPMoOXKkq8ensfi5x5OSDD
 57bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ovRJuS5lpqzO2I3RYDpFkTFNY68Ypwj0SYNGuuBtE80=;
 b=sPCnnYsrCmrv6RASURFjYsGS2QRZ19TgbxBLRhwWVQNzaX88cGlyPr9g/xEiaqo/it
 rQlyWhKti+YNcGarIebzoMA/WC3qIcgIKCkojUITLrjLacyWWJw+7i6+NA6IPJlfv17H
 7dUDRV2oRTGQaSHKNeFO9aQMmJryq8gbNPcEMCgGghTd+nVFCNvwZnw73c329kjvvdyp
 1mppP6j7m6SoHPd68nDNv7yDh/n9e6rCO3OGhnS/V1n7z3JjFhxqs+3nEaySG8P/Rf+g
 s7j8PJPofSGXt+LiRE4W2mDnI0ofEpMXARWGkMFOU17rHQZ80oLtFX+AzmZMZP/iynow
 jFew==
X-Gm-Message-State: ANhLgQ1hdNSZZZeRLljXk7hkvXBG7mmFOCgw0FOWyU95YJkzaHtKmGi4
 RhSf5PgfqIRLk3ynITElt9Pm8ZDJhb0YAtJHCxs82w==
X-Google-Smtp-Source: ADFU+vtO9SpYIyQVavJKPpW8FhVbc/O1O1Ou6xgnto6D94tYfgxnJn6K6KaRmZZLkeF96xri8ciDNDHhezOGLwzb6Ds=
X-Received: by 2002:a05:6830:1406:: with SMTP id
 v6mr318276otp.232.1583441625394; 
 Thu, 05 Mar 2020 12:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 20:53:34 +0000
Message-ID: <CAFEAcA--mFrS-kryyx6=4Q77fGRY+NwjEA52F=0Wevu54JOxTg@mail.gmail.com>
Subject: Re: [PULL v2 00/10] Merge TPM 2020/03/04
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 at 19:38, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> This series of patches adds support for TPM on ARM.
> This PR is based on v5 of Eric's series.
>
> Regards,
>     Stefan
>
> The following changes since commit af4378c39e54705d9b585089de80aae9526ac7e7:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-03-05' into staging (2020-03-05 15:18:19 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-03-04-2
>
> for you to fetch changes up to fe985ed6837ac6169ab9673547115df2897bcf6d:
>
>   test: tpm-tis: Add Sysbus TPM-TIS device test (2020-03-05 12:18:47 -0500)
>
> ----------------------------------------------------------------
>
> Eric Auger (10):
>   tpm: rename TPM_TIS into TPM_TIS_ISA
>   tpm: Use TPMState as a common struct
>   tpm: Separate tpm_tis common functions from isa code
>   tpm: Separate TPM_TIS and TPM_TIS_ISA configs
>   tpm: Add the SysBus TPM TIS device
>   hw/arm/virt: vTPM support
>   docs/specs/tpm: Document TPM_TIS sysbus device for ARM
>   test: tpm: pass optional machine options to swtpm test functions
>   test: tpm-tis: Get prepared to share tests between ISA and sysbus
>     devices
>   test: tpm-tis: Add Sysbus TPM-TIS device test
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


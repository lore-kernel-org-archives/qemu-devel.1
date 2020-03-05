Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D3AC3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E68320732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sitX/h2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E68320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rqs-0002CL-KS
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9rqD-0001jf-Hi
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9rqC-0006nM-8n
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:51:13 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9rqC-0006mr-2U
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:51:12 -0500
Received: by mail-oi1-x241.google.com with SMTP id q81so6242442oig.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 06:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fxwdOjBjS38OlXMnAcRZ7WqAHoHwUDf8jHd8hGD04BQ=;
 b=sitX/h2uZJbJGFEW8mk+0jlbi9O1cj2MWzJs4RyeAcCAhT4vbdhSui2dXtV/BkvcL1
 2yQ6TgfmzKfKBmvAEjwZGkKyERSOZVbjaR/RbyxuxgMwgtVcybvtRxrYsYJdsVFCVD5k
 hd3ePdeTsvxXUV0n+Niu4H7+yzCGAH+oY0dL3GY6qAK2UEb6OQT/Etxhw6GTjP2Mq/TB
 1ztprAnUF3zuEmz/y4gp0+BZdBoU4YRCg6c5ZLsH3uOM1LSYb5GodE/vMIN2M6TfV3Bv
 h5/0pGrvzaY0vtYZaIbxdyg+ImevS53T0iuzOJRU1d9R8+ebDaKZhSn6d/CS3fDbUaMc
 4vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fxwdOjBjS38OlXMnAcRZ7WqAHoHwUDf8jHd8hGD04BQ=;
 b=kXBMwm5yKlYwRc0goqmkrZJECgbPdOB92pjhj0dkNSLXeh4Fdm3uhqRPx8WQ0I0ZOB
 b7VFWea3oLtd56EpfZGsCFAjwg3IonRlU6wUkafiPczdXamJn5WrDbTIJ4i3PKLqoyMV
 v3TpEhANoMMgY2rkKpQpHIJHm6/KViSVY48AJqVMCBNZajz8YpuL0nmchvrF9NV3jGoq
 FsVAj3oOGtPZBONf+1UB26Z5gPMCmju5AWKkgTNnU5cU3TXTz6Gai2cR5L6GZmPYkjeW
 4G0X7HBAd0xIpPJjncB3EFDvHaskg32fG/BOfl9mzQi+Pg3uiV6oOlTWbsUG6ajnhX0l
 IonA==
X-Gm-Message-State: ANhLgQ0zcKLVkyNmxcMBw6ycsJYUMlMCNCEXooMngxhUPvN3qClyRDxf
 QGZEzMIcSs6SbIhzqIWZ4y3HIfPvb4a0yMkows377A==
X-Google-Smtp-Source: ADFU+vvfLYZzhmfAoSO2rxLPk3nlPET8YZSX2NIqXVj4/hDih+YBs6GlfA6aMI5/96C1nxELtMYC4bkgDtS21LFfVnA=
X-Received: by 2002:a54:4882:: with SMTP id r2mr655278oic.163.1583419871047;
 Thu, 05 Mar 2020 06:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20200304131214.179000-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200304131214.179000-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 14:50:59 +0000
Message-ID: <CAFEAcA9dW7MqCXYN6TvWiW_95BcC9K839Z=-an7hRYHvUvUJAg@mail.gmail.com>
Subject: Re: [PULL v1 00/10] Merge TPM 2020/03/04
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Wed, 4 Mar 2020 at 13:12, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> This series of patches adds support for TPM on ARM.
>
> Regards,
>     Stefan
>
> The following changes since commit 2ac031d171ccd18c973014d9978b4a63f0ad5fb0:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-5.0-sf3' into staging (2020-03-03 11:06:39 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-03-04-1
>
> for you to fetch changes up to cf5b8ff14b38eb93363364635df3a0e6aa8c74e5:
>
>   test: tpm-tis: Add Sysbus TPM-TIS device test (2020-03-03 07:29:09 -0500)


Hi; this fails 'make check' on osx hosts (possibly also elsewhere
but that's the first build to fail):

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64
QTEST_QEMU_IMG=qemu-img tests/qtest/arm-cpu-features -m=quick -k --tap
< /dev/null | ./scripts/tap-driver.pl --test-name="arm-cpu-features"
PASS 1 arm-cpu-features /aarch64/arm/query-cpu-model-expansion
qemu-system-aarch64: -accel kvm: invalid accelerator kvm
qemu-system-aarch64: falling back to tcg
PASS 2 arm-cpu-features /aarch64/arm/kvm/query-cpu-model-expansion
qemu-system-aarch64: -accel kvm: invalid accelerator kvm
qemu-system-aarch64: falling back to tcg
PASS 3 arm-cpu-features /aarch64/arm/kvm/query-cpu-model-expansion/sve-off
PASS 4 arm-cpu-features /aarch64/arm/max/query-cpu-model-expansion/sve-max-vq-8
PASS 5 arm-cpu-features /aarch64/arm/max/query-cpu-model-expansion/sve-off
MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64
QTEST_QEMU_IMG=qemu-img tests/qtest/tpm-tis-device-test -m=quick -k
--tap < /dev/null | ./scripts/tap-driver.pl
--test-name="tpm-tis-device-test"
qemu-system-aarch64: Device tpm-tis-device can not be dynamically instantiated
Broken pipe
/Users/pm215/src/qemu-for-merges/tests/qtest/libqtest.c:166:
kill_qemu() tried to terminate QEMU process but encountered exit
status 1 (expected 0)
ERROR - missing test plan


thanks
-- PMM


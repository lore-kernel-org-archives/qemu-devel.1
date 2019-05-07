Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B74C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 11:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E65204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 11:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRwTrMq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E65204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNxrw-0002Zi-8g
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 07:02:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNxqh-00023k-GU
	for qemu-devel@nongnu.org; Tue, 07 May 2019 07:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNxqe-0005YV-U9
	for qemu-devel@nongnu.org; Tue, 07 May 2019 07:01:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNxqc-0005Ws-4o
	for qemu-devel@nongnu.org; Tue, 07 May 2019 07:01:22 -0400
Received: by mail-ot1-x343.google.com with SMTP id g8so14447975otl.8
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 04:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=UlvYLBu+8+Kg11geN/1X2OLOgDY+iIcX2Bw2SSk28HY=;
	b=YRwTrMq8hnys72I+Hlv39aEW4hhIwggo/guZCrXYCbNiERvy33YoMfbUQWKRBWCDE0
	f9qdkXJ533st2EOcWgz9Gb8E/8Cw3REztSMLQkdzIv5gDGtB4iSE21tbuycDKBrG9HBt
	2bIMGJwCOl3VluST4AOv15WPMzI1hhCqCWXHX+ERllP98mqEInPMCps0SMQpMOMED54V
	lUrUetqhM6NHFG8SmMCWn8ejaZpI9xvDT7vDFoVIwleArM6g9NP7SZRc5B8aYqDBeUls
	eZmykUowAN8qzSHooKFTMOThomwZBwuEmgS1uVDNqf+5ttmSgVaUofoKdNOQmST7gHmx
	3lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=UlvYLBu+8+Kg11geN/1X2OLOgDY+iIcX2Bw2SSk28HY=;
	b=HYHRUNGbch1dB9bLCDBwumVDVn9YOL+f90gYSTweD6Ajzw+wLMX+Ny9Zycev3l+OlQ
	K+nRIY6kaEBWvjwLq1+pOKipOnD0jyb+dunrTPtz8gk9z83oCEJYSCRwSiOH+eN9WmKP
	MSTZcUNJ+6TbaFMocViSoetcNXtJ42I4l71jvv99rv6JUykvjPCBQ3NDD9cFgJAfEn+a
	BoTvIh2GqAgXVBA4snzuCeOc4KjiE8XWgNPICyfJMcAvGSHFL9lyTBvQEO3f/yYyHvQi
	xOiu5JkjBB28QkO/5N4VsAvrtWOwtq1XClkaH37zf/N0c5o/n4kKSfayMcDIR93Pr8z0
	EPug==
X-Gm-Message-State: APjAAAWVsg6FGFIaEIvJOHnWxCAcadmk3zUb9K+Ro6KlArhtNlFmReBA
	lfWke+a5HyMs5fVCraqYCzDSI+ymJQHw8dzWs9kx+w==
X-Google-Smtp-Source: APXvYqxce2dDznkQuar5jBY1uROmYcubk0HZQp8yXspp/pndicwY9MDjdid62Wjgu5nW+2W6Od6DXdaVHe4Zi9XYN3M=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr20561611otk.316.1557226878015; 
	Tue, 07 May 2019 04:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190505135714.11277-1-thuth@redhat.com>
In-Reply-To: <20190505135714.11277-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2019 12:01:06 +0100
Message-ID: <CAFEAcA_utmcMFAmaGL5CJm4erBg2dZWZpdGvETRqVukOxrdpPg@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/28] Kconfig for Arm machines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 May 2019 at 14:57, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-05
>
> for you to fetch changes up to 55e5578fabf744e62038f7357369a68e460fe205:
>
>   hw/arm: Remove hard-enablement of the remaining PCI devices (2019-05-03 17:06:20 +0200)
>
> ----------------------------------------------------------------
> Kconfig settings for the Arm machines
> ----------------------------------------------------------------

Hi Thomas. My test setup that does 'make clean' before the build
failed in 'make check':

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i38
6 QTEST_QEMU_IMG=qemu-img tests/ahci-test -m=quick -k --tap <
/dev/null | ./scripts/tap-driver.pl --test-name="a
hci-test"
qemu-system-i386: Unknown device 'ich9-ahci' for bus 'PCIE'
Broken pipe
/home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:143:
kill_qemu() detected QEMU death from signal 6 (Abort
ed) (core dumped)
Aborted (core dumped)
ERROR - too few tests run (expected 74, got 0)
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:903:
recipe for target 'check-qtest-i386' failed

(all the builds that are just incremental without the 'make clean'
worked ok). Any idea what's happened here?

thanks
-- PMM


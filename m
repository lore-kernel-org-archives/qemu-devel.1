Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6662AC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341AD27645
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjcDYd8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341AD27645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXpVD-0000La-EW
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:08:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXpO7-0003vq-Sr
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXpO5-0001e0-TQ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:00:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hXpO5-0001a5-9C
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:00:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id z23so1579717ote.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=6dx95la2BcxWhzhx9tP9NB4bKCmFMUHW9B8SflMtgjs=;
	b=sjcDYd8zuUQA06vK7UJfe0J032STBcs0drE1SR/pPEG2XtsLsos7g+ZVFpS6wL2/7i
	E1q9VlvAL4XueaptomdeHQYorHw1ReGhTS9txznpTEEGOxTrfHTCl02S4CZKQDafqHNJ
	jYv0IYj+C7sPaEZV78nljfWitRW86RIqYHf3hp65MfGe3tm7eb2KpdCVXx4wZSkViWfN
	j7iMWsmqw0mteBKgfF/4cSdqOYmCWzCXe4nUQ+WSqZIy7HFt7RGidB6PHg7yuq7GNdvz
	7rBPC9erawj62KBh+GTWOW25qEihzb3oq1D4GJtAcW76vGg2XDcAMnv2VlwOlY9kugcE
	Z2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=6dx95la2BcxWhzhx9tP9NB4bKCmFMUHW9B8SflMtgjs=;
	b=AuvobXJThuOg8h6CiHCb4/JTTNNnxbi1fPSjmKBdhVPiEiGs7MuZ6ETxJbAcyFJv31
	WQuUE0hueJsL2V1syaDXeZk2QgrCVFVWEcFOSvwGEZXOvZ8XcFIPE8RdWV2w2D4linab
	vJGx41KJrMSrqBprNwouEz+R+q0i7S20pojF/VIJXsVbzQPo0Ds4GfS0fpUXuEYYLdf3
	o/1mPQLX8cXImREK87RZPTZGnKJjS3yXfMFohCoeIAMQQDMQSkE91QxIMxtCnzsHljvV
	pqUuKPTr6PDjxi/BHro7573AGeD4kKNRfm0HcnxtIH++ComQ8m9h1iheS7XL8VJjt8Rw
	UH4A==
X-Gm-Message-State: APjAAAX4S/LngPy7FqeVz8A+2MpU4N/X7osqegs2HrzH04hMkv3/+GPm
	3gbcQtipyai1GK2LErN29dn1iVFf0kvrUvSPTQEExA==
X-Google-Smtp-Source: APXvYqyIvQTHdglLS4wRGqOlPgRHdqnseO2X5KlOjfHLWE3PgsB2HzK/G7ZHeT3pCsLFbcW8ExthqWlYkKBkyPfYlfs=
X-Received: by 2002:a9d:193:: with SMTP id e19mr1041225ote.135.1559577639173; 
	Mon, 03 Jun 2019 09:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190603150233.6614-1-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2019 17:00:28 +0100
Message-ID: <CAFEAcA_--oYicssh8-3i9_gntL_Puc_QkXxBUMEPeu=HJaMEvA@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 00/28] Block layer patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Jun 2019 at 16:05, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit ad88e4252f09c2956b99c90de39e95bab2e8e7af:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-1-2019' into staging (2019-06-03 10:25:12 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 9593db8ccd27800ce4a17f1d5b735b9130c541a2:
>
>   iotests: Fix duplicated diff output on failure (2019-06-03 16:33:20 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: AioContext management, part 2
> - Avoid recursive block_status call (i.e. lseek() calls) if possible
> - linux-aio: Drop unused BlockAIOCB submission method
> - nvme: add Get/Set Feature Timestamp support
> - Fix crash on commit job start with active I/O on base node
> - Fix crash in bdrv_drained_end
> - Fix integer overflow in qcow2 discard
>
> ----------------------------------------------------------------

Hi; this failed my build tests on any platform where I run
'make check':

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm QTEST_QEMU_IMG=qemu-img
tests/qos-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
--test-name="qos-test"
PASS 1 qos-test /arm/raspi2/generic-sdhci/sdhci/sdhci-tests/registers
PASS 2 qos-test /arm/sabrelite/generic-sdhci/sdhci/sdhci-tests/registers
[...]
PASS 30 qos-test
/arm/virt/virtio-mmio/virtio-bus/virtio-scsi-device/virtio-scsi/virtio-scsi-tests/hotplug
PASS 31 qos-test
/arm/virt/virtio-mmio/virtio-bus/virtio-scsi-device/virtio-scsi/virtio-scsi-tests/unaligned-write-same
qemu-system-arm: -device virtio-scsi-device,id=vs0,iothread=thread0:
ioeventfd is required for iothread
Broken pipe
/home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:135:
kill_qemu() tried to terminate QEMU process but encountered exit
status 1
Aborted (core dumped)
ERROR - too few tests run (expected 37, got 31)

thanks
-- PMM


Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D623C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF8A2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7+KNToG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF8A2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51918 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3IP-0000tz-R8
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:51:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3HO-0000WY-Hq
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3HN-0003z2-LT
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:50:02 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3HN-0003xy-Fy
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:50:01 -0400
Received: by mail-oi1-x242.google.com with SMTP id 203so12494828oid.13
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 04:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iVBVSGSDpTZ3p5BdQOxAUUhxfO0Q9QzwaDO7T9mFCoU=;
	b=W7+KNToGapHb4fKloLZG/3V0MuScrPHVpjIe63GIg4IdmCP4E17I3P0OHFgy7NYKYO
	XkbrULr9SAYXO+KdD+QQ/FIvG8rdeV1OMcJPnZNWhgNjE9ShJe6uAoAsU9v3dHrT9XBk
	xytmmHPLA6nwE771wKikXo1tgQ4MbCsTQ4KeA/L/1RRaFveyNAiCOcwDSboykOddw/wd
	A4XfBox71VlrPusJh6q7Y5dnxTnLog2aa7L6rx9UsY2s1vvEl+7+EKOh6yb3aWPHN3P7
	7rdbFr34Vlzj3tT+Ew7WW2EKj08aC4+aapPomGk2V8UVHs0QGuv/Zhg9SdddeRdFoY4N
	nYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iVBVSGSDpTZ3p5BdQOxAUUhxfO0Q9QzwaDO7T9mFCoU=;
	b=K1pMCGRNWF1vmstUV3cvgFc/YQmuaOVLgeKWSIHsSZ44Wkeshi3Xr/aVRY6m4BNjhU
	e+ZL0zIUE1JSmqREf1vEv0QMRGE+9UxDz4odSCnv7Rf1JKJjVfZG3nDud/q1ENoYo5AT
	edEUg1q1ATfKNeCVUubm1pAIQR6T9yrEVqLP9Tje65ZmYqlr7bb6fZ9xu53Say0+VKA5
	sHGTq60tVY7QFYjHzzssoLxbTcK8yElFhZv/M3X7ZI/qnfjppxbUD69wSQ5LQC8JEZJM
	rcc3u3EvSZTOB3JpmWAD28OX0ptRYhdM9fI6riVAJQBwX7yS/lr6q4La1GTb7RmIT9bC
	i9tg==
X-Gm-Message-State: APjAAAVjLYHJ8JBXU2W0KV7jTrkCd2j2ARRheky3ha6SeKIHrVNaLvbG
	FGt6qq6thXksnpb2m3x9rrBduYBPZhOFD10tvOHWsg==
X-Google-Smtp-Source: APXvYqwUbBZKFkbZq6iGSIjFf6TUCZjU0mKG7rHozA4QnG7elcWh33sU5wiwJ5rEEzsszSNfqnSrY9qtj5ZKOza+HBc=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr3135903oif.98.1558439399849; 
	Tue, 21 May 2019 04:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231008.20140-1-mst@redhat.com>
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 12:49:48 +0100
Message-ID: <CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL v2 00/36] pci, pc, virtio: features, fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 00:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 2259637b95bef3116cc262459271de08e038cc66:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-05-20 17:22:05 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 0c05ec64c388aea59facbef740651afa78e04f50:
>
>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-20 18:40:02 -0400)
>
> ----------------------------------------------------------------
> pci, pc, virtio: features, fixes
>
> reconnect for vhost blk
> tests for UEFI
> misc other stuff
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Hi -- this failed 'make check' for 32-bit Arm hosts:

ERROR:/home/peter.maydell/qemu/tests/acpi-utils.c:145:acpi_find_rsdp_address_uefi:
code should not be reached
Aborted
ERROR - too few tests run (expected 1, got 0)
/home/peter.maydell/qemu/tests/Makefile.include:885: recipe for target
'check-qtest-aarch64' failed

thanks
-- PMM


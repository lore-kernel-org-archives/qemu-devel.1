Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928ACC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E64026C1C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiavmvGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E64026C1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkPb-0004zx-NY
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:29:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWkOp-0004gV-Q6
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWkOn-0004q5-UT
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:28:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWkOl-0004mF-UN
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:28:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id m6so1221435wrj.10
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=VfK96mQbwbTPMECSvLcjRvExGPmA/7+SDYsox9nXIKA=;
	b=qiavmvGaFXnGsZwgXtuiPraieYOvSVd3YdhzcBL+/DiySGI8Plxwi/QtEIo2MZi01L
	FHnvrpAYXUlFzj5y4ZNZo5BPLGURz0XXOA+a7xP7LCQDbjnX+hTTdVPT7A88W195JxtC
	OO69P646C+LL0oSLQU8zPdwAvXxs1gCvVPhByX6fIamRHsuHU5jlTLR0qhvtT+JUx/MP
	qRwvErysXShmgNLO6JTfoKELhtZzt6fIsBrGl82aW6Hfh4v8Iiead97Jgig8bQBSE4Ld
	aIxCCqyq7O4FDMLKljFR0CfpRbg+Hxxh424cQuq8+r7jGNApH2tmgzLYzVMj7jCWUpAG
	KnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=VfK96mQbwbTPMECSvLcjRvExGPmA/7+SDYsox9nXIKA=;
	b=G5UVTZRGSP4GNqCKln5iU44hXWKbjlcMU9BMctHcD6AbmicB3VKS2CJOsZtSEzibRi
	vSU+69DWqG/6TfCVm+QJcGmRtb4AJwdzI6lA6FSppOfnZJPpTQ22Y/lnScYGaf3zixML
	gNJSriNxBl1ZJSlCTXavMSePRxBcrmFUPv9q5Ibe4ZqmCLWupACVYB6XTyHrXN/VtsJD
	LfBOY7yBpqIp2tZ/8gBygG7rYLo1RYiqQMZIFAafxrccbvVminpRhd9Z+ysSK73yQVth
	s6+1mIckWi3RjWmEoT0d2dTxVXLsWi/beK2dLfUK7SzwsiqximCxhqRcvivXYfFeoOJz
	oD/A==
X-Gm-Message-State: APjAAAXDkibd4Q3tF430r73BY1sABwEcvQ1JTBV1G/29CnNVQt/AYr4A
	f9B4JyUyvFaVZ+Ef5V/Grk9d6pdebhM=
X-Google-Smtp-Source: APXvYqyDA576KTXI/lIlCzPnn4exb4qSP4s2JNX6ETrO/Oo62ijsJyBB4YVKT53VIGlFTAtn2vZ5Xw==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr7537980wrn.258.1559320132558; 
	Fri, 31 May 2019 09:28:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	j82sm6245811wmj.40.2019.05.31.09.28.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 09:28:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 07F4F1FF87;
	Fri, 31 May 2019 17:28:51 +0100 (BST)
References: <155923186868.25498.16417785082829115907.malonedeb@gac.canonical.com>
	<155931574363.8426.10336516680800433530.malone@wampee.canonical.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1831115 <1831115@bugs.launchpad.net>
In-reply-to: <155931574363.8426.10336516680800433530.malone@wampee.canonical.com>
Date: Fri, 31 May 2019 17:28:50 +0100
Message-ID: <87muj28u65.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [Bug 1831115] Re: qemu 4.0.0 on aarch64: uefi
 firmware oversize
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jerry <ubuntu@mail.jerryxiao.cc> writes:

> [jerry@jerry-n1 aarch64]$ du -b *
> 67108864        AAVMF_CODE.fd
> 67108864        AAVMF_VARS.fd
> 67108864        QEMU_EFI.fd
> 67108864        QEMU_VARS.fd
>
> 2097152 QEMU_EFI.fd.orig
> 786432  QEMU_VARS.fd.orig
>
>
> Both files have been padded to 64MB. (if padding means filling it with
> /dev/zero)

You can use:

   truncate -s 64m /path/to/blob

>
> QEMU_EFI.fd and QEMU_VARS.fd are built by myself according to
> https://wiki.linaro.org/LEG/UEFIforQEMU. With the self-built formware,
> I'm getting almost the same error: qemu-system-aarch64: Initialization
> of device cfi.pflash01 failed: device requires 67108864 bytes, block
> backend provides 786432 bytes

Are you sure your libvirt invocation is properly pointing at your new
re-sized blobs? WFM here on master:

  ./aarch64-softmmu/qemu-system-aarch64 -cpu max -machine type=3Dvirt,virtu=
alization=3Don -display none -m 4096 -serial mon:stdio -netdev user,id=3Dun=
et,hostfwd=3Dtcp::2222-:22 -device virtio-net-pci,netdev=3Dunet -device vir=
tio-scsi-pci -blockdev driver=3Draw,node-name=3Dhd,discard=3Dunmap,file.dri=
ver=3Dhost_device,file.filename=3D/dev/zen-disk/debian-buster-arm64 -device=
 scsi-hd,drive=3Dhd -bios /usr/share/AAVMF/AAVMF_CODE.fd

Where:

ls -l /usr/share/AAVMF/*
-rw-r--r-- 1 root root 67108864 Mar 16 00:37 /usr/share/AAVMF/AAVMF32_CODE.=
fd
-rw-r--r-- 1 root root 67108864 Mar 16 00:37 /usr/share/AAVMF/AAVMF32_VARS.=
fd
-rw-r--r-- 1 root root 67108864 Mar 16 00:37 /usr/share/AAVMF/AAVMF_CODE.fd
-rw-r--r-- 1 root root 67108864 Mar 16 00:37 /usr/share/AAVMF/AAVMF_VARS.fd

--
Alex Benn=C3=A9e


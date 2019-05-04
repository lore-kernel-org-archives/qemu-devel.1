Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71A2C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 21:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBE220652
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 21:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcomC4oS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBE220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hN1pu-0004lV-JV
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 17:04:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oF-0003rl-Bo
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oE-0004Zy-Cb
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hN1oE-0004Yx-4t
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id h15so6466823wrb.2
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=RkG/pKtEKwAbNFSoBD+1KmVNGyGxLLvr2Eec2qtxGEo=;
	b=JcomC4oSbX8UM1dX9xRgOCy10tgXYj5Xi9kfB5blop8Jm+g/IcCCReIX11+RZ/0tl4
	3qxezSvBFd0RG1OaK/q0ZUF6fXXSuVWyUT6n2czFVZ+oyBM+H6cWuFrehDH3Urx3CIgP
	lgg+Qr6nmZcEVOK6OtZs7kPrBaMNOLTFHlqEsZ+Pek950K3WOWakiIunwjm8xOgtR5Py
	Oa1DMvMKI4KDrRUnH1VnunyQe9ZKvEsKYqNS3a+0JNtW0/5saSrV/JUFe7RvoT636FHe
	ZKYqognVB/0k1SpScTF2Mtvpk5EhfKS8jPHM1DXsSWqAzl/beQrjUp1OCmBJO4QGMtSJ
	de/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=RkG/pKtEKwAbNFSoBD+1KmVNGyGxLLvr2Eec2qtxGEo=;
	b=PIqStlaus19fh3DqLWUWgApgV1xiQW08tC/YWqtzzu324ZODEM9VOScyj2D4XEvhCF
	TUEgcVNhqgn6MVeW+QeovLRHaa4uh1lBHn+Y4HOP7s3PHM8D6PmtGYvHxboTa1Uvwu5J
	HDh0DHi1FFLwdCen2hnTg9uUW6H+B9Z+qi/UZczR3Mrb533lJGx3nDo7JyKtPFWqGQng
	CwQZMll2+8y4yHu5FQxuD9pPUyExLeEPGnllmE1qpcOzcutk9U1u+0dqq1I+KB6Sj3UM
	iylFAeJsEAQQgrz1c1gvNQ5GH9HFC8Z9Kh2IKZufpNiEoZ9Hq051jHYPp3DxsIKY3e4L
	osdA==
X-Gm-Message-State: APjAAAUiORu+R91fX9g90I69SpfJ0hAtqPgyR5+WRss7oYIxW3Wyk+jt
	mS1FtvKRwFjutw8n8mcJ3z0f2FX/
X-Google-Smtp-Source: APXvYqwr547NTLtCp70dCvMiroamz9d8fs/0OVpgqBuUAD+c7+MRFZsIajsf5E3sX7pBbZMjG7nKdw==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr11603989wru.128.1557003780074; 
	Sat, 04 May 2019 14:03:00 -0700 (PDT)
Received: from localhost ([46.114.6.7])
	by smtp.gmail.com with ESMTPSA id v2sm3972764wrq.12.2019.05.04.14.02.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 May 2019 14:02:59 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org,
	hpoussin@reactos.org
Date: Sat,  4 May 2019 23:02:31 +0200
Message-Id: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 0/3] Improve 40p, make AIX 5.1 boot
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
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504210231.FSR-sSXsqzK8QAEyRmpxGWDp1t4QKErwlLUl7NTJx0I@z>


This series makes various fixes for the -M 40p target.
Particularly now it's possible to boot AIX 5.1 (both from a cdrom
and a hard disk).

The OFW image: 
https://github.com/artyom-tarasenko/openfirmware/releases/download/20190406-AIX-boots/q40pofw-serial.rom

The command line:
qemu-system-ppc -M 40p -bios q40pofw-serial.rom -serial telnet::4441,server -hda aix-hdd.qcow2 -cdrom \
/path/to/aix-5.1-cd1.iso  -vga none -nographic

More info can be found here:
https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html

Artyom Tarasenko (3):
  lsi53c895a: hide 53c895a registers in 53c810
  40p and prep: implement PCI bus mastering
  hw/isa/i82378.c: use 1900 as a base year

 hw/isa/i82378.c      |  4 +++-
 hw/pci-host/prep.c   | 15 +++++++++++----
 hw/scsi/lsi53c895a.c | 17 ++++++++++++++---
 3 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.7.2



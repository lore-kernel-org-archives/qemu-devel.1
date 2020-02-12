Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C718C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECEDC20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBX3hKYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEDC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ohP-0004XY-5B
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j1ogZ-0003eY-Mm
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j1ogY-0006C0-IK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:51:59 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j1ogY-0006B0-CK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:51:58 -0500
Received: by mail-pl1-x642.google.com with SMTP id e8so759286plt.9
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 01:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AKfQbRn0iHa1qeEwp/Zt/Mjx9PG0p6ybIIQdU2RHOY8=;
 b=JBX3hKYFX2N6eTMZdPecrut93ybryOEt76XxlXKOnKllD/IPYIWXRXvp6/3vKzkO7y
 yt8qJxLquzTDHBWyjVYZEyEpQfax9UDwEeNsKwQsCQPMR/vNPEZBZeHKHr9dvNpN3QR9
 m/FtJaq6noLpZLq8+PPD9L9848zAlFH8aBkN0mraoPUVL6tXkBjzc5oK7kiiRXpcuEcu
 1Mcst8XBMhIKdCOi3VWnayBvWjVOw1CtGAc1wRVPgomvWnOtG6fHcbsjQ5jBmhBC7FZ/
 GKIJ0/MXfNJe2q1QTnX6kQQrkIFAJZ3wePbTGewnUA5fpmK2epu/DGnxJdJNDsLYJb91
 D9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AKfQbRn0iHa1qeEwp/Zt/Mjx9PG0p6ybIIQdU2RHOY8=;
 b=dUGR35lTjmVmxJN+RxuSSSm+0hL2KQubl7dI3VPdGwHpdkJAgTPuBho1TLT6IsFd5U
 n+IMnfM2GEw7UG1aXEOZJouDq9ltLvb/AsazGx7nib8lezDJYbx/YaIP9ZqyHwdOSb7g
 N1+J9ZHR8J9fqMDvQ8kXQir5HoizR68T+dVTdcP0RONDjQ+FntBfRq2W6njWtaHlLdrW
 2wGUQg5E8rDiYovu9Zvk/dl2BslveXcIzV1kTO2tPMxk0BJQpsLdUL/Cqq4BcgDqwewn
 Y5dJSvrIABt3wEQbsPR/YORetBf2mwzMulj7eCgt1B43CHtofUXdffzp7Srq/ypxDb9y
 C8FA==
X-Gm-Message-State: APjAAAVUehcwXDdM+xVd+hR58MdUAbDPCmXjUTp5M4nhMuqjTPnJ9ONA
 PvuoSCmw9yP1Kaz7NMthFY5dnbZP
X-Google-Smtp-Source: APXvYqzR7AFBdw7+2itlbsiY33q7j30qTtk0uslJA6Q3At5njHmO7s/4dRqxdM3YHshGP1UZ0A8qCw==
X-Received: by 2002:a17:90a:8a8f:: with SMTP id
 x15mr9207892pjn.87.1581501116293; 
 Wed, 12 Feb 2020 01:51:56 -0800 (PST)
Received: from localhost.localdomain ([2402:9e80:0:1000::1:4ad5])
 by smtp.googlemail.com with ESMTPSA id o19sm6298595pjr.2.2020.02.12.01.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 01:51:55 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] vhost-user block device backend implementation
Date: Wed, 12 Feb 2020 17:51:32 +0800
Message-Id: <20200212095137.7977-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <coiby.xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:
 * separate generic vhost-user-server code from vhost-user-blk-server
   code
 * re-write vu_message_read and kick hander function as coroutines to
   directly call blk_co_preadv, blk_co_pwritev, etc.
 * add aio_context notifier functions to support multi-threading model
 * other fixes regarding coding style, warning report, etc.

v2:
 * Only enable this feauture for Linux because eventfd is a Linux-specific
   feature


This patch series is an implementation of vhost-user block device
backend server, thanks to Stefan and Kevin's guidance.

Vhost-user block device backend server is a UserCreatable object and can be
started using object_add,

 (qemu) object_add vhost-user-blk-server,id=ID,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512
 (qemu) object_del ID

or appending the "-object" option when starting QEMU,

  $ -object vhost-user-blk-server,id=disk,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512

Then vhost-user client can connect to the server backend.
For example, QEMU could act as a client,

  $ -m 256 -object memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem -chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device vhost-user-blk-pci,id=blk0,chardev=char1

And guest OS could access this vhost-user block device after mouting it.

Coiby Xu (5):
  extend libvhost to support IOThread and coroutine
  generic vhost user server
  vhost-user block device backend server
  a standone-alone tool to directly share disk image file via vhost-user
    protocol
  new qTest case to test the vhost-user-blk-server

 Makefile                              |   4 +
 Makefile.target                       |   1 +
 backends/Makefile.objs                |   2 +
 backends/vhost-user-blk-server.c      | 716 ++++++++++++++++++++++++++
 backends/vhost-user-blk-server.h      |  21 +
 configure                             |   3 +
 contrib/libvhost-user/libvhost-user.c |  54 +-
 contrib/libvhost-user/libvhost-user.h |  38 +-
 qemu-vu.c                             | 252 +++++++++
 tests/libqos/vhost-user-blk.c         | 126 +++++
 tests/libqos/vhost-user-blk.h         |  44 ++
 tests/vhost-user-blk-test.c           | 694 +++++++++++++++++++++++++
 util/Makefile.objs                    |   3 +
 util/vhost-user-server.c              | 429 ++++++++++++++++
 util/vhost-user-server.h              |  56 ++
 vl.c                                  |   4 +
 16 files changed, 2440 insertions(+), 7 deletions(-)
 create mode 100644 backends/vhost-user-blk-server.c
 create mode 100644 backends/vhost-user-blk-server.h
 create mode 100644 qemu-vu.c
 create mode 100644 tests/libqos/vhost-user-blk.c
 create mode 100644 tests/libqos/vhost-user-blk.h
 create mode 100644 tests/vhost-user-blk-test.c
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

--
2.25.0



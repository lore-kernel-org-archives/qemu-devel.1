Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B3DC33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 04:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D25821556
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 04:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deR8sZmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D25821556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqroU-0000KZ-V6
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 23:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1iqrnK-000791-76
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 23:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1iqrnI-0006U1-QB
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 23:57:41 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1iqrnI-0006Rv-IM
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 23:57:40 -0500
Received: by mail-pg1-x541.google.com with SMTP id q127so4107529pga.4
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2020 20:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=brfGB97ZBMiTzGbtzJN1Eh5H6IkX/OIo6aTN77R1PlY=;
 b=deR8sZmrO1DNAu/wWMlxTppvMNyZNfXYhy5I4rYoUiQ5DB0dwyl7OedovFFGuL96NP
 r7BnykH2dM+uBOhXfDLwxoIarRxyJN8iA8yJJXM5yK+V6MnxJ2Y+WIy/CRTTsvZytcWf
 7DruJa/hQ6coJDb/cPzYu46iYFshAGGNHyJb9Fo5BEJxiiKucw0i2KLvlyBVdMWR+5nc
 tLDlRZRAreAfVAKbmXwn7EejKeNMfZySRCkt0OsYRwy5n+ZxvXplPqfaA7Kq6N5gPv5y
 TgrTXAI1z6h4ZuS5gq4rSxO5wtH/OwZJF7tSe91LFrG52PFJdtN9JsRGOdWkYfvLPW1Y
 z6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=brfGB97ZBMiTzGbtzJN1Eh5H6IkX/OIo6aTN77R1PlY=;
 b=cnlLh5NoYsDGtYYlGiFlgQCbAVKrydba63ZJggHbILTCgUJIDg5IO5Fg6x9P24Zrf3
 snICAJXbWg12ohEsUmi116bAbQDRk0nnNSoiGdRGyLV12E0LOf0qfkdGFeXSEZRHsSPZ
 wnN78r14swIqVr/EIHyQftRPJtaI9QpJ36UXUXGybKXRye/ZFUWH8pjTOtQZep4bguys
 nT1r7RfzHcA72YGoMa4qSefHgNtAXErfOtuPEMVOJ/lqD6lbvciu46+6/TB5iVJBOI88
 A8Zbj12y2rxC1DCqo30bAaGhPUFUqFa+N4KVv53bUx7Ow6sd7jJu9IE4rWqy8vWfecPb
 +IBQ==
X-Gm-Message-State: APjAAAXwJYOFQZTlBzN7T5XCyPO+c1tiMzIzmUQNvwnSUOiLSnWbHB2A
 DQ1ybAvBtwZV858U9VBsUjv6CFSOsAdeBA==
X-Google-Smtp-Source: APXvYqx/9iXBXW8H5hxJ+D02jjojVU0MKwkiWPgp4LmD4g+gG7LsR51uBH5URca8MhsS349cHfKRGg==
X-Received: by 2002:a63:4f54:: with SMTP id p20mr19088810pgl.246.1578891458762; 
 Sun, 12 Jan 2020 20:57:38 -0800 (PST)
Received: from localhost.localdomain ([175.124.145.172])
 by smtp.googlemail.com with ESMTPSA id o19sm17590552pjr.2.2020.01.12.20.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2020 20:57:38 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/5] vhost-user block device backend implementation
Date: Mon, 13 Jan 2020 12:56:59 +0800
Message-Id: <20200113045704.12318-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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


This patch series is an implementation of vhost-user-backend server, thanks to Stefan's guidance after reviewing the draft version and the instructions on https://wiki.qemu.org/Google_Summer_of_Code_2019#vhost-user-blk_device_backend,

Vhost-user-backend server is a UserCreatable object and can be started using object_add,

 (qemu) object_add vhost-user-server,id=ID,unix_socket=/tmp/vhost-user-blk_vhost.socket,name=DRIVE_NAME,writable=off
 (qemu) object_del ID

or appending the "-object" option when starting QEMU,

  $ -object vhost-user-server,id=disk,unix_socket=/tmp/vhost-user-blk_vhost.socket,name=disk,writable=off

Then vhost-user client can connect to the server backend. For example, QEMU could act as a client,
  $ -m 256 -object memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem -chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device vhost-user-blk-pci,id=blk0,chardev=char1

And guest OS could access this vhost-user block device after mouting it.

patches are against commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f.

Coiby Xu (5):
  vhost-user block device backend
  extend libvhost to support IOThread
  a standone-alone tool to directly share disk image file via vhost-user
    protocol
  new qTest case for the vhost-user-blk device backend
  building configuration files changes

 Makefile                              |    1 +
 Makefile.objs                         |    2 +-
 Makefile.target                       |    1 +
 blockdev-vu.c                         | 1008 +++++++++++++++++++++++++
 configure                             |    2 +-
 contrib/libvhost-user/libvhost-user.c |   64 +-
 contrib/libvhost-user/libvhost-user.h |   36 +-
 include/block/vhost-user.h            |   46 ++
 qemu-vu.c                             |  264 +++++++
 tests/Makefile.include                |    5 +-
 tests/libqos/vhost-user-blk.c         |  125 +++
 tests/libqos/vhost-user-blk.h         |   44 ++
 tests/vhost-user-blk-test.c           |  691 +++++++++++++++++
 vl.c                                  |    4 +
 14 files changed, 2277 insertions(+), 16 deletions(-)
 create mode 100644 blockdev-vu.c
 create mode 100644 include/block/vhost-user.h
 create mode 100644 qemu-vu.c
 create mode 100644 tests/libqos/vhost-user-blk.c
 create mode 100644 tests/libqos/vhost-user-blk.h
 create mode 100644 tests/vhost-user-blk-test.c

--
2.24.1



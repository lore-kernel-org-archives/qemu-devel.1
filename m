Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD479C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA05F2064C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuV/VPTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA05F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3v7h-000463-QM
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 00:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j3v6z-00038R-SS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j3v6y-0004QT-O7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:07:57 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:34216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j3v6y-0004Q4-IV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:07:56 -0500
Received: by mail-pj1-x102f.google.com with SMTP id f2so294370pjq.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 21:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iRNPxgEzAFsP+g5OygqUM7cdphUrevx5jBVX3GMIyFY=;
 b=LuV/VPTXva9obTYymFcgCDOhFHt2LsL/1Y8KGCFu0rv5/vmVFFrFTmf4jVfr/PZxCX
 /G+VoQzn9rEp4U4MbDVTpkYH+SmTadXGrrsbTzQLsbdd/srvAeayRmEY4Ol9VeEQNzM2
 F2ED51pvij2gT5Nw2pd3mQVq21viC42HDRFSDWyfu2NPCLFSeyRbu1zfbk6G1cDDfMds
 k7Mp7bM+hMOlBpQRDoycjvvZFq/ATV4LakeJMEHIkthZZmbFtvkaduxPr+UJFhYYTndx
 Y/zY0TRW3H48uW/ynBTtKi95Fm0cDtirx+JSjpkeUCAIr2nW5xb3MfJb6yR6boCesE3w
 23JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iRNPxgEzAFsP+g5OygqUM7cdphUrevx5jBVX3GMIyFY=;
 b=T6eyzaHpC1mrKjs4VfcUU8FgZsSjSfL+ysQ+FzPOXAIcH26WGJglBXwaxaY1hSwBQ0
 MgMgBZU80JtqaCzFqhAoYIvW8IddszHQYVVnZvMGO6+vUOAOz0mXJ7jvA46Ss4GsvJTY
 UYNWSdGBqCeK0nVduyILXAQcT2VrtmkMpuXsjXwaJYDqbtjjWepEKpFre3DclJEi0Svb
 fakX20tXzbDWbLnsHO3eQttymbqwza9H0pntsVmWZOb81SHbCylrR3TG1Guhb5Px6kDE
 SVslwskkSUe4YO9SjTFVGHDHCbbOz4+SV/sfuHztHV4K7aXakwSBKoq1mviFWBc/dMXD
 1Rpg==
X-Gm-Message-State: APjAAAVtYZ2FarS88d7ckWEdPtbOFSqK4CLXOEBxmBisaaK18QIxUjSj
 CxstZ/QWKG9PBSjJC84TRESesW3LEdU=
X-Google-Smtp-Source: APXvYqxNVlYkKAUDpDnBr6YcznIxL/VpxWEC7YagwZ6xapTfPs1Hko7E2InqrMWHHgpFkwihuPAf0A==
X-Received: by 2002:a17:90b:8d1:: with SMTP id
 ds17mr485253pjb.33.1582002474526; 
 Mon, 17 Feb 2020 21:07:54 -0800 (PST)
Received: from localhost.localdomain ([2402:9e80:0:1000::1:c192])
 by smtp.googlemail.com with ESMTPSA id 3sm1181613pjg.27.2020.02.17.21.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 21:07:53 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/5] vhost-user block device backend implementation
Date: Tue, 18 Feb 2020 13:07:06 +0800
Message-Id: <20200218050711.8133-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102f
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

v4:
 * add object properties in class_init
 * relocate vhost-user-blk-test
 * other changes including using SocketAddress, coding style, etc.

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
 backends/vhost-user-blk-server.c      | 718 ++++++++++++++++++++++++++
 backends/vhost-user-blk-server.h      |  21 +
 configure                             |   3 +
 contrib/libvhost-user/libvhost-user.c |  54 +-
 contrib/libvhost-user/libvhost-user.h |  38 +-
 qemu-vu.c                             | 252 +++++++++
 tests/Makefile.include                |   3 +-
 tests/qtest/Makefile.include          |   2 +
 tests/qtest/libqos/vhost-user-blk.c   | 126 +++++
 tests/qtest/libqos/vhost-user-blk.h   |  44 ++
 tests/qtest/vhost-user-blk-test.c     | 694 +++++++++++++++++++++++++
 util/Makefile.objs                    |   3 +
 util/vhost-user-server.c              | 427 +++++++++++++++
 util/vhost-user-server.h              |  56 ++
 vl.c                                  |   4 +
 18 files changed, 2444 insertions(+), 8 deletions(-)
 create mode 100644 backends/vhost-user-blk-server.c
 create mode 100644 backends/vhost-user-blk-server.h
 create mode 100644 qemu-vu.c
 create mode 100644 tests/qtest/libqos/vhost-user-blk.c
 create mode 100644 tests/qtest/libqos/vhost-user-blk.h
 create mode 100644 tests/qtest/vhost-user-blk-test.c
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

--
2.25.0



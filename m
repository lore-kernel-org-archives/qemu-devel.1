Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E660C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1915F206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH6fxtzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1915F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkXYg-0001cu-8w
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 14:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXXa-0008Nq-OV
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 14:39:34 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:40874)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXXZ-00018S-02
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 14:39:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id x11so458181plo.7
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rR5kBv+59SfrMrzSBIEu8BBGx+ri0RLQeo4FKt0fUkM=;
 b=LH6fxtzzAtr0BRO+MvGHvmuSyX0Z0PDd8YbW05GKZLt1JYwUB9NbVetEEBDaMRcLwn
 ZMIQxPhkn7PJJmWi7jTvfFCYvU/VpUsHipzRDrv8jiXqQFSuPw1cvOQ40Vel332LQbKh
 uN42WAXrhdhLWKquc5CjtKnV8mmEZIcHv6HJH6ShvBksFG0zNqX2QbQfmsRdhsdthMxv
 h3I85JyBhuN+N3WJwbRoipiv3KyiqHuNuXF1jLkKa5injZJOHlqtqOAPDje+FBkYboI1
 RQD6utSTnCEHhSPrMV87q9W2M6REz0r5SwxLUDC5GH77WcamTff1kWBLVtCXv5b/d+Ln
 rZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rR5kBv+59SfrMrzSBIEu8BBGx+ri0RLQeo4FKt0fUkM=;
 b=PjFU0X1I5QEwCp3qlWOsRnjKDaJQqZ6fug5UWa2IsO6kh5t7OBCiC5qeLLzqNVQ1L9
 rWO7OUq5jtSUdcMDvlY2/w53Cs4Ic6DM8cHbthOk6oPwCtusJXBokXrllLhRAb3lJhZL
 E9G96+cbFwqR3n7gNTto6bhvme/fQitM6Gbn7IS6RbQhyx9uGUJ2i/Xlq7guhZnXutAq
 ylRDbtd9jGtofw2xUfVyOBJyB5qEFAg0jPvLkQfySbuE2ZJiXHJWmhWLg+D/j17qylx1
 QtJeV+fT2RkmCcHVZxDUIK52ytmbswyohGmLlRT5iC0U0lwHx/jjumYZsEByVWgNRWSL
 N+6A==
X-Gm-Message-State: AOAM533FIgSYkvqCOouWdBpSoUaks2mr3V4v3RWP3qlyU19n+kCePaAn
 O5WVsYSN1jhK4CY5YC4wgQ1iiEjDbLEHIQ==
X-Google-Smtp-Source: ABdhPJwhk75BTrfS4tWmGLVzAS9kjyPEBw90Ua2Uw9vz+IsM5hlFafVF2VvXpDK1WhXt8ji3xNd89A==
X-Received: by 2002:a17:90a:36aa:: with SMTP id
 t39mr7930591pjb.185.1592159965887; 
 Sun, 14 Jun 2020 11:39:25 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id h12sm10156595pgj.71.2020.06.14.11.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 11:39:25 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 0/5] vhost-user block device backend implementation
Date: Mon, 15 Jun 2020 02:39:02 +0800
Message-Id: <20200614183907.514282-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

v9
 - move logical block size check function to a utility function
 - fix issues regarding license, coding style, memory deallocation, etc.

v8
 - re-try connecting to socket server to fix asan error
 - fix license naming issue

v7
 - fix docker-test-debug@fedora errors by freeing malloced memory

v6
 - add missing license header and include guard
 - vhost-user server only serve one client one time
 - fix a bug in custom vu_message_read
 - using qemu-storage-daemon to start vhost-user-blk-server
 - a bug fix to pass docker-test-clang@ubuntu

v5:
 * re-use vu_kick_cb in libvhost-user
 * keeping processing VhostUserMsg in the same coroutine until there is
   detachment/attachment of AIOContext
 * Spawn separate coroutine for each VuVirtqElement
 * Other changes including relocating vhost-user-blk-server.c, coding
   style etc.

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
 * Only enable this feature for Linux because eventfd is a Linux-specific
   feature


This patch series is an implementation of vhost-user block device
backend server, thanks to Stefan and Kevin's guidance.

Vhost-user block device backend server is a UserCreatable object and can be
started using object_add,

 (qemu) object_add vhost-user-blk-server,id=ID,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,logical-block-size=512
 (qemu) object_del ID

or appending the "-object" option when starting QEMU,

  $ -object vhost-user-blk-server,id=disk,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,logical-block-size=512

Then vhost-user client can connect to the server backend.
For example, QEMU could act as a client,

  $ -m 256 -object memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem -chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device vhost-user-blk-pci,id=blk0,chardev=char1

And guest OS could access this vhost-user block device after mounting it.


Coiby Xu (5):
  Allow vu_message_read to be replaced
  generic vhost user server
  move logical block size check function to a common utility function
  vhost-user block device backend server
  new qTest case to test the vhost-user-blk-server

 block/Makefile.objs                        |   1 +
 block/export/vhost-user-blk-server.c       | 669 +++++++++++++++++++
 block/export/vhost-user-blk-server.h       |  35 +
 contrib/libvhost-user/libvhost-user-glib.c |   2 +-
 contrib/libvhost-user/libvhost-user.c      |  11 +-
 contrib/libvhost-user/libvhost-user.h      |  21 +
 hw/core/qdev-properties.c                  |  18 +-
 softmmu/vl.c                               |   4 +
 tests/Makefile.include                     |   3 +-
 tests/qtest/Makefile.include               |   2 +
 tests/qtest/libqos/vhost-user-blk.c        | 130 ++++
 tests/qtest/libqos/vhost-user-blk.h        |  48 ++
 tests/qtest/libqtest.c                     |  35 +-
 tests/qtest/libqtest.h                     |  17 +
 tests/qtest/vhost-user-blk-test.c          | 739 +++++++++++++++++++++
 tests/vhost-user-bridge.c                  |   2 +
 tools/virtiofsd/fuse_virtio.c              |   4 +-
 util/Makefile.objs                         |   2 +
 util/block-helpers.c                       |  46 ++
 util/block-helpers.h                       |   7 +
 util/vhost-user-server.c                   | 400 +++++++++++
 util/vhost-user-server.h                   |  61 ++
 22 files changed, 2231 insertions(+), 26 deletions(-)
 create mode 100644 block/export/vhost-user-blk-server.c
 create mode 100644 block/export/vhost-user-blk-server.h
 create mode 100644 tests/qtest/libqos/vhost-user-blk.c
 create mode 100644 tests/qtest/libqos/vhost-user-blk.h
 create mode 100644 tests/qtest/vhost-user-blk-test.c
 create mode 100644 util/block-helpers.c
 create mode 100644 util/block-helpers.h
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

--
2.27.0



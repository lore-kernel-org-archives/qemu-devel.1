Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A00EC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1BC2100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkcm5HIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1BC2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBUW-0002Xc-Hh
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSW-0008IK-2Q
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSP-0003GM-M0
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:31 -0400
Received: by mail-pf1-x42f.google.com with SMTP id b124so2936544pfg.13
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l0HqYITpU+dVWTIM5Ap/tpaX3VJwFZje2hKS/+ewIuk=;
 b=Hkcm5HIkNf/4XaY/a+TMu/BYBr9F6KjjGPwtbi+nOYWN+95OdvKkH3zqW5JxtJAFzq
 yA0x0CPL6jegv2e++Rq+T8STdkiwrfgE2DDyfuEopdb19zAIxNcR7iuYcBQbYlOepRRv
 HANhOAhh54l1I/4ClpJfGhDZNapkiPuQLLBFmbvs+gp51Pv72G3SGK6twHoejL3MgzFK
 sJaOrPM+cQCd+iweoEtS9Ebwy0r/VRupEuGTrBSG19yeJLIBkypB5hWMJTrBefQp0UX4
 2J+09fTVhMF7bEcpmHPQa9Zrowpo2PdhwgpOSuA3zVxRz5bgX8h5mI+JY05r6N71ZjZw
 Fsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l0HqYITpU+dVWTIM5Ap/tpaX3VJwFZje2hKS/+ewIuk=;
 b=SYFoUZz6fay2HeiXM0wTvKbm5vQmjliQY7RSonodDxcbdU97G9VUdG+jViLqhb5dPo
 pwQxbzE6sCW8C7BOYKTnxGXHc11UYEUXKZiYaeeG3yKBTAsgM81ut+fHLqGAu1/QkY/d
 Dvp9XC+0UpLIUnmEPR1b5z3iZzwcD8y+6JyalzGeinngXK7M8cqwdGBK9dCgw9wKb9Ww
 N4yZBJiER6t97pytuN3MoDqn1JwfUNJRO4Trh+OYD/qVppW8HJNFDq2OlAhWRJ8gum2s
 y16kkaa8e3yW2fzJk2t7eKql3qyZEgSQ7NmrU073ecgAypaQMVCWO2Jxul6RuSoIxpSq
 A40g==
X-Gm-Message-State: AOAM532UVeLX1tmdsRurQRLZaxn3AT4FI/xbK0fmEKlb2lxAZagHswLl
 2OhMn5PTkLanyY2YTsxp0cDjgjUEoJaHbA==
X-Google-Smtp-Source: ABdhPJw/CRZ0bBZ///9OoHWiSSomC4F6JKaDlZhB3hdDP78mJdoeCMi9yvXzeo/Ie/GuiJXYQztqkA==
X-Received: by 2002:a63:1a66:: with SMTP id a38mr25412235pgm.253.1600416562483; 
 Fri, 18 Sep 2020 01:09:22 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id m13sm1981008pjl.45.2020.09.18.01.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:09:21 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 0/7] vhost-user block device backend implementation
Date: Fri, 18 Sep 2020 16:09:05 +0800
Message-Id: <20200918080912.321299-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=coiby.xu@gmail.com; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v10
 - Use a linked list of VuFdWatch objects to keep kick info [Stefan]
 - Merge improvements and fixes from Stefan
 - Rename libvhost-user's vu_message_read to vu_message_read_default [Kevin]
 - When shutting down the client, wait for the coroutine of processing
   vhost-user messages to be finished [Kevin]
 - Allocate struct req_data on the heap [Kevin]
 - Improve coding of qtest case [Thomas]
 - Fix several memory leaks detected by ASAN

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

Coiby Xu (7):
  libvhost-user: Allow vu_message_read to be replaced
  libvhost-user: remove watch for kick_fd when de-initialize vu-dev
  util/vhost-user-server: generic vhost user server
  block: move logical block size check function to a common utility
    function
  block/export: vhost-user block device backend server
  test: new qTest case to test the vhost-user-blk-server
  MAINTAINERS: Add vhost-user block device backend server maintainer

 MAINTAINERS                                |   8 +
 block/export/vhost-user-blk-server.c       | 661 ++++++++++++++++++
 block/export/vhost-user-blk-server.h       |  36 +
 block/meson.build                          |   1 +
 contrib/libvhost-user/libvhost-user-glib.c |   2 +-
 contrib/libvhost-user/libvhost-user.c      |  15 +-
 contrib/libvhost-user/libvhost-user.h      |  21 +
 hw/core/qdev-properties.c                  |  31 +-
 softmmu/vl.c                               |   4 +
 tests/qtest/libqos/libqtest.h              |  17 +
 tests/qtest/libqos/meson.build             |   1 +
 tests/qtest/libqos/vhost-user-blk.c        | 129 ++++
 tests/qtest/libqos/vhost-user-blk.h        |  48 ++
 tests/qtest/libqtest.c                     |  36 +-
 tests/qtest/meson.build                    |   4 +-
 tests/qtest/vhost-user-blk-test.c          | 751 +++++++++++++++++++++
 tests/vhost-user-bridge.c                  |   2 +
 tools/virtiofsd/fuse_virtio.c              |   4 +-
 util/block-helpers.c                       |  46 ++
 util/block-helpers.h                       |  19 +
 util/meson.build                           |   2 +
 util/vhost-user-server.c                   | 428 ++++++++++++
 util/vhost-user-server.h                   |  65 ++
 23 files changed, 2292 insertions(+), 39 deletions(-)
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
2.28.0



Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53882C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F84320674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnMFeQgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F84320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFID-0003Am-7t
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1jBFGt-0001gU-Tp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1jBFGs-00089S-Kx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:27 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1jBFGs-00089A-Cr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:26 -0400
Received: by mail-pj1-x1041.google.com with SMTP id y7so771938pjn.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oiwse/YzcLSP3TKb1cI5ve515PYVpRW0oxbEWocif88=;
 b=dnMFeQgAEYC937YKP0+MBhTVHqraxXC+5QCavH8DLXQNXjFnaeQzQSGjcviqyxT3CZ
 ZqcCxp8YGDXZ+906Xxw/rvY/kCoXgu4uCcK0baAVDWNebId2eQpLEUEMJIUO/43lq7o6
 TMcv4/h4NtA6UBGQwyD9t2YqDl+8J70HtsnL8hN4JWcGh9pbIS6fahmQ3IfKpT7T6d9x
 fn3orOZSEPqP5nQ/YWWJlPxeNNzKYP58GogZHH43n1v8JP4RPcXagFiOQBWMajjxPPwa
 GTeK3nlSCjJDDFYC6i4dAfpiS9yRDCIFgGl2p8t02GTcMvIw9dKqF4JQ0xrbkb8rvOXi
 ZeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oiwse/YzcLSP3TKb1cI5ve515PYVpRW0oxbEWocif88=;
 b=ozli4p/P3nTFpVoMvGryFXOEwnFvo5cf568/U98nKnQk/lSR/X0rdLRWtj58UU/PlP
 XkZ4JxQCmcoCWjXwvwP9VS4AjuV0d0ZI/G2D0s7Pgi4BydtQnnO4waRCxhUMtYPA/QHw
 sOWy4zfBTKugKQDgP3iUs7N4rfvtq9p+0YyB2t9F+pWumPtGdIGiNCw9ka+twDk03rwg
 EfAupnoxWk+59l3A+MbV+b6Svi9lvw5cpo4LaAG0yJ3PuTFBDZjOUXepv5Z4dvXRV4c1
 cyq2wmkPA09EqD/ek3obnSk52EFAfRm2TixdybzJC3aEpJpnU62uOUCvMUWMoGJUIqTL
 GAjQ==
X-Gm-Message-State: ANhLgQ0VG+im1s9vtakXTIekcNvJnvzawrLPfAIxqjmHmld6emIZvwbP
 KwUcPpvBoLY909tZBxEG7PrvXHIOQ8XbVw==
X-Google-Smtp-Source: ADFU+vt3f3zBj69uAYItAykB4PQawXgsn0F0f5tZmB7eYvm6893G8fz4e/u/zBoooSjFnDBZTDoOwA==
X-Received: by 2002:a17:902:76c8:: with SMTP id
 j8mr14791662plt.273.1583748264694; 
 Mon, 09 Mar 2020 03:04:24 -0700 (PDT)
Received: from localhost.localdomain
 (tunnel571398-pt.tunnel.tserv14.sea1.ipv6.he.net. [2001:470:a:247::2])
 by smtp.googlemail.com with ESMTPSA id s21sm16077377pfd.99.2020.03.09.03.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 03:04:24 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/5] vhost-user block device backend implementation
Date: Mon,  9 Mar 2020 18:03:37 +0800
Message-Id: <20200309100342.14921-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
  allow vu_message_read to be replaced
  generic vhost user server
  vhost-user block device backend server
  a standone-alone tool to directly share disk image file via vhost-user
    protocol
  new qTest case to test the vhost-user-blk-server

 Makefile                                   |   4 +
 block/Makefile.objs                        |   3 +
 block/export/vhost-user-blk-server.c       | 727 +++++++++++++++++++++
 block/export/vhost-user-blk-server.h       |  21 +
 configure                                  |   3 +
 contrib/libvhost-user/libvhost-user-glib.c |   2 +-
 contrib/libvhost-user/libvhost-user.c      |  10 +-
 contrib/libvhost-user/libvhost-user.h      |   6 +
 qemu-vu.c                                  | 252 +++++++
 softmmu/vl.c                               |   4 +
 tests/Makefile.include                     |   3 +-
 tests/qtest/Makefile.include               |   2 +
 tests/qtest/libqos/vhost-user-blk.c        | 126 ++++
 tests/qtest/libqos/vhost-user-blk.h        |  44 ++
 tests/qtest/vhost-user-blk-test.c          | 694 ++++++++++++++++++++
 tests/vhost-user-bridge.c                  |   2 +
 tools/virtiofsd/fuse_virtio.c              |   4 +-
 util/Makefile.objs                         |   3 +
 util/vhost-user-server.c                   | 360 ++++++++++
 util/vhost-user-server.h                   |  57 ++
 20 files changed, 2318 insertions(+), 9 deletions(-)
 create mode 100644 block/export/vhost-user-blk-server.c
 create mode 100644 block/export/vhost-user-blk-server.h
 create mode 100644 qemu-vu.c
 create mode 100644 tests/qtest/libqos/vhost-user-blk.c
 create mode 100644 tests/qtest/libqos/vhost-user-blk.h
 create mode 100644 tests/qtest/vhost-user-blk-test.c
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

--
2.25.1



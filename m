Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00698C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF6C2075B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0WozVzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF6C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgzPZ-00036r-2A
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 19:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgzOv-0002Jm-6r
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 19:35:57 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:54093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgzOt-0004tS-96
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 19:35:56 -0400
Received: by mail-pj1-x1036.google.com with SMTP id i12so1784391pju.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vfU+5soti4/GOU44IAzpfLG0Qw2ObTLZSwjYGjbQTMc=;
 b=I0WozVzY7snDC/Ql7+LPrOIo5rHd9tOWz6BmdYQLbQm3oJZaHhDUYwnCrrGmd2SDvx
 wtzbaPbeV/oNCsc7+57YB/kmxkHJUBxJ09qGD/buser7UjseHp4XzOFArgPGJ0MN3oc+
 XIgp6VpFnyjAk4tZI0+b8eIUKh8Mlm2z3YQslT2ecYxeL8H2K7LoZ0qyZ3GTMh/SZwKd
 9Sb404iMI+X0i1Q8kpz84Leb33rpeH8Rcqc8mYSoBOrE7himh1d8OXMIBRrqdfEFBe4B
 0JsaYO6Ldi5YhSg9GFEjk0VZEpaoWDJFswrMwFSLrdGGVTfFU2yongCKxJO0cLJTnR4p
 Y4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vfU+5soti4/GOU44IAzpfLG0Qw2ObTLZSwjYGjbQTMc=;
 b=s1g/qvs3pMr1FfMhuekt68riYMjf1pmh5vdoNoom5npjHHng/TA3ZLVVFvdrM8DO99
 f94WiCMQM3wvo/rrSjqxsK6di+7gi0DF5GxkaLpGYqPyCvyPB5D4NS9hAn21PEAAh5zp
 zF+I+hd3YfF+/kFotMgggGbOoWDPVBWiBQsMs8hPwsCRwcf9T/9bcuCzHE0EkqkHUECS
 M2K5OgJX9ZmHFvOPpWqS4gupHQNM/nTDVftdORYjL8HUEFaHdsC1To0UstNMX1hmBijy
 9E6GZm4ESQXbcG6lmGIBQMkPf6Ti0Vg4gxmrOq0Iti+kL/3Nd1wbKVWCxdmz3Z95vyiO
 WW0w==
X-Gm-Message-State: AOAM531oy8o3ko//3UEctSsvBzVx/W92BNcmUnD+cdS9ilY7RZp+ykF3
 I6eHmA0vw4g+3tiC5YIRtl43FEdTu4GsY6hA
X-Google-Smtp-Source: ABdhPJw04iTv6eFjzAvByCd+US7uW4VCVOoGLcRHnVL+XOHRtFHzsud2KWlmC4qmXXbsbLmTjzT2ow==
X-Received: by 2002:a17:902:103:: with SMTP id 3mr7161489plb.325.1591313753469; 
 Thu, 04 Jun 2020 16:35:53 -0700 (PDT)
Received: from localhost (tunnel570486-pt.tunnel.tserv25.sin1.ipv6.he.net.
 [2001:470:35:3d5::2])
 by smtp.gmail.com with ESMTPSA id l186sm5380754pfl.191.2020.06.04.16.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 16:35:52 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 0/4] vhost-user block device backend implementation
Date: Fri,  5 Jun 2020 07:35:34 +0800
Message-Id: <20200604233538.256325-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1036.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

 (qemu) object_add vhost-user-blk-server,id=ID,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512
 (qemu) object_del ID

or appending the "-object" option when starting QEMU,

  $ -object vhost-user-blk-server,id=disk,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512

Then vhost-user client can connect to the server backend.
For example, QEMU could act as a client,

  $ -m 256 -object memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem -chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device vhost-user-blk-pci,id=blk0,chardev=char1

And guest OS could access this vhost-user block device after mounting it.

Coiby Xu (4):
  Allow vu_message_read to be replaced
  generic vhost user server
  vhost-user block device backend server
  new qTest case to test the vhost-user-blk-server

 block/Makefile.objs                        |   1 +
 block/export/vhost-user-blk-server.c       | 716 ++++++++++++++++++++
 block/export/vhost-user-blk-server.h       |  34 +
 contrib/libvhost-user/libvhost-user-glib.c |   2 +-
 contrib/libvhost-user/libvhost-user.c      |  11 +-
 contrib/libvhost-user/libvhost-user.h      |  21 +
 softmmu/vl.c                               |   4 +
 tests/Makefile.include                     |   3 +-
 tests/qtest/Makefile.include               |   2 +
 tests/qtest/libqos/vhost-user-blk.c        | 130 ++++
 tests/qtest/libqos/vhost-user-blk.h        |  44 ++
 tests/qtest/libqtest.c                     |  54 +-
 tests/qtest/libqtest.h                     |  38 ++
 tests/qtest/vhost-user-blk-test.c          | 737 +++++++++++++++++++++
 tests/vhost-user-bridge.c                  |   2 +
 tools/virtiofsd/fuse_virtio.c              |   4 +-
 util/Makefile.objs                         |   1 +
 util/vhost-user-server.c                   | 406 ++++++++++++
 util/vhost-user-server.h                   |  59 ++
 19 files changed, 2229 insertions(+), 40 deletions(-)
 create mode 100644 block/export/vhost-user-blk-server.c
 create mode 100644 block/export/vhost-user-blk-server.h
 create mode 100644 tests/qtest/libqos/vhost-user-blk.c
 create mode 100644 tests/qtest/libqos/vhost-user-blk.h
 create mode 100644 tests/qtest/vhost-user-blk-test.c
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

--
2.26.2



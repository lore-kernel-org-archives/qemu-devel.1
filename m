Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FD820665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dflyx23m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FD820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7rB-000201-He
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7ph-0000yC-8m
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:07:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7pd-0001pt-Ih
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604930860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1VQyBj6lMnBA6tZH49jGG2rJ56sZOzdv92YtsNDmmrE=;
 b=dflyx23mKBQLCAlK4fNSYqMCJQjx+pljdfZFnuAm1D1E3G+gpToLomCXBri3dATOUhYDfq
 puJziXYWsfJiw0o0leb64bHpPHZOlZiRhCi2gICAlJyQpujteIXzExTL0e4M91pqgojxUP
 jvq+wxgybcSzED0bFZW2L8kUyTqLuRs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-v3pvMUosM_KMwmKfq4GCsA-1; Mon, 09 Nov 2020 09:07:34 -0500
X-MC-Unique: v3pvMUosM_KMwmKfq4GCsA-1
Received: by mail-wm1-f72.google.com with SMTP id a130so3465334wmf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1VQyBj6lMnBA6tZH49jGG2rJ56sZOzdv92YtsNDmmrE=;
 b=JPwgmyAJ7HJy3UJd/yDnxgzrV1XgVWBHR0esVrFxwRB2HtXPESjbEcigxhdrzQMask
 eF7icWW/RZ0FvRuN6QbpMWBGc3JXENzAOI15vMkbI4YKYqGAXT2RNssiW6IuaCABe/v1
 b+M3MG/x5q3v2MFrOFG0MYnhimmHlX0vVVQ4YLmRBJVTyoz5Gcv/kgmJK6t9k9vOOcf+
 1Qtr58u9soDBxRKNydYOw2lU4f6cGyVWtWg5zt7T4zRkHny8xpCzSgSFLcqdN1DB7uV4
 vBlMdYQU180GqEu7mDc6G+3yEIfTOXryC+/uZaVe3AgIluuhIo2mYQtHC9Wo8u2HN3TK
 2fwg==
X-Gm-Message-State: AOAM5321c2XUZAvRHElS5N1muJZ4DU2E+SXbOA5by5+i/Q3vXV6PHDTQ
 05HjTiuWVi9uPhGz3OaBHjjjN5LQNAWFyaxsnxw6KElmNbYJuMfmiJZiuqx4lRvsh42ml9tdqUz
 Gc/gEQHejpijIcLM=
X-Received: by 2002:a5d:51c1:: with SMTP id n1mr12501919wrv.395.1604930852806; 
 Mon, 09 Nov 2020 06:07:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrjkesMI/jvWt/mqoK7xzbxZAMEtd2LMBU3vTU0str2W/t58EulDls+HDTgylbTMjxUYJw7g==
X-Received: by 2002:a5d:51c1:: with SMTP id n1mr12501888wrv.395.1604930852452; 
 Mon, 09 Nov 2020 06:07:32 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id j13sm13140771wrt.80.2020.11.09.06.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 06:07:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3] configure: Check vhost-user is available for
 vhost-user-blk-server
Date: Mon,  9 Nov 2020 15:07:30 +0100
Message-Id: <20201109140730.2600017-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check vhost-user is available when building vhost-user-blk-server.

This fixes:

 $ ../configure \
      --disable-vhost-user --enable-vhost-user-blk-server && \
   make qemu-nbd
 ...
 [505/505] Linking target qemu-nbd
 FAILED: qemu-nbd
 cc  -o qemu-nbd qemu-nbd.p/qemu-nbd.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa -Wl,--no-whole-archive -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -m64 -fstack-protector-strong -Wl,--start-group libqemuutil.a libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa @block.syms -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -pthread -lgnutls -lutil -lm -lgthread-2.0 -lglib-2.0 -lbz2 -lgthread-2.0 -lglib-2.0 -lssh -lrbd -lrados -lcurl -lxml2 -lzstd -lacl -lgfapi -lglusterfs -lgfrpc -lgfxdr -luuid -laio /usr/lib64/libz.so -L/usr/lib64/iscsi -liscsi -lnettle -lgnutls -lpam -Wl,--end-group
 /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_process_vq':
 block/export/vhost-user-blk-server.c:203: undefined reference to `vu_get_queue'
 /usr/bin/ld: block/export/vhost-user-blk-server.c:208: undefined reference to `vu_queue_pop'
 /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
 block/export/vhost-user-blk-server.c:228: undefined reference to `vu_get_queue'
 /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_req_complete':
 block/export/vhost-user-blk-server.c:55: undefined reference to `vu_queue_push'
 /usr/bin/ld: block/export/vhost-user-blk-server.c:56: undefined reference to `vu_queue_notify'
 /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
 block/export/vhost-user-blk-server.c:229: undefined reference to `vu_set_queue_handler'
 /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_client_trip':
 util/vhost-user-server.c:176: undefined reference to `vu_dispatch'
 /usr/bin/ld: util/vhost-user-server.c:180: undefined reference to `vu_deinit'
 /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_accept':
 util/vhost-user-server.c:291: undefined reference to `vu_init'
 collect2: error: ld returned 1 exit status
 ninja: build stopped: subcommand failed.
 make: *** [Makefile:171: run-ninja] Error 1

Now we get:

 $ ../configure \
      --disable-vhost-user --enable-vhost-user-blk-server && \
 ERROR: --enable-vhost-user-blk-server requires --enable-vhost-user

Fixes: bc15e44cb21 ("configure: introduce --enable-vhost-user-blk-server")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Since v1:
- Addressed Thomas review comments
https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg02188.html
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 805f7791503..3124be82da1 100755
--- a/configure
+++ b/configure
@@ -2375,6 +2375,10 @@ test "$vhost_user_fs" = "" && vhost_user_fs=$vhost_user
 if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
   error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
 fi
+test "$vhost_user_blk_server" = "" && vhost_user_blk_server=$vhost_user
+if test "$vhost_user_blk_server" = "yes" && test "$vhost_user" = "no"; then
+  error_exit "--enable-vhost-user-blk-server requires --enable-vhost-user"
+fi
 #vhost-vdpa backends
 test "$vhost_net_vdpa" = "" && vhost_net_vdpa=$vhost_vdpa
 if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
-- 
2.26.2



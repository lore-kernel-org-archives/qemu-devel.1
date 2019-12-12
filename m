Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2EFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EA6214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBRVus+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EA6214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRhP-0001ug-E6
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVK-0005Ob-Pl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVJ-0001dD-FH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49152
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVJ-0001cT-Ah
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTx+GKJ25A7Hkl3M7fPSzFynCUZJjjcDWcOEEEe/PAg=;
 b=XBRVus+rzxYe9TDiOY3Zl6emrodMlC01Nlx68CKLpmjWB7dQIlgfZ8qNRHl4KzXC/Xe5SI
 PFVB0qnu2K1vvbgk+a8PGQtINHWOKIL4N7IQG0Z/YJm7svvwMcfOoUwgScjjSw9XxvIy9s
 KF32dGp8IaUOs9ojOMtQ92mRz2wXuCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-95ZC5Lr0On-f55YYT4FWFg-1; Thu, 12 Dec 2019 11:39:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE4EA1005512
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:50 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E71EE60BE1;
 Thu, 12 Dec 2019 16:39:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 025/104] virtiofsd: Add Makefile wiring for virtiofsd contrib
Date: Thu, 12 Dec 2019 16:37:45 +0000
Message-Id: <20191212163904.159893-26-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 95ZC5Lr0On-f55YYT4FWFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Wire up the building of the virtiofsd in contrib.

virtiofsd relies on Linux-specific system calls and seccomp.  Anyone
wishing to port it to other host operating systems should do so
carefully and without reducing security.

Only allow building on Linux hosts.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile                      |  8 ++++++++
 Makefile.objs                 |  1 +
 tools/virtiofsd/Makefile.objs | 10 ++++++++++
 3 files changed, 19 insertions(+)
 create mode 100644 tools/virtiofsd/Makefile.objs

diff --git a/Makefile b/Makefile
index b437a346d7..b7f7019a50 100644
--- a/Makefile
+++ b/Makefile
@@ -322,6 +322,8 @@ HELPERS-y =3D
 HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D qemu-bridge-hel=
per$(EXESUF)
=20
 ifdef CONFIG_LINUX
+HELPERS-y +=3D virtiofsd$(EXESUF)
+
 ifdef CONFIG_VIRGL
 ifdef CONFIG_GBM
 HELPERS-y +=3D vhost-user-gpu$(EXESUF)
@@ -430,6 +432,7 @@ dummy :=3D $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
+                virtiofsd-obj-y \
                 rdmacm-mux-obj-y \
                 libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
@@ -674,6 +677,11 @@ rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 =09$(call LINK, $^)
=20
+ifdef CONFIG_LINUX # relies on Linux-specific syscalls
+virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
+=09$(call LINK, $^)
+endif
+
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) li=
bqemuutil.a libqemustub.a
 =09$(call LINK, $^)
=20
diff --git a/Makefile.objs b/Makefile.objs
index 11ba1a36bd..b5f667a4ba 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -125,6 +125,7 @@ vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
 rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
 vhost-user-input-obj-y =3D contrib/vhost-user-input/
 vhost-user-gpu-obj-y =3D contrib/vhost-user-gpu/
+virtiofsd-obj-y =3D tools/virtiofsd/
=20
 ######################################################################
 trace-events-subdirs =3D
diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.objs
new file mode 100644
index 0000000000..67be16332c
--- /dev/null
+++ b/tools/virtiofsd/Makefile.objs
@@ -0,0 +1,10 @@
+virtiofsd-obj-y =3D buffer.o \
+                  fuse_opt.o \
+                  fuse_log.o \
+                  fuse_loop_mt.o \
+                  fuse_lowlevel.o \
+                  fuse_signals.o \
+                  fuse_virtio.o \
+                  helper.o \
+                  passthrough_ll.o
+
--=20
2.23.0



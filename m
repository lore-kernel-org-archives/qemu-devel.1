Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4646BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1193920684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg18EybC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1193920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVsy-0003f3-RH
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQl-00047e-As
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQf-0004K4-9j
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVQd-0004J5-BM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Dr6fsxLlWo66vt0ZJ7H8FDSelETVJXpGSfFe9MgsrY=;
 b=Dg18EybCXsiPGYXJxMOOi5efJN1dhyx2YmPmZwiynzC9qAQ9v2WmJmWL4chm0XeSc4Tkes
 1c5kkvnv9Oc2Y0qY/xMscldGASBqhJpwueUmyju7Sb47WOPbgSIYOmBcoMe+rxN/I8VMtM
 5RXXQMSz+CJt3xmY7MV5jyKmUcQmNUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-50Bnr8ceO567ZsmN9gAgQg-1; Mon, 21 Oct 2019 07:00:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DAE647B;
 Mon, 21 Oct 2019 11:00:40 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A3EE6060D;
 Mon, 21 Oct 2019 11:00:35 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 24/30] virtiofsd: Add Makefile wiring for virtiofsd contrib
Date: Mon, 21 Oct 2019 11:58:26 +0100
Message-Id: <20191021105832.36574-25-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 50Bnr8ceO567ZsmN9gAgQg-1
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
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
 Makefile                        |  8 ++++++++
 Makefile.objs                   |  1 +
 contrib/virtiofsd/Makefile.objs | 10 ++++++++++
 3 files changed, 19 insertions(+)
 create mode 100644 contrib/virtiofsd/Makefile.objs

diff --git a/Makefile b/Makefile
index d20e7ffce3..694a871384 100644
--- a/Makefile
+++ b/Makefile
@@ -316,6 +316,8 @@ HELPERS-y =3D
 HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D qemu-bridge-hel=
per$(EXESUF)
=20
 ifdef CONFIG_LINUX
+HELPERS-y +=3D virtiofsd$(EXESUF)
+
 ifdef CONFIG_VIRGL
 ifdef CONFIG_GBM
 HELPERS-y +=3D vhost-user-gpu$(EXESUF)
@@ -423,6 +425,7 @@ dummy :=3D $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
+                virtiofsd-obj-y \
                 rdmacm-mux-obj-y \
                 libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
@@ -658,6 +661,11 @@ rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
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
index abcbd89654..24d0b56f1f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -125,6 +125,7 @@ vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
 rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
 vhost-user-input-obj-y =3D contrib/vhost-user-input/
 vhost-user-gpu-obj-y =3D contrib/vhost-user-gpu/
+virtiofsd-obj-y =3D contrib/virtiofsd/
=20
 ######################################################################
 trace-events-subdirs =3D
diff --git a/contrib/virtiofsd/Makefile.objs b/contrib/virtiofsd/Makefile.o=
bjs
new file mode 100644
index 0000000000..67be16332c
--- /dev/null
+++ b/contrib/virtiofsd/Makefile.objs
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



Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4295C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BCD821D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ef+UxdrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCD821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhO9-0002BC-9G
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdh-0004iz-Pe
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdg-0006PN-0n
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdf-0006Oq-US
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqDg9C7PF4ZP+PGW/TCsORhZSISTuzgb3iowwgktUSs=;
 b=Ef+UxdrZ08anM/2rvCJRMr7t36G36dQu540o4TxvD7+A1umsdQWdFr9pmoMUz7ZqDVU/Jc
 jcCxdYZs8JE3cTi5KExaW/qnwhdCInDUC9p++M4PwHkzwvU30qNIuR8PD6oPT+A5CPM2AI
 8NxnTsYQElWvhFLp5NO9gP6KwVAwS1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-nCsTHDsMMum7MvwizmUezg-1; Thu, 23 Jan 2020 11:47:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25DAF8C04C2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:22 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6134128991;
 Thu, 23 Jan 2020 16:47:21 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 027/108] virtiofsd: Add Makefile wiring for virtiofsd contrib
Date: Thu, 23 Jan 2020 16:45:09 +0000
Message-Id: <20200123164630.91498-28-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: nCsTHDsMMum7MvwizmUezg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Wire up the building of the virtiofsd in tools.

virtiofsd relies on Linux-specific system calls and seccomp.  Anyone
wishing to port it to other host operating systems should do so
carefully and without reducing security.

Only allow building on Linux hosts.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 Makefile                      | 10 ++++++++++
 Makefile.objs                 |  1 +
 tools/virtiofsd/Makefile.objs |  9 +++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 tools/virtiofsd/Makefile.objs

diff --git a/Makefile b/Makefile
index 6562b0dc97..ef1e2155a7 100644
--- a/Makefile
+++ b/Makefile
@@ -327,6 +327,10 @@ HELPERS-y +=3D vhost-user-gpu$(EXESUF)
 vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
=20
+ifdef CONFIG_LINUX
+HELPERS-y +=3D virtiofsd$(EXESUF)
+endif
+
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -429,6 +433,7 @@ dummy :=3D $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
+                virtiofsd-obj-y \
                 rdmacm-mux-obj-y \
                 libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
@@ -668,6 +673,11 @@ rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
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
index 7c1e50f9d6..ff396b9209 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -123,6 +123,7 @@ vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
 rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
 vhost-user-input-obj-y =3D contrib/vhost-user-input/
 vhost-user-gpu-obj-y =3D contrib/vhost-user-gpu/
+virtiofsd-obj-y =3D tools/virtiofsd/
=20
 ######################################################################
 trace-events-subdirs =3D
diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.objs
new file mode 100644
index 0000000000..45a807500d
--- /dev/null
+++ b/tools/virtiofsd/Makefile.objs
@@ -0,0 +1,9 @@
+virtiofsd-obj-y =3D buffer.o \
+                  fuse_opt.o \
+                  fuse_log.o \
+                  fuse_lowlevel.o \
+                  fuse_signals.o \
+                  fuse_virtio.o \
+                  helper.o \
+                  passthrough_ll.o
+
--=20
2.24.1



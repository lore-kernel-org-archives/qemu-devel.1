Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14404C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57CC20702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ak++zgi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57CC20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47541 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw7DS-0004to-Vy
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iw7Cc-0004Sd-6L
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iw7Ca-0003PH-Er
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:25:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iw7Ca-0003Ox-AH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580142327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7vRasnHn1TWS1kkDbzF6M4jxihQyaS0r7w9JAUdETvQ=;
 b=ak++zgi/taRdOKA4txxS/zeGJBEH/9fzu12s0C2y8PiwpGBOKVSa8Nh4krUqUKCnUWIlWK
 HpJEXdbrJdGSvk0c11r9xfeBgpMF88kQG1U0rQ365WbnYiTHPu2hW9RFqqcEFXV/NXxPxa
 MHmwZciQFiR7AR3NVr98GSrcH1FlSto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-oFmbMbrTOlWwUPFVX2yqxg-1; Mon, 27 Jan 2020 11:25:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D70D109B318;
 Mon, 27 Jan 2020 16:25:21 +0000 (UTC)
Received: from localhost (ovpn-117-180.ams2.redhat.com [10.36.117.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF05E60C05;
 Mon, 27 Jan 2020 16:25:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: add virtiofsd(1) man page
Date: Mon, 27 Jan 2020 16:25:14 +0000
Message-Id: <20200127162514.56784-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: oFmbMbrTOlWwUPFVX2yqxg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document the virtiofsd(1) program and its command-line options.  This
man page is a rST conversion of the original texi documentation that I
wrote.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Based-on: 20200124162606.8787-1-peter.maydell@linaro.org
          ("[PATCH v2 0/8] qemu-img, qemu-trace-stap, virtfs-proxy-helper: =
convert to rST")
---
 MAINTAINERS                |   1 +
 Makefile                   |   8 ++-
 docs/interop/conf.py       |   5 +-
 docs/interop/index.rst     |   1 +
 docs/interop/virtiofsd.rst | 123 +++++++++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 docs/interop/virtiofsd.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 83fb32b860..1da0709129 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1603,6 +1603,7 @@ S: Supported
 F: tools/virtiofsd/*
 F: hw/virtio/vhost-user-fs*
 F: include/hw/virtio/vhost-user-fs.h
+F: docs/interop/virtiofsd.rst
=20
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
diff --git a/Makefile b/Makefile
index 539f9ef079..ecd26044bc 100644
--- a/Makefile
+++ b/Makefile
@@ -348,6 +348,9 @@ DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1
 DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-img.1
 DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
 DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-ga.8
+ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
+DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtiofsd.1
+endif
 DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
 DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/=
interop/qemu-qmp-ref.7
 DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/in=
terop/qemu-ga-ref.7
@@ -861,6 +864,9 @@ ifdef CONFIG_VIRTFS
 =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 =09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 "$(DES=
TDIR)$(mandir)/man1"
 endif
+ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
+=09$(INSTALL_DATA) docs/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
+endif
=20
 install-datadir:
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
@@ -1052,7 +1058,7 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manual-d=
eps,system)
=20
 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
-       virtfs-proxy-helper.1,\
+       virtiofsd.1 virtfs-proxy-helper.1,\
        $(SRC_PATH/qemu-img-cmds.hx))
=20
 $(call define-manpage-rule,system,qemu-block-drivers.7)
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index b0f322207c..b3cda17042 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -27,5 +27,8 @@ man_pages =3D [
      [], 1),
     ('virtfs-proxy-helper', 'virtfs-proxy-helper',
      u'QEMU 9p virtfs proxy filesystem helper',
-     ['M. Mohan Kumar'], 1)
+     ['M. Mohan Kumar'], 1),
+    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system daemon'=
,
+     ['Stefan Hajnoczi <stefanha@redhat.com>',
+      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 3b763b1eeb..e8455b4270 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -24,3 +24,4 @@ Contents:
    vhost-user
    vhost-user-gpu
    virtfs-proxy-helper
+   virtiofsd
diff --git a/docs/interop/virtiofsd.rst b/docs/interop/virtiofsd.rst
new file mode 100644
index 0000000000..51a657ac0c
--- /dev/null
+++ b/docs/interop/virtiofsd.rst
@@ -0,0 +1,123 @@
+QEMU virtio-fs shared file system daemon
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Synopsis
+--------
+
+**virtiofsd** [*OPTIONS*]
+
+Description
+-----------
+
+Share a host directory tree with a guest through a virtio-fs device.  This
+program is a vhost-user backend that implements the virtio-fs device.  Eac=
h
+virtio-fs device instance requires its own virtiofsd process.
+
+This program is designed to work with QEMU's ``--device vhost-user-fs-pci`=
`
+but should work with any virtual machine monitor (VMM) that supports
+vhost-user.  See the Examples section below.
+
+This program must be run as the root user.  Upon startup the program will
+switch into a new file system namespace with the shared directory tree as =
its
+root.  This prevents "file system escapes" due to symlinks and other file
+system objects that might lead to files outside the shared directory.  The
+program also sandboxes itself using seccomp(2) to prevent ptrace(2) and ot=
her
+vectors that could allow an attacker to compromise the system after gainin=
g
+control of the virtiofsd process.
+
+Options
+-------
+
+.. program:: virtiofsd
+
+.. option:: -h, --help
+
+  Print help.
+
+.. option:: -V, --version
+
+  Print version.
+
+.. option:: -d
+
+  Enable debug output.
+
+.. option:: --syslog
+
+  Print log messages to syslog instead of stderr.
+
+.. option:: -o OPTION
+
+  * debug -
+    Enable debug output.
+
+  * flock|no_flock -
+    Enable/disable flock.  The default is ``no_flock``.
+
+  * log_level=3DLEVEL -
+    Print only log messages matching LEVEL or more severe.  LEVEL is one o=
f
+    ``err``, ``warn``, ``info``, or ``debug``.  The default is ``info``.
+
+  * norace -
+    Disable racy fallback.  The default is false.
+
+  * posix_lock|no_posix_lock -
+    Enable/disable remote POSIX locks.  The default is ``posix_lock``.
+
+  * readdirplus|no_readdirplus -
+    Enable/disable readdirplus.  The default is ``readdirplus``.
+
+  * source=3DPATH -
+    Share host directory tree located at PATH.  This option is required.
+
+  * timeout=3DTIMEOUT -
+    I/O timeout in seconds.  The default depends on cache=3D option.
+
+  * vhost_user_socket=3DPATH -
+    Listen on vhost-user UNIX domain socket at PATH.
+
+  * writeback|no_writeback -
+    Enable/disable writeback cache. The cache alows the FUSE client to buf=
fer
+    and merge write requests.  The default is ``no_writeback``.
+
+  * xattr|no_xattr -
+    Enable/disable extended attributes (xattr) on files and directories.  =
The
+    default is ``no_xattr``.
+
+.. option:: --socket-path=3DPATH
+
+  Listen on vhost-user UNIX domain socket at PATH.
+
+.. option:: --fd=3DFDNUM
+
+  Accept connections from vhost-user UNIX domain socket file descriptor FD=
NUM.
+  The file descriptor must already be listening for connections.
+
+.. option:: --thread-pool-size=3DNUM
+
+  Restrict the number of worker threads per request queue to NUM.  The def=
ault
+  is 64.
+
+.. option:: --cache=3Dnone|auto|always
+
+  Select the desired trade-off between coherency and performance.  ``none`=
`
+  forbids the FUSE client from caching to achieve best coherency at the co=
st of
+  performance.  ``auto`` acts similar to NFS with a 1 second metadata cach=
e
+  timeout.  ``always`` sets a long cache lifetime at the expense of cohere=
ncy.
+
+Examples
+--------
+
+Export ``/var/lib/fs/vm001/`` on vhost-user UNIX domain socket
+``/var/run/vm001-vhost-fs.sock``:
+
+::
+
+  host# virtiofsd --socket-path=3D/var/run/vm001-vhost-fs.sock -o source=
=3D/var/lib/fs/vm001
+  host# qemu-system-x86_64 \
+      -chardev socket,id=3Dchar0,path=3D/var/run/vm001-vhost-fs.sock \
+      -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs \
+      -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,s=
hare=3Don \
+      -numa node,memdev=3Dmem \
+      ...
+  guest# mount -t virtio_fs myfs /mnt
--=20
2.24.1



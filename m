Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B65BC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEE120828
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEE120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I8J-0007GX-Ji
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i3Hs9-00057J-Mr
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i3Hs8-0008BV-As
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:41:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i3Hs8-0008A7-0K
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ADABC3001571
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:41:42 +0000 (UTC)
Received: from localhost (ovpn-117-104.ams2.redhat.com [10.36.117.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2DB060923;
 Thu, 29 Aug 2019 10:41:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 11:41:33 +0100
Message-Id: <20190829104133.17418-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 29 Aug 2019 10:41:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] virtiofsd: add man page
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile                         |  7 +++
 contrib/virtiofsd/virtiofsd.texi | 85 ++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 contrib/virtiofsd/virtiofsd.texi

diff --git a/Makefile b/Makefile
index a3dfdd6fa8..cc18025753 100644
--- a/Makefile
+++ b/Makefile
@@ -334,6 +334,9 @@ DOCS+=3Ddocs/qemu-cpu-models.7
 ifdef CONFIG_VIRTFS
 DOCS+=3Dfsdev/virtfs-proxy-helper.1
 endif
+ifdef CONFIG_LINUX
+DOCS+=3Dcontrib/virtiofsd/virtiofsd.1
+endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 DOCS+=3Dscripts/qemu-trace-stap.1
 endif
@@ -834,6 +837,9 @@ ifdef CONFIG_VIRTFS
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
 endif
+ifdef CONFIG_LINUX
+	$(INSTALL_DATA) contrib/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
+endif
=20
 install-datadir:
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
@@ -1018,6 +1024,7 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monito=
r.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
 qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
+contrib/virtiofsd/virtiofsd.1: contrib/virtiofsd/virtiofsd.texi
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 qemu-ga.8: qemu-ga.texi
 docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
diff --git a/contrib/virtiofsd/virtiofsd.texi b/contrib/virtiofsd/virtiof=
sd.texi
new file mode 100644
index 0000000000..eec7fbf4e6
--- /dev/null
+++ b/contrib/virtiofsd/virtiofsd.texi
@@ -0,0 +1,85 @@
+@example
+@c man begin SYNOPSIS
+@command{virtiofsd} [OPTION] @option{--socket-path=3D}@var{path}|@option=
{--fd=3D}@var{fdnum} @option{-o source=3D}@var{path}
+@c man end
+@end example
+
+@c man begin DESCRIPTION
+
+Share a host directory tree with a guest through a virtio-fs device.  Th=
is
+program is a vhost-user backend that implements the virtio-fs device.  E=
ach
+virtio-fs device instance requires its own virtiofsd process.
+
+This program is designed to work with QEMU's @code{--device vhost-user-f=
s-pci}
+but should work with any virtual machine monitor (VMM) that supports
+vhost-user.  See the EXAMPLES section below.
+
+This program must be run as the root user.  Upon startup the program wil=
l
+switch into a new file system namespace with the shared directory tree a=
s its
+root.  This prevents "file system escapes" due to symlinks and other fil=
e
+system objects that might lead to files outside the shared directory.  T=
he
+program also sandboxes itself using seccomp(2) to prevent ptrace(2) and =
other
+vectors that could allow an attacker to compromise the system after gain=
ing
+control of the virtiofsd process.
+
+@c man end
+
+@c man begin OPTIONS
+@table @option
+@item -h, --help
+Print help.
+@item -V, --version
+Print version.
+@item -d, -o debug
+Enable debug output.
+@item --syslog
+Print log messages to syslog instead of stderr.
+@item -o log_level=3D@var{level}
+Print only log messages matching @var{level} or more severe.  @var{level=
} is
+one of @code{err}, @code{warn}, @code{info}, or @code{debug}.  The defau=
lt is
+@var{info}.
+@item -o source=3D@var{path}
+Share host directory tree located at @var{path}.  This option is require=
d.
+@item --socket-path=3D@var{path}, -o vhost_user_socket=3D@var{path}
+Listen on vhost-user UNIX domain socket at @var{path}.
+@item --fd=3D@var{fdnum}
+Accept connections from vhost-user UNIX domain socket file descriptor @v=
ar{fdnum}.  The file descriptor must already be listening for connections=
.
+@item --thread-pool-size=3D@var{num}
+Restrict the number of worker threads per request queue to @var{num}.  T=
he default is 64.
+@item --cache=3D@code{none}|@code{auto}|@code{always}
+Select the desired trade-off between coherency and performance.  @code{n=
one}
+forbids the FUSE client from caching to achieve best coherency at the co=
st of
+performance.  @code{auto} acts similar to NFS with a 1 second metadata c=
ache
+timeout.  @code{always} sets a long cache lifetime at the expense of coh=
erency.
+@item --writeback
+Enable writeback cache, allowing the FUSE client to buffer and merge wri=
te requests.
+@end table
+@c man end
+
+@c man begin EXAMPLES
+Export @code{/var/lib/fs/vm001/} on vhost-user UNIX domain socket @code{=
/var/run/vm001-vhost-fs.sock}:
+
+@example
+host# virtiofsd --socket-path=3D/var/run/vm001-vhost-fs.sock -o source=3D=
/var/lib/fs/vm001
+host# qemu-system-x86_64 \
+    -chardev socket,id=3Dchar0,path=3D/var/run/vm001-vhost-fs.sock \
+    -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs \
+    -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,s=
hare=3Don \
+    -numa node,memdev=3Dmem \
+    ...
+guest# mount -t virtio_fs \
+    -o default_permissions,allow_other,user_id=3D0,group_id=3D0,rootmode=
=3D040000,dax \
+    myfs /mnt
+@end example
+@c man end
+
+@ignore
+@setfilename virtiofsd
+@settitle QEMU virtio-fs shared file system daemon
+
+@c man begin AUTHOR
+Copyright (C) 2019 Red Hat, Inc.
+This is free software; see the source for copying conditions.  There is =
NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE.
+@c man end
+@end ignore
--=20
2.21.0



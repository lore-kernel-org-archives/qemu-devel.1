Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AC6C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9055E217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gzr60tPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9055E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituFp-0006Zq-Ht
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsha-0003Hi-Bn
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itshW-0004n1-Os
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27387
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itshW-0004mm-Kr
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTrM0XC+BoDNjN37Jb9ct5yq0vjmGmSWo3Fs3ZOCpyc=;
 b=Gzr60tPzd9O6OU4edZgG6ZrkFy+1JO461xttrXv2GOfNjPfymmFM6ncS704vobPHlvqXBF
 AHosuxY6pryruEStcgEtzocXrwvg0qYPCk098hfGu8IdcB5N+qpxkUoTC0e4a+icRj620L
 IacVDpHEBYD+At8pH8UillRAh5i5Rxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-G4TMCgA0PYelKYNUEz5fCg-1; Tue, 21 Jan 2020 07:32:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC487107ACC9;
 Tue, 21 Jan 2020 12:32:07 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13CDF60BE0;
 Tue, 21 Jan 2020 12:32:05 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 093/109] virtiofsd: add man page
Date: Tue, 21 Jan 2020 12:24:17 +0000
Message-Id: <20200121122433.50803-94-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: G4TMCgA0PYelKYNUEz5fCg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

with additions by:
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 Makefile                       |   7 +++
 tools/virtiofsd/virtiofsd.texi | 104 +++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tools/virtiofsd/virtiofsd.texi

diff --git a/Makefile b/Makefile
index 2375a1f81c..ba7e2e5ebc 100644
--- a/Makefile
+++ b/Makefile
@@ -353,6 +353,9 @@ DOCS+=3D$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
 DOCS+=3Dfsdev/virtfs-proxy-helper.1
 endif
+ifdef CONFIG_LINUX
+DOCS+=3Dtools/virtiofsd/virtiofsd.1
+endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 DOCS+=3Dscripts/qemu-trace-stap.1
 endif
@@ -857,6 +860,9 @@ ifdef CONFIG_VIRTFS
 =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 =09$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
 endif
+ifdef CONFIG_LINUX
+=09$(INSTALL_DATA) tools/virtiofsd/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
+endif
=20
 install-datadir:
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
@@ -1065,6 +1071,7 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.=
texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
 qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
+tools/virtiofsd/virtiofsd.1: tools/virtiofsd/virtiofsd.texi
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
diff --git a/tools/virtiofsd/virtiofsd.texi b/tools/virtiofsd/virtiofsd.tex=
i
new file mode 100644
index 0000000000..d7a2528f7d
--- /dev/null
+++ b/tools/virtiofsd/virtiofsd.texi
@@ -0,0 +1,104 @@
+@example
+@c man begin SYNOPSIS
+@command{virtiofsd} [OPTION] @option{--socket-path=3D}@var{path}|@option{-=
-fd=3D}@var{fdnum} @option{-o source=3D}@var{path}
+@c man end
+@end example
+
+@c man begin DESCRIPTION
+
+Share a host directory tree with a guest through a virtio-fs device.  This
+program is a vhost-user backend that implements the virtio-fs device.  Eac=
h
+virtio-fs device instance requires its own virtiofsd process.
+
+This program is designed to work with QEMU's @code{--device vhost-user-fs-=
pci}
+but should work with any virtual machine monitor (VMM) that supports
+vhost-user.  See the EXAMPLES section below.
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
+@item -o flock|no_flock
+enable/disable flock.
+The default is @var{no_flock}.
+@item -o log_level=3D@var{level}
+Print only log messages matching @var{level} or more severe.  @var{level} =
is
+one of @code{err}, @code{warn}, @code{info}, or @code{debug}.  The default=
 is
+@var{info}.
+@item -o norace
+Disable racy fallback.
+The default is false.
+@item -o posix_lock|no_posix_lock
+Enable/Disable remote posix lock.
+The default is @var{posix_lock}.
+@item -o readdirplus|no_readdirplus
+Enable/Disable readdirplus.
+The default is @var{readdirplus}
+@item -o source=3D@var{path}
+Share host directory tree located at @var{path}.  This option is required.
+@item -o timeout=3D<number>
+I/O timeout (second).
+The default depends on cache=3D option.
+@item -o writeback|no_writeback
+Enable/Disable writeback cache. The cache alows the FUSE client
+to buffer and merge write requests.
+The default is @var{no_writeback}.
+@item -o xattr|no_xattr
+Enable/Disable Extended attributes (xattr) of the files and directories.
+The default is @var{no_xattr}.
+@item --socket-path=3D@var{path}, -o vhost_user_socket=3D@var{path}
+Listen on vhost-user UNIX domain socket at @var{path}.
+@item --fd=3D@var{fdnum}
+Accept connections from vhost-user UNIX domain socket file descriptor @var=
{fdnum}.  The file descriptor must already be listening for connections.
+@item --thread-pool-size=3D@var{num}
+Restrict the number of worker threads per request queue to @var{num}.  The=
 default is 64.
+@item --cache=3D@code{none}|@code{auto}|@code{always}
+Select the desired trade-off between coherency and performance.  @code{non=
e}
+forbids the FUSE client from caching to achieve best coherency at the cost=
 of
+performance.  @code{auto} acts similar to NFS with a 1 second metadata cac=
he
+timeout.  @code{always} sets a long cache lifetime at the expense of coher=
ency.
+@end table
+@c man end
+
+@c man begin EXAMPLES
+Export @code{/var/lib/fs/vm001/} on vhost-user UNIX domain socket @code{/v=
ar/run/vm001-vhost-fs.sock}:
+
+@example
+host# virtiofsd --socket-path=3D/var/run/vm001-vhost-fs.sock -o source=3D/=
var/lib/fs/vm001
+host# qemu-system-x86_64 \
+    -chardev socket,id=3Dchar0,path=3D/var/run/vm001-vhost-fs.sock \
+    -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs \
+    -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,sha=
re=3Don \
+    -numa node,memdev=3Dmem \
+    ...
+guest# mount -t virtio_fs myfs /mnt
+@end example
+@c man end
+
+@ignore
+@setfilename virtiofsd
+@settitle QEMU virtio-fs shared file system daemon
+
+@c man begin COPYRIGHT
+Copyright (C) 2019-2020 Red Hat, Inc.
+
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
.
+@c man end
+@end ignore
--=20
2.24.1



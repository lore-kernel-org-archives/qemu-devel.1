Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD148C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D9921556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxFAqFeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D9921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSgf-0006Ch-2p
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWy-0007iH-K7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWx-0004i7-51
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWw-0004gm-Ui
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5AO3BjV12qctb9/wSyR/WcWUQ11asDIps1CZbGF1aYw=;
 b=XxFAqFebVxlRxgItQixPjZV8zbVhM+OO0ELeNhLy+MUaBbYX+Cs1LhCNv5/ZwYxOBsOfxI
 GDjtWpJTYqy/l8EUovhDNLGN3rrQ2voIGCW2ir7s0cOv9NrVWyPsxv5pjGVFy1zz/XgnWW
 cpHD/rsfxzbSJKgOJyjt7Yq79Ko4iZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-TQn8XQ_7OpmzJgoAb6TA7Q-1; Thu, 12 Dec 2019 11:41:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 629FD12D6581
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:32 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8724E619A8;
 Thu, 12 Dec 2019 16:41:31 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 092/104] virtiofsd: add man page
Date: Thu, 12 Dec 2019 16:38:52 +0000
Message-Id: <20191212163904.159893-93-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TQn8XQ_7OpmzJgoAb6TA7Q-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile                       |  7 +++
 tools/virtiofsd/virtiofsd.texi | 85 ++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tools/virtiofsd/virtiofsd.texi

diff --git a/Makefile b/Makefile
index fa15174ba0..53d175d12f 100644
--- a/Makefile
+++ b/Makefile
@@ -357,6 +357,9 @@ DOCS+=3Ddocs/qemu-cpu-models.7
 ifdef CONFIG_VIRTFS
 DOCS+=3Dfsdev/virtfs-proxy-helper.1
 endif
+ifdef CONFIG_LINUX
+DOCS+=3Dtools/virtiofsd/virtiofsd.1
+endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 DOCS+=3Dscripts/qemu-trace-stap.1
 endif
@@ -863,6 +866,9 @@ ifdef CONFIG_VIRTFS
 =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 =09$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
 endif
+ifdef CONFIG_LINUX
+=09$(INSTALL_DATA) tools/virtiofsd/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
+endif
=20
 install-datadir:
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
@@ -1061,6 +1067,7 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.=
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
index 0000000000..eec7fbf4e6
--- /dev/null
+++ b/tools/virtiofsd/virtiofsd.texi
@@ -0,0 +1,85 @@
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
+@item -o log_level=3D@var{level}
+Print only log messages matching @var{level} or more severe.  @var{level} =
is
+one of @code{err}, @code{warn}, @code{info}, or @code{debug}.  The default=
 is
+@var{info}.
+@item -o source=3D@var{path}
+Share host directory tree located at @var{path}.  This option is required.
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
+@item --writeback
+Enable writeback cache, allowing the FUSE client to buffer and merge write=
 requests.
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
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
.
+@c man end
+@end ignore
--=20
2.23.0



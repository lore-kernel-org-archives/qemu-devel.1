Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D0C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686A521741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCOWOonv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686A521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06kD-0007OA-Gh
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j06jU-0006wu-5M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j06jR-0000ib-7B
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:43:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60131
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j06jQ-0000h6-FA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581093831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJZzFc4tYwsnobOMqdFK+ts48v8zhN4d0wSXe1xvCy4=;
 b=ZCOWOonvGgup/fUXfgSxJdscIZeebpXwB9qTvQCZX0I4aFYGShWmoYqyjFVVj/Qou0aqmd
 K2AkNufzDfspQ+pcFJKLlCOFSbh72LvygR2iVakzPJTK6KT+eVJFHtKmejneeQVUyODawU
 QFgjoG6N043bJz64e1FheZg1AjScTvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-uM66_Gs1OWyV5AUWIgEFgQ-1; Fri, 07 Feb 2020 11:43:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D465385EE6C;
 Fri,  7 Feb 2020 16:43:46 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB1FB790D8;
 Fri,  7 Feb 2020 16:43:43 +0000 (UTC)
Date: Fri, 7 Feb 2020 16:43:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] docs: add virtiofsd(1) man page
Message-ID: <20200207164340.GL3302@work-vm>
References: <20200207162951.178437-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207162951.178437-1-stefanha@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: uM66_Gs1OWyV5AUWIgEFgQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> Document the virtiofsd(1) program and its command-line options.  This
> man page is a rST conversion of the original texi documentation that I
> wrote.
>=20
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I'll add this to my stack for a virtiofs pull.

Dave


> ---
> v3:
>  * Dropped old -o vhost_user_socket=3DPATH option [dgilbert]
> v2:
>  * Fix mount -t virtio_fs -> virtiofs outdated doc [Liam]
>  * Use memory-backend-memfd instead of memory-backend-file
> ---
>  MAINTAINERS                |   1 +
>  Makefile                   |   9 ++-
>  docs/interop/conf.py       |   5 +-
>  docs/interop/index.rst     |   1 +
>  docs/interop/virtiofsd.rst | 120 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 134 insertions(+), 2 deletions(-)
>  create mode 100644 docs/interop/virtiofsd.rst
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e72b5e5f69..4a118fe504 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1612,6 +1612,7 @@ S: Supported
>  F: tools/virtiofsd/*
>  F: hw/virtio/vhost-user-fs*
>  F: include/hw/virtio/vhost-user-fs.h
> +F: docs/interop/virtiofsd.rst
> =20
>  virtio-input
>  M: Gerd Hoffmann <kraxel@redhat.com>
> diff --git a/Makefile b/Makefile
> index 461d40bea6..f0e1a2fc1d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -348,6 +348,9 @@ DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1
>  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-img.1
>  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
>  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-ga.8
> +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> +DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtiofsd.1
> +endif
>  DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
>  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-qmp-ref.7
>  DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/=
interop/qemu-ga-ref.7
> @@ -861,6 +864,9 @@ ifdef CONFIG_VIRTFS
>  =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
>  =09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 "$(D=
ESTDIR)$(mandir)/man1"
>  endif
> +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> +=09$(INSTALL_DATA) docs/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
> +endif
> =20
>  install-datadir:
>  =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
> @@ -1051,7 +1057,8 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manual=
-deps,system)
>  =09$(call build-manual,system,html)
> =20
>  $(call define-manpage-rule,interop,\
> -       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1 virtfs-proxy-he=
lper.1,\
> +       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
> +       virtiofsd.1 virtfs-proxy-helper.1,\
>         $(SRC_PATH/qemu-img-cmds.hx))
> =20
>  $(call define-manpage-rule,system,qemu-block-drivers.7)
> diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> index b0f322207c..b3cda17042 100644
> --- a/docs/interop/conf.py
> +++ b/docs/interop/conf.py
> @@ -27,5 +27,8 @@ man_pages =3D [
>       [], 1),
>      ('virtfs-proxy-helper', 'virtfs-proxy-helper',
>       u'QEMU 9p virtfs proxy filesystem helper',
> -     ['M. Mohan Kumar'], 1)
> +     ['M. Mohan Kumar'], 1),
> +    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system daemo=
n',
> +     ['Stefan Hajnoczi <stefanha@redhat.com>',
> +      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
>  ]
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index 3b763b1eeb..e8455b4270 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -24,3 +24,4 @@ Contents:
>     vhost-user
>     vhost-user-gpu
>     virtfs-proxy-helper
> +   virtiofsd
> diff --git a/docs/interop/virtiofsd.rst b/docs/interop/virtiofsd.rst
> new file mode 100644
> index 0000000000..378594c422
> --- /dev/null
> +++ b/docs/interop/virtiofsd.rst
> @@ -0,0 +1,120 @@
> +QEMU virtio-fs shared file system daemon
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopsis
> +--------
> +
> +**virtiofsd** [*OPTIONS*]
> +
> +Description
> +-----------
> +
> +Share a host directory tree with a guest through a virtio-fs device.  Th=
is
> +program is a vhost-user backend that implements the virtio-fs device.  E=
ach
> +virtio-fs device instance requires its own virtiofsd process.
> +
> +This program is designed to work with QEMU's ``--device vhost-user-fs-pc=
i``
> +but should work with any virtual machine monitor (VMM) that supports
> +vhost-user.  See the Examples section below.
> +
> +This program must be run as the root user.  Upon startup the program wil=
l
> +switch into a new file system namespace with the shared directory tree a=
s its
> +root.  This prevents "file system escapes" due to symlinks and other fil=
e
> +system objects that might lead to files outside the shared directory.  T=
he
> +program also sandboxes itself using seccomp(2) to prevent ptrace(2) and =
other
> +vectors that could allow an attacker to compromise the system after gain=
ing
> +control of the virtiofsd process.
> +
> +Options
> +-------
> +
> +.. program:: virtiofsd
> +
> +.. option:: -h, --help
> +
> +  Print help.
> +
> +.. option:: -V, --version
> +
> +  Print version.
> +
> +.. option:: -d
> +
> +  Enable debug output.
> +
> +.. option:: --syslog
> +
> +  Print log messages to syslog instead of stderr.
> +
> +.. option:: -o OPTION
> +
> +  * debug -
> +    Enable debug output.
> +
> +  * flock|no_flock -
> +    Enable/disable flock.  The default is ``no_flock``.
> +
> +  * log_level=3DLEVEL -
> +    Print only log messages matching LEVEL or more severe.  LEVEL is one=
 of
> +    ``err``, ``warn``, ``info``, or ``debug``.  The default is ``info``.
> +
> +  * norace -
> +    Disable racy fallback.  The default is false.
> +
> +  * posix_lock|no_posix_lock -
> +    Enable/disable remote POSIX locks.  The default is ``posix_lock``.
> +
> +  * readdirplus|no_readdirplus -
> +    Enable/disable readdirplus.  The default is ``readdirplus``.
> +
> +  * source=3DPATH -
> +    Share host directory tree located at PATH.  This option is required.
> +
> +  * timeout=3DTIMEOUT -
> +    I/O timeout in seconds.  The default depends on cache=3D option.
> +
> +  * writeback|no_writeback -
> +    Enable/disable writeback cache. The cache alows the FUSE client to b=
uffer
> +    and merge write requests.  The default is ``no_writeback``.
> +
> +  * xattr|no_xattr -
> +    Enable/disable extended attributes (xattr) on files and directories.=
  The
> +    default is ``no_xattr``.
> +
> +.. option:: --socket-path=3DPATH
> +
> +  Listen on vhost-user UNIX domain socket at PATH.
> +
> +.. option:: --fd=3DFDNUM
> +
> +  Accept connections from vhost-user UNIX domain socket file descriptor =
FDNUM.
> +  The file descriptor must already be listening for connections.
> +
> +.. option:: --thread-pool-size=3DNUM
> +
> +  Restrict the number of worker threads per request queue to NUM.  The d=
efault
> +  is 64.
> +
> +.. option:: --cache=3Dnone|auto|always
> +
> +  Select the desired trade-off between coherency and performance.  ``non=
e``
> +  forbids the FUSE client from caching to achieve best coherency at the =
cost of
> +  performance.  ``auto`` acts similar to NFS with a 1 second metadata ca=
che
> +  timeout.  ``always`` sets a long cache lifetime at the expense of cohe=
rency.
> +
> +Examples
> +--------
> +
> +Export ``/var/lib/fs/vm001/`` on vhost-user UNIX domain socket
> +``/var/run/vm001-vhost-fs.sock``:
> +
> +::
> +
> +  host# virtiofsd --socket-path=3D/var/run/vm001-vhost-fs.sock -o source=
=3D/var/lib/fs/vm001
> +  host# qemu-system-x86_64 \
> +      -chardev socket,id=3Dchar0,path=3D/var/run/vm001-vhost-fs.sock \
> +      -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs \
> +      -object memory-backend-memfd,id=3Dmem,size=3D4G,share=3Don \
> +      -numa node,memdev=3Dmem \
> +      ...
> +  guest# mount -t virtiofs myfs /mnt
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



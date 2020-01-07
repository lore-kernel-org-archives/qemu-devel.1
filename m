Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E3C33CA1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1642080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9QAjO6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1642080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioo8Q-0006LJ-MI
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ionjy-0005od-Ip
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ionjw-00026B-Qa
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:13:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ionjw-00025m-Lr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578399219;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WukLyzTavMJ/l87sBJDw4RiBiEQjiZ6aualo3TQBDsY=;
 b=N9QAjO6pyAeh/BDLkijCrNTSFB75egKWlZgJanAkVJPwOFXiM35UJd8AVqSEqabdvcQiwD
 31TLiEN5Aaj/dTukBUSPKMyzYqYWgbETGYNsX96/TQCIW1JUk8CUbY2norV8OXld74cUbW
 VKQLD6PcPNFngFGpm7htDUnCOD8dMQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-JxX6OycHNrCJQ9EDxKBmNg-1; Tue, 07 Jan 2020 07:13:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EBFD800D41
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 12:13:37 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D58D5C1B0;
 Tue,  7 Jan 2020 12:13:30 +0000 (UTC)
Date: Tue, 7 Jan 2020 12:13:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 092/104] virtiofsd: add man page
Message-ID: <20200107121328.GD3368802@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-93-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-93-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: JxX6OycHNrCJQ9EDxKBmNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:52PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  Makefile                       |  7 +++
>  tools/virtiofsd/virtiofsd.texi | 85 ++++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 tools/virtiofsd/virtiofsd.texi

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

with some notes at the very end


> diff --git a/Makefile b/Makefile
> index fa15174ba0..53d175d12f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -357,6 +357,9 @@ DOCS+=3Ddocs/qemu-cpu-models.7
>  ifdef CONFIG_VIRTFS
>  DOCS+=3Dfsdev/virtfs-proxy-helper.1
>  endif
> +ifdef CONFIG_LINUX
> +DOCS+=3Dtools/virtiofsd/virtiofsd.1
> +endif
>  ifdef CONFIG_TRACE_SYSTEMTAP
>  DOCS+=3Dscripts/qemu-trace-stap.1
>  endif
> @@ -863,6 +866,9 @@ ifdef CONFIG_VIRTFS
>  =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
>  =09$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1=
"
>  endif
> +ifdef CONFIG_LINUX
> +=09$(INSTALL_DATA) tools/virtiofsd/virtiofsd.1 "$(DESTDIR)$(mandir)/man1=
"
> +endif
> =20
>  install-datadir:
>  =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
> @@ -1061,6 +1067,7 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monito=
r.texi qemu-monitor-info.texi
>  qemu.1: qemu-option-trace.texi
>  qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
>  fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
> +tools/virtiofsd/virtiofsd.1: tools/virtiofsd/virtiofsd.texi
>  qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
>  docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
>  docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
> diff --git a/tools/virtiofsd/virtiofsd.texi b/tools/virtiofsd/virtiofsd.t=
exi
> new file mode 100644
> index 0000000000..eec7fbf4e6
> --- /dev/null
> +++ b/tools/virtiofsd/virtiofsd.texi
> @@ -0,0 +1,85 @@
> +@example
> +@c man begin SYNOPSIS
> +@command{virtiofsd} [OPTION] @option{--socket-path=3D}@var{path}|@option=
{--fd=3D}@var{fdnum} @option{-o source=3D}@var{path}
> +@c man end
> +@end example
> +
> +@c man begin DESCRIPTION
> +
> +Share a host directory tree with a guest through a virtio-fs device.  Th=
is
> +program is a vhost-user backend that implements the virtio-fs device.  E=
ach
> +virtio-fs device instance requires its own virtiofsd process.
> +
> +This program is designed to work with QEMU's @code{--device vhost-user-f=
s-pci}
> +but should work with any virtual machine monitor (VMM) that supports
> +vhost-user.  See the EXAMPLES section below.
> +
> +This program must be run as the root user.

So there's no way for an unprivileged user to do file sharing like they
can with 9p right now ?

>                                              Upon startup the program wil=
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
> +@c man end
> +
> +@c man begin OPTIONS
> +@table @option
> +@item -h, --help
> +Print help.
> +@item -V, --version
> +Print version.
> +@item -d, -o debug
> +Enable debug output.
> +@item --syslog
> +Print log messages to syslog instead of stderr.
> +@item -o log_level=3D@var{level}
> +Print only log messages matching @var{level} or more severe.  @var{level=
} is
> +one of @code{err}, @code{warn}, @code{info}, or @code{debug}.  The defau=
lt is
> +@var{info}.
> +@item -o source=3D@var{path}
> +Share host directory tree located at @var{path}.  This option is require=
d.
> +@item --socket-path=3D@var{path}, -o vhost_user_socket=3D@var{path}
> +Listen on vhost-user UNIX domain socket at @var{path}.
> +@item --fd=3D@var{fdnum}
> +Accept connections from vhost-user UNIX domain socket file descriptor @v=
ar{fdnum}.  The file descriptor must already be listening for connections.
> +@item --thread-pool-size=3D@var{num}
> +Restrict the number of worker threads per request queue to @var{num}.  T=
he default is 64.
> +@item --cache=3D@code{none}|@code{auto}|@code{always}
> +Select the desired trade-off between coherency and performance.  @code{n=
one}
> +forbids the FUSE client from caching to achieve best coherency at the co=
st of
> +performance.  @code{auto} acts similar to NFS with a 1 second metadata c=
ache
> +timeout.  @code{always} sets a long cache lifetime at the expense of coh=
erency.
> +@item --writeback
> +Enable writeback cache, allowing the FUSE client to buffer and merge wri=
te requests.
> +@end table
> +@c man end
> +
> +@c man begin EXAMPLES
> +Export @code{/var/lib/fs/vm001/} on vhost-user UNIX domain socket @code{=
/var/run/vm001-vhost-fs.sock}:
> +
> +@example
> +host# virtiofsd --socket-path=3D/var/run/vm001-vhost-fs.sock -o source=
=3D/var/lib/fs/vm001
> +host# qemu-system-x86_64 \
> +    -chardev socket,id=3Dchar0,path=3D/var/run/vm001-vhost-fs.sock \
> +    -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs \
> +    -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,s=
hare=3Don \
> +    -numa node,memdev=3Dmem \
> +    ...
> +guest# mount -t virtio_fs \
> +    -o default_permissions,allow_other,user_id=3D0,group_id=3D0,rootmode=
=3D040000,dax \
> +    myfs /mnt
> +@end example
> +@c man end
> +
> +@ignore
> +@setfilename virtiofsd
> +@settitle QEMU virtio-fs shared file system daemon
> +
> +@c man begin AUTHOR

s/AUTHOR/COPYRIGHT/

since this isn't providing any author information.

> +Copyright (C) 2019 Red Hat, Inc.

2019-2020 !

And now insert

 @c man end
 @c man begin LICENSE

> +This is free software; see the source for copying conditions.  There is =
NO
> +warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE.
> +@c man end
> +@end ignore



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



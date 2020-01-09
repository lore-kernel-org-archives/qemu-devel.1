Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE0C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 20:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7A12072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 20:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OercfJqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7A12072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipe1P-0001Va-Tm
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 15:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipe0i-00013p-JE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipe0f-00029h-6x
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:02:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38640
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipe0e-00021n-V7
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578600143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1TIemGUGuraqVgdzQs9QWNpoHdJWbTkUHzVZwlo48A=;
 b=OercfJqtArnCA2BuDIoWG7R/b+dkE16HVkUcPc9KjUPv6eU4+V45Yq9PV4DJUDurEaycpD
 tKTW7aTx7xUlt793bAt/jYqJLJ5Whg4hDJyjQqNKFv/VcKx06QFIekYTpK2jT8X3MbOVka
 7W4PoIYOMrUgZ+BidlxQvJSVdQYlh4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-WS3TxLN8OP-kn3NoFsaaIw-1; Thu, 09 Jan 2020 15:02:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7AFE107ACC4
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 20:02:19 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59C1F620A6;
 Thu,  9 Jan 2020 20:02:16 +0000 (UTC)
Date: Thu, 9 Jan 2020 20:02:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 092/104] virtiofsd: add man page
Message-ID: <20200109200213.GT6795@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-93-dgilbert@redhat.com>
 <20200107121328.GD3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107121328.GD3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WS3TxLN8OP-kn3NoFsaaIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:38:52PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  Makefile                       |  7 +++
> >  tools/virtiofsd/virtiofsd.texi | 85 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 92 insertions(+)
> >  create mode 100644 tools/virtiofsd/virtiofsd.texi
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks.

> with some notes at the very end

<snip>

> > +@c man begin DESCRIPTION
> > +
> > +Share a host directory tree with a guest through a virtio-fs device.  =
This
> > +program is a vhost-user backend that implements the virtio-fs device. =
 Each
> > +virtio-fs device instance requires its own virtiofsd process.
> > +
> > +This program is designed to work with QEMU's @code{--device vhost-user=
-fs-pci}
> > +but should work with any virtual machine monitor (VMM) that supports
> > +vhost-user.  See the EXAMPLES section below.
> > +
> > +This program must be run as the root user.
>=20
> So there's no way for an unprivileged user to do file sharing like they
> can with 9p right now ?

Correct.

(Which also makes it a pain for using in a make check)

> >                                              Upon startup the program w=
ill
> > +switch into a new file system namespace with the shared directory tree=
 as its
> > +root.  This prevents "file system escapes" due to symlinks and other f=
ile
> > +system objects that might lead to files outside the shared directory. =
 The
> > +program also sandboxes itself using seccomp(2) to prevent ptrace(2) an=
d other
> > +vectors that could allow an attacker to compromise the system after ga=
ining
> > +control of the virtiofsd process.
> > +
> > +@c man end
> > +
> > +@c man begin OPTIONS
> > +@table @option
> > +@item -h, --help
> > +Print help.
> > +@item -V, --version
> > +Print version.
> > +@item -d, -o debug
> > +Enable debug output.
> > +@item --syslog
> > +Print log messages to syslog instead of stderr.
> > +@item -o log_level=3D@var{level}
> > +Print only log messages matching @var{level} or more severe.  @var{lev=
el} is
> > +one of @code{err}, @code{warn}, @code{info}, or @code{debug}.  The def=
ault is
> > +@var{info}.
> > +@item -o source=3D@var{path}
> > +Share host directory tree located at @var{path}.  This option is requi=
red.
> > +@item --socket-path=3D@var{path}, -o vhost_user_socket=3D@var{path}
> > +Listen on vhost-user UNIX domain socket at @var{path}.
> > +@item --fd=3D@var{fdnum}
> > +Accept connections from vhost-user UNIX domain socket file descriptor =
@var{fdnum}.  The file descriptor must already be listening for connections=
.
> > +@item --thread-pool-size=3D@var{num}
> > +Restrict the number of worker threads per request queue to @var{num}. =
 The default is 64.
> > +@item --cache=3D@code{none}|@code{auto}|@code{always}
> > +Select the desired trade-off between coherency and performance.  @code=
{none}
> > +forbids the FUSE client from caching to achieve best coherency at the =
cost of
> > +performance.  @code{auto} acts similar to NFS with a 1 second metadata=
 cache
> > +timeout.  @code{always} sets a long cache lifetime at the expense of c=
oherency.
> > +@item --writeback
> > +Enable writeback cache, allowing the FUSE client to buffer and merge w=
rite requests.
> > +@end table
> > +@c man end
> > +
> > +@c man begin EXAMPLES
> > +Export @code{/var/lib/fs/vm001/} on vhost-user UNIX domain socket @cod=
e{/var/run/vm001-vhost-fs.sock}:
> > +
> > +@example
> > +host# virtiofsd --socket-path=3D/var/run/vm001-vhost-fs.sock -o source=
=3D/var/lib/fs/vm001
> > +host# qemu-system-x86_64 \
> > +    -chardev socket,id=3Dchar0,path=3D/var/run/vm001-vhost-fs.sock \
> > +    -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs \
> > +    -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm=
,share=3Don \
> > +    -numa node,memdev=3Dmem \
> > +    ...
> > +guest# mount -t virtio_fs \
> > +    -o default_permissions,allow_other,user_id=3D0,group_id=3D0,rootmo=
de=3D040000,dax \
> > +    myfs /mnt
> > +@end example
> > +@c man end
> > +
> > +@ignore
> > +@setfilename virtiofsd
> > +@settitle QEMU virtio-fs shared file system daemon
> > +
> > +@c man begin AUTHOR
>=20
> s/AUTHOR/COPYRIGHT/

OK

> since this isn't providing any author information.
>=20
> > +Copyright (C) 2019 Red Hat, Inc.
>=20
> 2019-2020 !

Time flies...

> And now insert
>=20
>  @c man end
>  @c man begin LICENSE
>=20
> > +This is free software; see the source for copying conditions.  There i=
s NO
> > +warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE.
> > +@c man end
> > +@end ignore

Hmm, so it ends up like:


@c man end

@ignore
@setfilename virtiofsd
@settitle QEMU virtio-fs shared file system daemon

@c man begin COPYRIGHT
Copyright (C) 2019-2020 Red Hat, Inc.
@c man end
@c man begin LICENSE
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
@c man end
@end ignore


That results in:

COPYRIGHT
       Copyright (C) 2019-2020 Red Hat, Inc.

but with no license printed.
That's from after a make doing a   nroff -man ./tools/virtiofsd/virtiofsd.1=
 |more

is that what's expected?  I'd expected to see the license somewhere.

Dave
>=20
>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



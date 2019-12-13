Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319B3C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18C724680
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFaJMNXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18C724680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmqt-0008E0-GR
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 10:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifmq2-0007QK-8o
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifmq0-00045h-Ve
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:26:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24379
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifmq0-00044W-O2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576250800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGDcFdaDweesenDqqpnURRfzP7XVOxTM+bg+9OEjETU=;
 b=AFaJMNXY+7MyJLCo95gw/Sf//yZECU2qWQ2saVQ5B/5omoJtZt7ZR3EdIg8NtEJNax9MS5
 k7GIi7iw/pfb6voQJksaapbawXSnDQ53uMeqbGVyq96gYeUyyuw+rudo2Gh8QhpOdbvoon
 2dTIfiNZHItaaG80uToIbgHJ67Kyscg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328--Cs0tYbzO8qRLF1vtDdpUQ-1; Fri, 13 Dec 2019 10:26:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB618107ACCC;
 Fri, 13 Dec 2019 15:26:36 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B46021EC8;
 Fri, 13 Dec 2019 15:26:32 +0000 (UTC)
Date: Fri, 13 Dec 2019 15:26:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH 092/104] virtiofsd: add man page
Message-ID: <20191213152630.GI3713@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-93-dgilbert@redhat.com>
 <378b3033-4ea6-96fc-3301-f3d4c20ed159@oracle.com>
MIME-Version: 1.0
In-Reply-To: <378b3033-4ea6-96fc-3301-f3d4c20ed159@oracle.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: -Cs0tYbzO8qRLF1vtDdpUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Liam Merwick (liam.merwick@oracle.com) wrote:
> On 12/12/2019 16:38, Dr. David Alan Gilbert (git) wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   Makefile                       |  7 +++
> >   tools/virtiofsd/virtiofsd.texi | 85 +++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 92 insertions(+)
> >   create mode 100644 tools/virtiofsd/virtiofsd.texi
> >=20
>=20
> ... deleted ...
>=20
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
>=20
>=20
>=20
> Should this be 'mount -t virtiofs myfs /mnt' like on
> https://virtio-fs.gitlab.io/howto-qemu.html ?

It should! The man page still had the old format; thanks for spotting
it.

> otherwise
>=20
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

Thank you!

Dave

>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



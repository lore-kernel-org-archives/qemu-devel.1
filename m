Received: from eggs.gnu.org ([2001:4830:134:3::10]:49164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYZno-0000k3-NS
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYZnl-0000we-IM
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:29:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYZnl-0000vz-C8
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:29:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F4128A3ED9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 16:29:44 +0000 (UTC)
Date: Thu, 28 Jun 2018 17:29:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628162941.GT3513@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180607101019.14958-1-berrange@redhat.com>
	<20180628131722.GA13766@redhat.com>
	<8964dea3-042d-2eac-0198-d50c9c8947fc@redhat.com>
	<03c1e60e-6f5b-51cb-afe1-9f4e26a2c56b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03c1e60e-6f5b-51cb-afe1-9f4e26a2c56b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] doc: switch to modern syntx for VNC TLS
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Thu, Jun 28, 2018 at 03:28:06PM +0200, Paolo Bonzini wrote:
> On 28/06/2018 15:22, Eric Blake wrote:
> >>>
> >>> -qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509=3D/etc/pki/qemu
> >>> -monitor stdio
> >>> +qemu-system-i386 [...OPTIONS...] \
> >>> +=C2=A0 -object
> >>> tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver,veri=
fy-peer=3Dno
> >>> \
> >=20
> > I'd use --object here (especially since -object cannot be used on
> > qemu-nbd, but --object tls-creds-x509 can).
>=20
> But that would be inconsistent with -vnc.

Yeah, in this case I'd rather stick with single dash, for consistency,
since this example is not applicable to non-system emulators anyway.

> I honestly don't understand the crusade against single-dashed options.

It does cause confusion in some documentation contexts with -object,
since qemu-nbd/qemu-img/qemu-io all mandated --object instead.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

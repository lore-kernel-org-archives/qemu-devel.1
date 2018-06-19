Received: from eggs.gnu.org ([2001:4830:134:3::10]:32833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVCcQ-0001Tt-F5
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVCcL-0007KL-8q
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:08:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVCcL-0007KB-2m
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:08:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F392640201BE
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:07:57 +0000 (UTC)
Date: Tue, 19 Jun 2018 10:07:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619090753.GJ20929@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-10-marcandre.lureau@redhat.com>
	<20180619061903.pmiy36kznlkpmanq@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180619061903.pmiy36kznlkpmanq@sirius.home.kraxel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/26] HACK: vhost-user-backend: allow
 to specify binary to execute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Tue, Jun 19, 2018 at 08:19:03AM +0200, Gerd Hoffmann wrote:
> On Mon, Jun 18, 2018 at 06:17:12PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > An executable with its arguments may be given as 'cmd' property, ex:
> > -object vhost-user-backend,id=3Dvui,cmd=3D"./vhost-user-input
> > /dev/input..". The executable is then spawn and, by convention, the
> > vhost-user socket is passed as fd=3D3. It may be considered a securit=
y
> > breach to allow creating processes that may execute arbitrary
> > executables, so this may be restricted to some known executables (via
> > signature etc) or directory.
>=20
> Hmm, maybe let the device which uses vhost-user-backend handle this?
>=20
> So you use "-device vhost-user-input-pci,device=3D/dev/input/$dev" and
> vhost-user-input-pci translates that into ...
> =20
>   argv =3D { "$dir/vhost-user-input", "-device", "/dev/input/$dev", NUL=
L }
>=20
> ... for vhost-user-backend ?

Or just accept the binary name, but mandate a pre-determined set of
argv, in the same way we do for  TAP device ifup scripts.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

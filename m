Received: from eggs.gnu.org ([2001:4830:134:3::10]:39238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMcDv-0003SB-2S
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMcDp-00048A-3y
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:11:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMcDo-00041X-Re
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:11:29 -0500
Date: Tue, 13 Nov 2018 17:11:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181113171112.GK14591@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-8-berrange@redhat.com>
	<CAJ+F1CLMtVnKjDJhm29Jx56FLVjeacvjA=8CvteimiYFg05SvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLMtVnKjDJhm29Jx56FLVjeacvjA=8CvteimiYFg05SvA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/11] authz: add QAuthZSimple object
 type for easy whitelist auth checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, philmd@redhat.com

On Thu, Nov 08, 2018 at 02:23:48AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> On Fri, Oct 19, 2018 at 5:49 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > In many cases a single VM will just need to whilelist a single identi=
ty
> > as the allowed user of network services. This is especially the case =
for
> > TLS live migration (optionally with NBD storage) where we just need t=
o
> > whitelist the x509 certificate distinguished name of the source QEMU
> > host.
> >
> > Via QMP this can be configured with:
> >
> >   {
> >     "execute": "object-add",
> >     "arguments": {
> >       "qom-type": "authz-simple",
> >       "id": "authz0",
> >       "parameters": {
> >         "identity": "fred"
> >       }
> >     }
> >   }
> >
> > Or via the command line
> >
> >   -object authz-simple,id=3Dauthz0,identity=3Dfred
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> (a test would be trivial)

Yes, will add one


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

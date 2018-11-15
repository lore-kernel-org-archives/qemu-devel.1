Received: from eggs.gnu.org ([2001:4830:134:3::10]:54451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNEx2-0006a4-Gs
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNEwy-00042x-8c
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:32:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gNEwy-00040G-2Y
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:32:40 -0500
Date: Thu, 15 Nov 2018 10:32:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181115103220.GH10900@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-11-berrange@redhat.com>
	<CAJ+F1CKVcjqTahNUW144Uhnh48=yAghdhBscFWh_f3HQWThWRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKVcjqTahNUW144Uhnh48=yAghdhBscFWh_f3HQWThWRg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 10/11] authz: add QAuthZPAM object type
 for authorizing using PAM
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

On Thu, Nov 08, 2018 at 02:23:18AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Oct 19, 2018 at 5:47 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index a1c3e0e59c..a9654b8115 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4447,6 +4447,41 @@ would look like:
> >       ...
> >  @end example
> >
> > +@item -object authz-pam,id=3D@var{id},service=3D@var{string}
> > +
> > +Create an authorization object that will control access to network s=
ervices.
> > +
> > +The @option{service} parameter provides the name of a PAM service to=
 use
> > +for authorization. It requires that a file @code{/etc/pam.d/@var{ser=
vice}}
> > +exist to provide the configuration for the @code{account} subsystem.
> > +
> > +An example authorization object to validate a TLS x509 distinguished
> > +name would look like:
> > +
> > +@example
> > + # $QEMU \
> > +     ...
> > +     -object authz-simple,id=3Dauth0,service=3Dqemu-vnc
>=20
> oops, wrong example,

Heh, fixed.

>=20
> other than that,
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

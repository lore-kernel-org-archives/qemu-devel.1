Received: from eggs.gnu.org ([2001:4830:134:3::10]:42226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHqdL-0001FE-Kt
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHqdF-0002DF-Rq
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:34:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gHqdF-0002CP-L8
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:34:01 -0400
Date: Wed, 31 Oct 2018 13:33:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181031133334.GL9625@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181031120049.GH9625@redhat.com>
	<CAFEAcA-20HUdGyNYFoqzhPdBbxpJ5iRH+F0WWNwgjs=JpsN7Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-20HUdGyNYFoqzhPdBbxpJ5iRH+F0WWNwgjs=JpsN7Xw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question: Perfecting checkpatch.pl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>

On Wed, Oct 31, 2018 at 01:27:15PM +0000, Peter Maydell wrote:
> On 31 October 2018 at 12:00, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > On Tue, Oct 30, 2018 at 12:35:15PM +0000, Aleksandar Markovic wrote:
> >> Perhaps checkpatch.pl should make sure the commit messages do not co=
ntain "address@hidden" and "Reviewed-off-by"?
> >>
> >> $ git log | grep address@hidden
> >>     Signed-off-by: Michael S. Tsirkin <address@hidden>
> >>     Signed-off-by: Ronald Hecht <address@hidden>
> >>     Signed-off-by: Justin Chevrier <address@hidden>
> >>     Signed-off-by: Justin Chevrier <address@hidden>
> >>     Signed-off-by: Justin Chevrier <address@hidden>
> >
> > This makes sense...
> >
> >>
> >> $ git log | grep Reviewed-off-by
> >>     Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> >>     Reviewed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> >
> > but I'm not convinced it is worth doing this, because the set of
> > mistakes people have made is enourmous, so it turns into a game
> > of whack-a-mole.
>=20
> You could have checkpatch whitelist the sensible ones:
>=20
> >    3127 Acked-by
> >    1834 Reported-by
> >   30991 Reviewed-by
> >   97837 Signed-off-by
> >     660 Suggested-by
> >    1951 Tested-by
>=20
> and warn about the rest...

I guess warning would be ok - I don't want to discourage people from
being creative and "singing off" their patches :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

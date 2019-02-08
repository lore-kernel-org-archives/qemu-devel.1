Received: from eggs.gnu.org ([209.51.188.92]:55134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gs3UU-0003yM-QZ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gs3US-0007UP-Vz
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:34:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gs3UP-0007Se-Pu
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:34:35 -0500
Date: Fri, 8 Feb 2019 11:34:19 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190208103419.tdlxryfnbqkibxvy@sirius.home.kraxel.org>
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
	<20190208095720.3d3f3cb4.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190208095720.3d3f3cb4.cohuck@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Maintainers, please git-am -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Anthony PERARD <anthony.perard@citrix.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Feb 08, 2019 at 09:57:20AM +0100, Cornelia Huck wrote:
> On Fri, 08 Feb 2019 08:30:11 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>=20
> > Short story: please add
> >=20
> >     [am]
> >             messageid =3D true
> >=20
> > to your .gitconfig.
> >=20
> > Long story.  git-am can add a Message-id: tag.  Looks like this:
> >=20
> >     commit 335dbb5de1e98c4dc73590349f17bb2a4d72596c
> >     Author: Thomas Huth <thuth@redhat.com>
> >     Date:   Mon Feb 4 09:25:43 2019 +0100
> >     Commit:     Peter Maydell <peter.maydell@linaro.org>
> >     CommitDate: Mon Feb 4 15:25:21 2019 +0000
> >=20
> >         tests/docker/test-mingw and docs: Remove --with-sdlabi=3D2.0
> >=20
> >         Patchew currently reports failures with the mingw docker test=
 - this
> >         is due to --with-sdlabi=3D2.0 configure flag which does not e=
xist anymore.
> >         Remove this remainder from the docker test and the docs now.
> >=20
> >         Signed-off-by: Thomas Huth <thuth@redhat.com>
> >         Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> >         Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >         Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >         Acked-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > --->    Message-id: 1549268743-18502-1-git-send-email-thuth@redhat.co=
m =20
> >         Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >=20
> > The Message-id identifies the patch e-mail.  It makes finding the rev=
iew
> > thread easier and more reliable.  It's also a valid key on Patchew[*]=
.
>=20
> I'm using it for anything I git am, but I'm usually not git am'ing my
> own patches (I just merge from the branch I have them on). Is the
> message id valuable enough to warrant the extra round-trip for patches
> that are committed by the authors themselves?

I typically do that, using Stefan's "patches" tool, to automatically
collect Reviewed-by: lines from replies.  And that adds the message id
too.

cheers,
  Gerd

Received: from eggs.gnu.org ([209.51.188.92]:36290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyx92-0003C2-E5
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyx90-0005SE-TC
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:13:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gyx90-0005RS-KC
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:12:58 -0500
Date: Wed, 27 Feb 2019 11:12:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190227111243.GF31688@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190225123111.30363-1-berrange@redhat.com>
	<CAFEAcA9_AeKMZxrGE7pSp0j1JSSWTLCk2g7aP=QCtTWGNFposQ@mail.gmail.com>
	<41d3532c-0ab4-db82-dc9a-cc9fb45c6162@redhat.com>
	<CAFEAcA-zo+mVS_H7dU2uM83Ndv_f_0BDSBS_jxJs1e7L+=0R5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-zo+mVS_H7dU2uM83Ndv_f_0BDSBS_jxJs1e7L+=0R5w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] Merge authz core patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Tue, Feb 26, 2019 at 07:09:29PM +0000, Peter Maydell wrote:
> On Tue, 26 Feb 2019 at 19:07, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
> >
> > On 2/26/19 8:04 PM, Peter Maydell wrote:
> > > On Mon, 25 Feb 2019 at 12:35, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> > >>
> > >> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f=
7a62be116:
> > >>
> > >>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates=
-20190221.0' into staging (2019-02-22 15:48:04 +0000)
> > >>
> > >> are available in the Git repository at:
> > >>
> > >>   https://github.com/berrange/qemu tags/authz-core-pull-request
> > >>
> > >> for you to fetch changes up to cfde05c6c0db7d3122a5491d50f62f7910a=
b8abb:
> > >>
> > >>   authz: delete existing ACL implementation (2019-02-25 12:28:25 +=
0000)
> > >>
> > >> ----------------------------------------------------------------
> > >> Add a standard authorization framework
> > >>
> > >> The current network services now support encryption via TLS and in=
 some
> > >> cases support authentication via SASL. In cases where SASL is not
> > >> available, x509 client certificates can be used as a crude authori=
zation
> > >> scheme, but using a sub-CA and controlling who you give certs to. =
In
> > >> general this is not very flexible though, so this series introduce=
s a
> > >> new standard authorization framework.
> > >>
> > >
> > > Applied, thanks.
> >
> > Argh there is a v2... Daniel didn't NACK'd this one.
>=20
> Oops. Yes, I process my pullreq queue oldest-first and unless you
> follow up to the cover letter to say "don't apply this v1" I'm
> not necessarily going to notice a v2. I'm afraid you'll have to
> send whatever the v1->v2 fixes were as a separate set of patches now.

Actually there is no problem here.  git-publish will always use the
same tag name when sending a pull request, so the v2 tag name was
the same as the v1 tag name & thus you automatically applied the
correct v2 pull request.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

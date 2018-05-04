Received: from eggs.gnu.org ([2001:4830:134:3::10]:33702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEWGc-0000Ff-S4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEWGZ-0004hD-N9
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:40:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fEWGZ-0004fq-3j
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:40:35 -0400
Date: Fri, 4 May 2018 09:40:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180504084032.GE18897@stefanha-x1.localdomain>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180501122436.GA14803@stefanha-x1.localdomain>
	<bdccdec2-b4dd-6a7f-282e-91885c5749c8@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <bdccdec2-b4dd-6a7f-282e-91885c5749c8@vivier.eu>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 11:52:20PM +0200, Laurent Vivier wrote:
> Le 01/05/2018 =E0 14:24, Stefan Hajnoczi a =E9crit=A0:
> > On Fri, Apr 27, 2018 at 04:51:03PM +0100, Peter Maydell wrote:
> >> (2) release timing:
> >>  * usual schedule would give us a next release mid-to-late August
> >>  * unless I can persuade Stefan to do the release management this
> >>    cycle we might need to wind that in by a couple of weeks so
> >>    it's definitely done by the middle of August, to avoid a clash
> >>    with a personal commitment
> >=20
> > I will be offline mid-August to mid-September, sorry.  Someone else can
> > volunteer to do the release.
> >=20
> >> (3) retrospective, lessons learned &c
> >>  * please remember that if every single submaintainer submits
> >>    a pull request on the morning of an RC, it is physically
> >>    not possible for me to process all those pulls in time to
> >>    tag the RC that day. We had several RCs which got delayed
> >>    by a day because of this; please try to submit earlier
> >>    rather than later...
> >>  * provide your opinions here ?
> >=20
> > Paolo asked sub-maintainers to include changelogs in pull request
> > messages.  This will make it easy to collate the QEMU 3.0 changelog just
> > from the merge commits.  I think it's a good idea.
>=20
> BTW, is there a way to have "git publish --pull-request" opens
> automatically an editor with the cover letter?
>=20
> I've just forgot to fill the entry in my last pull request...

Yes, this is the new default in git-publish v1.4.3.  Please make sure
you have the latest version.

Fedora and EPEL RPMs are available (updates will be pushed next Tuesday):
https://apps.fedoraproject.org/packages/git-publish

GitHub:
https://github.com/stefanha/git-publish/releases/tag/v1.4.3

Stefan

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa7ByAAAoJEJykq7OBq3PIKhIH/1bttdH79a6FF7eLeSj71c/Z
2RQmty/vObxUEt0MbH1+h7+rLwYeVS0tHE/PiIZjKr+N+aJ738Sc0nTZcCTNwL+6
VizwnWqn2//RNlUiXVJEb2XNHi9PCiK67Qi5D1Fa/LQ6RlCLvjNj1EObbt9KTH8t
w8BNJrAQGBgb0fvVfpj1+JewfShfWWX2mPGyeogO0fE6CnWaBvBvRPd74mWc/IJC
0+g6ttl0k/1hxOaYFLRRPSJf8HImHOkJ5cAlj8uEPxIDN6ZB0XJvG+RFkr5RVi+o
pxN1v39c53poJA3ibxOO0N77QP236uL9M9XLiKy6Xx3uzqxYoN105/SfTEwuqdI=
=3xVB
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--

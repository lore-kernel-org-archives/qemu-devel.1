Received: from eggs.gnu.org ([2001:4830:134:3::10]:48971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2t7-0004gL-77
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2t4-0004bP-1x
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:34:33 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fj2t3-0004aj-Qf
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:34:30 -0400
Received: by mail-wm0-x241.google.com with SMTP id n11-v6so5486127wmc.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 06:34:29 -0700 (PDT)
Date: Fri, 27 Jul 2018 14:34:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180727133426.GI28555@stefanha-x1.localdomain>
References: <20180724134339.17832-1-liujunjie23@huawei.com>
	<87r2jry8lc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline
In-Reply-To: <87r2jry8lc.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] qstring: Fix qstring_from_substr() not to
 provoke int overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: liujunjie <liujunjie23@huawei.com>, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, weidong.huang@huawei.com, qemu-devel@nongnu.org


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 11:21:03AM +0200, Markus Armbruster wrote:
> liujunjie <liujunjie23@huawei.com> writes:
> > diff --git a/qobject/qstring.c b/qobject/qstring.c
> > index afca54b..18b8eb8 100644
> > --- a/qobject/qstring.c
> > +++ b/qobject/qstring.c
> > @@ -37,7 +37,7 @@ size_t qstring_get_length(const QString *qstring)
> >   *
> >   * Return string reference
> >   */
> > -QString *qstring_from_substr(const char *str, int start, int end)
> > +QString *qstring_from_substr(const char *str, size_t start, size_t end)
> >  {
> >      QString *qstring;
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20

None more qualified to merge this than you:

$ scripts/get_maintainer.pl -f qobject/qstring.c
Markus Armbruster <armbru@redhat.com> (supporter:QObject)
qemu-devel@nongnu.org (open list:All patches CC here)

:)

--itqfrb9Qq3wY07cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWx9iAAoJEJykq7OBq3PIbIsH/0QmwGFNaZv+YSeVd4kNk4Q4
L3sFgvlArQjGR/4X50UaRM2o22BpTSv6bmn9WXKvJpC8qNy6PA29R5cNH6/GY7aF
jQSSvTdeRuM0+fXKe7HD1dfOZZweCOEe6WEP/tkQjSlYlwoIYkHR3Umt1yBrLpZM
YxnKjVQRXGTafBIXQkdcWxzN5JiDWqQQh05Y6mu5Nol1KN5lRG+RVsWjWV1v6+G0
8w/n9cLvCbI0O4KuzzGTXk0Dj1TJ59GSvbfR4gkfQMCfRnnfyyp/sgD6O6WQRJVD
nsvhX1GlqErlMN6Fb1aURaq/LP2LHni+Pl5yNFStoVqqfzLBUjRr93LS9O64r5o=
=2vid
-----END PGP SIGNATURE-----

--itqfrb9Qq3wY07cp--

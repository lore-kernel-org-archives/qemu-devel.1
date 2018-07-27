Received: from eggs.gnu.org ([2001:4830:134:3::10]:40308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2GX-0004LJ-27
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2GS-0007GL-5X
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:54:41 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fj2GR-0007G8-RQ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:54:36 -0400
Received: by mail-wm0-x242.google.com with SMTP id l2-v6so2031733wme.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 05:54:35 -0700 (PDT)
Date: Fri, 27 Jul 2018 13:54:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180727125432.GD28555@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-2-e.emanuelegiuseppe@gmail.com>
	<20180711142819.GM31228@stefanha-x1.localdomain>
	<bc76dd27-434f-9a75-0afd-47049cc915d6@redhat.com>
	<20180718142357.GM21825@stefanha-x1.localdomain>
	<00b4f8fe-b473-ac7a-4f13-9752aeef7062@redhat.com>
	<8349f160-fcc8-610b-774e-b074d77f6d9f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <8349f160-fcc8-610b-774e-b074d77f6d9f@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] tests: qgraph API for the qtest driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 11:13:18PM +0200, Emanuele wrote:
>=20
>=20
> On 07/18/2018 09:28 PM, Paolo Bonzini wrote:
> > On 18/07/2018 16:23, Stefan Hajnoczi wrote:
> > > > > > +struct QOSGraphObject {
> > > > > > +    /* for produces, returns void * */
> > > > > > +    QOSGetDriver get_driver;
> > > > > Unused?
> > > > >=20
> > > > > > +    /* for contains, returns a QOSGraphObject * */
> > > > > > +    QOSGetDevice get_device;
> > > > > Unused?
> > > > What is unused?
> > > Neither of these fields are used in this patch.  Please introduce them
> > > in the first patch that actually uses them.  This way code review can
> > > proceed linearly and it also prevents deadcode when just part of a pa=
tch
> > > series is merged or backported.
> > So do you suggest to squash patch 6 into this one, so that a user of
> > QOSGraphObject exists already here?
> I think he's right, it makes no sense to have qos-graph as patch 6, it co=
uld
> go as patch 2, even though by that time no object/node exist yet.
>=20
> Moreover, right now no file in patch 3-4-5 is actually compiled until pat=
ch
> 6, which is easily prone to errors in case of future edits (I too have th=
is
> problem right now, when I need to modify sdhci.c and I'm forced to return=
 to
> the branch head to compile), so adding it before would make things more
> clear.

Sounds good.

Stefan

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWxYIAAoJEJykq7OBq3PI+DoH/2tF15N/wOnTOp6cuyPtmAHz
O9onm9xjd9BcPzDGQ8QYxaSXEI02EOIzOraWX7LoM3gaIZLuLnKGtZPWO7XZTa8y
6bnCitP37rAoMdIUY0unozd6oP8DfdrphxecOurcwYHmWtm4KqL9aYs/Gucz+Fqq
iQV8QpDBBIkvhTz6xKCDJBzyer3p6A2Jzwvm2FS0U+cXDa7OWEtVUUYhz5YlcjUB
4EI5OQiGjR3zFUuSgFqJBG4KYxBRNK/7VnbPCCdp398miwlWqbL5deb/e08B3Pk4
sMkQl+oX/WZtTDpP6ebQs1SqFnaaEDQboMcSGf7amJzkX3pP3Y0aPKt24ljQfug=
=mKJY
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--

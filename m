Received: from eggs.gnu.org ([2001:4830:134:3::10]:58466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ct@flyingcircus.io>) id 1cZZ4u-0004Bq-Vt
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ct@flyingcircus.io>) id 1cZZ4r-00033c-RT
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:18:44 -0500
From: Christian Theune <ct@flyingcircus.io>
Message-Id: <BDD49697-FEDC-4088-BB5B-EB4D6D274730@flyingcircus.io>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_8753B396-C43B-49DA-9800-EA6E1AD919D4";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Fri, 3 Feb 2017 09:18:36 +0100
In-Reply-To: <ea032a8a-1429-bd95-5b68-4634a0fb0a57@redhat.com>
References: <1485876994-14555-1-git-send-email-pl@kamp.de>
	<ea032a8a-1429-bd95-5b68-4634a0fb0a57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga: ignore EBUSY when freezing a
 filesystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, mdroth@linux.vnet.ibm.com


--Apple-Mail=_8753B396-C43B-49DA-9800-EA6E1AD919D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

to clarify: I guess you ask about what happens when you thaw with the =
same condition: a filesystem that is mounted multiple times.

When I created the patch initially I looked at the thaw code and found =
it to already expect that thaws may happen outside its control and that =
the error handling is fine.

The code definitely does not have an early exit upon encountering an =
issue with thawing/double thawing.

Christian

> On 2 Feb 2017, at 22:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> On 31/01/2017 07:36, Peter Lieven wrote:
>> the current implementation fails if we try to freeze an
>> already frozen filesystem. This can happen if a filesystem
>> is mounted more than once (e.g. with a bind mount).
>>=20
>> Suggested-by: Christian Theune <ct@flyingcircus.io>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>=20
> What happens when you thaw?
>=20
> Paolo

--
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 http://flyingcircus.io
Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian. =
Theune, Christian. Zagrodnick


--Apple-Mail=_8753B396-C43B-49DA-9800-EA6E1AD919D4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJYlDzcAAoJEKuh8lKpfGLO1EQIAKVeRnXVej1DG/P4kI9yspGF
1sgka6ZTdiIpoTZXcOekF+f2yShSx/iQINHKPx0Xrg0gmxyzK1xkxHlQtB3Ozoaa
/tcr94jkFcwMUvM3Yv1wgvYnplK4idnzJFDmn/GPTG3DNjfXWhIMyWU6X7CCDQrH
K5vttglP4eRc/NwKnneptaexO0wqm2fFA7vqgcmJne/RleBuA2w7+YNxf46//gWQ
K/NerhzwR3PJZHHioaA/a/dWkDUNklg2WQVwKkORuIt6WUGEYvigtOLkv6M66CJR
7RAkDNw3Pe6+UYWLsyAG+xrvluPsHfHMFBh3PW1HqJ6Y5YQka+3SIzkiJhFl9wc=
=Tmef
-----END PGP SIGNATURE-----

--Apple-Mail=_8753B396-C43B-49DA-9800-EA6E1AD919D4--

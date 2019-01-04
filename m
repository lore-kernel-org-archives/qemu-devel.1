Received: from eggs.gnu.org ([208.118.235.92]:56555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gfMNB-0005YD-Tl
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gfMN6-0002AD-SE
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:06:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gfMN6-0001ub-KC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:06:32 -0500
Date: Fri, 4 Jan 2019 11:06:06 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190104100606.GH20900@natto.ory.fergeau.eu>
References: <110999ea-0ab9-49cb-915f-6d08cccdea3c@linuxsystems.it>
	<47cfb9f8-5957-7935-063b-304e3c53c268@redhat.com>
	<9de9afbe-fc7b-48a0-9b2d-b756f146303d@linuxsystems.it>
	<254296205.54150897.1545827908434.JavaMail.zimbra@redhat.com>
	<04864360-b345-4d49-a842-8cde724b3c94@linuxsystems.it>
	<87174d6c-2437-6331-e44b-93e2ecb8a572@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RkLO0ZVuuT1d19pw"
Content-Disposition: inline
In-Reply-To: <87174d6c-2437-6331-e44b-93e2ecb8a572@redhat.com>
Subject: Re: [Qemu-devel] [Spice-devel] Always get Invalid password while
 trying to connect to spice server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?iso-8859-1?Q?Niccol=F2?= Belli <darkbasic@linuxsystems.it>, Frediano Ziglio <fziglio@redhat.com>, secalert@redhat.com, mst@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, spice-devel@lists.freedesktop.org


--RkLO0ZVuuT1d19pw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jan 03, 2019 at 04:25:00PM -0600, Eric Blake wrote:
> On 12/27/18 8:51 AM, Niccol=F2 Belli wrote:
> > On mercoled=EC 26 dicembre 2018 13:38:28 CET, Frediano Ziglio wrote:
> >> Yes, this looks like a format string error in the upper (not into
> >> spice) layer.
> >>
> >> This potentially is a security problem.
> >=20
> > Considering the spice server is exposed to the internet this is
> > definitely worth investigating.
> >=20
> >> The specific '%' character could be the issue, can you try others
> >> ('!', '@' and
> >> so on) ?
> >=20
> > I tried several other special characters and they all seems to work,
> > expect for "Password&&" which gets converted to "Password&amp;&amp;" (if
> > I type "Password&amp;&amp;" it works).
>=20
> Could it be related to this patch where our JSON code mishandles %?
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00108.html

Yes definitely, this is where the patch came from.
Mentioning this spice issue is yet another thing I should have added in the
commit log, but which I only thought about *after* having sent the patch :)

Christophe

--RkLO0ZVuuT1d19pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlwvMA4ACgkQqdjCFCms
bILBng/8DSQ9+DU+DwyRxE9aVvYWSB92Hn08gCnO2OGCKSBrwp8RlcrGcudQmebB
Bzt+FqA7V6fNu0ozAo+qD9nFHIXG0mV38CGCKag3yNIGsHP2ukN+m6Z1M+TldOe5
LJyOHvbaGt2XfXqiEs+7847t9DiXEgqWRh8icPuRkVI3ejRVEOWPbTwV/1WhnqNQ
n7fWNjVu/yGEIck54FlbNPbF1qBDV4MjAJFiMl5TciU3Faq/DFqYRNI6S/j+JNWY
I8gFqtkKIyhyBVR6Pg9HzLkrcWXR5GC9/01Fo+hwmEK1mGU0q5mKvluass+A2XBX
1TZqSbBAIK6iRsj7o1kDbUP/oKyXgf/ulcjTqjHrKUt6JHtm9lwkXvhaKjEDdZG5
3iSw3PRRsj9Og+K8GdE7n1pJ3ItRLb09qgC+F6B3VYwiaBa+EKcgeZRkXUgeL9VV
3Cvk+dylOsSiugCMSRbYojrMYxKi5aCZPCD5tZoOilhjUsnpagm2P74p+tlhbX/o
ax0pRYINJJFX+lTlszPYs2Cx7oEq27Dz1EfQvtOdn9zD7pDJqEBD5Om2TXmWSwvv
dLrBXrSzfxVSwZrJ4zqExKYOxQ0iHIXDu5NBBYzu114RfZYkOKCFW/tlkAokfTuM
y1YRcvfi5Lym5W+JhYz7tercU6Kr9Bw29JQ15E+QrJwNfk9WGrA=
=3mJ4
-----END PGP SIGNATURE-----

--RkLO0ZVuuT1d19pw--

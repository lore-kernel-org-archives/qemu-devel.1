Received: from eggs.gnu.org ([2001:4830:134:3::10]:50730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv1HQ-0006HJ-D7
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv1HK-0005zb-IA
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cv1HK-0005zO-9I
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:40:14 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
Date: Mon, 3 Apr 2017 14:39:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170403081542.GA5036@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q8KiPNGHgFk35u8ARFB83oafGLRpd9EoV"
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, pkrempa@redhat.com, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q8KiPNGHgFk35u8ARFB83oafGLRpd9EoV
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Ciprian Barbu <Ciprian.Barbu@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>, pkrempa@redhat.com,
 Alexandru Avadanii <Alexandru.Avadanii@enea.com>,
 Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 svc-armband <armband@enea.com>
Message-ID: <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
 <9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
 <20170403081542.GA5036@noname.str.redhat.com>
In-Reply-To: <20170403081542.GA5036@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.2017 10:15, Kevin Wolf wrote:
> Am 31.03.2017 um 19:43 hat Max Reitz geschrieben:

[...]

>> So in theory all that's necessary is to set share-rw=3Don for the devi=
ce
>> in the management layer. But I'm not sure whether that's practical.
>=20
> Yes, libvirt needs to provide this option if the guest supports sharing=
=2E
> If it doesn't support sharing, rejecting a read-write NBD client seems
> correct to me.
>=20
> Peter, Eric, what is the status on the libvirt side here?
>=20
>> As for just allowing the NBD server write access to the device... To m=
e
>> that appears pretty difficult from an implementation perspective. We
>> assert that nobody can write without having requested write access and=

>> we make sure that nobody can request write access without it being
>> allowed. Making an exception for NBD seems very difficult and would
>> probably mean we'd have to drop the assertion for write accesses altog=
ether.
>=20
> Making an exception would simply be wrong.

Indeed. That is why it would be so difficult.

The question remains whether it is practical not to make an exception.
As far as I know, libvirt is only guaranteed to support older qemu
versions, not necessarily future ones. So we should be allowed to break
existing use cases here until libvirt is updated (assuming it is
possible for libvirt to express "guest device allows shared writes" as
an option for its next release).

Max


--q8KiPNGHgFk35u8ARFB83oafGLRpd9EoV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljiQpsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ajr0IAJg857FmCLKCFx6paxEva1l+4QobkDtf
F8pVh7wABFkO6EQ24s5Di8IHgMRN+s5YoER3h/QhXCFMUL4XZ8WEzdY4TedtFCei
NQTj15E1xodRVHQTWRkHfHFanwkzRh2JSXSSLHcf54hn1WeGytNMz2cQsP/znmjg
FpFT2hk9l73/IbPB8BNAQRwPzM166c/B4gz9bPAQ+UKxIYcNHwuDiBqF5VY9Q2fZ
jN470GcUt6bWLvQhz14bNir2fwFGSafTP2MY2ezJB0/tHb7v8pQQJPbTpYg2Iu3l
ahjXU+x0elNj6njFqESB94egx/f4LALO7sQzz7xJIy5kKUGMRL2kOI0=
=REfN
-----END PGP SIGNATURE-----

--q8KiPNGHgFk35u8ARFB83oafGLRpd9EoV--

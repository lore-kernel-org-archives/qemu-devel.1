Received: from eggs.gnu.org ([2001:4830:134:3::10]:35840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cRMYH-00084W-Jm
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cRMYG-0001yv-Em
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:19:09 -0500
References: <20170111164105.27164.30697.malonedeb@chaenomeles.canonical.com>
	<4fc41772-1607-7e55-ffa1-80e3579b964d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b53ded52-f5ca-43f8-321e-1a2617471510@redhat.com>
Date: Wed, 11 Jan 2017 18:19:00 +0100
MIME-Version: 1.0
In-Reply-To: <4fc41772-1607-7e55-ffa1-80e3579b964d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ivb4ho1DMkABKInvX91KVWdiSGVTOnC6R"
Subject: Re: [Qemu-devel] [Bug 1655708] [NEW] target/ppc/int_helper.c:2806:
 strange expression ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Bug 1655708 <1655708@bugs.launchpad.net>, qemu-devel@nongnu.org, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ivb4ho1DMkABKInvX91KVWdiSGVTOnC6R
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, Bug 1655708 <1655708@bugs.launchpad.net>,
 qemu-devel@nongnu.org, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org
Message-ID: <b53ded52-f5ca-43f8-321e-1a2617471510@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1655708] [NEW] target/ppc/int_helper.c:2806:
 strange expression ?
References: <20170111164105.27164.30697.malonedeb@chaenomeles.canonical.com>
 <4fc41772-1607-7e55-ffa1-80e3579b964d@redhat.com>
In-Reply-To: <4fc41772-1607-7e55-ffa1-80e3579b964d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.01.2017 18:12, Eric Blake wrote:
> On 01/11/2017 10:41 AM, dcb wrote:
>> so I think the compiler warning is for the i * 2 lhs of the ?.
>=20
> Yes - the compiler is complaining that 'i * 2' can only be non-zero if
> 'i' was non-zero (given that the code occurs in a loop for i between 0
> and 16), so it is just as easy to write 'i ? ...' instead of the weirde=
r
> '(i * 2) ? ...'.

=2E.. unless something like (i & 2) was meant instead?
Maybe Jose (who wrote that code) could comment on this?

 Thomas




--ivb4ho1DMkABKInvX91KVWdiSGVTOnC6R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYdmkJAAoJEC7Z13T+cC21l+kP/1RxQnb8oL+dsrRO4B3xejFS
SPu6moVDx9y32bBFsfVNWgNDOMI6/zFLlTv4k+JPcgSeG7nAg5QILkJFvUpvirC1
sCZ13r3bIu5zpiC/uGwQhtdI6eXikRKAWtNp1J2WoOyu3EzTlTbMaEG/hNqOZ68d
lov2TV48Xf3RyPuWjmU940N0gV6IiuVADO27nxxQ6Hkewq3oeUyHth5rLjdNQ+OR
Wg098eA7jFetXC+VJ/38hlPeDeeeoiNvkjh4/e86JcQabJtrQnY0gR6qz9Y3poLE
SFm8tgaUcGkXFuL9jig5wNXzfl5LKYX7uKFJ6eaoIeWyhwnGK2ccTY3+WxE/4ush
ONffWpQRctK2vyDF2m7XEnXmJ2lRT6NAT7G60zAxGWe1S8j4zVNcdTIpMwSgT/lF
V/KoVqLS/gzInG/wnDcEk6rALIo4hNKpsNHd+huoULb6vNLNy5Bcypj2jaeq3/b9
PHQCSVInwRjxpNvDVz+iNHwdSoaJfcgN1OGaHruJcersvGT9PWTLb3DgJ5E6xWPz
wy/CLv/u6M1ompIvhzxsVDRRvrAZTRzbiL3UBAPz/e1zKZaiPOXvGIY5haeeLMHR
CqAPAOnZMtiflZt2sXzomlx0BsN7IwmjFqh+sGb8SWHaQjzCbH1+ZJZ6NB9HjTmB
dTthQ860aTUVUvuxdcIx
=E/aI
-----END PGP SIGNATURE-----

--ivb4ho1DMkABKInvX91KVWdiSGVTOnC6R--

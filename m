Received: from eggs.gnu.org ([2001:4830:134:3::10]:55360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cny0w-000396-I4
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cny0s-0002iS-JN
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:46:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cny0s-0002i1-7G
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:46:06 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-46-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c9897d3-eff5-149c-9952-b11b0888d059@redhat.com>
Date: Tue, 14 Mar 2017 20:46:03 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-46-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r6nd4lacdiRhnq9SsISwMrtHtiA2f1Rxu"
Subject: Re: [Qemu-devel] [PATCH for-2.9 45/47] qapi: Drop unused
 .check_clash() parameter schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r6nd4lacdiRhnq9SsISwMrtHtiA2f1Rxu
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <6c9897d3-eff5-149c-9952-b11b0888d059@redhat.com>
Subject: Re: [PATCH for-2.9 45/47] qapi: Drop unused .check_clash() parameter
 schema
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-46-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-46-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

I'm not sure now why the 'schema' parameter was introduced; looks like
it was in commit b807a1e and unused there. I think at one point in my
multitude of refactoring patches that I was using schema for a name
lookup for nicer error reporting, but that idea fell by the wayside over
several revisions, and the 'schema' parameter became unused without
either of us realizing it.

At any rate, the cleanup is sane.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--r6nd4lacdiRhnq9SsISwMrtHtiA2f1Rxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyJzbAAoJEKeha0olJ0Nq7LsH/jM7jDjXJZ3esWrbThgB7v7u
SLTq+BODjKbN02pcVxjz7s0gKXoQzxZUj98He3AfzI3fTgTFfCqyZAUQ8xQpcdZS
rGx10uJ9IKrl1bm43gggX5FluNefqwjDbnQMEk8TNplZ/tFXIOmw7AyHYp1QBrib
FvJ1TznGLNIXIU3LskZaINFV7tJxoywJg7HxG58zv93JCmtq+A4pdycDhfADyIV9
mNTVyJJ/RKLVFocNyVz33sX9IEBV0NdnHXaJ/TBeCPqRdK/Zes54dzRke9LlNVRe
0OKP8T74UYAonjcUZTnDO/HKYcZnMnj/qHkAlAvPTCUTXgK68dG72nTFLD3ZyNc=
=uS/M
-----END PGP SIGNATURE-----

--r6nd4lacdiRhnq9SsISwMrtHtiA2f1Rxu--

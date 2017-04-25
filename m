Received: from eggs.gnu.org ([2001:4830:134:3::10]:39341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30Mn-0005S4-3q
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30Mi-0007QF-R1
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d30Mi-0007PA-HE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:18:48 -0400
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
	<1493103101-25165-3-git-send-email-clg@kaod.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d3e51a7d-b078-074c-5a2a-352e91f16c14@redhat.com>
Date: Tue, 25 Apr 2017 08:18:43 -0500
MIME-Version: 1.0
In-Reply-To: <1493103101-25165-3-git-send-email-clg@kaod.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V2xLLWkCI5Q7O1MFB82xM4N7pVfGqMr69"
Subject: Re: [Qemu-devel] [PATCH 2/2] ipmi: don't try to open a NULL filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Corey Minyard <cminyard@mvista.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V2xLLWkCI5Q7O1MFB82xM4N7pVfGqMr69
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Corey Minyard <cminyard@mvista.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <d3e51a7d-b078-074c-5a2a-352e91f16c14@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] ipmi: don't try to open a NULL filename
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
 <1493103101-25165-3-git-send-email-clg@kaod.org>
In-Reply-To: <1493103101-25165-3-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 01:51 AM, C=C3=A9dric Le Goater wrote:
> Currenlty, the code relies on the fact that open() handles NULL
> filenames but that can cause an error with new clang:

POSIX doesn't require it to work. Linux is nice and gives you EFAULT,
but there are systems where open(NULL) crashes with SIGSEGV.  The clang
warning is correct.

>=20
>   hw/core/loader.c:67:15: runtime error: null pointer passed as argumen=
t 1,
>   which is declared to never be null
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--V2xLLWkCI5Q7O1MFB82xM4N7pVfGqMr69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/0yzAAoJEKeha0olJ0NqXQEIAIwfR0JPrOmzY8m8BLMOmjZC
Ity8ZReI3SCCP4cyWFgRhh9QDxQeSoN56L+pBK1LyryxAXRr8xJZKeoWrh5iqLxE
+7zqaV5vYlsi5sx82kk+pQSTCLRPN8hdaLOX0KaYBhzj65znnRsDpwgHlOE2lwXv
jqn8x4cRJHnqcqHm3R6aojsdT1iQfB7U9A1/0J9JTV1imp4y3a3GtOYURKqBOXWS
hXcEWTX7OFt4UYQishKoAAO80iTSP7rbZGQ4IXjgMEbCnHM4qtj3s5MTTJshGswz
q2iIICGdzDB47eGmTmXzRuHkH6B5XMnVsJWaOpn6AwbcEXj96GTbu/iosbnsrEA=
=X96H
-----END PGP SIGNATURE-----

--V2xLLWkCI5Q7O1MFB82xM4N7pVfGqMr69--

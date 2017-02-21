Received: from eggs.gnu.org ([2001:4830:134:3::10]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0VT-0001nH-T8
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0VP-0004eN-Uo
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:48:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cg0VP-0004eF-Ol
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:48:43 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD439C054C2A
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:48:43 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ba0737b-ac09-4158-0b87-8428f3fc56cb@redhat.com>
Date: Mon, 20 Feb 2017 20:48:41 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4DqOoMBDFB0GPbIXoi6M1tHJCI5hGTMIw"
Subject: Re: [Qemu-devel] [PATCH 05/14] libqtest: Clean up qmp_response() a
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4DqOoMBDFB0GPbIXoi6M1tHJCI5hGTMIw
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <1ba0737b-ac09-4158-0b87-8428f3fc56cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/14] libqtest: Clean up qmp_response() a
 bit
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> Use qobject_to_qdict() instead of a type cast.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/libqtest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Happens to be the same (because of our struct layout), but agree that
the conversion function is safer if we ever change struct layout.

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--4DqOoMBDFB0GPbIXoi6M1tHJCI5hGTMIw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq6qJAAoJEKeha0olJ0NqB1YIAIGuJJMF/+mtm9DyyDQY94NB
EKCoV3PZdvsbFZ8wN+k94+wdPxdNEjIR6Mx7Phj0jeG8s0+l0fSSUJkuFmciJF+j
DUA0QQmDyXysyVrTsskumCdDxI6Y6XIYTBdcCUL2fKMY3Y/M41Xd5fTqY1RNbr0i
Xt+WfomSFsuyo8UGVn8RTkNotAWanU6SVyli4+S1Ss19mnfJvOljiPY1BTJcYW5x
rtVQnASm+d6Wsnz9kINkWSy2FvfZUtK3bk3WUJMAau415CXdhWn/CnFuOzU6hQPu
EFPRLAyBRdIzb6duESXafE++1LlN/3hwvaEkUBc4QmOiZibswFllL8cauo24aAo=
=Ohl3
-----END PGP SIGNATURE-----

--4DqOoMBDFB0GPbIXoi6M1tHJCI5hGTMIw--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZRW-0006ax-8R
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZRR-0003ht-5l
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:02:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYZRQ-0003hc-Rq
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:02:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81336C001CFF
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 15:02:07 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f6180fdd-ab41-c67d-1ab1-83c7603969fa@redhat.com>
Date: Fri, 21 Jul 2017 10:02:06 -0500
MIME-Version: 1.0
In-Reply-To: <1500645206-13559-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KP9Cso3pwJFCnBwUIW6CApRj6OM6TLsqT"
Subject: Re: [Qemu-devel] [PATCH 7/9] tests: Clean up wait for event
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
--KP9Cso3pwJFCnBwUIW6CApRj6OM6TLsqT
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f6180fdd-ab41-c67d-1ab1-83c7603969fa@redhat.com>
Subject: Re: [PATCH 7/9] tests: Clean up wait for event
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:53 AM, Markus Armbruster wrote:
> We still use hacks like qmp("") to wait for an event, even though we
> have qmp_eventwait() since commit 8fe941f, and qmp_eventwait_ref()
> since commit 7ffe312.  Both commits neglected to convert all the
> existing hacks.  Make up what they missed.
>=20
> Bonus: gets rid of empty format strings.  A step towards compile-time
> format string checking without triggering -Wformat-zero-length.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KP9Cso3pwJFCnBwUIW6CApRj6OM6TLsqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyF24ACgkQp6FrSiUn
Q2p9zAf/cIShFZLaxGoOhbDsvTOI8sbPC0hJbKUvh+PiV5E0/wRy5bHzVN1/TgC5
D3cUIRsjVEvpSjjxP51QwaoIAQqTn1QN1SHXCBTmiWJTRSDM9sYiTX7YrGlStDvV
+FhSJZCIOuQR0f3TMbL+SUexvM3UClQbyyWm5XLz8J6o0zfOO8gPmIgzlH6qYaP0
1o/7wpNppcN/H/AeL0SE1o8D+WVmuptaL7h99t/g8JOf3BSOBHUZO4IP0Wq8UDMu
GQ1Fd1Wy5l65yyFLW0qj8UCFvA1Za+AYEmlBH6ccHxI2gNfod3XlHY1cxUWYssme
QHacQDTBuqVr/RpFo4vhWc1wRJnJNQ==
=qC90
-----END PGP SIGNATURE-----

--KP9Cso3pwJFCnBwUIW6CApRj6OM6TLsqT--

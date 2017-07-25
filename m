Received: from eggs.gnu.org ([2001:4830:134:3::10]:57679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da0gh-0000cV-B4
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da0ge-0006Wd-4Z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1da0gd-0006WV-R1
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:19:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10B7AC058EA9
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 14:10:15 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f75806a-fe58-2ae3-2ac2-e7eaea5992d5@redhat.com>
Date: Tue, 25 Jul 2017 09:10:13 -0500
MIME-Version: 1.0
In-Reply-To: <1500645206-13559-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="deBaJj6Rn5oNbnhbFcU52AnsnKK56lnDH"
Subject: Re: [Qemu-devel] [PATCH 6/9] tests/libqos/pci: Clean up string
 interpolation into QMP input
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
--deBaJj6Rn5oNbnhbFcU52AnsnKK56lnDH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0f75806a-fe58-2ae3-2ac2-e7eaea5992d5@redhat.com>
Subject: Re: [PATCH 6/9] tests/libqos/pci: Clean up string interpolation into
 QMP input
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:53 AM, Markus Armbruster wrote:
> Leaving interpolation into JSON to qmp() is more robust than building
> QMP input manually, as explained in the commit before previous.
>=20
> The case in qpci_plug_device_test() is a bit complicated: it
> interpolates several JSON object members, not just a value.  Clean it
> up by passing them in as QDict rather than string, so we can leave
> interpolation to qmp() here and to qobject_from_jsonf() in callers.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +    QObject *extra_args =3D qobject_from_jsonf("{ 'shm': '%s', 'size':=
 '1M' }",
> +                                             tmpshm);
> =20
>      qtest_start("");
> =20
> -    opts =3D g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);
> -
> -    qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);

Wait, 'size':'1M' works?  I guess because it's a string, rather than a
JSON number.  One of our intentional design choices in QMP was to
represent everything as bytes, rather than as suffixed numbers, since
machine-generated code can easily generate bytes anywhere that humans
prefer a suffixed number.  But as you are not changing this interface,
but merely refactoring how it is tested, it's more of a side comment
than something that affects review.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--deBaJj6Rn5oNbnhbFcU52AnsnKK56lnDH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3UUUACgkQp6FrSiUn
Q2qkDQf/VEHLROC0NErQgO7FbWerhIosliPWOcW209FdIXaptO2SiuiV7GatPZTV
1b286OIF6iZ6wGBx4n2XgDszD/B/wCM+V+j7cKQG4jjYBDpS5dThTSuLN8vDQLYq
/1S+bLfUc0Od6znD07g4Mrym5WPgWplmHKf7XfVol+ytRIEixxsN8ncWu7YmoO52
Cc3TEqVBCogFIusav07O8jDALMNMSFHyPqrTu96hA8CSAh37ct9BCcj3x2JVTcnh
kr3if02aEXolbbD+YhBMwAadjEf+1vXCIDnxuhdpIXUlkGyJG0FzgiZpIOkotANa
zhLN6IuiQnCwBUECze+vL/EfsPgYOQ==
=e2OJ
-----END PGP SIGNATURE-----

--deBaJj6Rn5oNbnhbFcU52AnsnKK56lnDH--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnsP4-0004bU-Ew
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnsOz-0004bv-Cs
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnsOz-0004bF-3z
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:18:53 -0400
References: <20170901152200.5953-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e094cc5d-1a39-b466-8917-a4fe036c93f2@redhat.com>
Date: Fri, 1 Sep 2017 15:18:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170901152200.5953-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cxQbjPeRhwidOXKsHo6MT2j40TJG4SL03"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kchamart@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cxQbjPeRhwidOXKsHo6MT2j40TJG4SL03
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kchamart@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e094cc5d-1a39-b466-8917-a4fe036c93f2@redhat.com>
Subject: Re: [PATCH v3 0/3] docker: Add test-block
References: <20170901152200.5953-1-famz@redhat.com>
In-Reply-To: <20170901152200.5953-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 10:21 AM, Fam Zheng wrote:
> A few tweaks to the docker images and running commands allow us to run
> qemu-iotests in the fedora container. This will be added to the patchew=
 test
> cases later.
>=20
> v3: Add nbd, luks and limit to quick group.
>=20
> v2: Add nettle-devel because a few iotest cases blindly assumes the sup=
port is
> there.
>=20
> Fam Zheng (3):
>   docker: Use unconfined security profile
>   docker: Add nettle-devel to fedora image
>   docker: Add test-block

Based-on: <20170901105434.3288-1-berrange@redhat.com>
([PATCH 0/2] Fix / skip recent iotests with LUKS driver)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cxQbjPeRhwidOXKsHo6MT2j40TJG4SL03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmpwKcACgkQp6FrSiUn
Q2rA5wf+NGrOwygnMfOMjkJHHsP5g3mv7RtNe8SDLWvlcPWPDMAXvzGqvMQmftbY
AIRPAfhWJBwD4FgyXNqIHyK7r39NOn/k6OwTd3Yt4e9mtXDOzUEXlv3xA0HTaTo1
VJmTEf/JEpwA85OkvC9Z1ZM/SNy0nFCbr6jzXXYCRcxVLtVSszvbN3TNkx6Rz6DH
7v1jcKxy7qRDX+3IthcyARyEIoFGB3YgmrXyfg99HtVejZfSu5ySUIy8TPVGGlDK
7hf171y2FXUIjyRWP8UdPqdPnliMEd+tHiB0xxDEjM4Nd2u6iodC+JW76QTNxUcg
fDl4mtJI5T9KsDKdP69ajUi5TvyelQ==
=lkYK
-----END PGP SIGNATURE-----

--cxQbjPeRhwidOXKsHo6MT2j40TJG4SL03--

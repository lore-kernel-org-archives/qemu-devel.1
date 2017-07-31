Received: from eggs.gnu.org ([2001:4830:134:3::10]:56036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcBFS-0005yM-MB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcBFJ-0007q3-57
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:00:42 -0400
References: <20170731125111.28052-1-kwolf@redhat.com>
	<0c81b100-89af-83ba-069c-88b962b8a472@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f7e54a4-3a99-2506-a3ec-e9df6272a30c@redhat.com>
Date: Mon, 31 Jul 2017 09:00:15 -0500
MIME-Version: 1.0
In-Reply-To: <0c81b100-89af-83ba-069c-88b962b8a472@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EVaXWBo7adM7Qss6BbtL9j5wlKeF5gX75"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] block/qapi: Remove
 redundat NULL check to silence Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EVaXWBo7adM7Qss6BbtL9j5wlKeF5gX75
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <2f7e54a4-3a99-2506-a3ec-e9df6272a30c@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH for-2.10] block/qapi: Remove
 redundat NULL check to silence Coverity
References: <20170731125111.28052-1-kwolf@redhat.com>
 <0c81b100-89af-83ba-069c-88b962b8a472@redhat.com>
In-Reply-To: <0c81b100-89af-83ba-069c-88b962b8a472@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 08:06 AM, Eric Blake wrote:
> On 07/31/2017 07:51 AM, Kevin Wolf wrote:

In the subject line, s/redundat/redundant/

>> When skipping implicit nodes in bdrv_block_device_info(), we know that=

>> bs0 is always non-NULL; initially, because it's taken from a BdrvChild=

>> and a BdrvChild never has a NULL bs, and after the first iteration
>> because implicit nodes always have a backing file.
>>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EVaXWBo7adM7Qss6BbtL9j5wlKeF5gX75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/N+8ACgkQp6FrSiUn
Q2oFsgf7BXbczwVSQdfwS9Tm0V7expaVsmVdMhYdsc9uvhbDec85xIHGo/9TjCxx
Tap/hldT1qmDeKYfsrBRjXfKGGNV/3BLftUFNRmHU+/u6iSY7+wYNuM0pE4Zpee6
k1nke99viIWLIRyLkl90/ESKsHirKi7s+fqtv41JaKnlTJxezoCVvKI5lHXN6asX
qX38MeM8FXklxL+GB6kE6EYhsUBlMQU2lTDn56AqtYnFD/Kp/NiEEWxCLgTFv/5F
oWGzrWvZXonLXtA9l2YSMUsgXrB5AmeraV5227jKPPR1uVJaWZeCapL9Gkl7C16u
yKZIm4Yo8vYO/H29r00dbqS/mACrlA==
=my3R
-----END PGP SIGNATURE-----

--EVaXWBo7adM7Qss6BbtL9j5wlKeF5gX75--

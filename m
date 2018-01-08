Received: from eggs.gnu.org ([2001:4830:134:3::10]:34217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZJM-0007xo-TF
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZJI-0003gL-Qz
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:26:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYZJI-0003fg-IA
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:26:00 -0500
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
	<CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
	<4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
	<b5453cda-5ae3-cbb3-a158-846f83bb027a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4506b812-a247-44f8-ea02-5c4c70736354@redhat.com>
Date: Mon, 8 Jan 2018 09:25:54 -0600
MIME-Version: 1.0
In-Reply-To: <b5453cda-5ae3-cbb3-a158-846f83bb027a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yznYGSYTxjg144DDf3EXghfISpjMnk8bJ"
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yznYGSYTxjg144DDf3EXghfISpjMnk8bJ
From: Eric Blake <eblake@redhat.com>
To: Ed Swierk <eswierk@skyportsystems.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <famz@redhat.com>
Message-ID: <4506b812-a247-44f8-ea02-5c4c70736354@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
 <CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
 <4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
 <b5453cda-5ae3-cbb3-a158-846f83bb027a@redhat.com>
In-Reply-To: <b5453cda-5ae3-cbb3-a158-846f83bb027a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 09:18 AM, Eric Blake wrote:

> Hmm - we probably ought to enhance checkpatch.pl to insist that patches=

> attributed to qemu-devel@nongnu.org as the author should be flagged as
> invalid, since the list munging is a 1:M mapping rather than 1:1, and
> therefore not easily invertable.

Stefan reminded me on IRC that checkpatch.pl doesn't process From: lines
(it only sees patches, not mboxes) - but that patchew could be taught to
make this sort of check.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--yznYGSYTxjg144DDf3EXghfISpjMnk8bJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpTjYIACgkQp6FrSiUn
Q2qlfgf/civ9BpL0SAXey6Pcm6fJVro/9kg4xZDAgRavRhMOV11UWSTapSTR3Q9z
xn3CrNu/hXzmjBozDXU8XvBFrwdHcxUAhH68J135i5t0gb7HXsGjnXZ5/fOFNOPv
2TMMrqi2w5QnqAsK8l14cUKysePGR/pl16T6NuvSuD9IbgeU4NPReaorpdxj8xCE
4mvz6uHIphdM9MCF4put0ct102VTtiQ4r767IO5XkAqyRosjoJ22cudSmjmmeUUx
apm2deugwGcDOoqivQ/tdwCc2XiPoWAWnpYEwS/36o3JiR9HPAVbOhPcGTLQI55e
Tvho7B+n0O7xwhScQ22eUPgjuErDLw==
=nnfK
-----END PGP SIGNATURE-----

--yznYGSYTxjg144DDf3EXghfISpjMnk8bJ--

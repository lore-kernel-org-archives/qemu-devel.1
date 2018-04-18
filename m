Received: from eggs.gnu.org ([2001:4830:134:3::10]:43702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8oqM-0000t0-6r
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8oqI-0000ZJ-Qu
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:17:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8oqI-0000Yx-LF
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:17:54 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<c5e3f942-2c0e-9809-32ae-df97eaf2b7cd@redhat.com>
	<762b3dc8-a86f-a21f-1e21-334ec46677ef@redhat.com>
	<20180418120320.GH27579@redhat.com>
	<f16c1406-78ac-d275-63e9-90de3beac9f0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0d8036a-4ce0-de5c-88ac-28360658e1e2@redhat.com>
Date: Wed, 18 Apr 2018 10:17:41 -0500
MIME-Version: 1.0
In-Reply-To: <f16c1406-78ac-d275-63e9-90de3beac9f0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qCvXIR8hNMVRUeJ7nIstGuqoaNXQxzQBl"
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qCvXIR8hNMVRUeJ7nIstGuqoaNXQxzQBl
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 libvir-list@redhat.com, Alexander Graf <agraf@suse.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson
 <dgibson@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Message-ID: <b0d8036a-4ce0-de5c-88ac-28360658e1e2@redhat.com>
Subject: Re: [qemu RFC v2] qapi: add "firmware.json"
References: <20180417224054.26363-1-lersek@redhat.com>
 <c5e3f942-2c0e-9809-32ae-df97eaf2b7cd@redhat.com>
 <762b3dc8-a86f-a21f-1e21-334ec46677ef@redhat.com>
 <20180418120320.GH27579@redhat.com>
 <f16c1406-78ac-d275-63e9-90de3beac9f0@redhat.com>
In-Reply-To: <f16c1406-78ac-d275-63e9-90de3beac9f0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2018 07:40 AM, Laszlo Ersek wrote:

> Is it guaranteed that lists in JSON keep the order of the elements?
> Because, dictionaries definitely don't promise any ordering between the=

> keys.

Yes, JSON lists preserve order (and we have to explicitly document cases
where order within a list is not significant).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qCvXIR8hNMVRUeJ7nIstGuqoaNXQxzQBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXYZUACgkQp6FrSiUn
Q2ryngf/S6GQf0CNXWXIfinXj08hRZJkAVWbxj5/ukUqqfxe1U9dxwHWcoj3dFPc
Hb5WE7uPR8/Jvb9Er6a5dtvQvMwmenWfD3ajOc+WCWCiU7dD2hXmnStQUH60OgG7
vNqtP0brvvN6094qPS7uQ43W/jegZDsrkuahp+mjUy2nDIcIef+0InGnTSkGOfAL
rF1Fwazy72CNBX0pbcQgVQjR4nyw6KXzOKRmi6w9ckiE6OHOxp4M39vTvvO5HFzB
uXy9TiK+7/FGVKiE36lXkWxg0Jr91vdjAZljI9LgI34huyYL+IeXoqvg5wt0Zppa
Ei1QAonU/Xf86PjipwbFrk+0+6H4JQ==
=sBfc
-----END PGP SIGNATURE-----

--qCvXIR8hNMVRUeJ7nIstGuqoaNXQxzQBl--

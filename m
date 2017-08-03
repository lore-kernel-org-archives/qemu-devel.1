Received: from eggs.gnu.org ([2001:4830:134:3::10]:58065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddElz-0004GH-7S
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddEly-0007pm-AZ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:58:39 -0400
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<20170803080741.GA4456@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3d8be9b-0811-09f8-11a5-fd92e884da46@redhat.com>
Date: Thu, 3 Aug 2017 06:58:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170803080741.GA4456@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2j8WERihCUCregau86Br5fb34L6Fp4td2"
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2j8WERihCUCregau86Br5fb34L6Fp4td2
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <b3d8be9b-0811-09f8-11a5-fd92e884da46@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
 <20170731095443.28211-6-el13635@mail.ntua.gr>
 <20170803080741.GA4456@dhcp-200-186.str.redhat.com>
In-Reply-To: <20170803080741.GA4456@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 03:07 AM, Kevin Wolf wrote:
> Am 31.07.2017 um 11:54 hat Manos Pitsidianakis geschrieben:
>> block/throttle.c uses existing I/O throttle infrastructure inside a
>> block filter driver. I/O operations are intercepted in the filter's
>> read/write coroutines, and referred to block/throttle-groups.c
>>
>> The driver can be used with the syntax
>> -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>>         limits.iops-total=3D...,throttle-group=3Dbar
>>
>> The configuration flags and their semantics are identical to the
>> hardcoded throttling ones.
>>
>> A node can be created referring to an existing group, and will overwri=
te
>> its limits if any are specified, otherwise they are retained.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---

>> +
>> +    .is_filter                          =3D   true,
>> +};
>=20
> What about .bdrv_co_get_block_status?

And if so, do you want my byte-based block status to go in first?  (Our
two series conflict, so we need to pick who needs to rebase on top of
the other).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2j8WERihCUCregau86Br5fb34L6Fp4td2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDD+YACgkQp6FrSiUn
Q2qrOAgAlP7phZg/0KQHVG1GcpJ5cEv2iscHZyFTqf+i4oRnJGESujlziSbFp2LU
MP+r4EzPQfZYq3toIaelqxXe1c+gOaRYpRWScyMoqHYCZCO8Urh8K7Es7V80OwQx
7NiyI1pnDXCaoM+ig59Ij+j3gjZAkEb6ehX8HyuvS+qKQHaf4RvI/EM3l5V/AsNH
pkIYElD270/mI0VUlU3y1LwGSoaU6aByuMfq67mWFAf9fzKzI/VxezqIlEzRGix4
h6/hSXFwKcDL1iijx13F151hoZjQPlMyHx0z3rNNTODQAqLS7Uw8NRNzm8T0iE6C
xqSkKcK+jgGnIgk6Lao/9DbAHqj47g==
=5MFq
-----END PGP SIGNATURE-----

--2j8WERihCUCregau86Br5fb34L6Fp4td2--

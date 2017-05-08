Received: from eggs.gnu.org ([2001:4830:134:3::10]:48702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7mGR-0002Rc-2f
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7mGP-0006NW-Tx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:16:02 -0400
References: <20170507000552.20847-1-eblake@redhat.com>
	<20170507000552.20847-7-eblake@redhat.com>
	<3f3d454b-6ab4-52d4-eaac-adaeec3ca700@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8ba0bbc-b69b-9aae-0496-b1b6feb963d2@redhat.com>
Date: Mon, 8 May 2017 12:15:53 -0500
MIME-Version: 1.0
In-Reply-To: <3f3d454b-6ab4-52d4-eaac-adaeec3ca700@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="whRlQVHwrxgkd90A9N84RQqqABpJ7xnFK"
Subject: Re: [Qemu-devel] [PATCH v13 06/12] qcow2: Make distinction between
 zero cluster types obvious
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--whRlQVHwrxgkd90A9N84RQqqABpJ7xnFK
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <d8ba0bbc-b69b-9aae-0496-b1b6feb963d2@redhat.com>
Subject: Re: [PATCH v13 06/12] qcow2: Make distinction between zero cluster
 types obvious
References: <20170507000552.20847-1-eblake@redhat.com>
 <20170507000552.20847-7-eblake@redhat.com>
 <3f3d454b-6ab4-52d4-eaac-adaeec3ca700@redhat.com>
In-Reply-To: <3f3d454b-6ab4-52d4-eaac-adaeec3ca700@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 10:54 AM, Max Reitz wrote:
> On 07.05.2017 02:05, Eric Blake wrote:
>> Treat plain zero clusters differently from allocated ones, so that
>> we can simplify the logic of checking whether an offset is present.
>> Do this by splitting QCOW2_CLUSTER_ZERO into two new enums,
>> QCOW2_CLUSTER_ZERO_PLAIN and QCOW2_CLUSTER_ZERO_ALLOC.
>>

> (No, I'm not mentioning the fact that 060.out contains one more mention=

> of "Data cluster offset" that should definitely be a "Cluster allocatio=
n
> offset" or even "Preallocated zero cluster offset" at
> block/qcow2-cluster.c:1780, because let's really worry about this later=
)

Oh, you mean this?
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01784.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--whRlQVHwrxgkd90A9N84RQqqABpJ7xnFK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEKfJAAoJEKeha0olJ0NqKA8IAJl/PYaHD1b0TamblBHwjncB
Mta5vduaGAEA/L4RmqR2ggDrGW0eXbRGXAhbagK7OsvDY8nVMhAYMw8+9F9jJNIR
xktS4xyeAHRL1XKywOWYOLNvPjP+OAj8gNwQrL2aXBP4bwoZSPUsAAGuW0BwdO+O
TKBTjUpK2Eqoux6dINldpHj42caohgughl2Th424xmiXSSeuxldOek0tJ8NFSwqF
nony2gmW6PsWwZk0pK5VX6V88kLNjGhU1HSEj/eYlFXCbLhCzcrFWZRBQoFm7hv0
7ia9QmFqREJnx59m/P+L/3BjjoaRmrQ/NoIc4A9CeLDOnSLl62RjHlekzBC7Gok=
=Pi18
-----END PGP SIGNATURE-----

--whRlQVHwrxgkd90A9N84RQqqABpJ7xnFK--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhwz4-0001rg-FB
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhwz3-0003BO-9J
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:59:38 -0400
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<6ebebb61-1f5e-391b-03d7-cae2bee99a2f@redhat.com>
	<20170816094135.beufpqce3v4amhl3@postretch>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d2871d5-e224-6bc7-ebc1-f791357371ce@redhat.com>
Date: Wed, 16 Aug 2017 06:59:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170816094135.beufpqce3v4amhl3@postretch>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="smiipBiB8Wkkx1vxrdlepL4cuLRkl3B4u"
Subject: Re: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--smiipBiB8Wkkx1vxrdlepL4cuLRkl3B4u
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block <qemu-block@nongnu.org>
Message-ID: <1d2871d5-e224-6bc7-ebc1-f791357371ce@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP command
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
 <6ebebb61-1f5e-391b-03d7-cae2bee99a2f@redhat.com>
 <20170816094135.beufpqce3v4amhl3@postretch>
In-Reply-To: <20170816094135.beufpqce3v4amhl3@postretch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 04:41 AM, Manos Pitsidianakis wrote:

>>> +##
>>> +# @block-insert-node:
>>> +#
>>> +# Insert a filter node between a specific edge in the block driver
>>> state graph.
>>> +# @parent:  the name of the parent node or device
>>> +# @node:    the name of the node to insert under parent
>>> +# @child:   the name of the child of both node and parent
>>
>> Is this always going to be between two existing nodes, or can this
>> command also be used to insert at the end of the chain (for example, i=
f
>> parent or child is omitted)?
>=20
> If this is used for filter nodes, I suppose only between would make
> sense (for now). Is there a use case for the latter?

Perhaps.

Given a qcow2 image backing chain:

base <- active

there are four BDS (2 format, 2 protocol).  Ideally, I could add
filtering to any one of those four nodes (a filter on the base protocol
level restricts how much guest data can be used from the backing image,
but with no limits on the qcow2 metadata; a filter on the base format
level restricts metadata reads as well; similarly for filters on the
active protocol and format layers).

But adding a filter on 'active' at the format level has no pre-existing
parent (I'm adding the filter as the new top-level).  Or am I missing
something?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--smiipBiB8Wkkx1vxrdlepL4cuLRkl3B4u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmUM50ACgkQp6FrSiUn
Q2pUfwf+MSFJHizGatjj6j5c87CQgJnxpKb1FhNCNQxO+2E1z46XwsNWO8BqzOjc
inIXoI8GEj3mLEEW53m9tgEERouWH/HdrTULTJ0vbo7zKxrKgG0c+pjdxcTKjJb6
K6j20PPCQtNaoUbhvtcwT+iQGHhKuzWssFwvHpKPapeqslb+07qvrI//RDrsPoKT
w3MbPjRQ3ajS9lWYI6QbWa/X6ukmtR9CsdxqA5cuCH/fIoGzxEvspev8R7JxmiJu
qKP/HQd4ZpgM+xS4fnXbzPtSYvdiQRblbX5mYPrXrXVr1v6Ml6wriY96JDE1DRVu
v/Y2G+T8C/wwK54M2XoXeZyZgi/0OA==
=b9B4
-----END PGP SIGNATURE-----

--smiipBiB8Wkkx1vxrdlepL4cuLRkl3B4u--

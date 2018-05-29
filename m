Received: from eggs.gnu.org ([2001:4830:134:3::10]:47222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNaqp-0004rz-5H
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNaqo-0007Kh-8S
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:23:31 -0400
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<bbd19001-3e42-565b-bd48-c4370204c5ff@redhat.com>
	<20180528190915.GK4580@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <233d8d33-1865-9100-aa1e-07979473f495@redhat.com>
Date: Tue, 29 May 2018 11:23:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180528190915.GK4580@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pslr5BdWizvcvtxIzMcRuIvsqFVBb7xPo"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pslr5BdWizvcvtxIzMcRuIvsqFVBb7xPo
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <233d8d33-1865-9100-aa1e-07979473f495@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180518180440-mutt-send-email-mst@kernel.org>
 <20180524113251.GB4660@redhat.com>
 <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
 <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
 <bbd19001-3e42-565b-bd48-c4370204c5ff@redhat.com>
 <20180528190915.GK4580@localhost.localdomain>
In-Reply-To: <20180528190915.GK4580@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-05-28 21:09, Kevin Wolf wrote:
> Am 28.05.2018 um 20:44 hat Max Reitz geschrieben:
>> On 2018-05-28 20:38, Kevin Wolf wrote:
>>> Am 28.05.2018 um 20:30 hat Richard W.M. Jones geschrieben:
>>>> On Mon, May 28, 2018 at 08:10:32PM +0200, Max Reitz wrote:
>>>>> As someone who is just naive and doesn't see the big picture, I don=
't
>>>>> see what's wrong with using a tar file that contains the image and
>>>>> additional data.
>>>>
>>>> FWIW an OVA file is exactly this: an uncompressed tar file containin=
g
>>>> disk image(s) and metadata.
>>>
>>> If we combine VM configuration and the disk image this way, I would
>>> still want to directly use that combined thing without having to extr=
act
>>> its components first.
>>>
>>> Just accessing the image file within a tar archive is possible and we=

>>> could write a block driver for that (I actually think we should do
>>> this), but it restricts you because certain operations like resizing
>>> aren't really possible in tar. Unfortunately, resizing is a really
>>> common operation for non-raw image formats.
>>>
>>> And if I think of a file format that can contain several different
>>> things that can be individually resized etc., I end up with qcow2 in =
the
>>> simple case or a full file system in the more complex case.
>>
>> Well, you end up with VMDK.
>=20
> I don't think VMDK can save several different objects? It can have some=

> metadata in the descriptor, and it can spread the contents of a single
> object across multiple files (with extents), but I don't think it has
> something comparable to e.g. qcow2 snapshots, which are separate object=
s
> with an individual size that can dynamically change.

Right, I tried to be funny and was over-simplifying in the process.

What I meant is: You end up with an image format that is spread on a
filesystem, like VMDK is (usually).  Then you have some metadata
descriptor file that describes the rest and multiple data object files.

(For completeness's sake: And you can use an external or an internal
filesystem, that is, use multiple files (like VMDK) or have an internal
filesystem (like tar, except tar doesn't allow fragmentation).)

Max


--Pslr5BdWizvcvtxIzMcRuIvsqFVBb7xPo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNHAIACgkQ9AfbAGHV
z0DzhggAwsh9pqhSLG0n5rS0uxre8sKhuvcqsPin/uaWq6cLeC01ZUUX+D8d94sq
6IHe23ZANlvwqVFq6MLtdDLRS7RE9NmuciTlt1ZDGhMHcyuVMpai3HYjKwkT86NU
lj1waGw5mTz6pgRB7JPUay7Zvj8860u75B54TZ6M5+LqvOju/BEZgvP0aTYuJSWT
5h918NHNt8f/G6CJS451KDxtrKS7tTBCnvCdTCkuN9/WAQqxd+SaSJhSQXBIAYRw
2KfLayG4S5OpAKNHjbbyb8yWmIGIb4b3r3qz7x+PpDPtz/BFl6OWcY8QTowLR054
eDFlSsEnBji0RcUPXt7LshMxC3uNyg==
=p8FU
-----END PGP SIGNATURE-----

--Pslr5BdWizvcvtxIzMcRuIvsqFVBb7xPo--

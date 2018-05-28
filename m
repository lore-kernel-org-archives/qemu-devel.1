Received: from eggs.gnu.org ([2001:4830:134:3::10]:44394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNN8T-0003x4-1G
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNN8S-0006Zb-6f
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:44:49 -0400
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bbd19001-3e42-565b-bd48-c4370204c5ff@redhat.com>
Date: Mon, 28 May 2018 20:44:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180528183833.GJ4580@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Jz3X3q8BjQb4RFtvnp1quaPALF8okhYEG"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jz3X3q8BjQb4RFtvnp1quaPALF8okhYEG
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <bbd19001-3e42-565b-bd48-c4370204c5ff@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180518180440-mutt-send-email-mst@kernel.org>
 <20180524113251.GB4660@redhat.com>
 <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
 <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
In-Reply-To: <20180528183833.GJ4580@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-28 20:38, Kevin Wolf wrote:
> Am 28.05.2018 um 20:30 hat Richard W.M. Jones geschrieben:
>> On Mon, May 28, 2018 at 08:10:32PM +0200, Max Reitz wrote:
>>> As someone who is just naive and doesn't see the big picture, I don't=

>>> see what's wrong with using a tar file that contains the image and
>>> additional data.
>>
>> FWIW an OVA file is exactly this: an uncompressed tar file containing
>> disk image(s) and metadata.
>=20
> If we combine VM configuration and the disk image this way, I would
> still want to directly use that combined thing without having to extrac=
t
> its components first.
>=20
> Just accessing the image file within a tar archive is possible and we
> could write a block driver for that (I actually think we should do
> this), but it restricts you because certain operations like resizing
> aren't really possible in tar. Unfortunately, resizing is a really
> common operation for non-raw image formats.
>=20
> And if I think of a file format that can contain several different
> things that can be individually resized etc., I end up with qcow2 in th=
e
> simple case or a full file system in the more complex case.

Well, you end up with VMDK.

Max


--Jz3X3q8BjQb4RFtvnp1quaPALF8okhYEG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsMThgACgkQ9AfbAGHV
z0ANDwf/UXa8TcSBEQ1J9kPl6qhT2qiUPUB7AxyprshNE0w6Hg4m/rWIbf4WrTt6
RmQIAOv/B65JnETTVhvcqNszfcq7UJY2EwO0WOC8h8U6yV1sHWdyLuaZdMHotenz
5pAqkZzXmI3YN9WJZWTPwib7CMuEbYMcYY2bsl0YsdoMsEWh6Bqfqw7Xbu+jKsYH
o2X5xUBD7I5j0korC+WZgKAdyIGOP4N3zia5q+UJDrAAOz4vVS5QxNvGwo4daMGj
7J7ZyS4iua7HNsZCS4ytivK7/5HnKb7C6RA9Vw8eQ/hNUm7fKgJTTKqolrIedOY4
URzFEOkUisDXiaiBvfuZImbxG0f8pw==
=8jcJ
-----END PGP SIGNATURE-----

--Jz3X3q8BjQb4RFtvnp1quaPALF8okhYEG--

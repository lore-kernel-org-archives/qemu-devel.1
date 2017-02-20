Received: from eggs.gnu.org ([2001:4830:134:3::10]:56292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cfu8i-0000uw-PY
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cfu8e-0003eG-OL
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:00:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cfu8e-0003e6-Ff
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:00:48 -0500
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
	<20170220102304.GC2372@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
Date: Mon, 20 Feb 2017 14:00:39 -0600
MIME-Version: 1.0
In-Reply-To: <20170220102304.GC2372@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XunUrte39p7eaCu5FVe1NPMfE26NtqoBI"
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XunUrte39p7eaCu5FVe1NPMfE26NtqoBI
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 ben@skyportsystems.com, mst@redhat.com
Message-ID: <3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine Generation
 ID support
References: <cover.1487286467.git.ben@skyportsystems.com>
 <88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
 <20170217114321.6c8577e1@nial.brq.redhat.com>
 <918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
 <20170220102304.GC2372@work-vm>
In-Reply-To: <20170220102304.GC2372@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 04:23 AM, Dr. David Alan Gilbert wrote:
> * Laszlo Ersek (lersek@redhat.com) wrote:
>> CC Dave
>=20
> This isn't an area I really understand; but if I'm
> reading this right then=20
>    vmgenid is stored in fw_cfg?
>    fw_cfg isn't migrated
>=20
> So why should any changes to it get migrated, except if it's already
> been read by the guest (and if the guest reads it again aftwards what's=

> it expected to read?)

Why are we expecting it to change on migration?  You want a new value
when you load state from disk (you don't know how many times the same
state has been loaded previously, so each load is effectively forking
the VM and you want a different value), but for a single live migration,
you aren't forking the VM and don't need a new generation ID.

I guess it all boils down to what command line you're using: if libvirt
is driving a live migration, it will request the same UUID in the
command line of the destination as what is on the source; while if
libvirt is loading from a [managed]save to restore state from a file, it
will either request a new UUID directly or request auto to let qemu
generate the new id.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XunUrte39p7eaCu5FVe1NPMfE26NtqoBI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq0rnAAoJEKeha0olJ0NqzwYH/jsdDprNzud/KsRZb16SzsvE
4hHUMe5XyaaIyarzVg6Qd+stFoP/P9R+EwtnDqMzXZZhb6y6VtsiZOe7EmmSBiHw
b0WJqn6ieEK1xrh+rtNQj4Y2vgM2QQe90oGesnz+3xtVt2rTXeq+hvCsxvPY7Z3T
T0BD9zDr/41f041rD159UfUQTYZe/PaURpys9DGledHF0SBO8MY2lTOQCUVyQVWK
6RBqzlHExmERa5ThHIWaQiadlKemtY44y55b3fym7G3e26uAoMYSngEQaxxDvzRH
mHZABitwAGnCEW21X2mhQuElU9kAc+9L72IyZj7ZLBJBzxOJHSxv5ZWrrWRex8g=
=VwcT
-----END PGP SIGNATURE-----

--XunUrte39p7eaCu5FVe1NPMfE26NtqoBI--

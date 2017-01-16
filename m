Received: from eggs.gnu.org ([2001:4830:134:3::10]:33883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTDJj-00015u-1r
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTDJf-0007Ou-Q0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:51:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cTDJf-0007Oa-Go
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:51:43 -0500
References: <cover.1484593565.git.ben@skyportsystems.com>
	<d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skyportsystems.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a4fa1114-56b0-e996-2756-d9f2e96ca7c7@redhat.com>
Date: Mon, 16 Jan 2017 13:51:39 -0600
MIME-Version: 1.0
In-Reply-To: <d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skyportsystems.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2dVJPkNg2EBS3Jf6Kpu87I2oDLkx4vxjU"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] docs: vm generation id device's
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: Gal Hammer <ghammer@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2dVJPkNg2EBS3Jf6Kpu87I2oDLkx4vxjU
From: Eric Blake <eblake@redhat.com>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: Gal Hammer <ghammer@redhat.com>
Message-ID: <a4fa1114-56b0-e996-2756-d9f2e96ca7c7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] docs: vm generation id device's
 description
References: <cover.1484593565.git.ben@skyportsystems.com>
 <d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skyportsystems.com>
In-Reply-To: <d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 01:20 PM, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>

meta-comment: This message was sent with headers:
> Message-Id: <d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.be=
n@skyportsystems.com>
> In-Reply-To: <cover.1484593565.git.ben@skyportsystems.com>
> References: <cover.1484593565.git.ben@skyportsystems.com>
> In-Reply-To: <cover.1484594095.git.ben@skyportsystems.com>
> References: <cover.1484594095.git.ben@skyportsystems.com>

while your cover letter's actual headers included:
> Message-Id: <cover.1484593565.git.ben@skyportsystems.com>

I don't know how you got your sending side to use two different sets of
In-Reply-To, but it breaks at least Thunderbird's abilities to rethread
the messages (thunderbird apparently only pays attention to the last
header, while only the first one would cause correct threading).


>=20
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> Cc: Gal Hammer <ghammer@redhat.com>

If you are basing this patch off of earlier work (for example, you
mentioned Igor's work), you may need additional S-o-b lines for work you
copied from the earlier versions.

> ---
>  docs/specs/vmgenid.txt | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 docs/specs/vmgenid.txt
>=20
> diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
> new file mode 100644
> index 0000000..afc1717
> --- /dev/null
> +++ b/docs/specs/vmgenid.txt
> @@ -0,0 +1,38 @@
> +VIRTUAL MACHINE GENERATION ID
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Copyright (C) 2016 Red Hat, Inc.

Claiming Red Hat copyright makes it sound like you are basing this off
an earlier version.  That is the correct thing to do if you indeed
copied something with Red Hat copyright, but seems weird if you wrote it
from scratch.

> +Copyright (C) 2016 Skyport Systems, Inc.

Do you want to claim 2017 as well?


> +
> +The vmgenid device is a sysbus device with the ACPI ID "QEMU_Gen_Count=
er_V1".
> +
> +The device has one properties, which can be set using the command line=


s/properties/property/

> +argument or the QMP interface:
> + guid - sets the value of the GUID
> +For example:
> +QEMU  -device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
> +

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2dVJPkNg2EBS3Jf6Kpu87I2oDLkx4vxjU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfSRLAAoJEKeha0olJ0NqQq4H/1JgWAbe/yJoda0c8Zm802f4
Er2fQMuGfaN5VQWYJnhRary/le5impJnQTtQ0av+DFXo4YUXneSQSN6z9wq74EV6
7n+enVTLTbhta18Pv6CaasB/SZyaMMk2dtP4qjdl9v+qaOrD2ABTQukshiu+qazK
FautQP1AwIFzwK6mnswri0OalBk8peJzwon0HteYyr56uN81S98rgR+w5itiGs8h
NlQQ5PTkvhfcNFj05JqPenNytiZZsE/pz1l1sw6Cswax0ms6qrrxd21A3UaW3Zf1
gZSW2MAuXcvJkS8KInr5HeOtnsUdpYVoGel/ug1zumLPOkm7z46RR8SjJpm3lsY=
=mhL5
-----END PGP SIGNATURE-----

--2dVJPkNg2EBS3Jf6Kpu87I2oDLkx4vxjU--

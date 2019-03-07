Received: from eggs.gnu.org ([209.51.188.92]:48082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1vgO-0003R9-Li
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1vgN-0004i7-Sh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:15:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1vgN-0004h8-HK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:15:43 -0500
References: <20190307072251.9823-1-elena.ufimtseva@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a8708e52-8a83-e21f-7ea6-0579b475ad6b@redhat.com>
Date: Thu, 7 Mar 2019 10:15:36 -0600
MIME-Version: 1.0
In-Reply-To: <20190307072251.9823-1-elena.ufimtseva@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xhYZtk7s265ffxgHEDpEDNyb6xCnIq2Ll"
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 35/37] multi-process:
 QMP/HMP commands to resize block device on remote process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Cc: ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, dgilbert@redhat.com, berrange@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xhYZtk7s265ffxgHEDpEDNyb6xCnIq2Ll
From: Eric Blake <eblake@redhat.com>
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Cc: ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com,
 kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, sstabellini@kernel.org, dgilbert@redhat.com,
 berrange@redhat.com, armbru@redhat.com
Message-ID: <a8708e52-8a83-e21f-7ea6-0579b475ad6b@redhat.com>
Subject: Re: [multiprocess RFC PATCH 35/37] multi-process: QMP/HMP commands to
 resize block device on remote process
References: <20190307072251.9823-1-elena.ufimtseva@oracle.com>
In-Reply-To: <20190307072251.9823-1-elena.ufimtseva@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 1:22 AM, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Adds rblock_resize QMP/HMP commands to resize block devices on the remo=
te
> process.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---

I know the discussion is questioning whether this is even the right way
to go, but if we DO add a QMP command,

> +++ b/qapi/block-core.json
> @@ -1260,6 +1260,31 @@
>              'size': 'int' } }
> =20
>  ##
> +# @rblock_resize:

It should be named 'rblock-resize'

> +#
> +# Resize a block image while a guest is running, on a remote device.
> +#
> +# @device: the name of the device to get the image resized
> +#
> +# @size:  new image size in bytes
> +#
> +# Returns: nothing on success
> +#          If @device is not a valid block device, DeviceNotFound
> +#
> +# Since: 3.0.93

and you've missed 3.0 (if you got it in THIS week, it would be Since
4.0; but that's unlikely, so you want Since 4.1).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xhYZtk7s265ffxgHEDpEDNyb6xCnIq2Ll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBQ6gACgkQp6FrSiUn
Q2q77wf/T3j/ROb0aIpYJtXNzYN6MEbOIuu/i+ddhqC+tbGDhyrDKnSUQZcVT3M2
I4wif/rtooSvKQxJRup/fZztOwYFiV4u+MNxUE2qA+/TRw/3eFO6Bi6x8tE+zzyE
OWemWv9KA9E/C2LZ+zz73mBGMOKSIITG/QAxWk1pPAH/GTAiVttIMQym+zPkSdcf
0w52KjLJ9yRmg45PNeTH8+PcomrnjgOuvEd4BvlL2OTrlg/YhXHSA8/L49vCaGIO
G5mUhZNww/Vb8LrI5c1yj127zqJAuTgYWUbZ+LVo6hB36QKylttkqm/HCNaft8yI
kITCKtZdm3lXycubtWfkePfhdJxDDQ==
=Irio
-----END PGP SIGNATURE-----

--xhYZtk7s265ffxgHEDpEDNyb6xCnIq2Ll--

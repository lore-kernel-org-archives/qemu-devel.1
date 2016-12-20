Received: from eggs.gnu.org ([2001:4830:134:3::10]:41809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJLWx-0007cF-KI
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 09:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJLWt-0006Na-7U
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 09:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cJLWs-0006N0-V3
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 09:36:35 -0500
References: <cover.1482187052.git.ben@skyportsystems.com>
	<d73fe3d84b15c6bda193c709ed11d9335f99d9f8.1482187052.git.ben@skyportsystems.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b8edae8-b08d-7413-af41-39c854b8b696@redhat.com>
Date: Tue, 20 Dec 2016 08:36:32 -0600
MIME-Version: 1.0
In-Reply-To: <d73fe3d84b15c6bda193c709ed11d9335f99d9f8.1482187052.git.ben@skyportsystems.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jr67wi1jdG4xgLVbKKhm9SCgUHfPxwQqV"
Subject: Re: [Qemu-devel] [PATCH 5/5] qmp/hmp: add set-vm-generation-id
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jr67wi1jdG4xgLVbKKhm9SCgUHfPxwQqV
From: Eric Blake <eblake@redhat.com>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>
Message-ID: <9b8edae8-b08d-7413-af41-39c854b8b696@redhat.com>
Subject: Re: [PATCH 5/5] qmp/hmp: add set-vm-generation-id commands
References: <cover.1482187052.git.ben@skyportsystems.com>
 <d73fe3d84b15c6bda193c709ed11d9335f99d9f8.1482187052.git.ben@skyportsystems.com>
In-Reply-To: <d73fe3d84b15c6bda193c709ed11d9335f99d9f8.1482187052.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2016 04:46 PM, ben@skyportsystems.com wrote:
> From: Igor Mammedov <imammedo@redhat.com>
>=20
> Add set-vm-generation-id command to set Virtual Machine
> Generation ID counter.
>=20
> QMP command example:
>     { "execute": "set-vm-generation-id",
>           "arguments": {
>               "changed": true,
>               "guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>           }
>     }
>=20
> HMP command example:
>     set-vm-generation-id changed=3Dtrue guid=3D324e6eaf-d1d1-4bf6-bf41-=
b9bb6c91fb87
>=20
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> ---

> +++ b/qapi-schema.json
> @@ -4796,3 +4796,15 @@
>  # Since 2.9
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> +
> +##
> +# @set-vm-generation-id
> +#
> +# Set Virtual Machine Generation ID
> +#
> +# @changed: Is the Virtual Machine Generation ID a new value?
> +# @guid: new GUID to set as Virtual Machine Generation ID
> +#
> +# Since 2.9
> +##
> +{ 'command': 'set-vm-generation-id', 'data': { 'changed': 'bool', 'gui=
d': 'str' } }

When should 'changed' ever be set to false?  Should it be an optional
parameter, defaulting to true, if it is even needed?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jr67wi1jdG4xgLVbKKhm9SCgUHfPxwQqV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYWUHwAAoJEKeha0olJ0NqfNwH/RpiBGeiuuyRnpTUCEXaDTWZ
jYhQBTxraxEMG516i0T7pgg0W0xzDu3P7wmProJzATsiUWiVOSgodkFxELw3+hC/
1Qbp/rmVDnPD4xv9dNC14v0UHIZ+HP1wE86a7sXV8BFbpabR0C+hPRey8SJ5S3k8
/fEalzvvmGphC2Gzvb3Cjo+XvZoFNBi6fTpUKElorqT2/AU/6BkcurdrvhLGG4lN
iR8k+FTWXsNrIfrocqkJHiWNzfcD02G7BaUtNDNeoYILYvRV42CVhJ0Drwvrxk/v
t2UYE5XG0Fizx9WfHLQ7idYns/BI3GJq3BxjwGf8p/ssJsUxFTLS7skyiKaYEtU=
=vxfP
-----END PGP SIGNATURE-----

--jr67wi1jdG4xgLVbKKhm9SCgUHfPxwQqV--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepSj-0004Qr-17
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepSg-0002BU-F5
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:49:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cepSg-0002AL-6E
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:49:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 170372E6043
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:49:02 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-17-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3894759-0aea-2945-88e9-777ce10fbdcf@redhat.com>
Date: Fri, 17 Feb 2017 14:48:59 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-17-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n74ov7PXPniDN3IcJnP1x9rDifeumpMVv"
Subject: Re: [Qemu-devel] [PATCH 16/24] util/cutils: New qemu_strtosz()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n74ov7PXPniDN3IcJnP1x9rDifeumpMVv
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e3894759-0aea-2945-88e9-777ce10fbdcf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/24] util/cutils: New qemu_strtosz()
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-17-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> Most callers of qemu_strtosz_suffix() pass QEMU_STRTOSZ_DEFSUFFIX_B.
> Capture the pattern in new qemu_strtosz().
>=20
> Inline qemu_strtosz_suffix() into its only remaining caller.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/util/cutils.c
> @@ -178,6 +178,14 @@ int fcntl_setfl(int fd, int flag)
>  }
>  #endif
> =20
> +#define QEMU_STRTOSZ_DEFSUFFIX_EB 'E'
> +#define QEMU_STRTOSZ_DEFSUFFIX_PB 'P'
> +#define QEMU_STRTOSZ_DEFSUFFIX_TB 'T'
> +#define QEMU_STRTOSZ_DEFSUFFIX_GB 'G'
> +#define QEMU_STRTOSZ_DEFSUFFIX_MB 'M'
> +#define QEMU_STRTOSZ_DEFSUFFIX_KB 'K'
> +#define QEMU_STRTOSZ_DEFSUFFIX_B 'B'

5/7 of these #defines are useless, now that all callers are limited to
file scope.

With that cleaned up,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--n74ov7PXPniDN3IcJnP1x9rDifeumpMVv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp2G7AAoJEKeha0olJ0NqmZEH+gOzikXdp7noE0kISR2crFiD
seMLAVDQpHDsB8n52JgtnFXFF05BEhkny5K9v7bIr8DtppA+BWRIB3dPAW7Iqw4c
zWgIPqx2BQT6NeN3q5CU6rPfcNuyHmVCZZO8vKoNZ8+RlhOUPc0T99v1gD6b0VKK
p9LFeNwd5Epz+9r/zgiMNsHzRMo60SzeXoQcqSytV0/lAcQii9LCp49RKUH4k3Tv
+AvhNmJeBDYsOiSNMHIgDd56k+OHOFON3bSCLZB7KG4RSTDiihgDtsfUrZ/4xMCB
nIInOUnQkC7bpM4fYEQiH2YIuXepmRWpHjw+y//eeUSmfX4sHfdf0gW7EPBpp6M=
=nAxS
-----END PGP SIGNATURE-----

--n74ov7PXPniDN3IcJnP1x9rDifeumpMVv--

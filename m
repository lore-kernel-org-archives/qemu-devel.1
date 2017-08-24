Received: from eggs.gnu.org ([2001:4830:134:3::10]:43291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkuCv-00080w-6u
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkuCu-0002SF-3C
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:09 -0400
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-7-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1259373f-69cb-adcd-7f85-73930dc709bc@redhat.com>
Date: Thu, 24 Aug 2017 10:37:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170822131832.20191-7-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jqvHv0StgdX1v6E0A31hVWg2rclngfdbI"
Subject: Re: [Qemu-devel] [PATCH 06/10] scsi,
 file-posix: add support for persistent reservation management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jqvHv0StgdX1v6E0A31hVWg2rclngfdbI
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org
Message-ID: <1259373f-69cb-adcd-7f85-73930dc709bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] scsi, file-posix: add support for
 persistent reservation management
References: <20170822131832.20191-1-pbonzini@redhat.com>
 <20170822131832.20191-7-pbonzini@redhat.com>
In-Reply-To: <20170822131832.20191-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/22/2017 08:18 AM, Paolo Bonzini wrote:
> It is a common requirement for virtual machine to send persistent
> reservations, but this currently requires either running QEMU with
> CAP_SYS_RAWIO, or using out-of-tree patches that let an unprivileged
> QEMU bypass Linux's filter on SG_IO commands.
>=20
> As an alternative mechanism, the next patches will introduce a
> privileged helper to run persistent reservation commands without
> expanding QEMU's attack surface unnecessarily.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

> +++ b/qapi/block-core.json
> @@ -2191,6 +2191,9 @@
>  # Driver specific block device options for the file backend.
>  #
>  # @filename:    path to the image file
> +# @pr-manager:  the if for the object that will handle persistent rese=
rvations

s/if/interface/ for legibility

> +#               for this device (default: forward the commands via SG_=
IO,
> +#               since 2.11)
>  # @aio:         AIO backend (default: threads) (since: 2.8)
>  # @locking:     whether to enable file locking. If set to 'auto', only=
 enable
>  #               when Open File Descriptor (OFD) locking API is availab=
le
> @@ -2200,6 +2203,7 @@
>  ##
>  { 'struct': 'BlockdevOptionsFile',
>    'data': { 'filename': 'str',
> +            '*pr-manager': 'str',
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jqvHv0StgdX1v6E0A31hVWg2rclngfdbI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlme8tcACgkQp6FrSiUn
Q2ryLgf9GtTOCYVKO0HNuEWy1bBJiN8QgRYGgbRE3gUuCifE/PV4Ji0J6H0VskQ9
NFkut3L5/Y0WazT0f5Kt1t3hx9SgkwDgCVLh/1M4uynt9SmFcUrfw3lw+scxPBIJ
of7uJZoYe/Dyh2y1DkYafjzzgrnhJzR92FwkIVPKEczpe6VHM6BF/HZHB5QcDja6
pzHvJvBpjRqTmTzv826rdtG4yuSviKax2E39Tz5ltsxbMIYEoZ11MFXMZjd6lNYk
pQDXWOh90hjZCXzGtX2ecZewuoBp2pMASZXiunKzhKDRTS+GOWXh06ymhCov4HHv
ud5tNwRPymci4d/PlHrGjB9pMdMJ6Q==
=8wrj
-----END PGP SIGNATURE-----

--jqvHv0StgdX1v6E0A31hVWg2rclngfdbI--

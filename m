Received: from eggs.gnu.org ([2001:4830:134:3::10]:45066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkuKU-00056h-Op
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkuKT-0006Zs-P4
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:45:58 -0400
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-9-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d706748e-1443-76cc-9ae2-8525186a3c9d@redhat.com>
Date: Thu, 24 Aug 2017 10:45:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170822131832.20191-9-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="09nrJn6lAi8SeqJVANj9ivhd1fMv8Ev2q"
Subject: Re: [Qemu-devel] [PATCH 08/10] scsi: build qemu-pr-helper
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
--09nrJn6lAi8SeqJVANj9ivhd1fMv8Ev2q
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org
Message-ID: <d706748e-1443-76cc-9ae2-8525186a3c9d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/10] scsi: build qemu-pr-helper
References: <20170822131832.20191-1-pbonzini@redhat.com>
 <20170822131832.20191-9-pbonzini@redhat.com>
In-Reply-To: <20170822131832.20191-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/22/2017 08:18 AM, Paolo Bonzini wrote:
> Introduce a privileged helper to run persistent reservation commands.
> This lets virtual machines send persistent reservations without using
> CAP_SYS_RAWIO or out-of-tree patches.  The helper uses Unix permissions=

> and SCM_RIGHTS to restrict access to processes that can access its sock=
et
> and prove that they have an open file descriptor for a raw SCSI device.=

>=20
> The next patch will also correct the usage of persistent reservations
> with multipath devices.
>=20
> It would also be possible to support for Linux's IOC_PR_* ioctls in
> the future, to support NVMe devices.  For now, however, only SCSI is
> supported.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

> +++ b/docs/interop/pr-helper.rst
> @@ -0,0 +1,78 @@
> +..
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Persistent reservation helper protocol
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU's SCSI passthrough devices, ``scsi-block`` and ``scsi-generic``,
> +can delegate implementation of persistent reservations to an external
> +(and typically privilege) program.  Persistent Reservations allow

s/privilege/privileged/


> +
> +If a bit is 1 in ``requested_features`` and 0 in ``supported_features`=
`,
> +the corresponding feature is not supported by the helper and the conne=
ction
> +is closed.  On the other hand, it is acceptable for a bit to be 0 in
> +``requested_features`` and 1 in ``supported_features``; in this case,
> +he helper will not enable the feature.

s/^he/the/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--09nrJn6lAi8SeqJVANj9ivhd1fMv8Ev2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlme9KsACgkQp6FrSiUn
Q2qHbggAsGrQoVxTfYcjE3Ti0n7n1qgYO8jNEUfVIUW1gk8gcs2DqGb0mNagn9iQ
XCmbQBZaCRuozRF6a9hRGxzn/H9bcFIR1XsSBse292XwC+7JWlqc1R5gfO4vRoMd
CrOA699TfJI8zsL0oSTT2D7OjYDjJ5pFVGiqdxQWDfmZWRWzFDekMnA/euEWdjQw
VczK/u67wkDORP1fHSCsoGYiXhByiTbbtw+AC0MVrX76zcSHspPsqsI5KXKG6SKR
wcLfFVheFDOwy69nlCcvonLguRAhq1R7DGH0WxAVmto1ajBNjn0/6yGc1xR38cn1
+h7xyuotFNIJL+DbN/3Wc0IKIXZwDg==
=1K24
-----END PGP SIGNATURE-----

--09nrJn6lAi8SeqJVANj9ivhd1fMv8Ev2q--

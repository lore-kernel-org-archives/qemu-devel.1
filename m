Received: from eggs.gnu.org ([2001:4830:134:3::10]:47018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9CMV-0006TG-DL
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9CMR-0001lQ-Au
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:24:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9CMR-0001kp-3Q
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:24:39 -0400
References: <20180418173901.19843-1-viktor.prutyanov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3452557e-c215-9afa-1ba2-3cdd3fa8c291@redhat.com>
Date: Thu, 19 Apr 2018 11:24:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180418173901.19843-1-viktor.prutyanov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1aFpNwkKeNsrM06JmjXYubq4rHc5ivk1s"
Subject: Re: [Qemu-devel] [PATCH v2] dump: add Windows dump format to
 dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: rkagan@virtuozzo.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1aFpNwkKeNsrM06JmjXYubq4rHc5ivk1s
From: Eric Blake <eblake@redhat.com>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: rkagan@virtuozzo.com, marcandre.lureau@redhat.com, dgilbert@redhat.com,
 armbru@redhat.com
Message-ID: <3452557e-c215-9afa-1ba2-3cdd3fa8c291@redhat.com>
Subject: Re: [PATCH v2] dump: add Windows dump format to dump-guest-memory
References: <20180418173901.19843-1-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <20180418173901.19843-1-viktor.prutyanov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2018 12:39 PM, Viktor Prutyanov wrote:
> This patch adds Windows crashdumping feature. Now QEMU can produce ELF-=
dump
> containing Windows crashdump header, which can help to convert to a val=
id
> WinDbg-understandable crashdump file, or immediately create such file.
> The crashdump will be obtained by joining physical memory dump and 8K h=
eader
> exposed through vmcoreinfo/fw_cfg device by guest driver at BSOD time. =
Option
> '-w' was added to dump-guest-memory command. At the moment, only x64
> configuration is supported.
> Suitable driver can be found at
> https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/fwc=
fg64
>=20
> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
> ---

> +++ b/qapi/misc.json
> @@ -1645,10 +1645,12 @@
>  #
>  # @kdump-snappy: kdump-compressed format with snappy-compressed
>  #
> +# @win-dmp: Windows full crashdump format, can be used instead of ELF =
converting (since 2.13)

Long line, please wrap under 80 columns.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1aFpNwkKeNsrM06JmjXYubq4rHc5ivk1s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrYwrsACgkQp6FrSiUn
Q2qM3wf/eG3mI8irNDaSIXBlEQsm6GSK+6oJL1j+Fg3zokvE7hS9RQDDw/s8GjMq
zFS7GHi8KX+4Rgmk8spBBFqXSU/7cREiVrczJDxy3jKtLdHfHYdzWKmgrfnXBCGs
Cn4EeJ4796PuaRAhotu/WWIIi37H7WggXEIbQffdypipWziSUmyqRv1VK/ZFtBVP
SxMKiDf0bdCOV5s7nZlmLHTpi8S8VrKIySW5gncBciEQdrdRa2lWCo4n7uG2z1ic
2pTyVLsUw6hxL0W2S8oOZ4muN18P+hfIy5UCajFF7V0qjW8tcPJmGp59nwoW36tG
d2kSAbWiKL0BDkb0oCSpZ6QLNFSAuw==
=i/A5
-----END PGP SIGNATURE-----

--1aFpNwkKeNsrM06JmjXYubq4rHc5ivk1s--

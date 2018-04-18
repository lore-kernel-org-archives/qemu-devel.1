Received: from eggs.gnu.org ([2001:4830:134:3::10]:60470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8oTL-0006p8-W3
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8oTI-0002zK-6z
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:54:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42320 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8oTI-0002z3-0r
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:54:08 -0400
References: <1523973044-25754-1-git-send-email-viktor.prutyanov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2af13979-965c-8b33-2de7-853f44e52fff@redhat.com>
Date: Wed, 18 Apr 2018 09:53:59 -0500
MIME-Version: 1.0
In-Reply-To: <1523973044-25754-1-git-send-email-viktor.prutyanov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="abimc0UK2ToqloPeDBZxc5E0KmhleMINF"
Subject: Re: [Qemu-devel] [PATCH v1] dump: add Windows dump format to
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
Cc: armbru@redhat.com, marcandre.lureau@gmail.com, rkagan@virtuozzo.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--abimc0UK2ToqloPeDBZxc5E0KmhleMINF
From: Eric Blake <eblake@redhat.com>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@gmail.com, rkagan@virtuozzo.com,
 dgilbert@redhat.com
Message-ID: <2af13979-965c-8b33-2de7-853f44e52fff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] dump: add Windows dump format to
 dump-guest-memory
References: <1523973044-25754-1-git-send-email-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <1523973044-25754-1-git-send-email-viktor.prutyanov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2018 08:50 AM, Viktor Prutyanov wrote:
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
> +# @win-dmp: Windows full crashdump format (can be used instead of ELF =
converting)

Missing a '(since 2.13)' tag.

> +#
>  # Since: 2.0
>  ##
>  { 'enum': 'DumpGuestMemoryFormat',
> -  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy' ] }
> +  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy', 'win-dmp=
' ] }
> =20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--abimc0UK2ToqloPeDBZxc5E0KmhleMINF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXXAgACgkQp6FrSiUn
Q2rNGAgAquR0CQio7ao2qTfcpSc36gevGjBkimsEnCjZfj5FP8Uog4lCZZ39kKEi
kpX0xVDc+JRmWtnPlfoiFlE9wjP67wBpwnNeQIJIYoaqowxIjX7BYe14NS+mtJ9a
9ahrihpNNj7s8F6AdLOEjyvvBAHvPxEBIvshQmjrB9AjnoGKgRIwdB0EN2HuWHYH
UpQqj+Y9m0mwDnTkajAieHzvBTZLbQOGU38qYdzEPKtJSVkvaiUT2Z0LtGAk4wIj
URFAbzZe9lXcF8eYNC17Jc4qcZ1paqW/qsv6bNiosXZ1cIESqCSSoeXWU3lne424
g53EJDUIiLEf9y92vGcmCWF21wEHNQ==
=O84J
-----END PGP SIGNATURE-----

--abimc0UK2ToqloPeDBZxc5E0KmhleMINF--

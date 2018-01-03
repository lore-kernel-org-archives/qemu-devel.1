Received: from eggs.gnu.org ([2001:4830:134:3::10]:33001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWsO1-0006xz-0f
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWsNx-0003JD-SO
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eWsNx-0003IV-K6
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:23:49 -0500
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-22-git-send-email-mjc@sifive.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e3bcfa2-c511-3ffb-44ab-be4567f2fb17@redhat.com>
Date: Wed, 3 Jan 2018 17:23:46 -0600
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-22-git-send-email-mjc@sifive.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0eUsJJeR2xMZuoDStf8E5UKzARZedtedM"
Subject: Re: [Qemu-devel] [PATCH v1 21/21] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0eUsJJeR2xMZuoDStf8E5UKzARZedtedM
From: Eric Blake <eblake@redhat.com>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Message-ID: <4e3bcfa2-c511-3ffb-44ab-be4567f2fb17@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 21/21] RISC-V Build Infrastructure
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
 <1514940265-18093-22-git-send-email-mjc@sifive.com>
In-Reply-To: <1514940265-18093-22-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2018 06:44 PM, Michael Clark wrote:
> This adds RISC-V into the build system enabling the following targets:
>=20
> - riscv32-softmmu
> - riscv64-softmmu
> - riscv32-linux-user
> - riscv64-linux-user
>=20
> This adds defaults configs for RISC-V, enables the build for the RISC-V=

> CPU core, hardware, and Linux User Emulation. The 'qemu-binfmt-conf.sh'=

> script is updated to add the RISC-V ELF magic.
>=20
> Expected checkpatch errors for consistency reasons:
>=20
> ERROR: line over 90 characters
> FILE: scripts/qemu-binfmt-conf.sh
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---

> +++ b/qapi-schema.json
> @@ -413,7 +413,7 @@
>  # Since: 2.6
>  ##
>  { 'enum': 'CpuInfoArch',
> -  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
> +  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'riscv', 'other' =
] }

Missing documentation that riscv was added in 2.12 (see QKeyCode in
qapi/ui.json for an enum that serves as an example of documenting
changes over time).


> =20
>  ##
> +# @CpuInfoRISCV:
> +#
> +# Additional information about a virtual RISCV CPU
> +#
> +# @pc: the instruction pointer
> +#
> +# Since 2.8

2.12, actually.

> +##
> +{ 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }

Should this be 'uint64' or other specific type, rather than the generic
'int' (which happens to be 64 bits, but signed)?  Other architectures
use 'int' because of history, but we could use this chance to improve
things if desired.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0eUsJJeR2xMZuoDStf8E5UKzARZedtedM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpNZgIACgkQp6FrSiUn
Q2okGwf+PU3NFQ6Zll2F6ZnUv0PBs4nyK6k1sBVlNSvsY7Zz6k1IRSa4QE7+KJke
BLeucrqKrgTYkYuCwS+wO4KXKUSq/EvGr2BYjv5l+Mpb0AXc5+uiMhaZ3yXmrKWZ
TMIPfw9d3qDeAgVzlEnMQTP3YO2bACsQIE67HcS97DWtASkeXtUB3pCSSvjt0mMj
qFQHmiAet/DUfBpe6DbairN7YKgzUofO852y+9jIP7uh2q64B6d7G3qpZxdlD8o7
rw2vvYtwQx3+K1oFFJxm2tmng7fMxWwo03kg0hcFyB/+Eu3Lg8ElxvFPFuGkaOYc
Ey0LXqWUo8LTqsAHj2hUtmDgjebvnA==
=DaXA
-----END PGP SIGNATURE-----

--0eUsJJeR2xMZuoDStf8E5UKzARZedtedM--

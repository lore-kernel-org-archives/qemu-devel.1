Received: from eggs.gnu.org ([2001:4830:134:3::10]:43924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6Sl-0004Ut-Lu
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6Si-00062F-GT
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:31:03 -0400
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-2-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5a4a333-c960-59ce-a850-105a7b609084@redhat.com>
Date: Tue, 24 Apr 2018 17:30:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180424214550.32549-2-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VLTeZgxgjZmzHeAksju4JsE2rjRYkTO3t"
Subject: Re: [Qemu-devel] [PATCH 1/6] qapi: fill in CpuInfoFast.arch in
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VLTeZgxgjZmzHeAksju4JsE2rjRYkTO3t
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, qemu-stable@nongnu.org
Message-ID: <e5a4a333-c960-59ce-a850-105a7b609084@redhat.com>
Subject: Re: [PATCH 1/6] qapi: fill in CpuInfoFast.arch in query-cpus-fast
References: <20180424214550.32549-1-lersek@redhat.com>
 <20180424214550.32549-2-lersek@redhat.com>
In-Reply-To: <20180424214550.32549-2-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 04:45 PM, Laszlo Ersek wrote:
> Commit ca230ff33f89 added added the @arch field to @CpuInfoFast, but it=


s/added added/added/

> failed to set the new field in qmp_query_cpus_fast(), when TARGET_S390X=

> was not defined. The updated @query-cpus-fast example in
> "qapi-schema.json" showed "arch":"x86" only because qmp_query_cpus_fast=
()
> calls g_malloc0() to allocate CpuInfoFast, and the CPU_INFO_ARCH_X86 en=
um
> constant is generated with value 0.
>=20
> All @arch values other than @s390 implied the @CpuInfoOther sub-struct =
for
> @CpuInfoFast -- at the time of writing the patch --, thus no fields oth=
er
> than @arch needed to be set when TARGET_S390X was not defined. Set @arc=
h
> now, by copying the corresponding assignments from qmp_query_cpus().

Perhaps worth mentioning that the riscv architecture shows up as 'other'
in this patch?  (But that gets cleaned up in the next one, so no big deal=
)

>=20
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: qemu-stable@nongnu.org
> Fixes: ca230ff33f89bf7102cbfbc2328716da6750aaed
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VLTeZgxgjZmzHeAksju4JsE2rjRYkTO3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfsBsACgkQp6FrSiUn
Q2pJsggAgjM9bO26B/Kw0YrOQrV4kWDSq3guy/ksBy+3nUcsVxbkut88kqYV7Ghy
sBr8SDFKXUlkkMFG28QrTkJauI8/OkE/wcSiTmkf0+NoiWgimxFSIIzIjrexVtbC
1uvCp1yKJL1IAtKUj+3SCr+LFrg0Ht0rh2lZOZ6ZtZV5c20xStY3pWQkB+7taXn4
bUBSu0P18nnVdvK3ou+3vsFOl+nMZlYzV9VVbMhm7hkwpcafTMAxKaOKifAbNVSG
g+pdJMEIJgdZGVzPSeypTkIi9a0rxYLJQPFCOEHCdGeWDVZQfQ/AV78KvkP7AEev
Bw4Jyv1CFwKppzXJBmYSIBueSusxFQ==
=nwJy
-----END PGP SIGNATURE-----

--VLTeZgxgjZmzHeAksju4JsE2rjRYkTO3t--

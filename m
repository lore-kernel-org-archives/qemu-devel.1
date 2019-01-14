Received: from eggs.gnu.org ([209.51.188.92]:57834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj8k9-0002lh-9e
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj8X5-0002EB-Ne
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:08:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gj8X3-0002CA-Rw
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:08:27 -0500
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
	<1547468699-17633-2-git-send-email-like.xu@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0fe9258-dcb6-f0eb-edfc-bf158ba2dbb4@redhat.com>
Date: Mon, 14 Jan 2019 14:08:16 -0600
MIME-Version: 1.0
In-Reply-To: <1547468699-17633-2-git-send-email-like.xu@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Wq27DwJMUXwS2EflI5Y35Iinne3iTTFsO"
Subject: Re: [Qemu-devel] [PATCH v1 1/5] cpu: introduce die,
 the new cpu toppolgy emulation level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>, qemu-devel@nongnu.org
Cc: drjones@redhat.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, like.xu@intel.com, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wq27DwJMUXwS2EflI5Y35Iinne3iTTFsO
From: Eric Blake <eblake@redhat.com>
To: Like Xu <like.xu@linux.intel.com>, qemu-devel@nongnu.org
Cc: drjones@redhat.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, like.xu@intel.com, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com,
 Richard Henderson <rth@twiddle.net>
Message-ID: <e0fe9258-dcb6-f0eb-edfc-bf158ba2dbb4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/5] cpu: introduce die, the new cpu
 toppolgy emulation level
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
 <1547468699-17633-2-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1547468699-17633-2-git-send-email-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 6:24 AM, Like Xu wrote:
> Following codes on smp_cores, the smp_dies/nr_dies/die-id is added to
> machine and CPUState. In addition to enable_cpuid_0xb, enable_cpuid_0x1=
f
> is introduced to track wether host is a new MCP macine or just ignored.=


s/wether/whether/, s/macine/machine/

> The number for die level_type on Intel is 5 while core type keeps 2.
>=20
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  cpus.c                | 1 +
>  include/qom/cpu.h     | 1 +
>  include/sysemu/cpus.h | 1 +
>  qapi/misc.json        | 1 +
>  target/i386/cpu.h     | 5 +++++
>  5 files changed, 9 insertions(+)
>=20

> +++ b/qapi/misc.json
> @@ -3229,6 +3229,7 @@
>  { 'struct': 'CpuInstanceProperties',
>    'data': { '*node-id': 'int',
>              '*socket-id': 'int',
> +            '*die-id': 'int',

Missing documentation of the new field, including a '(since 4.0)' tag.

>              '*core-id': 'int',
>              '*thread-id': 'int'
>    }


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Wq27DwJMUXwS2EflI5Y35Iinne3iTTFsO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw87DAACgkQp6FrSiUn
Q2o23wf+J63aToj7eTauc8bh6pYLsxOTBtkWp8zuBqDPhRic1UbMt6+G/TyCujjG
whBbvkN1YKwb6CrulqVZqex8IJbIqrhe9UxLABsB5vHinv77YIfPQQv6PiprBsVv
yHVFRDyfSP2VhTv4S/F319CLJTDDEZsCdgYL7pQNVnCrem1osMlsvQaN8fjamd10
7EDiOl184Ba4epLZGoOkA1unI0i1J+Yq+eh8qD+Pl2DoWV7VjZ39gFUxYygw1FD1
GjkFXAcBVfwZBPQuWz4SqRrSsPkQ9TkIdZLaoCQ5a4fFaFdhs6D3Hv1aQoA39N8s
jxnv5ry9hGysDtTI3g38tm3Ed3EcTQ==
=WAKY
-----END PGP SIGNATURE-----

--Wq27DwJMUXwS2EflI5Y35Iinne3iTTFsO--

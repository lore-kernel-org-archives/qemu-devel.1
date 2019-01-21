Received: from eggs.gnu.org ([209.51.188.92]:40902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gldD1-0006zf-QS
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gldD0-0004KT-V8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:18:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gldD0-0004Jv-M0
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:18:02 -0500
References: <20190111153451.14304-1-tao3.xu@intel.com>
	<20190111153451.14304-8-tao3.xu@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4c1c8b52-636e-db9f-b4ab-fbebd9e4a88d@redhat.com>
Date: Mon, 21 Jan 2019 11:11:07 -0600
MIME-Version: 1.0
In-Reply-To: <20190111153451.14304-8-tao3.xu@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nBE59dG5REgV2JPTxhLSQqvHXiJn2Huvs"
Subject: Re: [Qemu-devel] [PATCH v2 7/9] hmat acpi: fix some coding style
 and small issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Xu <tao3.xu@intel.com>, mst@redhat.com, imammedo@redhat.com
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, danmei.wei@intel.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nBE59dG5REgV2JPTxhLSQqvHXiJn2Huvs
From: Eric Blake <eblake@redhat.com>
To: Tao Xu <tao3.xu@intel.com>, mst@redhat.com, imammedo@redhat.com
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, danmei.wei@intel.com, rth@twiddle.net
Message-ID: <4c1c8b52-636e-db9f-b4ab-fbebd9e4a88d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/9] hmat acpi: fix some coding style and
 small issues
References: <20190111153451.14304-1-tao3.xu@intel.com>
 <20190111153451.14304-8-tao3.xu@intel.com>
In-Reply-To: <20190111153451.14304-8-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 9:34 AM, Tao Xu wrote:
> Per Igor and Eric's comments, fix some small issues of V1 patch:
>   - update the version number in qapi/misc.json
>   - including the expansion of the acronym HMAT in qapi/misc.json
>   - correct spell mistakes in qapi/misc.json and qemu-options.hx
>   - fix the comment syle in hw/i386/acpi-build.c
>   and hw/acpi/hmat.h
>   - remove some unnecessary head files in hw/acpi/hmat.c
>   - use hardcoded numbers from spec to generate
>   Memory Subsystem Address Range Structure in hw/acpi/hmat.c
>   - drop the struct AcpiHmat and AcpiHmatSpaRange
>   in hw/acpi/hmat.h

These fixes should be rebased into the patches that introduced the
problem, rather than being a followup patch (at least, as long as the
original patches have not been merged into mainline yet).

>=20
> Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---

> +++ b/qapi/misc.json
> @@ -2746,9 +2746,9 @@
>  #
>  # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>  #
> -# @hmat-lb: memory latency and bandwidth information (Since: 2.13)
> +# @hmat-lb: memory latency and bandwidth information (Since: 3.10)

There is no 3.10 release; the next release will be 4.0.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nBE59dG5REgV2JPTxhLSQqvHXiJn2Huvs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxF/SsACgkQp6FrSiUn
Q2oCVgf/VUI3h5pMiDTPxk2N42bTAcEMQYkdZA9XLZb6dQ77kVtw2RDY055P719P
2Qv1KVsmU15AfQEaUJ1WM8cwHktbYALGYlG0j+AhJl5b+EcUUSlR62kM8dyIIlS1
bHCTt4pz/24IyG3MlRA1kVcUICE+nFox/OG/oooxpZrpPcrp4Ow8+gm339QehM8v
2G6fzJ9avZdKZGVJR962HBLh9au2eUeJHfLlyIoavEn0kn7K9xy+y5REsypy0Tq+
R2/fXrYXWDmbvwJAQUYG1iT1LKaJPPo613vXwRrQKwBzOGR3jRGxFDjVv3ZQpugx
TD8wXgSvwu/6yyUiB3TIonDImEsTIg==
=7mrs
-----END PGP SIGNATURE-----

--nBE59dG5REgV2JPTxhLSQqvHXiJn2Huvs--

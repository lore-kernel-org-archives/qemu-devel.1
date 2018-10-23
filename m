Received: from eggs.gnu.org ([2001:4830:134:3::10]:36803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhL-0006fR-HX
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybx-000769-Pp
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:51 -0400
Date: Tue, 23 Oct 2018 16:20:37 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152037.GO12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-19-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E187YRO8KGM40JwS"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-19-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 18/45] memory-device: fix alignment error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>


--E187YRO8KGM40JwS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:55PM -0300, Eduardo Habkost wrote:
> From: David Hildenbrand <david@redhat.com>
>=20
> We're missing "x" after the leading 0.
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20181005092024.14344-2-david@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/memory-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 6de4f70bb4..0b52fe2c5e 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -120,7 +120,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms=
, const uint64_t *hint,
> =20
>      /* address_space_start indicates the maximum alignment we expect */
>      if (QEMU_ALIGN_UP(address_space_start, align) !=3D address_space_sta=
rt) {
> -        error_setg(errp, "the alignment (0%" PRIx64 ") is not supported",
> +        error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported=
",
>                     align);
>          return 0;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E187YRO8KGM40JwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPEUACgkQbDjKyiDZ
s5JKAg/7BowUsdlrXWyLguo/yiLX+4ws0E/Q79YuCbOXR7DVo411UxqUSAeO36EZ
YVSj7qXlLOOriUEYvNbDXfrFaa9uYi8BTYU7BtlWidJCGoZwVLE44U3prqjqx+bc
PIokmY4a1NOny14VCpb0PFKWHY4hkcQzV3QcpY/OeuWFm4tyeCcbe3x20bB9pGdG
6TSHkCJFVNhNQIKPXzaUfgxNAF0kBdxBjwhGX6Qdm/gQqnUDtLEhSLNHjA2pQS01
KTxXRPtTj2Gy+0fIQOBrsjAvL6CLGma1ff8lsQLbUYKQMD1f3cdoGJvB0MfE15ph
fzsLyVp1ZVb2XfIDWnvyer2nZw6E1xBisTwUBXpcBkjAUf1h8/Xudt3zKkN0x4hm
ZcUYSi0Nxl/LADSoQL+Z4KBENZ4H66q3K7Im1tXIGaitL9jkZeH+60Jasxl7rkh2
vdIpWccfNfXJp+4RnDYazh3GlARIrYb5YBdM/Mz9rY8SYvLHDMhPXykuRFSg46O5
cm494T4dCIIAB1TBk99AIehbMmMFNSZycq5ENC/98VntZZsLrVCK2emLi+NtBVow
p5FeYqFsaCqNv+0iAtUSqXjpnq6sHXkn24XShTYrnVQrEd6uUUlbyayaRFjK46Jp
wsgcQD0Ms+GkRui9d+760Uk++wsZgRROZshCIjHXWQWDNzKknqE=
=eZ5n
-----END PGP SIGNATURE-----

--E187YRO8KGM40JwS--

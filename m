Received: from eggs.gnu.org ([209.51.188.92]:60931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkYAE-0004WJ-3E
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkYAD-00058f-8B
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:42:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkYAB-0004sw-57
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:42:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A4BA88306
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:42:26 +0000 (UTC)
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c67886c-2d80-76e3-8826-70c059ecddff@redhat.com>
Date: Fri, 18 Jan 2019 11:42:14 -0600
MIME-Version: 1.0
In-Reply-To: <20190118173103.4903-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k4mc6l3UgnqN3aEkTBRCWiinIB0FHK8fw"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] trace: enforce that every
 trace-events file has a final newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k4mc6l3UgnqN3aEkTBRCWiinIB0FHK8fw
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <7c67886c-2d80-76e3-8826-70c059ecddff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] trace: enforce that every
 trace-events file has a final newline
References: <20190118173103.4903-1-berrange@redhat.com>
 <20190118173103.4903-3-berrange@redhat.com>
In-Reply-To: <20190118173103.4903-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> When generating the trace-events-all file, the build system simply
> concatenates all the individual trace-events files. If any one of those=

> files does not have a final newline, the printf format string will have=

> the contents of the first line of the next file appended to it, which i=
s
> usually a '#' comment.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/gpio/trace-events          | 2 +-
>  scripts/tracetool/__init__.py | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

Does checkpatch and/or patchew flag what are intended to be text files
but which lack a trailing newline?  If not, how hard would it be to get
them to do so?

> diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
> index cb41a89756..5d4dd200c2 100644
> --- a/hw/gpio/trace-events
> +++ b/hw/gpio/trace-events
> @@ -4,4 +4,4 @@
>  nrf51_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " val=
ue 0x%" PRIx64
>  nrf51_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 =
" value 0x%" PRIx64
>  nrf51_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %"=
 PRIi64
> -nrf51_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRI=
i64 " value %" PRIi64
> \ No newline at end of file
> +nrf51_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRI=
i64 " value %" PRIi64
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__=
=2Epy

Fixes the problem file...

> index 0e3c9e146c..3478ac93ab 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -350,6 +350,8 @@ def read_events(fobj, fname):
> =20
>      events =3D []
>      for lineno, line in enumerate(fobj, 1):
> +        if line[-1] !=3D '\n':
> +            raise ValueError("%s does not end with a new line" % fname=
)

and ensures that no future trace-events files will have the problem,
whether or not checkpatch flags other such files.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--k4mc6l3UgnqN3aEkTBRCWiinIB0FHK8fw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxCD/YACgkQp6FrSiUn
Q2pnCQf7BZ5vcsyuf/TYVdNZXLd9tlUS5h3ouYuu+i1aoAB3Jg6PJ1s0AwcDwI8L
xoAG/cgZdFgCn5mnKdyBOgC6USCl/yn1NRujOgepL2uFDtZITbgj2U0gTdSowGHe
J1bQ3S4CRef2dpKFu40cB/doLHzW0vkw5+B7PqLJ6ES5jt1X1Ewc63qU7c6czpCm
qTy4ZHJjLYxpbosHyp33g44KcdTcapDafh3aS6ty37DPSHMd+Aa93Izf3RbXlGmF
//Zmo9QZ8k89fDbL3FcTVUhq/Bj5ZQ7hksoV98KGXrTwyIBuWcku2AZjb5dLOXmh
g5QLW3QQownpDmDHuw598/yC5FwjVg==
=fhgh
-----END PGP SIGNATURE-----

--k4mc6l3UgnqN3aEkTBRCWiinIB0FHK8fw--

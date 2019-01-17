Received: from eggs.gnu.org ([209.51.188.92]:34681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk4lM-0002X9-1m
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk4lL-0005uM-9b
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:19:04 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gk4lL-0005tL-1o
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:19:03 -0500
Received: by mail-wm1-x344.google.com with SMTP id n190so453609wmd.0
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:19:02 -0800 (PST)
Date: Thu, 17 Jan 2019 10:19:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190117101900.GC27840@stefanha-x1.localdomain>
References: <20190117090259.32713-1-sgarzare@redhat.com>
	<20190117090259.32713-6-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20190117090259.32713-6-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/5] optionrom/pvh: load initrd from
 fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 10:02:59AM +0100, Stefano Garzarella wrote:
> If we found initrd through fw_cfg, we can load it and use the
> first module of hvm_start_info to pass initrd address and size
> to the kernel.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  pc-bios/optionrom/pvh_main.c |  21 +++++++++++++++++++--
>  pc-bios/pvh.bin              | Bin 1536 -> 1536 bytes
>  2 files changed, 19 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQFaUAAoJEJykq7OBq3PIiyQIALsM03LSeOYK0nLmsJIiII/9
/tHhYMcw0pwKeqCKlVRha2lmsQPpF6rOqXL7yFchJdp+/G0shOxEUu7il3Ry/94a
AmLTsGdOj3kLevaIz84pAin3qXxhlVTBsZjia8CLURFdNuOVhFXohZ2KclHQ2H4V
UJ4OV5cSTgk04kzdB1DVLkTAmo4tqJpLCdY7WnEhaYq3SLxALr5P7isTaW0wMJrc
KlPhguxPeIRbK3K2T/Z82MCKbZyPjRI+canlnDVIoRvj3wuuMK7gDAgz6xwhAfjg
rg4oxB6uvWLc0aqn3tqxcAzuSQ6Qp3T2CtGLIfsH/H9XBLvrhqxnnhB3OTVDgIY=
=pnTW
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

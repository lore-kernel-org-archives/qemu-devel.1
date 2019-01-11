Received: from eggs.gnu.org ([209.51.188.92]:53598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghziw-0008EW-RP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghziw-0003N3-2k
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:31:58 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghziv-0003Mo-Sd
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:31:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id g67so2963035wmd.2
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 08:31:57 -0800 (PST)
Date: Fri, 11 Jan 2019 16:31:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190111163155.GD14776@stefanha-x1.localdomain>
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-4-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <20190111131836.107549-4-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] optionrom: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Maran Wilson <maran.wilson@oracle.com>, Richard Henderson <rth@twiddle.net>


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 02:18:35PM +0100, Stefano Garzarella wrote:
> The new pvh.bin option rom can be used with SeaBIOS to boot
> uncompressed kernel using the x86/HVM direct boot ABI.
>=20
> pvh.S contains the entry point of the option rom. It runs
> in real mode, loads the e820 table querying the BIOS, and
> then it switches to 32bit protect mode and jump to the
> pvh_load_kernel() written in pvh_main.c.
> pvh_load_kernel() loads the cmdline and kernel entry_point
> using fw_cfg, then it looks for RSDP, fills the
> hvm_start_info required by x86/HVM ABI, and finally jumps
> to the kernel entry_point.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  pc-bios/optionrom/Makefile   |   5 +-
>  pc-bios/optionrom/pvh.S      | 200 +++++++++++++++++++++++++++++++++++
>  pc-bios/optionrom/pvh_main.c | 117 ++++++++++++++++++++
>  3 files changed, 321 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/optionrom/pvh.S
>  create mode 100644 pc-bios/optionrom/pvh_main.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcOMT7AAoJEJykq7OBq3PIwmwH/16kjRZReY2VZdyJ/p/yAMch
19aH409caGfyiwEhxLmrQcbXM1NcleOVc6AjmHqWBK8H5VLfqfcT+e+O/D9PYG3w
rptzz6Hc/QCjIVwBGiMCqwWe7J6aMlyEFdqcUBZByRAblj6j5k83qVWsapTcdPpp
gy5Li0PQEBHT5/vPPCQ5sN86ZShTHYSHtrqMNVp04jN3tZKlaPtABMtZLhleF3JD
MQ6bJ/d4OQUdGAI4btFfsBzyi3lbC5hiMheJYpy3VrSnMC7RGsICLgvaN9dLoABa
y1t+MbZezss6WozPeyijoSuz30tgn/e5Z7albLanPDB88FHwYSDuC13SGh7/BJg=
=H03Z
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--

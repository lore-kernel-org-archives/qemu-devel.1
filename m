Received: from eggs.gnu.org ([2001:4830:134:3::10]:42937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1foA6s-0002CC-1a
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1foA6n-0005os-Hk
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:17:54 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:44919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1foA6n-0005oB-8t
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:17:49 -0400
Received: by mail-ua1-x944.google.com with SMTP id k25-v6so2435590uao.11
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 09:17:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1533574847-19294-58-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <94f5f57e-1b5e-fb65-affe-c2bfbc0f41e0@amsat.org>
Date: Fri, 10 Aug 2018 13:17:40 -0300
MIME-Version: 1.0
In-Reply-To: <1533574847-19294-58-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="3YHKLgrz2dZAE8LlylOaTpT1jWMFDqEc4"
Subject: Re: [Qemu-devel] [PATCH v7 57/80] mips_malta: Setup GT64120 BARs in
 nanoMIPS bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, aurelien@aurel32.net
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3YHKLgrz2dZAE8LlylOaTpT1jWMFDqEc4
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, aurelien@aurel32.net
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, laurent@vivier.eu,
 riku.voipio@iki.fi, richard.henderson@linaro.org, amarkovic@wavecomp.com,
 smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com,
 arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com
Message-ID: <94f5f57e-1b5e-fb65-affe-c2bfbc0f41e0@amsat.org>
Subject: Re: [PATCH v7 57/80] mips_malta: Setup GT64120 BARs in nanoMIPS
 bootloader
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1533574847-19294-58-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-58-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Aleksandar,

On 08/06/2018 02:00 PM, Aleksandar Markovic wrote:
> From: Paul Burton <pburton@wavecomp.com>
>=20
> Setup the GT64120 BARs in the nanoMIPS bootloader, in the same way that=

> they are setup in the MIPS32 bootloader. This is necessary for Linux to=

> be able to access peripherals, including the UART.
>=20
> Signed-off-by: Paul Burton <pburton@wavecomp.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/mips/mips_malta.c | 73 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 73 insertions(+)
>=20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 4bc9036..d1a7c1f 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -664,6 +664,79 @@ static void write_bootloader_nanomips(uint8_t *bas=
e, int64_t run_addr,
>                                  /* lui a3,%hi(loaderparams.ram_low_siz=
e) */
>      stw_p(p++, 0x80e7); stw_p(p++, NM_LO(loaderparams.ram_low_size));
>                                  /* ori a3,a3,%lo(loaderparams.ram_low_=
size) */
> +
> +    /* Load BAR registers as done by YAMON */
> +    stw_p(p++, 0xe040); stw_p(p++, 0x0681);
> +                                /* lui t1, %hi(0xb4000000) */

you access the GT64120 via kseg2 having default ISD =3D 0x14000000.

> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0be1);
> +                                /* lui t0, %hi(0xdf000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x00df);
> +                                /* addiu[32] t0, $0, 0xdf */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9068);
> +                                /* sw t0, 0x68(t1) */

looking at hw/mips/gt64xxx_pci.c, 0x68 is GT_ISD, that will remap the
registers to 0xdf << 21 =3D 0x1be00000.

--

> +
> +    stw_p(p++, 0xe040); stw_p(p++, 0x077d);
> +                                /* lui t1, %hi(0xbbe00000) */

you now use kseg2 remapped address 0x1be00000.

> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0801);
> +                                /* lui t0, %hi(0xc0000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x00c0);
> +                                /* addiu[32] t0, $0, 0xc0 */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9048);
> +                                /* sw t0, 0x48(t1) */

0x48 is GT_PCI0IOLD, so the new I/O low address is 0xc0 << 21 =3D 0x18000=
000,

> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0800);
> +                                /* lui t0, %hi(0x40000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x0040);
> +                                /* addiu[32] t0, $0, 0x40 */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9050);
> +                                /* sw t0, 0x50(t1) */

0x50 is GT_PCI0IOHD, new I/O high address is (0x40 + 1) << 21 =3D
0x08200000, so the region size is 0x00200000 =3D 2 MiB.

So this setup PCI0 I/O bar from 0x18000000 to 0x181fffff.

--

> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0001);
> +                                /* lui t0, %hi(0x80000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x0080);
> +                                /* addiu[32] t0, $0, 0x80 */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9058);
> +                                /* sw t0, 0x58(t1) */
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x07e0);
> +                                /* lui t0, %hi(0x3f000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x003f);
> +                                /* addiu[32] t0, $0, 0x3f */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9060);
> +                                /* sw t0, 0x60(t1) */

0x58 is GT_PCI0M0LD,
0x60 is GT_PCI0M0HD,
0x80 << 21 =3D 0x10000000,
(0x3f + 1) << 21 =3D 0x8000000,

so you setup PCI0 MEM0 at 0x10000000, size 0x8000000

> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0821);
> +                                /* lui t0, %hi(0xc1000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x00c1);
> +                                /* addiu[32] t0, $0, 0xc1 */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9080);
> +                                /* sw t0, 0x80(t1) */
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0bc0);
> +                                /* lui t0, %hi(0x5e000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x005e);
> +                                /* addiu[32] t0, $0, 0x5e */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9088);
> +                                /* sw t0, 0x88(t1) */

similarly GT_PCI0M1LD & GT_PCI0M1HD,
0xc1 << 21 =3D 0x18200000
(0x5e + 1) << 21 =3D 0xbe00000,

so you setup PCI0 MEM1 at 0x18200000, size 0xbe00000.

--

Can you add comments about all this? That would ease to understand what
this code is doing, and avoid the next person to redo what I just did.

Now that we have cross-tools Docker images available, we could add the
=2ES in the repository and commit the hexblob.

--

A bigger ifdef would be easier to read, such:

#ifdef TARGET_WORDS_BIGENDIAN
    a
    b
    c
    d
#else
    e
    f
    g
    h
#endif

> +
>      stw_p(p++, 0xe320 | NM_HI1(kernel_entry));
>      stw_p(p++, NM_HI2(kernel_entry));
>                                  /* lui t9,%hi(kernel_entry) */
>=20

With review addressed:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Regards,

Phil.


--3YHKLgrz2dZAE8LlylOaTpT1jWMFDqEc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlttuqUACgkQ4+MsLN6t
wN6ivA/9HHbYnOH0R6e5UwIa0EnC/Jc6nTjUHuZX840b16A2vqFJlZCKiuuRwa5X
zdLV4RZ6m27t8VzJ7dcPAkNJOOgQ74eE116Ocbe9OTMhKkr0c8sqaslN6erwqiIS
hTFjw5JfBMCvbkwtQSdDP5J1jW5XmEGzI8YkeSFzBBQ+AIFe7+v9YFDbyt7lLhPN
Qak7/5I022Y6gxj0jsDXneh3gUcZqw3NWo29lN0pqo3jkC6bURCTARRwdPQ5aJm7
0zdTUfNJTKYR/DYU4nHmbPakRpY4YDps4YOh+XB60y0JLMSSK5CSKa4CiOKeTwOE
dNCwVklfMZJ8iWbTBbJA4OAr0i1rFqEvwQvIu5w00kuVuSzppCleClGUWXGFTZk5
BRxpJg0Hg59vzqq8wgvOfrUlCRgmoNwTA1meQ64MTPc8ues6zUw2LXOKnbX/AXhL
Zl/dd8kiZLGcNPNwZDzUs6LziPc/d0dUPN7EaSqClx0/IHCm1jBdqJB8jEgS1e4b
L9TE7Y7qg5NX37Oq5bZ1ZDiC31Bn5WYgZ5cVWk2iRXKVwM1BPe0hbrvVvGstjx1i
EeYA0SPiE2HWEhDCj6h2M5Tcn5qhQxzAHdWtN2gdbtyPg89dENYzjKWPVS/YNaH4
xHzJepPLnFpTV6NX21fRpA+OoVxna8JAggB5kmsXxlN9Db91E+o=
=hknE
-----END PGP SIGNATURE-----

--3YHKLgrz2dZAE8LlylOaTpT1jWMFDqEc4--

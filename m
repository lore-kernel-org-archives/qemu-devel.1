Received: from eggs.gnu.org ([2001:4830:134:3::10]:47201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmjuH-00032E-N3
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmjuD-00057o-CP
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:07:01 -0400
Received: from mail-bl2nam02on0128.outbound.protection.outlook.com
	([104.47.38.128]:46352
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fmjuD-00057S-2M
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:06:57 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 6 Aug 2018 18:06:52 +0000
Message-ID: <BN7PR08MB4868BC15964A8413DAB1EC1FC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1533574847-19294-54-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-54-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 53/80] elf: Add nanoMIPS specific
 variations in ELF header fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>


> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 6, 2018 7:00 PM
> Subject: [PATCH v7 53/80] elf: Add nanoMIPS specific variations in ELF he=
ader fields
>=20
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Add nanoMIPS-related values in ELF header fields as specified in
> nanoMIPS' "ELF ABI Supplement".
>=20
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  include/elf.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>=20
> diff --git a/include/elf.h b/include/elf.h
> index 002a002..3f74fba 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -62,6 +62,24 @@ typedef int64_t  Elf64_Sxword;
>  #define EF_MIPS_FP64      0x00000200
>  #define EF_MIPS_NAN2008   0x00000400
>=20
> +/* nanoMIPS architecture bits, EF_NANOMIPS_ARCH */
> +#define EF_NANOMIPS_ARCH_32R6 0x00000000  /* 32-bit nanoMIPS Release 6 I=
SA   */
> +#define EF_NANOMIPS_ARCH_64R6 0x10000000  /* 62-bit nanoMIPS Release 6 I=
SA   */
> +
> +/* nanoMIPS ABI bits, EF_NANOMIPS_ABI */
> +#define EF_NANOMIPS_ABI_P32   0x00001000  /* 32-bit nanoMIPS ABI        =
     */
> +#define EF_NANOMIPS_ABI_P64   0x00002000  /* 64-bit nanoMIPS ABI        =
     */
> +
> +/* nanoMIPS processor specific flags, e_flags */
> +#define EF_NANOMIPS_LINKRELAX 0x00000001  /* Link-time relaxation       =
     */
> +#define EF_NANOMIPS_PIC       0x00000002  /* Position independant code  =
     */
> +#define EF_NANOMIPS_32BITMODE 0x00000004  /* 32-bit object for 64-bit ar=
ch.  */
> +#define EF_NANOMIPS_PID       0x00000008  /* Position independant data  =
     */
> +#define EF_NANOMIPS_PCREL     0x00000010  /* PC-relative mode           =
     */
> +#define EF_NANOMIPS_ABI       0x0000f000  /* nanoMIPS ABI               =
     */
> +#define EF_NANOMIPS_MACH      0x00ff0000  /* Machine variant            =
     */
> +#define EF_NANOMIPS_ARCH      0xf0000000  /* nanoMIPS architecture      =
     */
> +
>  /* MIPS machine variant */
>  #define EF_MIPS_MACH_NONE     0x00000000  /* A standard MIPS implementat=
ion  */
>  #define EF_MIPS_MACH_3900     0x00810000  /* Toshiba R3900              =
     */
> @@ -143,6 +161,8 @@ typedef int64_t  Elf64_Sxword;
>=20
>  #define EM_RISCV        243     /* RISC-V */
>=20
> +#define EM_NANOMIPS     249     /* Wave Computing nanoMIPS */
> +
>  /*
>   * This is an interim value that we will use until the committee comes
>   * up with a final number.
> --
> 2.7.4

Received: from eggs.gnu.org ([209.51.188.92]:60612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBgVv-0004M3-5g
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBgVt-0008KQ-T5
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:05:15 -0400
Received: from mail-eopbgr780130.outbound.protection.outlook.com
	([40.107.78.130]:38317
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBgVt-0008Gd-84
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:05:13 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 3 Apr 2019 14:05:08 +0000
Message-ID: <BN6PR2201MB1251BABEFBF5A4A1357C35C4C6570@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190403125055.26564-1-jbi.octave@gmail.com>,
	<20190403125055.26564-2-jbi.octave@gmail.com>
In-Reply-To: <20190403125055.26564-2-jbi.octave@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/5] target/mips: add space to fix
 checkpatch errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Jules Irenge <jbi.octave@gmail.com>
> Subject: [PATCH 1/5] target/mips: add space to fix checkpatch errors
>=20
> Add space to fix errors reported by checkpatch.pl tool
> "ERROR: spaces required around that ..."
> "ERROR: space required before the open parenthesis"
> "ERROR: space required after that ..."
>=20
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  target/mips/cpu.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20

Hello, Jules.

I appreciate this and all other patches in the series.

It looks that here you have additional types of errors
in the same code lines that you change in this patch
("line over 90 characters"), and this causes the script
checkpatch.pl to report errors for this very patch,
which is not allowed.

I think your best option is to blend (squash) existing
patches 1 and 5 onto a single patch.

> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index a10eeb0de3..2429fe80ac 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -22,10 +22,10 @@ typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
>=20
>  typedef union wr_t wr_t;
>  union wr_t {
> -    int8_t  b[MSA_WRLEN/8];
> -    int16_t h[MSA_WRLEN/16];
> -    int32_t w[MSA_WRLEN/32];
> -    int64_t d[MSA_WRLEN/64];
> +    int8_t  b[MSA_WRLEN / 8];
> +    int16_t h[MSA_WRLEN / 16];
> +    int32_t w[MSA_WRLEN / 32];
> +    int64_t d[MSA_WRLEN / 64];
>  };
>=20
>  typedef union fpr_t fpr_t;
> @@ -71,16 +71,16 @@ struct CPUMIPSFPUContext {
>  #define FCR31_FS 24
>  #define FCR31_ABS2008 19
>  #define FCR31_NAN2008 18
> -#define SET_FP_COND(num,env)     do { ((env).fcr31) |=3D ((num) ? (1 << =
((num) + 24)) : (1 << 23)); } while(0)
> -#define CLEAR_FP_COND(num,env)   do { ((env).fcr31) &=3D ~((num) ? (1 <<=
 ((num) + 24)) : (1 << 23)); } while(0)
> +#define SET_FP_COND(num, env)    do { ((env).fcr31) |=3D ((num) ? (1 << =
((num) + 24)) : (1 << 23)); } while (0)
> +#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &=3D ~((num) ? (1 <=
< ((num) + 24)) : (1 << 23)); } while (0)

There is a misalignment here for the last two lines, after
this patch is applied ("do" is misaligned). That should be
corrected.

Thanks a lot!
Aleksandar

>  #define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) | (((env)=
.fcr31 >> 23) & 0x1))
>  #define GET_FP_CAUSE(reg)        (((reg) >> 12) & 0x3f)
>  #define GET_FP_ENABLE(reg)       (((reg) >>  7) & 0x1f)
>  #define GET_FP_FLAGS(reg)        (((reg) >>  2) & 0x1f)
> -#define SET_FP_CAUSE(reg,v)      do { (reg) =3D ((reg) & ~(0x3f << 12)) =
| ((v & 0x3f) << 12); } while(0)
> -#define SET_FP_ENABLE(reg,v)     do { (reg) =3D ((reg) & ~(0x1f <<  7)) =
| ((v & 0x1f) << 7); } while(0)
> -#define SET_FP_FLAGS(reg,v)      do { (reg) =3D ((reg) & ~(0x1f <<  2)) =
| ((v & 0x1f) << 2); } while(0)
> -#define UPDATE_FP_FLAGS(reg,v)   do { (reg) |=3D ((v & 0x1f) << 2); } wh=
ile(0)
> +#define SET_FP_CAUSE(reg, v)      do { (reg) =3D ((reg) & ~(0x3f << 12))=
 | ((v & 0x3f) << 12); } while (0)
> +#define SET_FP_ENABLE(reg, v)     do { (reg) =3D ((reg) & ~(0x1f <<  7))=
 | ((v & 0x1f) << 7); } while (0)
> +#define SET_FP_FLAGS(reg, v)      do { (reg) =3D ((reg) & ~(0x1f <<  2))=
 | ((v & 0x1f) << 2); } while (0)
> +#define UPDATE_FP_FLAGS(reg, v)   do { (reg) |=3D ((v & 0x1f) << 2); } w=
hile (0)
>  #define FP_INEXACT        1
>  #define FP_UNDERFLOW      2
>  #define FP_OVERFLOW       4
> --
> 2.20.1

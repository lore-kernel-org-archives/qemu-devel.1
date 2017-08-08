Received: from eggs.gnu.org ([2001:4830:134:3::10]:37019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1df4rz-0004WN-3l
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1df4rt-0004hl-Ol
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:48:27 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:34076)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1df4rt-0004ge-HD
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:48:21 -0400
References: <20170808121544.12850-1-f4bug@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <6748c2a6-8798-e35c-d501-f76425bcfd19@imgtec.com>
Date: Tue, 8 Aug 2017 14:48:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170808121544.12850-1-f4bug@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10] target/mips: remove MIPS16 ASE
 from 4Km
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>



On 08/08/2017 13:15, Philippe Mathieu-Daud=C3=A9 wrote:
> MIPS32 4Km does not support the MIPS16 instruction set, see:
>     MIPS32 4K Processor Core Family Software UM (MD00016 Rev 01.18)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> probably incorrect copy/paste from 8d162c2b68db72623a507069fda0e35ccd1c=
6b85
>=20
>  target/mips/translate_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/mips/translate_init.c b/target/mips/translate_init.=
c
> index 255d25bacd..7297c8c000 100644
> --- a/target/mips/translate_init.c
> +++ b/target/mips/translate_init.c
> @@ -149,7 +149,7 @@ static const mips_def_t mips_defs[] =3D
>          .CP0_Status_rw_bitmask =3D 0x1258FF17,
>          .SEGBITS =3D 32,
>          .PABITS =3D 32,
> -        .insn_flags =3D CPU_MIPS32 | ASE_MIPS16,
> +        .insn_flags =3D CPU_MIPS32,
>          .mmu_type =3D MMU_TYPE_FMT,
>      },
>      {
>=20

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>

Regards,
Yongbok

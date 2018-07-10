Received: from eggs.gnu.org ([2001:4830:134:3::10]:56150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxDI-0005iW-Lc
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxDE-0007HT-Ki
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:18:12 -0400
Received: from mail-dm3nam03on0721.outbound.protection.outlook.com
	([2a01:111:f400:fe49::721]:47106
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcxDE-0007HI-Cq
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:18:08 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 18:18:05 +0000
Message-ID: <BN7PR08MB4868296317B48096E10FB6D8C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-23-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-23-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 22/33] target/mips: Adjust behavior of
 Config3's ISAOnExc bit for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 22/33] target/mips: Adjust behavior of Config3's ISAOn=
Exc bit for nanoMIPS
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Config3.ISAOnExc is read only in nanoMIPS.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/op_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index cb83b6d..5e10286 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1730,7 +1730,8 @@ void helper_mtc0_config2(CPUMIPSState *env, target_=
ulong arg1)
>
>  void helper_mtc0_config3(CPUMIPSState *env, target_ulong arg1)
>  {
> -    if (env->insn_flags & ASE_MICROMIPS) {
> +    if ((env->insn_flags & ASE_MICROMIPS) &&
> +        !(env->insn_flags & ISA_NANOMIPS32)) {
>          env->CP0_Config3 =3D (env->CP0_Config3 & ~(1 << CP0C3_ISA_ON_EXC=
)) |
>                             (arg1 & (1 << CP0C3_ISA_ON_EXC));
>      }
> --
> 2.7.4
>

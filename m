Received: from eggs.gnu.org ([2001:4830:134:3::10]:34437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcs2N-0007Fz-0X
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcs2J-0005Gm-PY
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:46:35 -0400
Received: from mail-by2nam05on070f.outbound.protection.outlook.com
	([2a01:111:f400:fe52::70f]:50504
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcs2J-0005GY-Ex
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:46:31 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 12:46:09 +0000
Message-ID: <BN7PR08MB4868ADCB86BF4822BCE4CCB3C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/33] target/mips: Add emulation of
 nanoMIPS 16-bit load and store instructions
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

> Subject: [PATCH v2 03/33] target/mips: Add emulation of nanoMIPS 16-bit l=
oad and store > instructions
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Add emulation of LWXS16, LB16, SB16, LBU16, LH16, SH16, LHU16, LW16, LWSP=
16,
> LW4X4, SW4X4, LWGP16, SWSP16, SW16, and SWGP16 instructions.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 114 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 114 insertions(+)
>

The mixture of using extract32(), NANOMIPS_EXTRACT_XXX(), and mask/shift fo=
r decoding opcodes and registers should be streamlined, as also Richard sug=
gested in a comment for another patch.

However, this can be fixed later, after the first integration in the upstre=
am, if the risk of regressions is too high for this stage od development of=
 nanoMIPS support.

With all these caveats, still:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

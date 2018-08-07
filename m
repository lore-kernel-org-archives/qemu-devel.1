Received: from eggs.gnu.org ([2001:4830:134:3::10]:45798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fn1Xi-000521-DA
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fn1Xd-0003Jh-Hq
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:56:54 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com
	([104.47.42.107]:44120
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fn1Xc-0003JD-S3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:56:49 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 7 Aug 2018 12:56:45 +0000
Message-ID: <BN7PR08MB4868929484AAA8CAD2D665CBC6270@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1533574847-19294-24-git-send-email-aleksandar.markovic@rt-rk.com>,
	<BN7PR08MB4868CF1F900F491D44B2C15BC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868CF1F900F491D44B2C15BC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 23/80] target/mips: Add emulation of
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>


> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 6, 2018 6:59 PM
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
>  target/mips/translate.c | 81 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 81 insertions(+)
>

It was brought to my attention that this patch doesn't contain fix for emul=
ation of several instruction that was developed, but not included in this s=
eries. (Those are cases flagged by Richarsd in one of previous reviews.) Pl=
ease include all fixes in the next version.

Aleksandar M.=

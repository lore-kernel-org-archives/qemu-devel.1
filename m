Received: from eggs.gnu.org ([2001:4830:134:3::10]:55069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fzf5t-0001Ma-Vg
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fzf3W-0002vx-2n
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:34:01 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com
	([40.107.68.131]:4544
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fzf3V-0002vM-QQ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:33:58 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 11 Sep 2018 09:33:54 +0000
Message-ID: <BN7PR08MB4868831CF81522919CC4EEC3C6040@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180909013444.18936-1-f4bug@amsat.org>,
	<20180909013444.18936-2-f4bug@amsat.org>
In-Reply-To: <20180909013444.18936-2-f4bug@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Increase the 'supported
 instructions' flags holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Fredrik Noring <noring@nocrew.org>, Richard Henderson <rth@twiddle.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on beha=
lf of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Sent: Sunday, September 9, 2018 3:34 AM
>
> Subject: [PATCH 1/2] target/mips: Increase the 'supported instructions' f=
lags holder size
>
> Currently this holder is limited to at most 32 flags on
> a 32-bit architecture, which lets an unique bit available
> for another 'chip specific instructions' flag.
>=20
> Relax this limit using a 64-bit integer.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> target/mips/cpu.h       | 2 +-
> target/mips/internal.h  | 2 +-
> target/mips/translate.c | 4 ++--
> 3 files changed, 4 insertions(+), 4 deletions(-)

"int insn_flags;" in DisasContext definition in target/mips/translate.c nee=
ds to be updated as well.

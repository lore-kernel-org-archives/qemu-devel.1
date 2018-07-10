Received: from eggs.gnu.org ([2001:4830:134:3::10]:33213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcrxC-0005s6-O1
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcrx9-0003FO-Ex
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:41:14 -0400
Received: from mail-co1nam05on0711.outbound.protection.outlook.com
	([2a01:111:f400:fe50::711]:14992
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcrx9-0003En-2L
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:41:11 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 12:41:06 +0000
Message-ID: <BN7PR08MB48686E50139EFF1AC4E320C2C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/33] target/mips: Add
 decode_nanomips_opc() function
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

Subject: [PATCH v2 02/33] target/mips: Add decode_nanomips_opc() function

From: Yongbok Kim <yongbok.kim@mips.com>

Add body and invocation of decode_nanomips_opc() if bit
ISA_NANOMIPS32 is set in env->insn_flags.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 313 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 311 insertions(+), 2 deletions(-)

Decoding utilities should be in a separate patch (or two patches).

The code of the segment that contains decode_nanomips_opc() invocation shou=
ld also be in a separate patch, leaving this patch as defining the body of =
decode_nanomips_opc().

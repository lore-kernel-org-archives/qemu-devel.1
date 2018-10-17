Received: from eggs.gnu.org ([2001:4830:134:3::10]:39208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCkki-0000OH-GT
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCkkb-0003rv-Jn
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:16:39 -0400
Received: from mail-sn1nam02on0108.outbound.protection.outlook.com
	([104.47.36.108]:50096
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gCkkX-0003fR-7T
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:16:31 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 17 Oct 2018 12:16:22 +0000
Message-ID: <BN6PR2201MB1251BC3478B3503E7A251E05C6FF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20180930214744.27580-1-f4bug@amsat.org>,
	<20180930214744.27580-2-f4bug@amsat.org>
In-Reply-To: <20180930214744.27580-2-f4bug@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/4] target/mips: Increase the
 'supported instructions' flags holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on beha=
lf of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Subject: [PATCH v3 1/4] target/mips: Increase the 'supported instructions=
' flags holder size
>
> Currently this holder is limited to at most 32 flags on
a 32-bit architecture, which lets an unique bit available
for another 'chip specific instructions' flag.
>
>Relax this limit using a 64-bit integer.
>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---

This patch doesn't apply to the main tree, but I will fixed that while inte=
grating MIPS queue.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

This patch will be included in the next MIPS queue with minor modifications=
.=

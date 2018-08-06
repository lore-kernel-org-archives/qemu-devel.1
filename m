Received: from eggs.gnu.org ([2001:4830:134:3::10]:36688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmkmZ-0004CC-3s
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmkmW-00079L-1G
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:03:07 -0400
Received: from mail-cys01nam02on070a.outbound.protection.outlook.com
	([2a01:111:f400:fe45::70a]:48848
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fmkmV-00079D-NN
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:03:03 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 6 Aug 2018 19:02:59 +0000
Message-ID: <BN7PR08MB4868295C24556E53FAE5650BC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1533574847-19294-46-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-46-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 45/80] disas: Add support for microMIPS
 and nanoMIPS
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
>=20
> From: Matthew Fortune <matthew.fortune@mips.com>
>=20
> Modify disassembler engine to execute a separate disassembler
> for microMIPS and nanoMIPS platforms.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  disas/Makefile.objs |     1 +
>  disas/mips.c        |   358 +-
>  disas/nanomips.cpp  | 15752 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  disas/nanomips.h    |  1208 ++++
>  include/disas/bfd.h |     1 +
>  target/mips/cpu.c   |    12 +-
>  6 files changed, 17329 insertions(+), 3 deletions(-)
>  create mode 100644 disas/nanomips.cpp
>  create mode 100644 disas/nanomips.h

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

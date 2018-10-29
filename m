Received: from eggs.gnu.org ([2001:4830:134:3::10]:54057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gH8vB-0007zc-P7
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gH8v2-0003LV-1G
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:53:33 -0400
Received: from mail-cys01nam02on0700.outbound.protection.outlook.com
	([2a01:111:f400:fe45::700]:51569
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gH8v1-0003Ka-Ma
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:53:27 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 29 Oct 2018 14:53:18 +0000
Message-ID: <BN6PR2201MB1251DB91FBD5E2C3FF3F3A67C6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540821315-28346-1-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540821315-28346-1-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/6] target/mips: Add support for
 prctl() PR_GET_FP_MODE and PR_SET_FP_MODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>

> From: Stefan Markovic <stefan.markovic@rt-rk.com>
> Subject: [PATCH v2 0/6] target/mips: Add support for prctl() PR_GET_FP_MO=
DE and PR_SET_FP_MODE
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> This series includes support for prctl() PR_GET_FP_MODE and PR_SET_FP_MOD=
E. This requires
> extracting MIPS.abiflags section from ELF file and fp_abi value handling.

Stefan, the patch titles don't have appropriate prefixes "elf:" and "user-m=
ode:", but I can fix that while integrating.

Laurent, heads up: I plan to include this series in a MIPS pull request tha=
t is planned for today.

Thanks,
Aleksandar=

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG2fD-0007tc-3r
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG2f9-0001LF-Sz
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:00:35 -0400
Received: from mail-dm3nam05on0700.outbound.protection.outlook.com
	([2a01:111:f400:fe51::700]:13024
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gG2f9-0001Kr-LM
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:00:31 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 14:00:26 +0000
Message-ID: <BN6PR2201MB1251E37E85DA42FB5A6E2157C6F00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1540487815.git.noring@nocrew.org>,
	<658cb95479c9b6debebe43ec06ff498ebf624653.1540487815.git.noring@nocrew.org>
In-Reply-To: <658cb95479c9b6debebe43ec06ff498ebf624653.1540487815.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 01/11] target/mips: Rename ASE_MMI to
 ASE_TOSHIBA_MMI, with Toshiba namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Petar Jovanovic <pjovanovic@wavecomp.com>

> From: Fredrik Noring <noring@nocrew.org>
> Subject: [PATCH 01/11] target/mips: Rename ASE_MMI to ASE_TOSHIBA_MMI, wi=
th Toshiba namespace
>=20
> Several vendors have multimedia instruction (MMI) sets and other
> extensions of various kinds. ASE vendor namespaces make it clear these
> are not generic architectural features and also avoid name clashes.

ASE_XXX flags are not meant to identify a CPU or vendor. They are not wired=
 to any configuration bit or CPU model. They are purely QEMU internal const=
ructs, whose purpose was to make internal QEMU MIPS-specific code organizat=
ion easier. In this case, ASE_MMI is an umbrella for all MMI-like ASEs, int=
roduced with intent to make encapsulation of MMI-specific code better and e=
asier. Differences between CPUs should be resolved by other means. Name 'AS=
E_MMI' is fine.

Thanks,
Aleksandar=

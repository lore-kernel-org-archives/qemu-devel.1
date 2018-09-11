Received: from eggs.gnu.org ([2001:4830:134:3::10]:58502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fzfFh-0001Aa-Pl
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fzfFc-0001uM-Pe
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:46:33 -0400
Received: from mail-sn1nam02on0114.outbound.protection.outlook.com
	([104.47.36.114]:6212
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fzfFc-0001tW-I9
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:46:28 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 11 Sep 2018 09:46:20 +0000
Message-ID: <BN7PR08MB48683CDC7E04D4696EB66AA0C6040@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180707194137.GB14409@localhost.localdomain>
	<alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
	<20180801133922.GC2371@localhost.localdomain>
	<c4b04967-c6fa-eea6-4c6e-7001c48344ba@linaro.org>
	<20180907191619.GA11275@r52>
	<DM6PR08MB4875E5EDA598B98379D09C57C6070@DM6PR08MB4875.namprd08.prod.outlook.com>,
	<20180908142741.GA11984@r52>
In-Reply-To: <20180908142741.GA11984@r52>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] target/mips: Support R5900 GCC programs
 in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, "Maciej W. Rozycki" <macro@linux-mips.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> > - organize the changes in the form of patch series
>=20
> What kind of granularity do you have in mind? The patch is quite small wi=
th
> 79 insertions and 1 deletion in total.

For patch organization, you may find these links useful:

https://wiki.qemu.org/Contribute/SubmitAPatch

and=20

https://wiki.openstack.org/wiki/GitCommitMessages

Patch size is not the best criterium while organizing patches.

One good organization of your changes would be:

Patch 1: Add preprocessor constants INSN_R5900 and CPU_R5900
Patch 2: Amend OPC_MULT/OPC_MULTU handling for R5900
Patch 3: Update cpu_get_model() for R5900 case
Patch 4: Add defintion of R5900 CPU

This will allow us to discuss individual changes separately.

Thanks,
Aleksandar=

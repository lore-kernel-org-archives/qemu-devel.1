Received: from eggs.gnu.org ([209.51.188.92]:44384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gjl8m-0004HV-1w
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gjl8k-0001uh-UT
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:21:55 -0500
Received: from mail-eopbgr770129.outbound.protection.outlook.com
	([40.107.77.129]:65464
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1gjl8k-0001lP-J4
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:21:54 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Wed, 16 Jan 2019 13:21:35 +0000
Message-ID: <DM5PR22MB165810CC5E11B5361EE94764D2820@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1547643949-10776-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547643949-10776-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] target/mips: Amend CP0 (add
 MemoryMapID, add macros, renaming)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, January 16, 2019 2:05 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo; aurelien@aurel32.net
> Subject: [PATCH 0/3] target/mips: Amend CP0 (add MemoryMapID, add macros,=
 renaming)
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add MemoryMapId register and add preprocessor constants for
> fmajority of CP0 subregisters, and rename few variables.
>
> Aleksandar Markovic (3):
>   target/mips: Add preprocessor constants for CP0 subregisters
>   target/mips: Add CP0 register MemoryMapID
>   target/mips: Rename 'rn' to 'register_name'
>
>  target/mips/cpu.h       | 115 +++++++
>  target/mips/machine.c   |   5 +-
>  target/mips/translate.c | 858 ++++++++++++++++++++++++------------------=
------
>  3 files changed, 550 insertions(+), 428 deletions(-)
>
> --
> 2.7.4


Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


Except PATCH 1/3 where CPO should be CP0 (zero instead O) in all defines.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuH6W-0003Zp-Er
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuGpz-0002aP-QU
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:41:47 -0400
Received: from mail-dm3nam05on0716.outbound.protection.outlook.com
	([2a01:111:f400:fe51::716]:12352
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fuGpz-0002Zm-Im
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:41:43 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 27 Aug 2018 12:41:39 +0000
Message-ID: <BN7PR08MB4868E9E3097EF45063736C01C60B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <cover.1535133088.git.jancraig@amazon.com>,
	<261dd8062c85c2a5eefb4d6effa2a44d5fc953f7.1535133089.git.jancraig@amazon.com>
In-Reply-To: <261dd8062c85c2a5eefb4d6effa2a44d5fc953f7.1535133089.git.jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/7] target/mips: Add MXU register support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, Petar Jovanovic <pjovanovic@wavecomp.com>

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Friday, August 24, 2018 9:44 PM
>
> Subject: [PATCH 1/7] target/mips: Add MXU register support
>=20
>This commit makes the MXU registers and the helper functions for
> reading/writing to them. This is required for full MXU instruction
> support.

> Signed-off-by: Craig Janeczek <jancraig@amazon.com>

Also, Craig,

This patch will cause compiler errors if QEMU is built with clang, with thi=
s patch as the last one. Clang will complain about unused functions. This w=
ill affect bisect algorithms. you should move definition of the functions t=
o the patches where they are used for the first time in the series.

Otherwise, overall, we want the content of your series integrated, you just=
 need to improve/correct the code.

Regards,
Aleksandar=

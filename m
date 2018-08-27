Received: from eggs.gnu.org ([2001:4830:134:3::10]:34531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuGkZ-0001vr-Sh
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuGkW-0003jX-Lj
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:36:07 -0400
Received: from mail-by2nam01on0134.outbound.protection.outlook.com
	([104.47.34.134]:44448
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fuGkW-0003hN-5r
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:36:04 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 27 Aug 2018 12:35:53 +0000
Message-ID: <BN7PR08MB48687DC8D5F23786CCD97A9DC60B0@BN7PR08MB4868.namprd08.prod.outlook.com>
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
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Friday, August 24, 2018 9:44 PM
>
> Subject: [PATCH 1/7] target/mips: Add MXU register support
>=20
> This commit makes the MXU registers and the helper functions for
> reading/writing to them. This is required for full MXU instruction
> support.

Hi, Craig,

The term "helper function" is good in general terminology sense, however, i=
n QEMU terminology, it is used for something else (see op_helper.c for exam=
ples), and not for the case similar to the functions in this patch. Your fu=
nctions generate "inline" code, in QEMU terminology, which is opposite to "=
helper" functions. Just don't use the word "helper" in the commit message. =
Use "wrapper", "utility", or similar word.

Thanks,
Aleksandar

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gGpfP-0007N5-5X
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 14:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gGpfH-00057S-PC
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 14:20:01 -0400
Received: from mail-bn3nam04on0717.outbound.protection.outlook.com
	([2a01:111:f400:fe4e::717]:38890
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gGpfC-00054r-68
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 14:19:52 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Sun, 28 Oct 2018 18:19:45 +0000
Message-ID: <BN6PR2201MB12513A37AD824BBC26FE1FDAC6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1540383527-7923-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-13-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 12/20] target/mips: Add emulation of MXU
 instructions S32I2M and S32M2I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

> Subject: [PATCH v7 12/20] target/mips: Add emulation of MXU instructions =
S32I2M and S32M2I
>=20
> From: Craig Janeczek <jancraig@amazon.com>
>=20
> Add support for emulating the S32I2M and S32M2I MXU instructions.
> This commit also contains utility functions for reading/writing
> to MXU registers. This is required for overall MXU instruction
> support.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Not all bits of MXU_CR are RW. RW-rules should be included in this patch. O=
r, at minimum, a "TODO" note should be inserted in the appropiriate handler=
.

Other than this:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Thanks,
Aleksandar=

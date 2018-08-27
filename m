Received: from eggs.gnu.org ([2001:4830:134:3::10]:49762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuHWR-0000fM-T7
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuHWO-000231-K3
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:25:35 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com
	([104.47.42.102]:60585
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fuHWO-00022B-9F
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:25:32 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 27 Aug 2018 13:25:27 +0000
Message-ID: <BN7PR08MB4868711B3B45495757BC5962C60B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <cover.1535133088.git.jancraig@amazon.com>
	<f1e92127959ffb3df713a06452328a71170bda93.1535133089.git.jancraig@amazon.com>
	<231c38e4-8ad4-0f73-69ab-7a66d20716d3@linaro.org>
	,<fed7b415b77c45d286e3b7cb4bc7b84f@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <fed7b415b77c45d286e3b7cb4bc7b84f@EX13D12UEA003.ant.amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/7] target/mips: Add MXU instructions
 S32I2M and S32M2I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Janeczek, Craig" <jancraig@amazon.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Janeczek, Craig <jancraig@amazon.com>
> Sent: Monday, August 27, 2018 2:22 PM
>=20
> Subject: RE: [Qemu-devel] [PATCH 2/7] target/mips: Add MXU instructions S=
32I2M and S32M2I
>=20
> https://github.com/MIPS/CI20_mplayer/blob/ci20_mplayer/mxu_as
>=20
> Sorry I mis-read our comment. The bit layouts were pulled from
> this script and validated by visually examining compiled code.

I think Richard brings to your attention that the structure definitions usi=
ng bit fields may yield different results on little and big endian hosts, w=
hich is certainly the situation you want to avooid, and recommends using ex=
tract32(), or similar QEMU feature, instead.

Aleksandar

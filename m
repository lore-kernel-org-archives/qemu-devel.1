Received: from eggs.gnu.org ([2001:4830:134:3::10]:34484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqLPv-0008KB-Iy
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqLPr-00030g-JQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:46:35 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com
	([104.47.34.90]:59445
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqLPr-00030E-87
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:46:31 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 16:46:27 +0000
Message-ID: <BN7PR08MB48680E332BC7EFD7CD65A21BC63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-23-git-send-email-aleksandar.markovic@rt-rk.com>,
	<ade97260-3d27-4a52-a040-c259a7545149@linaro.org>
In-Reply-To: <ade97260-3d27-4a52-a040-c259a7545149@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 22/84] target/mips: Add emulation of
 nanoMIPS 16-bit branch instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Thursday, August 16, 2018 6:33 PM
>=20
> Subject: Re: [PATCH v9 22/84] target/mips: Add emulation of nanoMIPS 16-b=
it branch instructions
>=20
> On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> > From: Yongbok Kim <yongbok.kim@mips.com>
> >
> > Add emulation of nanoMIPS 16-bit branch instructions.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > ---
> >  target/mips/translate.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
>=20
> This patch needs the gen_compute_compact_branch_nm you add in patch 39.
> All of the uses of gen_compute_branch are incorrect.
>=20
>=20
> r~

Hi, Richard,

The gen_compute_branch() will be eliminated from nanoMIPS code accross the =
board. This will be included in v10. That change has been worked on in last=
 few days, but didn't make it to be included in v9.

Thanks,
Aleksandar

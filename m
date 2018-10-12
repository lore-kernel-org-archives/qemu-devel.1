Received: from eggs.gnu.org ([2001:4830:134:3::10]:37728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxYs-0007oT-7G
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxYp-0004fZ-0T
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:33:02 -0400
Received: from mail-dm3nam03on0136.outbound.protection.outlook.com
	([104.47.41.136]:64096
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gAxYo-0004dZ-OQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:32:58 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 13:32:55 +0000
Message-ID: <BN6PR2201MB1251111DDB205F17A8341844C6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539256947-22807-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-15-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 14/22] target/mips: Improve DSP
 R2/R3-related naming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>

> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Do following replacements:
>=20
> ASE_DSPR2 -> ASE_DSP_R2
> ASE_DSPR3 -> ASE_DSP_R3
> check_dspr2() -> check_dsp_r2()
> check_dspr3() -> check_dsp_r3()

There may be a couple of other similar cases. They should be included in th=
is patch.

Other than this:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=

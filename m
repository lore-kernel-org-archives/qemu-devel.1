Received: from eggs.gnu.org ([2001:4830:134:3::10]:36912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxVl-0005EZ-Ay
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxVh-0006ve-80
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:29:49 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com
	([104.47.42.103]:26592
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gAxVg-0006tJ-K1
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:29:44 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 13:29:41 +0000
Message-ID: <BN6PR2201MB12513689A5EE57DB457C1C39C6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539256947-22807-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 07/22] target/mips: Add CPO PWCtl
 register
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

> From: Yongbok Kim <yongbok.kim@mips.com>
>=20
> Add PWCtl register (CP0 Register 5, Select 6).

Please bump version_id and minimum_version_id of vmstate_mips_cpu in machin=
e.c.

Other than this:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=

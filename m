Received: from eggs.gnu.org ([2001:4830:134:3::10]:37297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxXP-0006WP-Gh
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxXM-0001Ku-7r
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:31:31 -0400
Received: from mail-eopbgr700100.outbound.protection.outlook.com
	([40.107.70.100]:61022
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gAxXJ-0001CN-M2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:31:26 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 13:31:21 +0000
Message-ID: <BN6PR2201MB1251B47B1AB6B238DBAF0625C6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539256947-22807-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 08/22] target/mips: Implement hardware
 page table walker
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
> Implement hardware page table walker.

What is missing is initialization of PWField and PWsize register.

This initialization is very well documented, and it should be straightforwa=
rd.
Probably the best dobne in a separate patch.

Other than this:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=

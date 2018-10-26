Received: from eggs.gnu.org ([2001:4830:134:3::10]:57123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4cQ-0002nd-JG
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG4cL-0000HK-Mr
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:05:50 -0400
Received: from mail-sn1nam01on0722.outbound.protection.outlook.com
	([2a01:111:f400:fe40::722]:51258
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gG4cL-0000GF-Ct
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:05:45 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 16:05:39 +0000
Message-ID: <BN6PR2201MB1251A120B9F7C6EE381C6A72C6F00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1540563667-23300-7-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540563667-23300-7-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 6/6] Add prctl() PR_SET_FP_MODE and
 PR_GET_FP_MODE implementations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>

> From: Stefan Markovic <stefan.markovic@rt-rk.com>
> Subject: [PATCH 6/6] Add prctl() PR_SET_FP_MODE and PR_GET_FP_MODE implem=
entations
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>

>  #define TARGET_PR_SET_FP_MODE  45
>  #define TARGET_PR_GET_FP_MODE  46
> +#define TARGET_PR_FP_MODE_FR  (1 << 0)
> +#define TARGET_PR_FP_MODE_FRE (1 << 1)

There should be one space more to the left of (1 << 0) and (1 << 1) to achi=
eve nicer alignment.

A short commit message is needed too. Other than that:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

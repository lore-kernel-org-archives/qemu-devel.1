Received: from eggs.gnu.org ([208.118.235.92]:51994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcWn2-0001Il-5p
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcWmy-0005rK-5M
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:37:36 -0500
Received: from mail-eopbgr700098.outbound.protection.outlook.com
	([40.107.70.98]:6912
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gcWmw-0005iN-4T
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:37:30 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 27 Dec 2018 14:37:15 +0000
Message-ID: <BN6PR2201MB12511EDE907ACC2B5C4D9452C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1545920586-17815-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545920586-17815-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 04/26] disas: nanoMIPS: Fix order of
 some invocations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Subject: [PATCH v6 04/26] disas: nanoMIPS: Fix order of some invocations

> Fix order of extraction function invocations so that extraction
goes from MSB side to LSB side of the given instruction coding
content. This is desireable because of consistency and easier
visual spotting of errors.

The dictionaries list "desireable" as an archaic form of "desirable", so I =
will replace "desireable" with "desirable" in next version of the series, o=
r potential pull request.

The same appplies to patch 10.

Thanks,
Aleksandar=

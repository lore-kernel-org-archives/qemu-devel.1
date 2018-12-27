Received: from eggs.gnu.org ([208.118.235.92]:60551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcVYy-0003BK-7F
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 08:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcVYv-0004OA-2V
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 08:19:00 -0500
Received: from mail-eopbgr730103.outbound.protection.outlook.com
	([40.107.73.103]:26854
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gcVYu-0004J9-P5
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 08:18:57 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 27 Dec 2018 13:18:51 +0000
Message-ID: <BN6PR2201MB1251A5B244430F8689B751E1C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1545822388-10911-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545822388-10911-13-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 12/20] disas: nanoMIPS: Clean up
 handling of 16-bit logic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Subject: [PATCH v5 12/20] disas: nanoMIPS: Clean up handling of 16-bit lo=
gic instructions

> Clean up handling of 16-bit logic nanoMIPS instructions:

...
>=20
> -    return img::format("AND %s, %s", rs3, rt3);
> +    return img::format("AND[16] %s, %s", rs3, rt3);
> }

I wonder if this instruction should be displayed with two or three argument=
s (by design of this instruction, the destination is the same register as o=
ne of sources, but would it be more clear for end user to see three argumen=
ts, even if two of them are always the same?)

Aleksandar=

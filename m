Received: from eggs.gnu.org ([209.51.188.92]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB1AO-0007BM-TQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB1AN-0000Sy-16
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:56:16 -0400
Received: from mail-dm3nam05on070a.outbound.protection.outlook.com
	([2a01:111:f400:fe51::70a]:40304
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hB1AL-0000R5-7J
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:56:14 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 1 Apr 2019 17:56:07 +0000
Message-ID: <CY4PR2201MB12549D7CBB646334CF97A231C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1553845000-6537-2-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1553845000-6537-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/5] target/mips: MSA instructions ld,
 big endian host fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH v3 1/5] target/mips: MSA instructions ld, big endian host=
 fix
>=20

Start the title with the imperative, such as "target/mips: Fix..."

Use full instruction names, as explained in previous reviews.

> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> Fix the case when the host is running on a big endian machine,
> and change the approach toward ld instruction helpers.
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>

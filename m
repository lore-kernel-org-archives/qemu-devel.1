Received: from eggs.gnu.org ([209.51.188.92]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB1Fo-0003LV-Sd
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB1Fm-0002aX-Tk
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:01:52 -0400
Received: from mail-cys01nam02on0725.outbound.protection.outlook.com
	([2a01:111:f400:fe45::725]:52579
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hB1Fi-0002YJ-O1
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:01:50 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 1 Apr 2019 18:01:36 +0000
Message-ID: <CY4PR2201MB125474BCF00E6B16576EE851C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1553845000-6537-4-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1553845000-6537-4-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/5] target/mips: Different approach
 toward COPY_S MSA instr. and big endian fix
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
> Subject: [PATCH v3 3/5] target/mips: Different approach toward COPY_S MSA=
 instr. and big endian fix
>=20

"Different approach toward..." -> "Refactor and fix COPY_S.<B|H|W|D> instru=
ctions"

> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> The old version of the helper for the COPY_S.<B|H|W|D> MSA instructions
> has been replaced with a four helpers that don't use switch, and change
> the endianness of the given index, when executed on a big endian host.
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

Received: from eggs.gnu.org ([209.51.188.92]:58399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB0lK-0004p6-ST
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB0lK-00021s-26
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:30:22 -0400
Received: from mail-eopbgr790123.outbound.protection.outlook.com
	([40.107.79.123]:63488
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hB0lJ-00021P-Px
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:30:22 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 1 Apr 2019 17:30:18 +0000
Message-ID: <CY4PR2201MB125458E09253D73F9E85D3E7C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1554129501-27175-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554129501-27175-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] target/mips: MOD_<U|S>.<B|H|W|D> MSA
 insturctions fixed
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
> Subject: [PATCH 2/2] target/mips: MOD_<U|S>.<B|H|W|D> MSA insturctions fi=
xed
>=20
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> In case of dividing integers by zero, the result is unpredictable [1],
> but according to the hardware, the result is not zero, but the dividend.
>
> [1] MIPS=AE Architecture for Programmers
>    Volume IV-j: The MIPS64=AE SIMD
>    Architecture Module, Revision 1.12
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

See the review of the patch 1/2.

Thanks,
Aleksandar=

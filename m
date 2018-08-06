Received: from eggs.gnu.org ([2001:4830:134:3::10]:53377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmfp6-0006D6-Lf
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmfp1-0005X0-Uv
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:45:24 -0400
Received: from mail-co1nam04on0712.outbound.protection.outlook.com
	([2a01:111:f400:fe4d::712]:65248
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fmfp1-0005Vb-GZ
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:45:19 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 6 Aug 2018 13:45:12 +0000
Message-ID: <BN7PR08MB48684CB85A7CF2E3E1996EB4C6200@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1533219424-7627-62-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-62-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 61/77] linux-user: Add syscall numbers
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

ping

(Riku, Laurent?)

> From: Stefan Markovic <stefan.markovic@rt-rk.com>
> Sent: Thursday, August 2, 2018 4:16 PM
> To: qemu-devel@nongnu.org
>=20
> Subject: [PATCH v6 61/77] linux-user: Add syscall numbers for nanoMIPS
>=20
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Add syscall numbers for nanoMIPS. nanoMIPS redefines its ABI
> compared to preceding MIPS architectures, and its set of
> supported system calls is significantly different.
>=20
> Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  linux-user/nanomips/syscall_nr.h | 275 +++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 275 insertions(+)
>  create mode 100644 linux-user/nanomips/syscall_nr.h

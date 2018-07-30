Received: from eggs.gnu.org ([2001:4830:134:3::10]:42019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fkBEu-0007gz-QK
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fkBEq-0008UL-Ha
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:41:44 -0400
Received: from mail-cys01nam02on0731.outbound.protection.outlook.com
	([2a01:111:f400:fe45::731]:45074
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fkBEq-0008Tq-5e
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:41:40 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 30 Jul 2018 16:41:35 +0000
Message-ID: <BN7PR08MB486887FE64E831C3298A3B0CC62F0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 00/76] Add nanoMIPS support to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> v4->v5:
>=20
>   - merged series "Mips maintenance and misc fixes and improvements"
>     and this one for easier handling (there are build dependencies)
>   - eliminated shadow variables from translate.c
>   - replaced shift/mask combination with extract32()
>   - added new function gen_op_addr_addi()
>   - added "fall through" comments at appropriate places
>   - eliminated micromips flag from I7200 definition
>   - numerous other enhancements originating from reviewer's
>     comments
>   - some of the patches split into two or more for easier
>     handling and review
>   - rebased to the latest code

I forgot to include an important item here:

  - reimplemented emulation of LLWP/SCWP pair

Aleksandar M.

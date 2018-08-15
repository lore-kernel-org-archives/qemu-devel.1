Received: from eggs.gnu.org ([2001:4830:134:3::10]:57784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpvkN-0004Nv-9T
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpvkJ-00069F-Mp
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:21:58 -0400
Received: from mail-co1nam03on0113.outbound.protection.outlook.com
	([104.47.40.113]:9296
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fpvkH-000639-FD
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:21:54 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 15 Aug 2018 13:21:46 +0000
Message-ID: <BN7PR08MB4868A393D57E0BBE16D276FEC63F0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-37-git-send-email-aleksandar.markovic@rt-rk.com>,
	<740e5769-e392-cb7b-f23a-582243453127@linaro.org>
In-Reply-To: <740e5769-e392-cb7b-f23a-582243453127@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 36/76] target/mips: Add emulation of
 nanoMIPS 32-bit branch instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> I think perhaps all of your branching code, utilizing the existing expand=
ers, needs a re-think.

We re-thought handling of nanoMIPS branch instructions, and a new approach =
will be integrated in the next version.

We plan ()for nanoMIPS branches) not to rely on pre-nanoMIPS branch-related=
 functions at all. Also, to remove all delay/forbidden slot artifacts from =
nanoMIPS code.

Thanks for valuable feedback.

Regards,
Aleksandar=

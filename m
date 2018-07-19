Received: from eggs.gnu.org ([2001:4830:134:3::10]:42533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fgBfd-0005nl-Lt
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fgBfZ-0001Mh-F7
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:20:49 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com
	([40.107.70.117]:42592
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fgBfZ-0001Ln-4w
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:20:45 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 19 Jul 2018 16:20:38 +0000
Message-ID: <BN7PR08MB4868DB73F3F048397F8C6312C6520@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-12-git-send-email-stefan.markovic@rt-rk.com>,
	<8541a994-5ab2-49da-cbe8-a92a53075d7c@linaro.org>
In-Reply-To: <8541a994-5ab2-49da-cbe8-a92a53075d7c@linaro.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 11/11] linux-user: Add availability
 control to some syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Thursday, July 19, 2018 5:57 PM
>
> On 07/19/2018 05:52 AM, Stefan Markovic wrote:
> > From: Aleksandar Rikalo <arikalo@wavecomp.com>
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > ---
> >  linux-user/strace.c  | 14 +++++++++++++-
> >  linux-user/syscall.c | 25 +++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+), 1 deletion(-)
>
> We need a (any) description of why.  Is nanoMIPS going to reset the kerne=
l > abi
> and do away with the "legacy" mips syscalls?
>
>
> r~

Second that. This patch needs a proper commit message anyway, I don't know =
how it managed to arrive to this list without one.

I do know the answer to the connection between this patch and nanoMIPS thou=
gh. nanoMIPS supports different set of syscalls from "stat" group than mips=
32/mips64/mipsn32 or any other platform. Without this patch, nanoMIPS QEMU =
user-mode build would fail (but complete nanoMIPS QEMU user-mode support ha=
ve not been sent for review to this list so far - it will be sent most like=
ly next week).

Regards,
Aleksandar

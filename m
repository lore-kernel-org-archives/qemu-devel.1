Received: from eggs.gnu.org ([2001:4830:134:3::10]:35220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbMfk-0006ve-RF
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbMff-00076v-OL
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:05:00 -0400
Received: from mail-eopbgr680132.outbound.protection.outlook.com
	([40.107.68.132]:36231
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fbMff-000725-GQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:04:55 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 6 Jul 2018 09:04:48 +0000
Message-ID: <BN7PR08MB48686506B4081A5E5554DE24C6470@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530732637-28606-5-git-send-email-aleksandar.markovic@rt-rk.com>,
	<20f56ce2-9998-75c1-a15f-80633a70bd5e@linaro.org>
In-Reply-To: <20f56ce2-9998-75c1-a15f-80633a70bd5e@linaro.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/8] target/mips: Avoid case statements
 formulated by ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> >      case 18:
> >          switch (sel) {
> > -        case 0 ... 7:
> > +        case 0:
> > +        case 1:
> > +        case 2:
> > +        case 3:
> > +        case 4:
> > +        case 5:
> > +        case 6:
> > +        case 7:
>
> I don't see the point in this.  It is clear what 0 ... 7 means.

The point is to avoid using ranges altogether, regardless of the clarity of=
 a particular instance.

Let me further explain the reason: Consider this: Let's say we plan to repl=
ace 0, 1, 2, 3, 4, 5, 6, 7 with some preprocessor constants, appropriate fo=
r the particular context. If we keep "0 ... 7" notation, that line will loo=
k like "case ABC_KLM ... ABC_RST:" and will suddenly become much less clear=
.

As a mattter of fact, there is a plan to switch from hardcoded numbers to p=
reprocessor constants in this instance, but it is a low priority task.

Regards,
Aleksandar

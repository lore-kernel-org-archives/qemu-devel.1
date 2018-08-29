Received: from eggs.gnu.org ([2001:4830:134:3::10]:35779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <timbaldwin@fastmail.co.uk>) id 1fv2Yb-0006AH-QD
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <timbaldwin@fastmail.co.uk>) id 1fv2YY-0002dv-JK
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:38:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <timbaldwin@fastmail.co.uk>)
	id 1fv2YY-0002da-B0
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:38:54 -0400
Message-Id: <1535557130.3162451.1490203088.1408408F@webmail.messagingengine.com>
From: Timothy Baldwin <timbaldwin@fastmail.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <BN7PR08MB4868E801C917548C44678D88C6320@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534182832-554-82-git-send-email-aleksandar.markovic@rt-rk.com>
	<c9eb581f-3f03-c28e-4095-3064e556f7c0@members.leeds.ac.uk>
	<BN7PR08MB4868E801C917548C44678D88C6320@BN7PR08MB4868.namprd08.prod.outlook.com>
Date: Wed, 29 Aug 2018 16:38:50 +0100
Subject: Re: [Qemu-devel] [PATCH v8 81/87] linux-user: Add support for
 statx() syscall for all platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu, philippe.mathieu.daude@gmail.com, Petar Jovanovic <pjovanovic@wavecomp.com>, aurelien@aurel32.net

On Mon, 20 Aug 2018, at 10:45 AM, Aleksandar Markovic wrote:

> > As such an implementation of lstat that uses statx will be broken.
> > 
> > Since fstatat exists since 2.6.16 this can be reduced to a call to fstatat.
> 
> I am not sure what you meant here. I think QEMU lstat() implementation 
> does not use statx(). This implementation of statx() uses hosts's 
> statx(), and, as a fallback, host's fstat(), stat(), and fstatat().

I was referring to an  implementation of lstat in a C library that is running on QEMU linux user.

> 
> I would like to add that I think this patch should be submitted 
> separately, out of this series.
> 
> Yours,
> Aleksandar
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRF31-0003yt-Co
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 06:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRF30-0000Rn-Lk
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 06:55:11 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRF30-0000QO-GM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 06:55:10 -0400
Received: by mail-oi0-x244.google.com with SMTP id c6-v6so10329194oiy.0
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 03:55:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b4903491-f450-1a54-2a70-a084c30cd8c6@redhat.com>
References: <20180606152128.449-1-f4bug@amsat.org>
	<b4903491-f450-1a54-2a70-a084c30cd8c6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 11:54:49 +0100
Message-ID: <CAFEAcA_xP37u4KMdvPe8MyU3y_6re88pAx3KTLY_DOP0qWQzqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/11] misc: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2018 at 20:43, John Snow <jsnow@redhat.com> wrote:
> so error_setg must be used WITHOUT \n and logging must happen with \n?
>
> If we're sure that's the way we want to have things laid out, we really
> ought to augment checkpatch to catch this -- because there's 0% chance
> that we'll keep it straight on our own otherwise.

It's a historical side effect of them being basically separately
designed APIs. error_setg() takes the "give it the entire error
message" approach. logging is printf-style and gives the caller
flexibility to compose more complicated lines of logging with
multiple calls. Consistency between the two might be nice but
there are an awful lot of qemu_log calls in the codebase to check
and change to the other convention...

thanks
-- PMM

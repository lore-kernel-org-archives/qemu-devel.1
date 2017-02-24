Received: from eggs.gnu.org ([2001:4830:134:3::10]:49949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHGt-0003WU-8G
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHGs-00019s-Jv
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:54:59 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chHGs-00019Q-Da
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:54:58 -0500
Received: by mail-wm0-x234.google.com with SMTP id r141so16442681wmg.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:54:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8936f97ffdf6fe9a71a300113019bfdba0ecef23.1487522123.git.balaton@eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<8936f97ffdf6fe9a71a300113019bfdba0ecef23.1487522123.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 14:54:36 +0000
Message-ID: <CAFEAcA9m8Yjwjn_B5aBZmWVwXXVj7-BQ1_d76ED4bg3cAWw=bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 09/10] sm501: Add some more missing
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Write only to allow clients to initialise these without failing
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

What's the point in write-only register values?

What does the real hardware do here?

If the registers are writes-ignored, there's no need to store
the data written into the state struct; if the registers are
reads-as-written then implement them that way.

(If they get state struct fields the vmstate needs to be
updated accordingly, as does reset.)

thanks
-- PMM

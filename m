Received: from eggs.gnu.org ([2001:4830:134:3::10]:36839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chf8N-0006bq-FP
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chf8M-0005Jw-Mq
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:23:47 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chf8M-0005Je-Gx
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:23:46 -0500
Received: by mail-wm0-x229.google.com with SMTP id r141so34589846wmg.1
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 08:23:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1702242135160.76443@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<e87856482b30803a17c5af8124dad9454c0bed86.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA8jd10oqz6R4RDC5pOrsXxOMft9q0sghBUqvVpduJ3K1Q@mail.gmail.com>
	<alpine.BSF.2.20.1702242135160.76443@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Feb 2017 16:23:25 +0000
Message-ID: <CAFEAcA_AoCPUGxrC434x1EvOpPOogK7XERRZfPCcSspb9dW+Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 08/10] sm501: Add support for panel layer
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

On 24 February 2017 at 20:38, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Fri, 24 Feb 2017, Peter Maydell wrote:
>> Please don't change variable names in the middle of a patch that's
>> adding new functionality, it makes the patch harder to review.
>
>
> Where should I do it then? Again another patch?

Yes. Either make it its own patch, or drop the change altogether.
Anything that makes the core "this is making a bug fix or
adding new functionality" patch bigger by adding unnecessary
code change to it makes that patch harder to review.
(Conversely a patch that's just "change this variable name"
is trivially easy to review.)

thanks
-- PMM

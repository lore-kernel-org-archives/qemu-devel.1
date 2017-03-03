Received: from eggs.gnu.org ([2001:4830:134:3::10]:35328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrvZ-0004C6-J8
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrvY-00057J-T6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:27:41 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjrvY-00056Z-NM
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:27:40 -0500
Received: by mail-wm0-x22f.google.com with SMTP id v186so21784405wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:27:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2631f4fa83bdb4ea9da97cb807a8ff1756db1684.1488504063.git.balaton@eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<2631f4fa83bdb4ea9da97cb807a8ff1756db1684.1488504063.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:27:19 +0000
Message-ID: <CAFEAcA-knxUep+x-svv+e6FaJ51r_6JwhBW20pR_PMF+2618OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 08/13] sm501: Fix hardware cursor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 4 December 2016 at 18:01, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>
> v3: simplify return expression in get_bpp

In my review on v2 I asked for the commit message to
say clearly what the bugs being fixed here are. It's
a lot easier to review a patch if I know what it's supposed
to be doing rather than having to figure it out from scratch.

thanks
-- PMM

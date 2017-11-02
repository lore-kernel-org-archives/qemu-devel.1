Received: from eggs.gnu.org ([2001:4830:134:3::10]:50831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAHDA-0008Kk-Jy
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAHD9-0002Wg-Mc
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:15:16 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:54671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAHD9-0002Vn-Gv
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:15:15 -0400
Received: by mail-wr0-x241.google.com with SMTP id o44so5330471wrf.11
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 08:15:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d0aa7605-c262-273f-7fab-94e72f202aa7@gmx.com>
References: <20170903164952.26760-1-n54@gmx.com>
	<20170911171639.22005-1-n54@gmx.com>
	<CAFEAcA-wNp2T7BGih1O3-Tq1+OrYNnM1VqAneM3QfXrd5u9ZPg@mail.gmail.com>
	<d0aa7605-c262-273f-7fab-94e72f202aa7@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 15:14:53 +0000
Message-ID: <CAFEAcA-E9TEay9xbeE9tZCHFvSLrE8R4V2ZttzEwoQN8JQzX9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] Discover openpty(3) dynamically in
 configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Jonathan Perkin <jperkin@joyent.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Tribble <peter.tribble@gmail.com>, =?UTF-8?Q?Antonio_Huete_Jim=C3=A9nez?= <tuxillo@quantumachine.net>

On 28 October 2017 at 18:07, Kamil Rytarowski <n54@gmx.com> wrote:
> I've naively expected that once a build on a certain OS will be fixed,
> it will be functional for longer period (at least few weeks). In one
> month qemu has been broken on DragonFly and SmartOS so they are not just
> broken in tests, but also in the basic build.

Yep; things do break if they're not tested, which is why I think
we have to have a host system being in our regular build/test
process in order to be able to call it supported.

> Because there is need to fix the SmartOS build in order to improve this
> openpty(3) patch, I'm resigning from it. I also resign from helping
> DragonFly port.
>
> I will focus entirely on the bits that I registered as a maintainer.
>
> I leave the decisions and steps about support of these platforms to
> other volunteers and qemu core maintainers.

Thanks for your efforts with the BSD porting work; we appreciate
it.

thanks
-- PMM

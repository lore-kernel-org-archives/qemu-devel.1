Received: from eggs.gnu.org ([2001:4830:134:3::10]:52661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f3jLg-00067V-EB
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f3jLf-0001RK-JI
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:25:16 -0400
Date: Wed, 4 Apr 2018 16:25:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180404142505.4mpvautvlqemjlpp@sirius.home.kraxel.org>
References: <20180319161556.16446-1-peter.maydell@linaro.org>
	<CAFEAcA8trs8tMKBqbOLaNx4OR9H9+xO4jJQjY2+yeCNdsdCBCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8trs8tMKBqbOLaNx4OR9H9+xO4jJQjY2+yeCNdsdCBCA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12 0/2] bcm2835_sdhost:
 fix interrupt handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "patches@linaro.org" <patches@linaro.org>

On Wed, Apr 04, 2018 at 11:18:23AM +0100, Peter Maydell wrote:
> Ping for code review, please? It would be nice if our 'raspi3'
> model for 2.12 was one we could say actually booted a known
> Linux image...

The Fedora 27 image kernel (aarch64, 4.13) boots and mounts the root
filesystem.  This is an improvement, so:

Tested-by: Gerd Hoffmann <kraxel@redhat.com>

It doesn't finish boot though, at some point the kernel starts to
complain about timeouts and xfs throws io errors, so things are not
perfect yet.

raspi2 doesn't boot the fedora 27 armhfp kernel.  Looks unrelated
though, it fails with "Division by zero in kernel" before even loading
the sdhost driver.  I suspect the kernel tries to access some hardware
not emulated by qemu ...

Trying to run u-boot as boot-loader (so I don't have to copy the kernel
from the image) doesn't work too.

cheers,
  Gerd

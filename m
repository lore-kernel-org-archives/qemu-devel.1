Received: from eggs.gnu.org ([2001:4830:134:3::10]:47537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRh1z-00088U-EU
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRh1y-0003FW-GO
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:15:43 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:49234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@weiser.dinsnail.net>)
	id 1eRh1y-0003D7-8G
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:15:42 -0500
Date: Wed, 20 Dec 2017 17:01:06 +0100
From: Michael Weiser <michael.weiser@gmx.de>
Message-ID: <20171220160106.GE15475@weiser.dinsnail.net>
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-3-michael.weiser@gmx.de>
	<bd78a6f5-f023-af5a-0d35-f3b29ae4e7a6@vivier.eu>
	<CAFEAcA8D0n_PNJ-fqMq8KtZSBRdf2i=3cxcbwT1HSnFi9_MhpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8D0n_PNJ-fqMq8KtZSBRdf2i=3cxcbwT1HSnFi9_MhpA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] linux-user: Add separate aarch64_be
 uname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Hi Peter,

On Wed, Dec 20, 2017 at 03:36:29PM +0000, Peter Maydell wrote:

> >>  #define UNAME_MINIMUM_RELEASE "3.8.0"

> > For aarch64_be, I think the minimum release should be 4.9.0
> > (see kernel commit cfa88c79462d "arm64: Set UTS_MACHINE in the Makefile")

> Isn't the thing that defines what we set the minimum-release
> to glibc, not the kernel? That is, the reason we lie to the
> guest about the kernel version for some architectures is because
> the glibc for those archs insists on a minimum kernel version
> which the host may not have. Unless aarch64_be glibc insists
> on kernel 4.9.0 there's no need to tell the guest that.

I can confirm that cross-compiled glibc runs fine with the current
value. Also, a native compile of glibc inside an qemu-aarch64_be binfmt
chroot configured without problem and currently churns along compiling.

My Gentoo setup calls configure with --enable-kernel=3.2.0 and that says
about this:

checking installed Linux kernel header files... 3.2.0 or later
configure: WARNING: minimum kernel version reset to 3.7.0
checking for kernel header at least 3.7.0... ok

So it seems your memory is right.
-- 
Bye,
Michael

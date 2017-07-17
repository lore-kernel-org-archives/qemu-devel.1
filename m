Received: from eggs.gnu.org ([2001:4830:134:3::10]:60721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX5U9-00047X-Nr
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX5U9-00056o-0c
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:50:49 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX5U8-00056L-OU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:50:48 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 12so6383658wrb.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 05:50:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717065621.4688-1-david@gibson.dropbear.id.au>
References: <20170717065621.4688-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:50:27 +0100
Message-ID: <CAFEAcA-p2maYu=wDM_uwfOTWDffh+ZGtLNtaQqpp6js=nuafpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] ppc-for-2.10 queue 20170717
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

On 17 July 2017 at 07:56, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e25:
>
>   vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170717
>
> for you to fetch changes up to 346ebfc6fbf1a0c07cbdfc52beef0f0b9b5180d4:
>
>   target/ppc: fix CPU hotplug when radix is enabled (TCG) (2017-07-17 15:07:05 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-07-17
>
> This pull requests supersedes the one from 2017-07-14.  That one had a
> couple of subtle regressions: there was a build error for mingw32, and
> an instance_size which was theoretically wrong everywhere, but only
> actually bit on the Travis OSX build.
>
> There are two major batches in this set, rather than the usual
> collection of assorted fixes.
>
>     * More DRC cleanup.  This gets the state management into a state
>       which should fix many of the hotplug+migration problems we've
>       had.  Plus it gets the migration stream format into something
>       well defined and pretty minimal which we can reasonably support
>       into the future.
>
>     * Hashed Page Table resizing.  It's been a while since this was
>       posted, but it's been through several previous rounds of review.
>       The kernel parts (both guest and host) are merged in 4.11, so
>       this is the only remaining piece left to allow resizing of the
>       HPT in a running guest.
>
> There are also a handful of unrelated fixes.
>

Applied, thanks.

-- PMM

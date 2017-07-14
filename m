Received: from eggs.gnu.org ([2001:4830:134:3::10]:46472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVxmm-0006MG-Hz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVxml-0004fN-Ii
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:25:24 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVxml-0004f8-CN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:25:23 -0400
Received: by mail-wm0-x231.google.com with SMTP id i127so18164530wma.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:25:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714061521.28300-1-david@gibson.dropbear.id.au>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 11:25:01 +0100
Message-ID: <CAFEAcA9H7td0EogiAcp3rL6CB46fvq8fJbDBCZw1R3Z8Ch0AvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] ppc-for-2.10 queue 20170714
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, sbobroff@au1.ibm.com, Laurent Vivier <lvivier@redhat.com>

On 14 July 2017 at 07:15, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d4f:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12' into staging (2017-07-13 16:56:06 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170714
>
> for you to fetch changes up to e11134d2ac7744569d7c387102368c507d340c30:
>
>   pseries: Allow HPT resizing with KVM (2017-07-14 09:28:30 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-07-14
>
> Two major batches in this set, rather than the usual collection of
> assorted fixes.
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

I see Alex Graf's update to the e500 u-boot image didn't make
it in to this -- are you planning to send that separately
or should I pick it up directly? (I definitely would like to
see that in the 2.10 release, because it fixes a problem where
our u-boot sources are (a) very old and (b) not even the version
corresponding to the binary blob we ship...)

thanks
-- PMM

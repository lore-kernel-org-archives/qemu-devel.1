Received: from eggs.gnu.org ([2001:4830:134:3::10]:47478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZaOx-0006w5-AZ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZaOw-0005zn-AW
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:43:31 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZaOw-0005z3-2f
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:43:30 -0500
Received: by mail-wm0-x22f.google.com with SMTP id c85so19771626wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 01:43:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 09:43:08 +0000
Message-ID: <CAFEAcA-Lmb-5Y2Z1i+g6d3+S1Fi-YJtBwXCwUNDUpHWPCecyRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 000/107] ppc-for-2.9 queue 20170202
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 2 February 2017 at 05:12, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170202
>
> for you to fetch changes up to 7c6e8797337c24520b48d8b50a900a747e50f974:
>
>   hw/ppc/pnv: Use error_report instead of hw_error if a ROM file can't be found (2017-02-02 09:30:07 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-02-02
>
> This obsoletes ppc-for-2.9-20170112, which had a MacOS build bug.
>
> This is a long overdue ppc pull request for qemu-2.9.  It's been a
> long time coming due to some holidays and inconveniently timed
> problems with testing.  So, there's a lot in here:
>
>     * More POWER9 instruction implementations for TCG
>     * The simpler parts of my CPU compatibility mode cleanup
>         * This changes behaviour to prefer compatibility modes over
>           "raW" mode for new machine type versions
>     * New "40p" machine type which is essentially a modernized and
>       cleaned up "prep".  The intention is that it will replace "prep"
>       once it has some more testing and polish.
>     * Add pseries-2.9 machine type
>     * Implement H_SIGNAL_SYS_RESET hypercall
>     * Consolidate the two alternate CPU init paths in pseries by
>       making it always go through CPU core objects to initialize CPU
>     * A number of bugfixes and cleanups
>     * Stop the guest timebase when the guest is stopped under KVM.
>       This makes the guest system clock also stop when paused, which
>       matches the x86 behaviour.
>     * Some preliminary cleanups leading towards implementation of the
>       POWER9 MMU.
>
> There are also some changes not strictly related to ppc code, but for
> its benefit:
>
>     * Limit the pxi-expander-bridge (PXB) device to x86 guests only
>       (it's essentially a hack to work around historical x86
>       limitations)
>     * Some additions to the 128-bit math in host_utils, necessary for
>       some of the new instructions.
>     * Revise a number of qtests and enable them for ppc

Applied, thanks.

-- PMM

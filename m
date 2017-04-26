Received: from eggs.gnu.org ([2001:4830:134:3::10]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Nzb-0006B1-9o
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Nza-0004bL-7A
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:32:31 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3NzZ-0004aK-WC
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:32:30 -0400
Received: by mail-wr0-x231.google.com with SMTP id w50so1298364wrc.0
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 07:32:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 15:32:08 +0100
Message-ID: <CAFEAcA9+KdCGAb0Andsaxcn+-RRzxcHT-jY=q4Rd4iNuaqcqMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/48] ppc-for-2.10 queue 20170426
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 26 April 2017 at 07:59, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit fe491fa85c4634453b340b18046aae2eaf8147db:
>
>   Merge remote-tracking branch 'remotes/agraf/tags/signed-s390-for-upstream' into staging (2017-04-25 14:48:55 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170426
>
> for you to fetch changes up to df02d2ca8b23ba1fff137090a65731c68cf1393d:
>
>   MAINTAINERS: Remove myself from e500 (2017-04-26 12:41:56 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-04-26
>
> Here's a respind of my first pull request for qemu-2.10, consisting of
> assorted patches which have accumulated while qemu-2.9 stabilized.
> Highlights are:
>     * Rework / cleanup of the XICS interrupt controller
>     * Substantial improvement to the 'powernv' machine type
>         - Includes an MMIO XICS version
>     * POWER9 support improvements
>         - POWER9 guests with KVM
>         - Partial support for POWER9 guests with TCG
>     * IOMMU and VFIO improvements
>     * Assorted minor changes
>
> There are several IPMI patches here that aren't usually in my area of
> maintenance, but there isn't a regular maintainer and these patches
> are for the benefit of the powernv machine type.
>
> This pull request supersedes my 2017-04-26 pull request.  This new set
> fixes a bug in one of the aforementioned IPMI patches which caused
> clang sanitizer failures (and may have crashed on some libc / host
> versions).

Applied, thanks.

-- PMM

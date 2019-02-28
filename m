Received: from eggs.gnu.org ([209.51.188.92]:37304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJcr-0004bc-2g
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJcq-0002i5-2E
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:13:17 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJcp-0002gK-T0
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:13:15 -0500
Received: by mail-oi1-x241.google.com with SMTP id w66so16156917oia.4
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:13:03 +0000
Message-ID: <CAFEAcA-=N7QV8wCZr35xuQg6RaEyfPC3uPFtbMDm3ay5KnRCBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/50] ppc-for-4.0 queue 20190226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: gkurz@kaod.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On Tue, 26 Feb 2019 at 04:53, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit ef80b99ce7ffbd66b3efd493f4ca99f8abf59e79:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-220219-1' into staging (2019-02-25 14:04:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190226
>
> for you to fetch changes up to b268a6162da8ef9daa6384f24d4b95a0385081eb:
>
>   ppc/pnv: use IEC binary prefixes to represent sizes (2019-02-26 14:20:30 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-02-26
>
> Next set of patches for ppc and spapr.  There's a lot in this one:
>  * Support "STOP light" states on POWER9
>  * Add support for HVI interrupts on POWER9 (powernv machine)
>  * CVE-2019-8934: Don't leak host model and serial information to the guest
>  * Tests and cleanups for various hot unplug options
>  * Hash and radix MMU implementation on POWER9 for powernv machine
>  * PCI Host Bridge hotplug support for pseries machine
>  * Allow larger kernels and initrds for powernv machine
>
> Plus a handful of miscellaneous fixes and cleanups.
>
> The cpu hotplug tests and cleanups from David Hildenbrand aren't
> solely power related.  However the consensus amongst Michael Tsirkin,
> David Hildenbrand, Cornelia Huck and myself was that it made most
> sense to come in via my tree.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

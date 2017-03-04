Received: from eggs.gnu.org ([2001:4830:134:3::10]:47369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckDeM-0005Yj-LQ
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 12:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckDeL-0006G6-IM
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 12:39:22 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckDeL-0006Fp-Bh
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 12:39:21 -0500
Received: by mail-wm0-x22b.google.com with SMTP id t193so36379936wmt.1
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 09:39:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Mar 2017 17:38:59 +0000
Message-ID: <CAFEAcA8eurHbQH339FXjjPiEhEmqRyLZse-iDfXX0sw88GBWaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/17] ppc-for-2.9 queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 3 March 2017 at 03:24, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit ecb24d334af1a98ef0329f4b3b0e14ae8cb8770d:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tgt-20170302' into staging (2017-03-02 22:06:41 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170303
>
> for you to fetch changes up to 992d7e976c7eca2b3129cd4bae4a0d350a8065fa:
>
>   target/ppc: rewrite f[n]m[add,sub] using float64_muladd (2017-03-03 11:38:33 +1100)
>
> ----------------------------------------------------------------
> ppc patch queuye for 2017-03-03
>
> This will probably be my last pull request before the hard freeze.  It
> has some new work, but that has all been posted in draft before the
> soft freeze, so I think it's reasonable to include in qemu-2.9.
>
> This batch has:
>     * A substantial amount of POWER9 work
>         * Implements the legacy (hash) MMU for POWER9
>         * Some more preliminaries for implementing the POWER9 radix
>           MMU
>         * POWER9 has_work
>         * Basic POWER9 compatibility mode handling
>         * Removal of some premature tests
>     * Some cleanups and fixes to the existing MMU code to make the
>       POWER9 work simpler
>     * A bugfix for TCG multiply adds on power
>     * Allow pseries guests to access PCIe extended config space
>
> This also includes a code-motion not strictly in ppc code - moving
> getrampagesize() from ppc code to exec.c.  This will make some future
> VFIO improvements easier, Paolo said it was ok to merge via my tree.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

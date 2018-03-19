Received: from eggs.gnu.org ([2001:4830:134:3::10]:53786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exsTP-0007pn-SR
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exsTP-0004CM-3k
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:57:03 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:45055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exsTO-0004Bk-Uw
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:57:03 -0400
Received: by mail-ot0-x230.google.com with SMTP id 79-v6so16831790oth.11
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 03:57:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319003524.28143-1-david@gibson.dropbear.id.au>
References: <20180319003524.28143-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 10:56:41 +0000
Message-ID: <CAFEAcA8Wc3744Rn2TKHWLZeprVweALR7pmWV0B5da8FrG8aCsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] ppc-for-2.12 queue 20180319
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, surajjs@au1.ibm.com, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org

On 19 March 2018 at 00:35, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit e1e44a9916b4318e943aecd669e096222cb3eaeb:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20180316-xtensa' into staging (2018-03-17 14:15:03 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180319
>
> for you to fetch changes up to 91c60f124e682a78c9a2ef951e8e58ebab6441d0:
>
>   target/ppc: fix tlbsync to check privilege level depending on GTSE (2018-03-18 21:03:20 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2018-03-19
>
> This pull request supersedes the one for 2018-03-15.  The only
> difference is one patch is removed, since it exposed some code which
> triggers ubsan warnings.
>
> Here's the set of accumulated patches now that we're into soft freeze.
> I've split new functionality into a ppc-for-2.13 branch, so this only
> has bugfixes.  Well.. and a couple of simple cleanups to make bugfixes
> easier, some test improvements and a trivial change to make command
> line options more obvious.  I think those are all acceptable for soft
> freeze.
>

Applied, thanks.

-- PMM

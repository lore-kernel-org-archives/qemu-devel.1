Received: from eggs.gnu.org ([2001:4830:134:3::10]:47287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cahiT-0006fh-Pe
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cahiS-000871-T5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:44:17 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cahiS-00086n-My
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:44:16 -0500
Received: by mail-wm0-x22e.google.com with SMTP id c85so116365143wmi.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 03:44:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170206013927.13693-1-david@gibson.dropbear.id.au>
References: <20170206013927.13693-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Feb 2017 11:43:54 +0000
Message-ID: <CAFEAcA9yOkJ4kghewFNrMVBHutiiZ1CE-LD7mT_VqpuO7soo9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] isa-cleanup queue 20170206
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Jia Liu <proljc@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Max Filippov <jcmvbkbc@gmail.com>, Veronia Bahaa <veroniabahaa@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>

On 6 February 2017 at 01:39, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit a951316b8a5c3c63254f20a826afeed940dd4cba:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-03 14:41:49 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/isa-cleanup-20170206
>
> for you to fetch changes up to c124c4d13bcb19fc866e7f6de075f906fca6af4a:
>
>   Split ISA and sysbus versions of m48t59 device (2017-02-06 12:33:21 +1100)
>
> ----------------------------------------------------------------
> Allow ISA to be disabled on some platforms (v3)
>
> This makes some cleanups that are a start on allowing ISA to be
> compiled out for platforms which don't use it.
>
> I posted this series last November, and it collected a number of R-bs
> and no apparent objections.  So, I've now rebased it (trivially) and
> am sending a pull request in the hopes of merge.  A lot of the pieces
> here don't have a clear maintainer, so I'm sending it directly to
> Peter.
>
> Notes:
>   * Patch 3/3 triggers a style warning, but that's just because I'm
>     moving a C++ // comment verbatim from one file to another
>
> Changes since v2:
>   * Trivial rebase
>
> Changes since v1:
>   * Fixed some silly compile errors in 3/3 exposed by some
>     changes in other headers

I think one or two platforms have appeared since (notably
nios) but they don't need CONFIG_SERIAL_ISA so that's ok.

Applied, thanks.

-- PMM

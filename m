Received: from eggs.gnu.org ([2001:4830:134:3::10]:40179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGr7s-0001Xa-Sc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGr7r-0006mr-Vl
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:49:00 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGr7r-0006lD-PB
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:48:59 -0500
Received: by mail-wr0-x241.google.com with SMTP id r2so2561434wra.13
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 10:48:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171120054239.8739-1-david@gibson.dropbear.id.au>
References: <20171120054239.8739-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 18:48:37 +0000
Message-ID: <CAFEAcA-cxNvGztiAbQ_0b1Ov=n1c3_J6-6c6mQfmLj7GiTzjHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-2.11 queue 20171120
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 20 November 2017 at 05:42, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 2e02083438962d26ef9dcc7100f3b378104183db:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-11-17 19:08:07 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171120
>
> for you to fetch changes up to 82512483940c756e2db1bd67ea91b02bc29c5e01:
>
>   spapr: reset DRCs after devices (2017-11-20 10:10:56 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-11-20
>
> Here's the current queue of ppc patches.  These 2 patches are both
> more complex than I'd ideally like this late in the 2.11 cycle.
> However, they do fix important bugs, so I think it's worth it on
> balance.
>
> ----------------------------------------------------------------
> Greg Kurz (1):
>       spapr: reset DRCs after devices
>
> Suraj Jitindar Singh (1):
>       target/ppc: Update setting of cpu features to account for compat modes
>
>  hw/ppc/spapr.c     | 64 +++++++++++++++++++++++++++++++++++-------------------
>  hw/ppc/spapr_drc.c |  7 ------
>  2 files changed, 42 insertions(+), 29 deletions(-)

Applied, thanks.

-- PMM

Received: from eggs.gnu.org ([209.51.188.92]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqdoD-0003HB-LP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqdoB-0006pS-FQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:57:09 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqdoA-0006oT-S6
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:57:07 -0500
Received: by mail-ot1-x343.google.com with SMTP id e12so12729651otl.5
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 04:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 12:56:54 +0000
Message-ID: <CAFEAcA8nSy=gi+CDSi0GoJbdzgM-b=hOv6BdSFj67eb3yijUsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/37] ppc-for-4.0 queue 20190204
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, spopovyc@redhat.com

On Mon, 4 Feb 2019 at 09:01, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit b3fc0af1ff5e922d4dd7c875394dbd26dc7313b4:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-02-01 17:58:27 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190204
>
> for you to fetch changes up to 53adb9d43e1abba187387a51f238e878e934c647:
>
>   mmap-alloc: fix hugetlbfs misaligned length in ppc64 (2019-02-04 18:44:20 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-02-04
>
> Here's the next batch of ppc target and spapr related changes.
> Highlights are:
>  * A number of endianness handling cleanups from Mark Cave-Ayland
>  * Updated Mac VGA driver
>  * Updated SLOF image
>  * Some XIVE cleanups and small fixes
>  * ppc4xx cleanups and fixes from BALATON Zoltan
>
> There are a few chances not technically in the ppc target code:
>  * Several MAINTAINERS updates
>  * Fixes for unmapping of hugepages on power hosts
>
> The latter is included because it's primarily of interest for ppc KVM setups.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

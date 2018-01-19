Received: from eggs.gnu.org ([2001:4830:134:3::10]:56911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecXOq-0000ND-FY
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecXOk-0005OC-H6
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:12:08 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:43682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecXOk-0005Nl-BN
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:12:02 -0500
Received: by mail-ot0-x230.google.com with SMTP id p36so1480057otd.10
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 06:12:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119094015.28266-1-david@gibson.dropbear.id.au>
References: <20180119094015.28266-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2018 14:11:40 +0000
Message-ID: <CAFEAcA-sHoJvWjJNZLv42DHk66GtfbHgDXif5y8kb1Doxj5WbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] ppc-for-2.12 queue 20180119
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com, Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nognu.org, QEMU Developers <qemu-devel@nongnu.org>

On 19 January 2018 at 09:40, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit b4d6ed1c5ae519d3efb5297be3ef6625ca2a20f4:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-17' into staging (2018-01-18 15:25:17 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180119
>
> for you to fetch changes up to 040cb0a2badf9e265cdbb78380048cd1624dd434:
>
>   target/ppc/spapr_caps: Add macro to generate spapr_caps migration vmstate (2018-01-19 16:06:26 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-01-19
>
> Quite soon after my previous pull request, but it's already
> accumulated a reasonable amount of stuff:
>   * Significant TCG speedup by optimizing cmp generation
>   * Fix a regression caused by recent change to set compat mode on
>     hotplugged cpus
>   * Cleanup of default configs
>   * Some implementation of msgsnd/msgrcv instructions for server chips
>
> ----------------------------------------------------------------


'make check' logs are full of
qemu-system-ppcemb: warning: qemu-system-ppcemb is deprecated, please
use qemu-system-ppc instead.

You need to silence that, or it's impossible for me to find actual
warnings in build tests.

thanks
-- PMM

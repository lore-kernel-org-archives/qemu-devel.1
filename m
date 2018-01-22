Received: from eggs.gnu.org ([2001:4830:134:3::10]:49064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edbyU-0003Dh-Q9
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:17:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edbyT-0007fm-Lt
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:17:22 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:37687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edbyT-0007fJ-FP
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:17:21 -0500
Received: by mail-ot0-x229.google.com with SMTP id a24so7405251otd.4
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 05:17:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180121053353.25970-1-david@gibson.dropbear.id.au>
References: <20180121053353.25970-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 13:17:00 +0000
Message-ID: <CAFEAcA-3kBqHKeu10sWJLJr=qKJ=H9gWAap9S=xNai2xD9AvjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180121
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, surajjs@au1.ibm.com

On 21 January 2018 at 05:33, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc78f:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-01-19 16:35:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180121
>
> for you to fetch changes up to 1f63ebaa91f73f469c8f107dbd266cabdbea3a40:
>
>   target/ppc/spapr_caps: Add macro to generate spapr_caps migration vmstate (2018-01-20 17:15:05 +1100)
>
> Peter, since I'm on my way to linux.conf.au, this hasn't been through
> my full usual test regimen, just a quick sanity check.  I'm hoping
> this is ok, since the only changes since the superseded pull request
> (which did pass the full set of tests) is a clean rebase and removal
> of Thomas' patch deprecating ppcemb.
>
> ----------------------------------------------------------------
> ppc patch queue 2018-01-21
>
> This request supersedes the one from 2018-01-19.  The only difference
> is that the patch deprecating ppcemb-softmmu, and thereby creating
> many annying warnings from make check has been removed.
>
> Highlights are:
>   * Significant TCG speedup by optimizing cmp generation
>   * Fix a regression caused by recent change to set compat mode on
>     hotplugged cpus
>   * Cleanup of default configs
>   * Some implementation of msgsnd/msgrcv instructions for server chips
>

Applied, thanks.

-- PMM

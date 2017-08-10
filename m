Received: from eggs.gnu.org ([2001:4830:134:3::10]:33066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfms2-0007oN-66
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfms1-0003Eb-6S
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:47:26 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfms1-0003E4-0Z
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:47:25 -0400
Received: by mail-wr0-x22c.google.com with SMTP id c24so2734714wra.1
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 05:47:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170809070357.28723-1-david@gibson.dropbear.id.au>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2017 13:47:03 +0100
Message-ID: <CAFEAcA_n88x0w1cVirQ61h+NOrvX1V7bXD1LCASVGyUZU=qDgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] ppc patch queue 2017-08-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 9 August 2017 at 08:03, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 54affb3a3623b1d36c95e34faa722a5831323a74:
>
>   Update version for v2.10.0-rc2 release (2017-08-08 19:07:46 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170809
>
> for you to fetch changes up to f57467e3b326c7736f8e481fd6b680f30e575c87:
>
>   spapr: Fix bug in h_signal_sys_reset() (2017-08-09 14:04:28 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-08-09
>
> This series contains a number of bugfixes for ppc and related
> machines, for the qemu-2.10.release.  Some are true regressions,
> others are serious enough and non-invasive enough to fix that it's
> worth putting in 2.10 this late.
>
> ----------------------------------------------------------------

Applied, thanks.

> I haven't completed a Travis build for this, which is part of my usual
> test regime, since the first dozen or so Travis builds are failing
> more often than not on master as well.  I don't know why this is -
> seems to be failing some of the x86 tests.

Doesn't look much worse than usual to me -- of the last 24 travis
builds for master 4 failed and 20 passed.

thanks
-- PMM

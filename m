Received: from eggs.gnu.org ([2001:4830:134:3::10]:51651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePpFy-0003aO-GM
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePpFx-00027e-Io
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:38:26 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePpFx-000273-Bf
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:38:25 -0500
Received: by mail-oi0-x241.google.com with SMTP id r193so4365536oie.3
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 04:38:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 12:38:04 +0000
Message-ID: <CAFEAcA8WUHH65ytJsTJ9Vz58H6QBRUVayDvh1Dp2UF2wnK1gwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/24] ppc-for-2.12 queue 20171215
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 15 December 2017 at 05:54, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 0ef0583d5adceb9138bdb47494dabd1549ac5b6d:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171214' into staging (2017-12-14 15:32:32 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20171215
>
> for you to fetch changes up to 1481fe5fcfeb7fcf3c1ebb9d8c0432e3e0188ccf:
>
>   spapr: don't initialize PATB entry if max-cpu-compat < power9 (2017-12-15 09:50:29 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-12-15
>
> First pull request for qemu-2.12.  This has quite a bit of stuff
> accumulated while 2.11 was finalizing.  Highlights are:
>
>   * Some preliminary work towards implementing the "XIVE" POWER9
>     interrupt controller
>   * Some fixes for problems during reboot with MTTCG
>   * A substantial TCG performance improvement via
>     tcg_get_lookup_and_goto_ptr
>   * Numerous assorted cleanups and bugfixes that weren't urgent enough
>     for 2.11
>

Applied, thanks.

-- PMM

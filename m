Received: from eggs.gnu.org ([2001:4830:134:3::10]:50043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etAdV-0002Nq-5M
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etAdU-0001mu-5i
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:20:01 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etAdU-0001md-0a
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:20:00 -0500
Received: by mail-oi0-x242.google.com with SMTP id c18so14511763oiy.9
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:19:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 11:19:38 +0000
Message-ID: <CAFEAcA9wA-Go6SPy6yWsh4TLJMtG1gWnNWsgbgwZ6JL1dQYUxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/30] ppc-for-2.12 queue 20180306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, Alexander Graf <agraf@suse.de>, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2018 at 04:01, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit f2bb2d14c2958f3f5aef456bd2cdb1ff99f4a562:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-05 16:41:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180306
>
> for you to fetch changes up to 21b786f607b11d888f90bbb8c3414500515d11e7:
>
>   PowerPC: Add TS bits into msr_mask (2018-03-06 13:16:29 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-03-06
>
> This pull request supersedes ppc-for-2.12-20180302 which had compile
> problems with some gcc versions.  It also contains a few additional
> patches.
>
> Highlights are:
>     * New Sam460ex machine type
>     * Yet more fixes related to vcpu id allocation for spapr
>     * Numerous macio cleanupsr
>     * Some enhancements to the Spectre/Meltdown fixes for pseries,
>       allowing use of a better mitigation for indirect branch based
>       exploits
>     * New pseries machine types with Spectre/Meltdown mitigations
>       enabled (stop gap until libvirt and management understands the
>       machine options)
>     * A handful of other fixes
>

Applied, thanks.

-- PMM

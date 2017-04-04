Received: from eggs.gnu.org ([2001:4830:134:3::10]:39769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvJtv-0002Fx-2p
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvJtu-0007qO-1s
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:33:19 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvJtt-0007pc-Rn
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:33:17 -0400
Received: by mail-wr0-x230.google.com with SMTP id t20so25220913wra.1
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 01:33:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403221712.26304.98856.malonedeb@chaenomeles.canonical.com>
References: <20170403221712.26304.98856.malonedeb@chaenomeles.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 09:32:56 +0100
Message-ID: <CAFEAcA_R4MWGRtEzNdDfyaPQKE8iKKp6-yc0bJ7fy6EnN3ELZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1679358] [NEW] ARM: SCTLR fields not being
 preserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1679358 <1679358@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 April 2017 at 23:17, Yifan <yifanlu94@gmail.com> wrote:
> There are fields in SCTLR that are RAO/SBOP or WI or in the case of the
> RR field, accessible only in secure mode. Currently it seems that qemu
> just propagates any write to SCTLR to the register and this screwed up
> in a bootloader that I am debugging.

Yes, we're a bit loose in QEMU on the handling of reserved bits.

Note that most of the SCTLR bits like this are RAO/SBOP or RAZ/SBZP,
so the guest should not be writing wrong values to them.

thanks
-- PMM

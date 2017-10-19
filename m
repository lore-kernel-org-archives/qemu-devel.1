Received: from eggs.gnu.org ([2001:4830:134:3::10]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5FP8-0003zH-Os
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5FP7-00022w-RD
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:18:50 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:49102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5FP7-00022Y-KQ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:18:49 -0400
Received: by mail-wr0-x22b.google.com with SMTP id u5so9233278wrc.5
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 11:18:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019071036.GB20805@kentang.lan>
References: <20171019071036.GB20805@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 19:18:27 +0100
Message-ID: <CAFEAcA_KWLxNKSr3cDDoQE2JPaKm8L4MCKRDJYri4THpqjbBdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] Update OpenBIOS images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2017 at 08:10, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here are the latest set of updates for OpenBIOS which should be pulled after the sun4u
> patches have been applied due to breaking changes in the sun4u machine.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 861cd431c99e56ddb5953ca1da164a9c32b477ca:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171017' into staging (2017-10-17 15:26:51 +0100)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-openbios-signed
>
> for you to fetch changes up to 08e2c1854d8bc32b3b6fcefbead0ea808c44cbc8:
>
>   Update OpenBIOS images to 83818bd built from submodule. (2017-10-19 08:04:15 +0100)
>
> ----------------------------------------------------------------
> Update OpenBIOS images
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to 83818bd built from submodule.
>
>  pc-bios/openbios-ppc     |  Bin 754936 -> 754936 bytes
>  pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
>  pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
>  roms/openbios            |    2 +-

This fails to merge, because your other pullreq also
updated pc-bios/openbios-sparc64 and git can't automatically
resolve merge conflicts between binary files.

If you tell me which version of the binary to prefer I can
fix it up by hand in the merge commit I guess.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faNst-0005W1-Tw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faNss-0005HG-LE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:10:31 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faNss-0005Gt-9p
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:10:30 -0400
Received: by mail-oi0-x241.google.com with SMTP id r16-v6so4917473oie.3
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 09:10:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703135003.7485-1-shorne@gmail.com>
References: <20180703135003.7485-1-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 17:10:09 +0100
Message-ID: <CAFEAcA8-Ajhy8a8n0YU5Ta_N-8LZC2PN3TOvbj=cp4QhnB3xsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/25] OpenRISC updates for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>

On 3 July 2018 at 14:50, Stafford Horne <shorne@gmail.com> wrote:
> Hello Peter,
>
> Trying again to send this series, just one difference here so just sending the
> single patch.
>
> Changes since v2:
>  - Use PAGE_ instead of PROT_ flags in MMU patches to fix windows build.
>
>
> Please consider for pull:
>
> The following changes since commit 646f34fa5482e495483de230b4cf0f2ae4fd2781:
>
>   tcg: Fix --disable-tcg build breakage (2018-07-02 13:42:05 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:stffrdhrn/qemu.git tags/pull-or-20180703
>
> for you to fetch changes up to dfc84745bbaa0fea2abc8575dd349f6e4bb7edc7:
>
>   target/openrisc: Fix writes to interrupt mask register (2018-07-03 22:40:33 +0900)
>
> ----------------------------------------------------------------
> OpenRISC cleanups and Fixes for QEMU 3.0
>
> Mostly patches from Richard Henderson fixing multiple things:
>  * Fix singlestepping in GDB.
>  * Use more TB linking.
>  * Fixes to exit TB after updating SPRs to enable registering of state
>    changes.
>  * Significant optimizations and refactors to the TLB
>  * Split out disassembly from translation.
>  * Add qemu-or1k to qemu-binfmt-conf.sh.
>  * Implement signal handling for linux-user.
>
> Then there are a few fixups from me:
>  * Fix delay slot detections to match hardware, this was masking a bug
>    in the linus kernel.
>  * Fix stores to the PIC mask register

Applied, thanks.

-- PMM

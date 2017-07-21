Received: from eggs.gnu.org ([2001:4830:134:3::10]:34320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYXgA-0004dT-7M
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYXg9-0001QH-20
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:09:14 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:37006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYXg8-0001Pz-RW
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:09:12 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 33so25742214wrz.4
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:09:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
References: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 14:08:51 +0100
Message-ID: <CAFEAcA-rOyqHWFYMitBy20mJRsB_4k0zM13Yx67Mb0N9CJAwKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 July 2017 at 03:37, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> The following changes since commit 25d0233c1ac6cd14a15fcc834f1de3b179037b1d:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20170720-pull-request' into staging (2017-07-20 16:40:01 +0100)
>
> are available in the git repository at:
>
>   git://github.com/yongbok/upstream-qemu.git tags/mips-20170721
>
> for you to fetch changes up to bad63a8008a0aaefcd00542c89bee01623d7c9de:
>
>   target/mips: Enable CP0_EBase.WG on MIPS64 CPUs (2017-07-21 03:23:44 +0100)
>
> ----------------------------------------------------------------
> MIPS patches 2017-07-21
>
> Changes:
> * Add Enhanced Virtual Addressing (EVA) support
>
> ----------------------------------------------------------------
>
>
> James Hogan (14):
>   target/mips: Fix MIPS64 MFC0 UserLocal on BE host
>   target/mips: Fix TLBWI shadow flush for EHINV,XI,RI
>   target/mips: Weaken TLB flush on UX,SX,KX,ASID changes
>   target/mips: Add CP0_Ebase.WG (write gate) support
>   target/mips: Prepare loads/stores for EVA
>   target/mips: Decode MIPS32 EVA load & store instructions
>   target/mips: Decode microMIPS EVA load & store instructions
>   target/mips: Check memory permissions with mem_idx
>   target/mips: Abstract mmu_idx from hflags
>   target/mips: Add an MMU mode for ERL
>   target/mips: Add segmentation control registers
>   target/mips: Implement segmentation control
>   target/mips: Add EVA support to P5600
>   target/mips: Enable CP0_EBase.WG on MIPS64 CPUs
>

Applied, thanks.

-- PMM

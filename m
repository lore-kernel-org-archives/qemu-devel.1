Received: from eggs.gnu.org ([2001:4830:134:3::10]:46190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewXzy-0006tA-0S
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewXzx-0005en-7e
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:53:10 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewXzx-0005eW-2I
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:53:09 -0400
Received: by mail-ot0-x244.google.com with SMTP id t2-v6so7946195otj.4
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 11:53:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 18:52:47 +0000
Message-ID: <CAFEAcA9P9NPr41mDpfQLA3SumpM2k_2R0BX_eb3kOQdYWeED8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] Linux user for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 13 March 2018 at 17:33, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit b39b61e410022f96ceb53d4381d25cba5126ac44:
>
>   memory: fix flatview_access_valid RCU read lock/unlock imbalance (2018-03-09 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request
>
> for you to fetch changes up to 8c17d862b3cefed23a62c4e09d4b3f1f04a38631:
>
>   linux-user: init_guest_space: Add a comment about search strategy (2018-03-13 15:04:01 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Laurent Vivier (1):
>   linux-user: allows to use "--systemd ALL" with qemu-binfmt-conf.sh
>
> Luke Shumaker (9):
>   linux-user: Use #if to only call validate_guest_space for 32-bit ARM
>     target
>   linux-user: Rename validate_guest_space => init_guest_commpage
>   linux-user: init_guest_space: Clean up if we can't initialize the
>     commpage
>   linux-user: init_guest_space: Correctly handle guest_start in commpage
>     initialization
>   linux-user: init_guest_space: Clarify page alignment logic
>   linux-user: init_guest_commpage: Add a comment about size check
>   linux-user: init_guest_space: Clean up control flow a bit
>   linux-user: init_guest_space: Don't try to align if we'll reject it
>   linux-user: init_guest_space: Add a comment about search strategy
>
> Max Filippov (5):
>   linux-user: fix mmap/munmap/mprotect/mremap/shmat
>   linux-user: fix assertion in shmdt
>   linux-user: fix target_mprotect/target_munmap error return values
>   linux-user: drop unused target_msync function
>   qemu-binfmt-conf.sh: add qemu-xtensa
>
> Peter Maydell (2):
>   linux-user: Drop unicore32 code
>   linux-user: Remove the unused "not implemented" signal handling stubs
>
> Shea Levy (1):
>   linux-user: Support f_flags in statfs when available.

Applied, thanks.

-- PMM

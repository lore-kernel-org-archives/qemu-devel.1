Received: from eggs.gnu.org ([2001:4830:134:3::10]:41372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO5o-0002od-V3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO5k-0000Gg-3v
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:54:17 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euO5j-0000Fv-PN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:54:12 -0500
References: <20180308144733.25615-1-peter.maydell@linaro.org>
	<20180308144733.25615-2-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7b4433a5-7c9f-56b4-19f2-c048509ed6b3@vivier.eu>
Date: Fri, 9 Mar 2018 20:53:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180308144733.25615-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: Drop unicore32 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Riku Voipio <riku.voipio@iki.fi>, patches@linaro.org

Le 08/03/2018 à 15:47, Peter Maydell a écrit :
> We dropped the unicore32-linux-user target in commit 5e2b40f7271cf9
> in 2016. Nobody has made any attempt to fix the issues that
> caused us to drop it, so remove the associated code.
> (The system emulation parts of unicore32 remain.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/qemu.h                     |   5 +-
>  linux-user/syscall_defs.h             |   6 +-
>  linux-user/unicore32/syscall_nr.h     | 371 ----------------------------------
>  linux-user/unicore32/target_cpu.h     |  27 ---
>  linux-user/unicore32/target_elf.h     |  14 --
>  linux-user/unicore32/target_signal.h  |  30 ---
>  linux-user/unicore32/target_structs.h |  58 ------
>  linux-user/unicore32/target_syscall.h |  62 ------
>  linux-user/unicore32/termbits.h       |   2 -
>  linux-user/elfload.c                  |  72 -------
>  linux-user/main.c                     |  99 +--------
>  linux-user/signal.c                   |   5 +-
>  12 files changed, 6 insertions(+), 745 deletions(-)
>  delete mode 100644 linux-user/unicore32/syscall_nr.h
>  delete mode 100644 linux-user/unicore32/target_cpu.h
>  delete mode 100644 linux-user/unicore32/target_elf.h
>  delete mode 100644 linux-user/unicore32/target_signal.h
>  delete mode 100644 linux-user/unicore32/target_structs.h
>  delete mode 100644 linux-user/unicore32/target_syscall.h
>  delete mode 100644 linux-user/unicore32/termbits.h
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent

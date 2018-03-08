Received: from eggs.gnu.org ([2001:4830:134:3::10]:46561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1etxBc-0005DF-9e
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1etxBY-0003rh-Tw
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:10:28 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:56295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1etxBY-0003oN-JA
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:10:24 -0500
References: <20180308144733.25615-1-peter.maydell@linaro.org>
	<20180308144733.25615-2-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <fce7cfb1-9ab1-10b6-eb96-2488eb27da04@vivier.eu>
Date: Thu, 8 Mar 2018 16:10:06 +0100
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
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Guan Xuetao <gxt@mprc.pku.edu.cn>

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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

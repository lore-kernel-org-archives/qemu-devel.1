Received: from eggs.gnu.org ([2001:4830:134:3::10]:47815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJli-0000KL-Rd
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJlZ-0007sA-Ak
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:40:10 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:38307)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emJlZ-0007rV-13
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:40:01 -0500
References: <20180124211301.10095-1-laurent@vivier.eu>
	<20180124211301.10095-2-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7e22b0d7-7b5d-0554-cfdd-3cbe9fa51ed1@vivier.eu>
Date: Thu, 15 Feb 2018 14:39:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180124211301.10095-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/4] linux-user: Move CPU type name
 selection to a function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Aaron Sierra <asierra@xes-inc.com>

Le 24/01/2018 à 22:12, Laurent Vivier a écrit :
> Instead of a sequence of "#if ... #endif" move the
> selection to a function in linux-user/*/target_elf.h
> 
> We can't add them in linux-user/*/target_cpu.h
> because we will need to include "elf.h" to
> use ELF flags with eflags, and including
> "elf.h" in "target_cpu.h" introduces some
> conflicts in elfload.c
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/aarch64/target_elf.h    | 14 +++++++++++++
>  linux-user/alpha/target_elf.h      | 14 +++++++++++++
>  linux-user/arm/target_elf.h        | 14 +++++++++++++
>  linux-user/cris/target_elf.h       | 14 +++++++++++++
>  linux-user/hppa/target_elf.h       | 14 +++++++++++++
>  linux-user/i386/target_elf.h       | 14 +++++++++++++
>  linux-user/m68k/target_elf.h       | 14 +++++++++++++
>  linux-user/main.c                  | 41 ++------------------------------------
>  linux-user/microblaze/target_elf.h | 14 +++++++++++++
>  linux-user/mips/target_elf.h       | 14 +++++++++++++
>  linux-user/mips64/target_elf.h     | 14 +++++++++++++
>  linux-user/nios2/target_elf.h      | 14 +++++++++++++
>  linux-user/openrisc/target_elf.h   | 14 +++++++++++++
>  linux-user/ppc/target_elf.h        | 18 +++++++++++++++++
>  linux-user/s390x/target_elf.h      | 14 +++++++++++++
>  linux-user/sh4/target_elf.h        | 14 +++++++++++++
>  linux-user/sparc/target_elf.h      | 14 +++++++++++++
>  linux-user/sparc64/target_elf.h    | 14 +++++++++++++
>  linux-user/tilegx/target_elf.h     | 14 +++++++++++++
>  linux-user/unicore32/target_elf.h  | 14 +++++++++++++
>  linux-user/x86_64/target_elf.h     | 14 +++++++++++++
>  21 files changed, 286 insertions(+), 39 deletions(-)
>  create mode 100644 linux-user/aarch64/target_elf.h
>  create mode 100644 linux-user/alpha/target_elf.h
>  create mode 100644 linux-user/arm/target_elf.h
>  create mode 100644 linux-user/cris/target_elf.h
>  create mode 100644 linux-user/hppa/target_elf.h
>  create mode 100644 linux-user/i386/target_elf.h
>  create mode 100644 linux-user/m68k/target_elf.h
>  create mode 100644 linux-user/microblaze/target_elf.h
>  create mode 100644 linux-user/mips/target_elf.h
>  create mode 100644 linux-user/mips64/target_elf.h
>  create mode 100644 linux-user/nios2/target_elf.h
>  create mode 100644 linux-user/openrisc/target_elf.h
>  create mode 100644 linux-user/ppc/target_elf.h
>  create mode 100644 linux-user/s390x/target_elf.h
>  create mode 100644 linux-user/sh4/target_elf.h
>  create mode 100644 linux-user/sparc/target_elf.h
>  create mode 100644 linux-user/sparc64/target_elf.h
>  create mode 100644 linux-user/tilegx/target_elf.h
>  create mode 100644 linux-user/unicore32/target_elf.h
>  create mode 100644 linux-user/x86_64/target_elf.h
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent

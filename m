Received: from eggs.gnu.org ([2001:4830:134:3::10]:57771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f98CS-0003kG-Fj
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f98CP-00036w-DM
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:58:04 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:36606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f98CO-00033n-TT
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:58:01 -0400
References: <1524135103-30477-1-git-send-email-frederic.konrad@adacore.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <9551faef-173a-b232-5dfb-ca70bb8ef3fe@mail.uni-paderborn.de>
Date: Thu, 19 Apr 2018 13:57:55 +0200
MIME-Version: 1.0
In-Reply-To: <1524135103-30477-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] riscv: requires libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sagark@eecs.berkeley.edu, palmer@sifive.com, mjc@sifive.com

On 04/19/2018 12:51 PM, KONRAD Frederic wrote:
> When compiling on a machine without libfdt installed the configure script
> should try to get libfdt from the git or should die because otherwise
> CONFIG_LIBFDT is not set and the build process end in an error in the link
> phase.. eg:
> 
> hw/riscv/virt.o: In function `riscv_virt_board_init':
> qemu/src/hw/riscv/virt.c:317: undefined reference to `qemu_fdt_setprop_cell'
> qemu/src/hw/riscv/virt.c:319: undefined reference to `qemu_fdt_setprop_cell'
> qemu/src/hw/riscv/virt.c:345: undefined reference to `qemu_fdt_dumpdtb'
> collect2: error: ld returned 1 exit status
> make[1]: *** [qemu-system-riscv64] Error 1
> make: *** [subdir-riscv64-softmmu] Error 2
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1fB0zz-0001T6-1H
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1fB0zu-00053U-IG
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:40:59 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1fB0zu-00052a-BQ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:40:54 -0400
Received: by mail-pf0-x243.google.com with SMTP id o16so12719324pfk.9
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 09:40:54 -0700 (PDT)
Date: Tue, 24 Apr 2018 09:40:52 -0700 (PDT)
In-Reply-To: <20180424160329.8089-1-alex.bennee@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-b0d36032-c147-44ea-82ec-8ff808359cbf@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: set minimum uname for RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, alex.bennee@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu

On Tue, 24 Apr 2018 09:03:29 PDT (-0700), alex.bennee@linaro.org wrote:
> As support was merged into the mainline kernel at 4.15 it is unlikely
> 3.8.0 is the correct value. Indeed when I testing binaries created by
> the current Debian SID compiler the tests failed with:
>
>   FATAL: kernel too old
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/riscv/target_syscall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
> index d4e109a27f..ee81d8bc88 100644
> --- a/linux-user/riscv/target_syscall.h
> +++ b/linux-user/riscv/target_syscall.h
> @@ -45,7 +45,7 @@ struct target_pt_regs {
>  #else
>  #define UNAME_MACHINE "riscv64"
>  #endif
> -#define UNAME_MINIMUM_RELEASE "3.8.0"
> +#define UNAME_MINIMUM_RELEASE "4.15.0"
>
>  #define TARGET_MINSIGSTKSZ 2048
>  #define TARGET_MLOCKALL_MCL_CURRENT 1

If I understand this correctly, this will make host kernels older than 4.15.0 
look like 4.15.0 when a program running in user-mode emulation on a RISC-V 
system?  I think that's the correct thing to do, so if that's the case then 
feel free to add a

    Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

if that helps any.

Thanks!

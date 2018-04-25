Received: from eggs.gnu.org ([2001:4830:134:3::10]:43905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBKcW-0000Xr-Ub
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBKcS-0001r0-VS
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:38:04 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBKcS-0001qi-Pk
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:38:00 -0400
Received: by mail-qk0-x241.google.com with SMTP id b39so22591108qkb.5
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 06:38:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180425100218.24785-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cff9bcd8-b0dc-d731-1278-947886f2c251@amsat.org>
Date: Wed, 25 Apr 2018 10:37:56 -0300
MIME-Version: 1.0
In-Reply-To: <20180425100218.24785-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: set minimum uname for RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 04/25/2018 07:02 AM, Alex Bennée wrote:
> As support for RISC-V was only merged into the mainline kernel at 4.15
> it is unlikely that glibc will be happy with a reported kernel version
> of 3.8.0. Indeed when I testing binaries created by the current Debian
> Sid compiler the tests failed with:
> 
>   FATAL: kernel too old
> 
> Bump the version to the minimum a RISC-V glibc would expect:
> 
>   https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/riscv/configure.ac

This link point to the last version which might change over time, can we
use instead the full link Peter suggested?

https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/riscv/configure.ac;h=4fae013ec91451370a6d14b15b7e6d37fcd669af;hb=HEAD

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> v2
>   - minor tweak to wording to make clearer and add link to glibc config
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
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGZfk-0006zB-5e
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGZfh-0000H4-46
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:43:04 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:45610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGZfg-0000Gu-Ul
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:43:01 -0400
Received: by mail-qk0-x244.google.com with SMTP id c64-v6so298289qkf.12
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 17:43:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180509231123.20864-1-laurent@vivier.eu>
	<20180509231123.20864-7-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b5ddfc9c-d25a-6878-d406-553be158f69c@amsat.org>
Date: Wed, 9 May 2018 21:42:56 -0300
MIME-Version: 1.0
In-Reply-To: <20180509231123.20864-7-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] linux-user: fix UNAME_MACHINE for
 sparc/sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>

On 05/09/2018 08:11 PM, Laurent Vivier wrote:
> "sun4" is not recognized by config.guess.
> linux defines sparc and sparc64 in arch/sparc/Makefile.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/sparc/target_syscall.h   | 2 +-
>  linux-user/sparc64/target_syscall.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
> index 3725875fcf..b9160a771b 100644
> --- a/linux-user/sparc/target_syscall.h
> +++ b/linux-user/sparc/target_syscall.h
> @@ -11,7 +11,7 @@ struct target_pt_regs {
>  	abi_ulong u_regs[16];
>  };
>  
> -#define UNAME_MACHINE "sun4"
> +#define UNAME_MACHINE "sparc"
>  #define UNAME_MINIMUM_RELEASE "2.6.32"
>  
>  /* SPARC kernels don't define this in their Kconfig, but they have the
> diff --git a/linux-user/sparc64/target_syscall.h b/linux-user/sparc64/target_syscall.h
> index 34f49df4a1..3073a23e03 100644
> --- a/linux-user/sparc64/target_syscall.h
> +++ b/linux-user/sparc64/target_syscall.h
> @@ -12,7 +12,7 @@ struct target_pt_regs {
>  	abi_ulong fprs;
>  };
>  
> -#define UNAME_MACHINE "sun4u"
> +#define UNAME_MACHINE "sparc64"
>  #define UNAME_MINIMUM_RELEASE "2.6.32"
>  
>  /* SPARC kernels don't define this in their Kconfig, but they have the
> 

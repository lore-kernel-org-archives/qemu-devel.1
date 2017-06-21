Received: from eggs.gnu.org ([2001:4830:134:3::10]:58710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNo3A-0003aw-LJ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNo37-0005dy-PK
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:24:36 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNo37-0005dd-Jw
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:24:33 -0400
Received: by mail-qt0-x242.google.com with SMTP id x58so29272929qtc.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 15:24:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-14-git-send-email-yang.zhong@intel.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f43b3405-c7c8-a3e0-1b36-fea3e42b447f@twiddle.net>
Date: Wed, 21 Jun 2017 15:24:29 -0700
MIME-Version: 1.0
In-Reply-To: <1498040401-16361-14-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/15] tcg: disable tcg in CPUX86State
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On 06/21/2017 03:19 AM, Yang Zhong wrote:
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -52,7 +52,9 @@
>   
>   #include "exec/cpu-defs.h"
>   
> +#ifdef CONFIG_TCG
>   #include "fpu/softfloat.h"
> +#endif
>   
>   #define R_EAX 0
>   #define R_ECX 1
> @@ -1130,8 +1132,9 @@ typedef struct CPUX86State {
>   
>       /* Fields up to this point are cleared by a CPU reset */
>       struct {} end_reset_fields;
> -
> +#ifdef CONFIG_TCG
>       CPU_COMMON
> +#endif

This is at the wrong level.  If !CONFIG_TCG, then CPU_COMMON should be empty.


r~

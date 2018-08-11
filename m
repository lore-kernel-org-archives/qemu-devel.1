Received: from eggs.gnu.org ([2001:4830:134:3::10]:38068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1foJqP-00046S-OM
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 22:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1foJqL-0002v1-RH
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 22:41:33 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1foJqL-0002u5-KF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 22:41:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id a11-v6so5173657pgw.6
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 19:41:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180810222502.19663-1-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0c363042-274c-a713-3c3b-69cb4906dec2@twiddle.net>
Date: Fri, 10 Aug 2018 19:41:26 -0700
MIME-Version: 1.0
In-Reply-To: <20180810222502.19663-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sh4: fix use_icount with linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Aurelien Jarno <aurelien@aurel32.net>

On 08/10/2018 03:25 PM, Laurent Vivier wrote:
> +++ b/target/sh4/translate.c
> @@ -253,7 +253,6 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
>              tcg_gen_lookup_and_goto_ptr();
>          }
>      }
> -    ctx->base.is_jmp = DISAS_NORETURN;
>  }
>  

Looking at the other places gen_goto_tb is used,
this doesn't look right.

Based on the description, I expected a modification in
gen_conditional_jump, much like the one you remove here:

> @@ -324,7 +323,6 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
>          gen_jump(ctx);
>  
>          gen_set_label(l1);
> -        ctx->base.is_jmp = DISAS_NEXT;
>          return;
>      }
>  


r~

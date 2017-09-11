Received: from eggs.gnu.org ([2001:4830:134:3::10]:59542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drTD2-00061p-1i
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drTCy-0001G6-RI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:13:24 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drTCy-0001Ev-Ml
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:13:20 -0400
Received: by mail-qk0-x243.google.com with SMTP id c69so5878625qke.5
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:13:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170911022839.23231-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <da50f354-35ad-5ddc-2890-58fc6d9fbe64@amsat.org>
Date: Mon, 11 Sep 2017 15:13:14 -0300
MIME-Version: 1.0
In-Reply-To: <20170911022839.23231-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org

On 09/10/2017 11:28 PM, Philippe Mathieu-Daudé wrote:
> changed in 659ef5cbb893, this fixes building with --enable-tcg-interpreter:
> 
> /home/travis/build/qemu/qemu/tcg/tcg.c:116:14: error: ‘tcg_out_ldst_finalize’ used but never defined [-Werror]
>   static bool tcg_out_ldst_finalize(TCGContext *s);
>                ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I'm not sure I can sign for Jincheng, but since his patch has the same 
content you could add:

Signed-off-by: Jincheng Miao <jincheng.miao@gmail.com>

(https://patchwork.kernel.org/patch/9947709/)

> ---
> see https://travis-ci.org/qemu/qemu/jobs/273351287
> 
>   tcg/tci/tcg-target.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
> index 5d692e1f4b..26140d78cb 100644
> --- a/tcg/tci/tcg-target.h
> +++ b/tcg/tci/tcg-target.h
> @@ -206,8 +206,4 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
>       /* no need to flush icache explicitly */
>   }
>   
> -#ifdef CONFIG_SOFTMMU
> -#define TCG_TARGET_NEED_LDST_LABELS
> -#endif
> -
>   #endif /* TCG_TARGET_H */
> 

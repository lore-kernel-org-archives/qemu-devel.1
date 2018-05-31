Received: from eggs.gnu.org ([2001:4830:134:3::10]:40285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOIp4-0004be-9O
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOIp1-0001oK-3w
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:20:38 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fOIp0-0001nn-Qg
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:20:35 -0400
References: <20180531041822.5761-1-richard.henderson@linaro.org>
	<20180531041822.5761-3-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <dedf7afe-fc28-073c-d700-363321fda451@vivier.eu>
Date: Thu, 31 May 2018 10:20:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180531041822.5761-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Fix struct sigaltstack for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shorne@gmail.com

Le 31/05/2018 à 06:18, Richard Henderson a écrit :
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/openrisc/target_signal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
> index 2a4e00b035..901097972a 100644
> --- a/linux-user/openrisc/target_signal.h
> +++ b/linux-user/openrisc/target_signal.h
> @@ -7,8 +7,8 @@
>  
>  typedef struct target_sigaltstack {
>      abi_long ss_sp;
> +    abi_int ss_flags;
>      abi_ulong ss_size;
> -    abi_long ss_flags;
>  } target_stack_t;
>  
>  /* sigaltstack controls  */
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

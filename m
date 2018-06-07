Received: from eggs.gnu.org ([2001:4830:134:3::10]:33833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR0ZX-0007qT-7z
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR0ZS-0004xS-H4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:27:47 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR0ZS-0004uM-CN
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:27:42 -0400
Received: by mail-qt0-x244.google.com with SMTP id i18-v6so11051324qtp.12
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 12:27:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180607184844.30126-1-richard.henderson@linaro.org>
	<20180607184844.30126-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2602ee2d-d930-53c7-c0f0-e88505322adc@amsat.org>
Date: Thu, 7 Jun 2018 16:27:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180607184844.30126-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] linux-user/hppa: Fix typo in mknodat
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu

On 06/07/2018 03:48 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

mknodat is not at 8ee78dece0d.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/hppa/syscall_nr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/hppa/syscall_nr.h b/linux-user/hppa/syscall_nr.h
> index 55bdf71d50..9c1d0a195d 100644
> --- a/linux-user/hppa/syscall_nr.h
> +++ b/linux-user/hppa/syscall_nr.h
> @@ -279,7 +279,7 @@
>  #define TARGET_NR_ppoll             274
>  #define TARGET_NR_openat            275
>  #define TARGET_NR_mkdirat           276
> -#define TARGET_NR_mknotat           277
> +#define TARGET_NR_mknodat           277
>  #define TARGET_NR_fchownat          278
>  #define TARGET_NR_futimesat         279
>  #define TARGET_NR_fstatat64         280
> 

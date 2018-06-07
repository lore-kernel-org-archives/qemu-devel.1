Received: from eggs.gnu.org ([2001:4830:134:3::10]:34066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR0bC-0000DA-Mh
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR0b7-0006zR-Vn
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:29:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR0b7-0006wl-Qr
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:29:25 -0400
Received: by mail-qt0-x242.google.com with SMTP id y20-v6so11076016qto.8
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 12:29:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180607184844.30126-1-richard.henderson@linaro.org>
	<20180607184844.30126-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd5bcefe-be9d-95ba-3f1f-e48c4b2cbc3d@amsat.org>
Date: Thu, 7 Jun 2018 16:29:22 -0300
MIME-Version: 1.0
In-Reply-To: <20180607184844.30126-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] linux-user/microblaze: Fix typo in
 accept4 syscall
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

04 since '09: 8dfbe4e839e.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/microblaze/syscall_nr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/microblaze/syscall_nr.h b/linux-user/microblaze/syscall_nr.h
> index 0704449bae..761208e9e6 100644
> --- a/linux-user/microblaze/syscall_nr.h
> +++ b/linux-user/microblaze/syscall_nr.h
> @@ -363,7 +363,7 @@
>  #define TARGET_NR_shutdown		359 /* new */
>  #define TARGET_NR_sendmsg		360 /* new */
>  #define TARGET_NR_recvmsg		361 /* new */
> -#define TARGET_NR_accept04		362 /* new */
> +#define TARGET_NR_accept4		362 /* new */
>  #define TARGET_NR_preadv                363 /* new */
>  #define TARGET_NR_pwritev               364 /* new */
>  #define TARGET_NR_rt_tgsigqueueinfo     365 /* new */
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1H4-0007sD-9c
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1H1-0007fE-3Z
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:12:46 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:58481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fR1H0-0007V6-P7
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:12:42 -0400
References: <20180607184844.30126-1-richard.henderson@linaro.org>
	<20180607184844.30126-4-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6c6cd347-999a-286b-79f7-9243d5dd811f@vivier.eu>
Date: Thu, 7 Jun 2018 22:12:40 +0200
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

Le 07/06/2018 à 20:48, Richard Henderson a écrit :
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

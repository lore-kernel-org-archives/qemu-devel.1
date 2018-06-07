Received: from eggs.gnu.org ([2001:4830:134:3::10]:40418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1GU-0007cB-JX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1GR-0001eL-7l
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:12:10 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:44217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fR1GQ-0001TG-T7
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:12:07 -0400
References: <20180607184844.30126-1-richard.henderson@linaro.org>
	<20180607184844.30126-3-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <001faa77-753b-7e0b-6068-43912fd4f1c5@vivier.eu>
Date: Thu, 7 Jun 2018 22:12:03 +0200
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

Le 07/06/2018 à 20:48, Richard Henderson a écrit :
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

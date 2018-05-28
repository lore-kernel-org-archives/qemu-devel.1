Received: from eggs.gnu.org ([2001:4830:134:3::10]:50956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fNG67-00087O-5j
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fNG64-0007Zc-0z
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:13:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fNG63-0007Z6-TC
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:13:51 -0400
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-21-git-send-email-mst@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <09fa0eda-0494-e4e3-0c2e-6010b5861f52@redhat.com>
Date: Mon, 28 May 2018 13:13:49 +0200
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-21-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 20/20] arch_init: sort architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 05/25/18 18:48, Michael S. Tsirkin wrote:
> Sort alphabetically. Will help us see if anything is missing (e.g. tile
> is not there now).
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch_init.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch_init.c b/arch_init.c
> index 9597218..f4f3f61 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -52,14 +52,14 @@ int graphic_depth = 32;
>  #define QEMU_ARCH QEMU_ARCH_ARM
>  #elif defined(TARGET_CRIS)
>  #define QEMU_ARCH QEMU_ARCH_CRIS
> -#elif defined(TARGET_I386)
> -#define QEMU_ARCH QEMU_ARCH_I386
>  #elif defined(TARGET_HPPA)
>  #define QEMU_ARCH QEMU_ARCH_HPPA
> -#elif defined(TARGET_M68K)
> -#define QEMU_ARCH QEMU_ARCH_M68K
> +#elif defined(TARGET_I386)
> +#define QEMU_ARCH QEMU_ARCH_I386
>  #elif defined(TARGET_LM32)
>  #define QEMU_ARCH QEMU_ARCH_LM32
> +#elif defined(TARGET_M68K)
> +#define QEMU_ARCH QEMU_ARCH_M68K
>  #elif defined(TARGET_MICROBLAZE)
>  #define QEMU_ARCH QEMU_ARCH_MICROBLAZE
>  #elif defined(TARGET_MIPS)
> @@ -80,12 +80,12 @@ int graphic_depth = 32;
>  #define QEMU_ARCH QEMU_ARCH_SH4
>  #elif defined(TARGET_SPARC)
>  #define QEMU_ARCH QEMU_ARCH_SPARC
> -#elif defined(TARGET_XTENSA)
> -#define QEMU_ARCH QEMU_ARCH_XTENSA
> -#elif defined(TARGET_UNICORE32)
> -#define QEMU_ARCH QEMU_ARCH_UNICORE32
>  #elif defined(TARGET_TRICORE)
>  #define QEMU_ARCH QEMU_ARCH_TRICORE
> +#elif defined(TARGET_UNICORE32)
> +#define QEMU_ARCH QEMU_ARCH_UNICORE32
> +#elif defined(TARGET_XTENSA)
> +#define QEMU_ARCH QEMU_ARCH_XTENSA
>  #endif
>  
>  const uint32_t arch_type = QEMU_ARCH;
> 

I sorted the list from scratch, using some regexes to temporarily move
the #define's to the same lines as the #[el]if's. My results were
identical to those of this patch.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

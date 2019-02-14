Received: from eggs.gnu.org ([209.51.188.92]:54638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDKC-0001ms-EF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDGe-0003k2-PJ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:25:17 -0500
References: <20190212074840.13542-1-richard.henderson@linaro.org>
	<20190212074840.13542-3-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <eea1959f-5cac-515e-1d1b-eae2c66ffe55@vivier.eu>
Date: Thu, 14 Feb 2019 10:25:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190212074840.13542-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: Fix ELF_PLATFORM for
 aarch64_be-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

On 12/02/2019 08:48, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index d796d51ec6..5aa0628ae9 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -537,7 +537,11 @@ static const char *get_elf_platform(void)
>  
>  #define ELF_ARCH        EM_AARCH64
>  #define ELF_CLASS       ELFCLASS64
> -#define ELF_PLATFORM    "aarch64"
> +#ifdef TARGET_WORDS_BIGENDIAN
> +# define ELF_PLATFORM    "aarch64_be"
> +#else
> +# define ELF_PLATFORM    "aarch64"
> +#endif
>  
>  static inline void init_thread(struct target_pt_regs *regs,
>                                 struct image_info *infop)
> 

Applied to my linux-user branch.

Thanks,
Laurent

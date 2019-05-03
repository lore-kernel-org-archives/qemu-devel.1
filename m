Received: from eggs.gnu.org ([209.51.188.92]:34284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMOv4-0006zk-Qj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMOv3-00045H-NV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:31:30 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMOv3-00044x-HL
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:31:29 -0400
Received: by mail-pl1-x644.google.com with SMTP id w20so2024912plq.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 20:31:28 -0700 (PDT)
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003707.10185-1-driver1998@foxmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <46c2245c-3133-8335-226d-007b6e22c2f4@linaro.org>
Date: Thu, 2 May 2019 20:31:23 -0700
MIME-Version: 1.0
In-Reply-To: <20190503003707.10185-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] util/cacheinfo: Use uint64_t on
 LLP64 model to satisfy Windows ARM64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org

On 5/2/19 5:37 PM, Cao Jiaxi wrote:
> Windows ARM64 uses LLP64 model, which breaks current assumptions.
> 
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  util/cacheinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index 3cd080b83d..eebe1ce9c5 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>  static void arch_cache_info(int *isize, int *dsize)
>  {
>      if (*isize == 0 || *dsize == 0) {
> -        unsigned long ctr;
> +        uint64_t ctr;
>  
>          /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
>             but (at least under Linux) these are marked protected by the
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

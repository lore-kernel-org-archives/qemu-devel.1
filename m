Received: from eggs.gnu.org ([209.51.188.92]:33293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMU95-0003nD-NK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMU94-000600-ON
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:06:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMU94-0005zB-I4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:06:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id p21so6159001wmc.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:06:18 -0700 (PDT)
References: <20190503002258.9799-1-driver1998@foxmail.com>
	<20190503002930.9991-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d1f8690-518b-dd06-c7e1-b1d88b2d1f5d@redhat.com>
Date: Fri, 3 May 2019 11:06:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190503002930.9991-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 5/3/19 2:29 AM, Cao Jiaxi wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

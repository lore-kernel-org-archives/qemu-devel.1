Received: from eggs.gnu.org ([209.51.188.92]:41940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLLeC-0003Bj-BN
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLLeB-0002Xs-DR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:49:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLLeB-0002Xc-7g
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:49:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so19429462wrt.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 22:49:43 -0700 (PDT)
References: <20190429003322.22908-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d25baf06-1176-5cce-2ff1-3b5652e3ca27@redhat.com>
Date: Tue, 30 Apr 2019 07:49:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190429003322.22908-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] util/cacheinfo.c: Use uintptr_t
 instead of unsigned long in AArch64 arch_cache_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: driver1998 <driver1998@foxmail.com>, qemu-devel@nongnu.org

On 4/29/19 2:33 AM, driver1998 wrote:
> Windows ARM64 uses LLP64 model, which breaks current assumptions.
> 
> Signed-off-by: driver1998 <driver1998@foxmail.com>
> ---
>  util/cacheinfo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index 3cd080b83d..a815cb0722 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>  static void arch_cache_info(int *isize, int *dsize)
>  {
>      if (*isize == 0 || *dsize == 0) {
> -        unsigned long ctr;
> +        uintptr_t ctr;
>  
>          /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
>             but (at least under Linux) these are marked protected by the
> @@ -120,6 +120,8 @@ static void arch_cache_info(int *isize, int *dsize)
>          if (*dsize == 0) {
>              *dsize = 4 << ((ctr >> 16) & 0xf);
>          }
> +
> +        printf("%d %d\n", *isize, *dsize);

The patch looks correct (except your real name), but here you forgot to
remove this debugging code.

>      }
>  }
>  
> 

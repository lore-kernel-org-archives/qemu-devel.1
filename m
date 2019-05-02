Received: from eggs.gnu.org ([209.51.188.92]:45698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM73A-0004aT-M7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM738-00074V-TQ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hM738-00072L-94
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:26:38 -0400
References: <20190430181326.1314-1-driver1998@foxmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6e3335b8-a5ce-ef0a-bf24-08165d877a2a@redhat.com>
Date: Thu, 2 May 2019 10:26:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190430181326.1314-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] util/cacheinfo.c: Use uintptr_t
 instead of unsigned long in AArch64 arch_cache_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org

On 30/04/2019 20.13, Cao Jiaxi wrote:
> Windows ARM64 uses LLP64 model, which breaks current assumptions.
> 
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  util/cacheinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index 3cd080b83d..ce6f0dbf6a 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>  static void arch_cache_info(int *isize, int *dsize)
>  {
>      if (*isize == 0 || *dsize == 0) {
> -        unsigned long ctr;
> +        uintptr_t ctr;

Looking at the whole function, is uintptr_t really the right type to use
here? ctr does not seem to contain the value of a pointer variable, so
this looks wrong to me...
Do you get a compiler warning here? If so, how does it look like?
Anyway, I think it would be better to use a uint64_t or uint32_t type
here instead if possible?

 Thomas

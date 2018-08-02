Received: from eggs.gnu.org ([2001:4830:134:3::10]:54823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flFhD-0005MB-C8
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flFhC-00074F-Fb
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:39:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180801123111.3595-1-richard.henderson@linaro.org>
	<20180801123111.3595-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <72c08000-d0fa-1b02-a1f1-d0cb2c6d6566@amsat.org>
Date: Thu, 2 Aug 2018 12:39:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180801123111.3595-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/4] target/arm: Fix typo in
 helper_sve_movz_d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org

On 08/01/2018 09:31 AM, Richard Henderson wrote:
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 87594a8adb..c3cbec9cf5 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1042,7 +1042,7 @@ void HELPER(sve_movz_d)(void *vd, void *vn, void *vg, uint32_t desc)
>      uint64_t *d = vd, *n = vn;
>      uint8_t *pg = vg;
>      for (i = 0; i < opr_sz; i += 1) {
> -        d[i] = n[1] & -(uint64_t)(pg[H1(i)] & 1);
> +        d[i] = n[i] & -(uint64_t)(pg[H1(i)] & 1);

:)))

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      }
>  }
>  
> 

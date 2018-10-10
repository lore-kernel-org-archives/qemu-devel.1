Received: from eggs.gnu.org ([2001:4830:134:3::10]:37166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAGBr-00038i-2r
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAGBn-0007ug-UU
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:14:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAGBn-0007te-Mc
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:14:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so5759995wrt.1
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 08:14:19 -0700 (PDT)
References: <20181010144853.13005-1-cota@braap.org>
	<20181010144853.13005-3-cota@braap.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <56c5b32f-7a71-baff-49c9-f92c50f19ba5@redhat.com>
Date: Wed, 10 Oct 2018 17:14:17 +0200
MIME-Version: 1.0
In-Reply-To: <20181010144853.13005-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] tcg: fix use of uninitialized variable
 under CONFIG_PROFILER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

On 10/10/2018 16:48, Emilio G. Cota wrote:
> We forgot to initialize n in commit 15fa08f845 ("tcg: Dynamically
> allocate TCGOps", 2017-12-29).
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tcg/tcg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index f27b22bd3c..8f26916b99 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3430,7 +3430,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>  
>  #ifdef CONFIG_PROFILER
>      {
> -        int n;
> +        int n = 0;
>  
>          QTAILQ_FOREACH(op, &s->ops, link) {
>              n++;
> 

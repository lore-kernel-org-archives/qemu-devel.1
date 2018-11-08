Received: from eggs.gnu.org ([2001:4830:134:3::10]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKk5L-0006Km-Kx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKk2k-0000d4-2C
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:08:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKk2j-0000c4-Ko
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:08:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id z13-v6so18808194wrs.3
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 05:08:16 -0800 (PST)
References: <20181108125256.30986-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a7929a8-74d3-ed14-b284-f420afe824ea@redhat.com>
Date: Thu, 8 Nov 2018 14:08:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181108125256.30986-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tcg-op.h: Add multiple include guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 8/11/18 13:52, Peter Maydell wrote:
> The tcg-op.h header was missing the usual guard against multiple
> inclusion; add it.
> 
> (Spotted by lgtm.com's static analyzer.)

I'm pretty sure there are more occurences.

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   tcg/tcg-op.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 7513c1eb7c5..db4e9188f42 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -22,6 +22,9 @@
>    * THE SOFTWARE.
>    */
>   
> +#ifndef TCG_TCG_OP_H
> +#define TCG_TCG_OP_H
> +
>   #include "tcg.h"
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
> @@ -1267,3 +1270,5 @@ static inline void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a)
>   
>   #undef PTR
>   #undef NAT
> +
> +#endif /* TCG_TCG_OP_H */
> 

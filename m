Received: from eggs.gnu.org ([2001:4830:134:3::10]:41110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kPz-0005Gy-21
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kPy-0001M8-9R
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:58:03 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5kPy-0001Lm-3B
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:58:02 -0400
Received: by mail-pl0-x241.google.com with SMTP id 59-v6so6539180plc.13
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 20:58:01 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-9-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <997636a9-1458-331f-7802-0e351680520b@linaro.org>
Date: Tue, 10 Apr 2018 13:57:53 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-9-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/17] target/mips: use *ctx for
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 04/07/2018 04:19 AM, Emilio G. Cota wrote:
> No changes to the logic here; this is just to make the diff
> that follows easier to read.
> 
> While at it, remove the unnecessary 'struct' in
> 'struct TranslationBlock'.
> 
> Note that checkpatch complains with a false positive:
>   ERROR: space prohibited after that '&' (ctx:WxW)
>   #75: FILE: target/mips/translate.c:20220:
>   +    ctx->kscrexist = (env->CP0_Config4 >> CP0C4_KScrExist) & 0xff;
>                                                               ^
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/mips/translate.c | 166 ++++++++++++++++++++++++------------------------
>  1 file changed, 84 insertions(+), 82 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

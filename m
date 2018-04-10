Received: from eggs.gnu.org ([2001:4830:134:3::10]:43545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kUN-0007Zn-Of
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kUM-0003uu-SQ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:02:35 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5kUM-0003uZ-Lk
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:02:34 -0400
Received: by mail-pf0-x241.google.com with SMTP id p6so3585689pfn.4
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 21:02:34 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-10-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17a2a188-d577-09c3-2e09-975f3bb97380@linaro.org>
Date: Tue, 10 Apr 2018 14:02:27 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-10-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/17] target/mips: convert to
 TranslatorOps
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
> Notes:
> 
> - DISAS_TOO_MANY replaces the former "break" in the translation loop.
>   However, care must be taken not to overwrite a previous condition
>   in is_jmp; that's why in translate_insn we first check is_jmp and
>   return if it's != DISAS_NEXT.
> 
> - Added an assert in translate_insn, before exiting due to an exception,
>   to make sure that is_jmp is set to DISAS_EXCP (the exception generation
>   function always sets it.)
> 
> - Added an assert for the default case in is_jmp's switch.
> 
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/mips/translate.c | 227 ++++++++++++++++++++++++------------------------
>  1 file changed, 113 insertions(+), 114 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

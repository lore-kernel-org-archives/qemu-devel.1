Received: from eggs.gnu.org ([2001:4830:134:3::10]:32771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enr9z-0007cd-Di
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enr9v-0007Lq-HJ
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:31:35 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1enr9v-0007Kv-9j
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:31:31 -0500
Received: by mail-pl0-x241.google.com with SMTP id 31so6133567ple.9
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 11:31:30 -0800 (PST)
References: <1518751105-17211-1-git-send-email-cota@braap.org>
	<1518751105-17211-2-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f8f48954-e803-c8ba-9b84-5ebb68da006d@linaro.org>
Date: Mon, 19 Feb 2018 11:31:25 -0800
MIME-Version: 1.0
In-Reply-To: <1518751105-17211-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] translator: pass max_insns to tb_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 02/15/2018 07:18 PM, Emilio G. Cota wrote:
> sh4 will need it.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translator.c     | 2 +-
>  include/exec/translator.h  | 3 ++-
>  target/alpha/translate.c   | 3 ++-
>  target/arm/translate-a64.c | 4 +++-
>  target/arm/translate.c     | 4 +++-
>  target/hppa/translate.c    | 4 +++-
>  target/i386/translate.c    | 3 ++-
>  7 files changed, 16 insertions(+), 7 deletions(-)

There is another possibility, which is to move max_insns into DisasContextBase
where it can be modified.  This would allow the gusa sequence to be handled
differently as an instance of the translate_insn hook, which would allow a
breakpoint to be placed on the first insn of a gusa sequence.

I guess I don't have strong feelings either way.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

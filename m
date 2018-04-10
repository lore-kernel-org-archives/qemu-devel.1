Received: from eggs.gnu.org ([2001:4830:134:3::10]:51651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5jrj-0004fs-0B
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5jrh-0003PD-Rw
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:22:38 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5jrh-0003Om-M5
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:22:37 -0400
Received: by mail-pl0-x243.google.com with SMTP id x4-v6so6497313pln.7
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 20:22:37 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-5-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c2e2afb-a3f7-a688-29db-26f1a7b67e16@linaro.org>
Date: Tue, 10 Apr 2018 13:22:30 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-5-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/17] target/sparc: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 04/07/2018 04:19 AM, Emilio G. Cota wrote:
> Notes:
> 
> - pc and npc are left unmodified, since they can point to out-of-TB
>   jump targets.
> 
> - Got rid of last_pc in gen_intermediate_code(), using base.pc_next
>   instead. Only update pc_next (1) on a breakpoint (so that tb->size
>   includes the insn), and (2) after reading the current instruction
>   from memory. This allows us to use base.pc_next in the BP check,
>   which is what the translator loop does.
> 
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/sparc/translate.c | 92 +++++++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

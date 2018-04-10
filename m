Received: from eggs.gnu.org ([2001:4830:134:3::10]:58335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5koi-0002Xd-Tp
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5koi-0000oU-7N
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:23:36 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:35171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5koi-0000o3-0O
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:23:36 -0400
Received: by mail-pl0-x241.google.com with SMTP id 61-v6so6589404plb.2
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 21:23:35 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-15-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ffd33a52-6fd2-260f-0e00-ff6aafbe6d96@linaro.org>
Date: Tue, 10 Apr 2018 14:23:29 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-15-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/17] target/openrisc: convert to
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
Cc: Stafford Horne <shorne@gmail.com>

On 04/07/2018 04:19 AM, Emilio G. Cota wrote:
> Notes:
> 
> - Changed the num_insns test in insn_start to check for
>   dc->base.num_insns > 1, since when tb_start is first
>   called in a TB, base.num_insns is already set to 1.
> 
> - Removed DISAS_NEXT from the switch in tb_stop; use
>   DISAS_TOO_MANY instead.
> 
> - Added an assert_not_reached on tb_stop for DISAS_NEXT
>   and the default case.
> 
> - Merged the two separate log_target_disas calls into the
>   disas_log op.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/openrisc/translate.c | 163 +++++++++++++++++++++-----------------------
>  1 file changed, 79 insertions(+), 84 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

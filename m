Received: from eggs.gnu.org ([2001:4830:134:3::10]:55934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1emLKo-0000RY-KT
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1emLKm-0005Ls-U1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:20:30 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1518664462-2960-1-git-send-email-cota@braap.org>
	<1518664462-2960-4-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dd84965a-27cb-a9eb-418f-c36fea46cc93@twiddle.net>
Date: Thu, 15 Feb 2018 07:20:14 -0800
MIME-Version: 1.0
In-Reply-To: <1518664462-2960-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 02/14/2018 07:14 PM, Emilio G. Cota wrote:
> A few changes worth noting:
> 
> - Didn't migrate ctx->exception to DISAS_* since the exception field is
>   in many cases architecturally relevant.
> 
> - Moved the cross-page check from the end of translate_insn to tb_start.
> 
> - Removed the exit(1) after a TCG temp leak; changed the fprintf there to
>   qemu_log.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/ppc/translate.c | 329 +++++++++++++++++++++++++------------------------
>  1 file changed, 167 insertions(+), 162 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

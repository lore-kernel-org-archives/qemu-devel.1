Received: from eggs.gnu.org ([2001:4830:134:3::10]:36722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dpCYr-0005bA-K4
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dpCYk-0007DB-4P
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:02:33 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:38886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dpCYj-0007Bx-Tt
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:02:26 -0400
Received: by mail-wr0-x232.google.com with SMTP id 108so8192170wra.5
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 05:02:25 -0700 (PDT)
References: <20170829063313.10237-1-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170829063313.10237-1-bobby.prani@gmail.com>
Date: Tue, 05 Sep 2017 13:02:22 +0100
Message-ID: <87lgltmjzl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] target/arm: Remove stale comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org, rth@twiddle.net, pbonzini@redhat.com


Pranith Kumar <bobby.prani@gmail.com> writes:

> Update the comment which is not true since MTTCG.

What happened to the cover letter? We seem to have a mix of patches but
no summary of the overall outcome.

>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  target/arm/translate-a64.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 2200e25be0..f42b155d7d 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -2012,10 +2012,6 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
>      }
>      tcg_addr = read_cpu_reg_sp(s, rn, 1);
>
> -    /* Note that since TCG is single threaded load-acquire/store-release
> -     * semantics require no extra if (is_lasr) { ... } handling.
> -     */
> -
>      if (is_excl) {
>          if (!is_store) {
>              s->is_ldex = true;


--
Alex Bennée

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4BTX-0003xl-Vf
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4BTV-0008Ru-BE
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:22:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d4BTV-0008Rg-7T
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:22:41 -0400
Date: Fri, 28 Apr 2017 15:22:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170428192238.GA24988@flamenco>
References: <20170427120006.20564-1-rth@twiddle.net>
	<1493407045-24172-1-git-send-email-cota@braap.org>
	<1493407045-24172-2-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493407045-24172-2-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v5 + 1/2] target/aarch64: optimize
 cross-page direct jumps in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org

On Fri, Apr 28, 2017 at 15:17:24 -0400, Emilio G. Cota wrote:
> Perf numbers in next commit's log.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/arm/translate-a64.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 24de30d..5b691fc 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -373,8 +373,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
>          } else if (s->singlestep_enabled) {
>              gen_exception_internal(EXCP_DEBUG);
>          } else {
> -            tcg_gen_exit_tb(0);
> -            s->is_jmp = DISAS_TB_JUMP;

I'm not sure about removing this line though. Would it be better to leave it?
I can't see how TB_JUMP ends up doing anything in the rest of the file.

Thanks,

		E.

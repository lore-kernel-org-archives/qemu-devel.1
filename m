Received: from eggs.gnu.org ([2001:4830:134:3::10]:33890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1enrEu-0001Qh-0b
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1enrEq-0001M2-4x
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:36:40 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1enrEp-0001Lm-Uy
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:36:36 -0500
Received: by mail-pf0-x244.google.com with SMTP id i3so2527600pfe.5
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 11:36:35 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1518663946-2326-1-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <15810185-a5ba-0493-362f-f701e2427c80@twiddle.net>
Date: Mon, 19 Feb 2018 11:36:30 -0800
MIME-Version: 1.0
In-Reply-To: <1518663946-2326-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/hppa: use tb_cflags() to access
 tb->cflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 02/14/2018 07:05 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/hppa/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 6499b39..b4b74a8 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2075,7 +2075,7 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
>          /* FIXME: Respect PSW_S bit.  */
>          nullify_over(ctx);
>          tmp = dest_gpr(ctx, rt);
> -        if (ctx->base.tb->cflags & CF_USE_ICOUNT) {
> +        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {

Applied to tgt-hppa.  Thanks.


r~

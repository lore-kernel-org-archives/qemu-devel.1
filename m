Received: from eggs.gnu.org ([2001:4830:134:3::10]:37755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVGpn-0007i5-3R
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVGpj-0004mj-WB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:33:39 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVGpj-0004mG-PP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:33:35 -0400
Received: by mail-wr0-f178.google.com with SMTP id k67so31673237wrc.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 05:33:35 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-3-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-3-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 13:32:32 +0100
Message-ID: <87r2xl96ov.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/22] translate-all: remove redundant
 !tcg_enabled check in dump_exec_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> This check is redundant because it is already performed by the only
> caller of dump_exec_info -- the caller was updated by b7da97eef
> ("monitor: Check whether TCG is enabled before running the "info jit"
> code").
>
> Checking twice wouldn't necessarily be too bad, but here the check also
> returns with tb_lock held. So we can either do the check before tb_lock is
> acquired, or just get rid of it. Given that it is redundant, I am going
> for the latter option.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index dfb9f0d..f768681 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1851,11 +1851,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
>
>      tb_lock();
>
> -    if (!tcg_enabled()) {
> -        cpu_fprintf(f, "TCG not enabled\n");
> -        return;
> -    }
> -
>      target_code_size = 0;
>      max_target_code_size = 0;
>      cross_page = 0;


--
Alex Bennée

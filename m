Received: from eggs.gnu.org ([209.51.188.92]:55723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glg2n-00016Y-VZ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glg2m-00011f-Tx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:19:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glg2l-0000zv-8T
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:19:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so12050120wmc.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:19:33 -0800 (PST)
References: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1548097698-28951-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a2b64f84-686f-6290-9fc8-cee4b8fbf660@redhat.com>
Date: Mon, 21 Jan 2019 21:19:24 +0100
MIME-Version: 1.0
In-Reply-To: <1548097698-28951-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] target/mips: nanoMIPS: Remove
 duplicate macro definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 1/21/19 8:08 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Several macros were defined twice, with identical values.
> Remove duplicates.

"Previously added in 80845edf37b."

"This reverts commit 6bfa9f4c9cf24d6cfaaa227722e9cdcca1ad6fe9."

> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/translate.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 057aaf9..fb2c42c 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -18433,16 +18433,6 @@ static inline int decode_gpr_gpr4_zero(int r)
>  }
>  
>  
> -/* extraction utilities */
> -
> -#define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
> -#define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
> -#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
> -#define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
> -#define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
> -#define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
> -
> -
>  static void gen_adjust_sp(DisasContext *ctx, int u)
>  {
>      gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], u);
> 

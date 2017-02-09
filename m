Received: from eggs.gnu.org ([2001:4830:134:3::10]:44104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbhDz-00055N-Dl
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbhDw-0002Ct-9t
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:24:55 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbhDw-0002Cn-5P
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:24:52 -0500
Received: by mail-qt0-x242.google.com with SMTP id w20so25914002qtb.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 21:24:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170209045154.16868-1-rth@twiddle.net>
	<20170209045154.16868-16-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <88fcf75b-991a-6e1d-d1cf-1a1b4a7ba6b4@gmail.com>
Date: Thu, 9 Feb 2017 02:24:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170209045154.16868-16-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 15/22] target/openrisc: Enable trap, csync,
 msync, psync for user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, shorne@gmail.com

On 02/09/2017 01:51 AM, Richard Henderson wrote:
> Not documented as disabled for user mode.
>
> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/translate.c | 32 --------------------------------
>  1 file changed, 32 deletions(-)
>
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index f91ab6a..6c8f05c 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -1134,52 +1134,20 @@ static void dec_sys(DisasContext *dc, uint32_t insn)
>
>      case 0x100:    /* l.trap */
>          LOG_DIS("l.trap %d\n", K16);
> -#if defined(CONFIG_USER_ONLY)
> -        return;
> -#else
> -        if (dc->mem_idx == MMU_USER_IDX) {
> -            gen_illegal_exception(dc);
> -            return;
> -        }
>          tcg_gen_movi_tl(cpu_pc, dc->pc);
>          gen_exception(dc, EXCP_TRAP);
> -#endif
>          break;
>
>      case 0x300:    /* l.csync */
>          LOG_DIS("l.csync\n");
> -#if defined(CONFIG_USER_ONLY)
> -        return;
> -#else
> -        if (dc->mem_idx == MMU_USER_IDX) {
> -            gen_illegal_exception(dc);
> -            return;
> -        }
> -#endif
>          break;
>
>      case 0x200:    /* l.msync */
>          LOG_DIS("l.msync\n");
> -#if defined(CONFIG_USER_ONLY)
> -        return;
> -#else
> -        if (dc->mem_idx == MMU_USER_IDX) {
> -            gen_illegal_exception(dc);
> -            return;
> -        }
> -#endif
>          break;
>
>      case 0x270:    /* l.psync */
>          LOG_DIS("l.psync\n");
> -#if defined(CONFIG_USER_ONLY)
> -        return;
> -#else
> -        if (dc->mem_idx == MMU_USER_IDX) {
> -            gen_illegal_exception(dc);
> -            return;
> -        }
> -#endif
>          break;
>
>      default:
>

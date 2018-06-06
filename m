Received: from eggs.gnu.org ([2001:4830:134:3::10]:40492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQaKC-0000bh-5S
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQaK6-0006l3-8q
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:26:12 -0400
References: <20180606152128.449-1-f4bug@amsat.org>
	<20180606152128.449-10-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9fcb3ccc-f703-de2d-7072-3bab2e37e3b0@vivier.eu>
Date: Wed, 6 Jun 2018 17:26:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180606152128.449-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/11] target/m68k: Add trailing '\n' to
 qemu_log() call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 06/06/2018 à 17:21, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/m68k/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 37d6ffd853..4b5dbdb51c 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -1556,7 +1556,7 @@ DISAS_INSN(undef)
>      /* ??? This is both instructions that are as yet unimplemented
>         for the 680x0 series, as well as those that are implemented
>         but actually illegal for CPU32 or pre-68020.  */
> -    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x",
> +    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x\n",
>                    insn, s->insn_pc);
>      gen_exception(s, s->insn_pc, EXCP_UNSUPPORTED);
>  }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

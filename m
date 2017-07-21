Received: from eggs.gnu.org ([2001:4830:134:3::10]:52825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgWK-0003jv-AB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgWH-0007AL-73
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:35:40 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:46717)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgWG-0007A2-RR
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:35:37 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-4-rth@twiddle.net>
Date: Sat, 22 Jul 2017 01:35:26 +0300
In-Reply-To: <20170715094243.28371-4-rth@twiddle.net> (Richard Henderson's
	message of "Fri, 14 Jul 2017 23:42:12 -1000")
Message-ID: <87tw25ifkh.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v14 03/34] target/i386: Use generic DISAS_*
 enumerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com

Richard Henderson writes:

> This target is not sophisticated in its use of cleanups at the
> end of the translation loop.  For the most part, any condition
> that exits the TB is dealt with by emitting the exiting opcode
> right then and there.  Therefore the only is_jmp indicator that
> is needed is DISAS_NORETURN.

> For two stack segment modifying cases, we have not yet exited
> the TB (therefore DISAS_NORETURN feels wrong), but intend to exit.
> The caller of gen_movl_seg_T0 currently checks for any non-zero
> value, therefore DISAS_TOO_MANY seems acceptable for that usage.

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/i386/translate.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)

> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index cab9e32..3ffbf1b 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -31,6 +31,7 @@
>  #include "trace-tcg.h"
>  #include "exec/log.h"
 
> +#define DISAS_TOO_MANY 5

Why is this one not added as a generic define too (like DISAS_NORETURN in prev
patch)?


Thanks,
  Lluis

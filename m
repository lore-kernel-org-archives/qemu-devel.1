Received: from eggs.gnu.org ([2001:4830:134:3::10]:52307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgTt-0002LN-NZ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgTq-00066g-LC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:33:09 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:46697)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYgTq-000656-86
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:33:06 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-3-rth@twiddle.net>
Date: Sat, 22 Jul 2017 01:32:52 +0300
In-Reply-To: <20170715094243.28371-3-rth@twiddle.net> (Richard Henderson's
	message of "Fri, 14 Jul 2017 23:42:11 -1000")
Message-ID: <87zibxifor.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v14 02/34] tcg: Add generic DISAS_NORETURN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

Richard Henderson writes:

> This will allow some amount of cleanup to happen before
> switching the backends over to enum DisasJumpType.

> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>


> ---
>  include/exec/exec-all.h | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 48d9d11..6760078 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -40,6 +40,7 @@ typedef ram_addr_t tb_page_addr_t;
>  #define DISAS_JUMP    1 /* only pc was modified dynamically */
>  #define DISAS_UPDATE  2 /* cpu state was modified dynamically */
>  #define DISAS_TB_JUMP 3 /* only pc was modified statically */
> +#define DISAS_NORETURN 4 /* the tb has already been exited */
=20
>  #include "qemu/log.h"
=20
> --=20
> 2.9.4

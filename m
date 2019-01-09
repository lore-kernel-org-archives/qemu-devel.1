Received: from eggs.gnu.org ([209.51.188.92]:33101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAtg-0005M8-V6
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAtg-0005bO-5W
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:15:40 -0500
References: <5c2e6965.1c69fb81.b832c.13ee@mx.google.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2c434536-6388-563f-344b-c6800769a733@vivier.eu>
Date: Wed, 9 Jan 2019 11:15:26 +0100
MIME-Version: 1.0
In-Reply-To: <5c2e6965.1c69fb81.b832c.13ee@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] Whitespace cleanup:
 target/ppc/translate_init.inc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jon Diekema <jon.diekema@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Cc: qemu-trivial@nongnu.org

Hi Jon,

please cc: qemu-devel and MAINTAINERS when you send a patch.

You can have the list of maintainers using a script in qemu directory:

   ./scripts/get_maintainer.pl XXXX.patch

Thanks,
Laurent

On 03/01/2019 20:58, Jon Diekema wrote:
> From: Jon Diekema <jon.diekema@gmail.com>
> Date: Tue, 25 Dec 2018 04:03:04 -0500
> Subject: Whitespace cleanup: target/ppc/translate_init.inc.c
> 
> Signed-off-by: Jon Diekema <jon.diekema@gmail.com>
> ---
>  target/ppc/translate_init.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index c971a5faf7..b5f4c9bd55 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -5237,7 +5237,7 @@ static void init_proc_601(CPUPPCState *env)
>                   0x00000000);
>      /* Memory management */
>      init_excp_601(env);
> -    /* XXX: beware that dcache line size is 64 
> +    /* XXX: beware that dcache line size is 64
>       *      but dcbz uses 32 bytes "sectors"
>       * XXX: this breaks clcs instruction !
>       */
> @@ -10485,7 +10485,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>      cc->tcg_initialize = ppc_translate_init;
>  #endif
>      cc->disas_set_info = ppc_disas_set_info;
> - 
> +
>      dc->fw_name = "PowerPC,UNKNOWN";
>  }
>  
> 

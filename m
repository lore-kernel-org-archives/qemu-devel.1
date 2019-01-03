Received: from eggs.gnu.org ([208.118.235.92]:42839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gf6hT-0003td-Jc
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gf6hQ-0004p7-GW
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:22:31 -0500
References: <CALvuzg6x2NjiJR=fPkgEmW2fCn6Uzy+rLAPHsC6Qn-S6hiNoqQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <cfd7963a-d93f-1977-b7c5-ddf1b80a09ab@vivier.eu>
Date: Thu, 3 Jan 2019 18:22:14 +0100
MIME-Version: 1.0
In-Reply-To: <CALvuzg6x2NjiJR=fPkgEmW2fCn6Uzy+rLAPHsC6Qn-S6hiNoqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Jon Diekema <jon.diekema@gmail.com>
Cc: qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

your patch is corrupted: please generate it with "git format-patch" and
send it with "git send-email" (you can also use git-publish)

Thanks,
Laurent

Le 25/12/2018 à 10:57, Jon Diekema a écrit :
> From b9c6caf3913487f05997144a940db0b900b17f05 Mon Sep 17 00:00:00 2001
> From: Jon Diekema <jon.diekema@ge.com <mailto:jon.diekema@ge.com>>
> Date: Tue, 25 Dec 2018 04:03:04 -0500
> Subject: Whitespace cleanup: target/ppc/translate_init.inc.c
> 
> Signed-off-by: Jon Diekema <jon.diekema@ge.com <mailto:jon.diekema@ge.com>>
> ---
>  target/ppc/translate_init.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/translate_init.inc.c
> b/target/ppc/translate_init.inc.c
> index 03f1d34a97..ac186845d0 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -5245,7 +5245,7 @@ static void init_proc_601(CPUPPCState *env)
>                   0x00000000);
>      /* Memory management */
>      init_excp_601(env);
> -    /* XXX: beware that dcache line size is 64 
> +    /* XXX: beware that dcache line size is 64
>       *      but dcbz uses 32 bytes "sectors"
>       * XXX: this breaks clcs instruction !
>       */
> @@ -10493,7 +10493,7 @@ static void ppc_cpu_class_init(ObjectClass *oc,
> void *data)
>      cc->tcg_initialize = ppc_translate_init;
>  #endif
>      cc->disas_set_info = ppc_disas_set_info;
> - 
> +
>      dc->fw_name = "PowerPC,UNKNOWN";
>  }
>  
> -- 
> 2.20.1.3.gf17a2b179
> 

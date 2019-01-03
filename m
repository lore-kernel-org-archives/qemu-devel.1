Received: from eggs.gnu.org ([208.118.235.92]:40937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gf6by-0005kA-9b
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gf6bv-0007ZM-6h
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:16:50 -0500
References: <CALvuzg43uSodseEHjNaRcPFBKKPTY2mcppUbYgiLL=QO9RxX_Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e62bbdda-2ab9-b9a1-7843-0a3a40f56282@vivier.eu>
Date: Thu, 3 Jan 2019 18:16:26 +0100
MIME-Version: 1.0
In-Reply-To: <CALvuzg43uSodseEHjNaRcPFBKKPTY2mcppUbYgiLL=QO9RxX_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] ppc: e6500 registers SPR 604 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jon Diekema <jon.diekema@gmail.com>
Cc: qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Roman Kapl <rka@sysgo.com>

Please cc: qemu-devel and maintainers (see MAINTAINERS file)

Le 25/12/2018 à 10:50, Jon Diekema a écrit :
> From f399f28441e0aa79458d68996038ca3606fcb699 Mon Sep 17 00:00:00 2001
> From: Jon Diekema <jon.diekema@ge.com <mailto:jon.diekema@ge.com>>

it's better to use the same email address for the patch author and to
send it.

> Date: Tue, 25 Dec 2018 04:36:06 -0500
> Subject: ppc: e6500 registers SPR 604 twice
> 
> When using the e6500 CPU, QEMU generates a fatal error after
> complaining about registering SPR 604 twice.
> 
> Building and testing with commit
> 9b2e891ec5ccdb4a7d583b77988848282606fdea shows the issue:
> 
> qemu-system-ppc64 --version
> QEMU emulator version 3.1.50 (v3.1.0-456-g9b2e891ec5-dirty)
> Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
> 
> qemu-system-ppc64 -M none -cpu e6500
> Error: Trying to register SPR 604 (25c) twice !

Fixes: 0e3bf48909
       ppc: add DBCR based debugging

> Signed-off-by: Jon Diekema <jon.diekema@ge.com <mailto:jon.diekema@ge.com>>
> ---
>  target/ppc/translate_init.inc.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/target/ppc/translate_init.inc.c
> b/target/ppc/translate_init.inc.c
> index 03f1d34a97..c971a5faf7 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -4947,14 +4947,6 @@ static void init_proc_e500(CPUPPCState *env, int
> version)
>      }
>  
>      if (version == fsl_e6500) {
> -        spr_register(env, SPR_BOOKE_SPRG8, "SPRG8",
> -                     SPR_NOACCESS, SPR_NOACCESS,
> -                     &spr_read_generic, &spr_write_generic,
> -                     0x00000000);
> -        spr_register(env, SPR_BOOKE_SPRG9, "SPRG9",
> -                     SPR_NOACCESS, SPR_NOACCESS,
> -                     &spr_read_generic, &spr_write_generic,
> -                     0x00000000);
>          /* Thread identification */
>          spr_register(env, SPR_TIR, "TIR",
>                       SPR_NOACCESS, SPR_NOACCESS,
> -- 
> 2.20.1.3.gf17a2b179
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>

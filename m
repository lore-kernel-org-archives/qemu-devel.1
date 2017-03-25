Received: from eggs.gnu.org ([2001:4830:134:3::10]:33411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1crjPW-0006TB-0l
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 06:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1crjPV-00041V-8e
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 06:59:06 -0400
References: <1490360147-26450-1-git-send-email-fred.konrad@greensocs.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7e150e14-dfb1-7dda-fb1b-0d885b28b33b@vivier.eu>
Date: Sat, 25 Mar 2017 11:58:48 +0100
MIME-Version: 1.0
In-Reply-To: <1490360147-26450-1-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] ppc_booke: drop useless
 assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Le 24/03/2017 à 13:55, fred.konrad@greensocs.com a écrit :
> From: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> The tb_env variable is set two lines above. So just drop the double assignment.
> 
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> ---
>  hw/ppc/ppc_booke.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
> index 60baffa..23bcf1b 100644
> --- a/hw/ppc/ppc_booke.c
> +++ b/hw/ppc/ppc_booke.c
> @@ -282,7 +282,6 @@ void store_booke_tcr(CPUPPCState *env, target_ulong val)
>      ppc_tb_t *tb_env = env->tb_env;
>      booke_timer_t *booke_timer = tb_env->opaque;
>  
> -    tb_env = env->tb_env;
>      env->spr[SPR_BOOKE_TCR] = val;
>      kvmppc_set_tcr(cpu);
>  
> 
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSmOP-00011p-7R
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSmOO-00056O-E1
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:43:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <08279239-43ac-96a8-f01b-b84ab04ee554@amsat.org>
Date: Tue, 12 Jun 2018 13:43:27 -0300
MIME-Version: 1.0
In-Reply-To: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/ppc: drop empty #if/#endif block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/12/2018 01:27 PM, Greg Kurz wrote:
> Commit 9d6f106552fa moved the last line in this block to somewhere else,
> but it forgot to remove the now useless #if/#endif.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/ppc/cpu.h |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0247c1f04c37..a91f1a8777eb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1300,8 +1300,6 @@ void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
>  void ppc_store_msr (CPUPPCState *env, target_ulong value);
>  
>  void ppc_cpu_list (FILE *f, fprintf_function cpu_fprintf);
> -#if defined(TARGET_PPC64)
> -#endif
>  
>  /* Time-base and decrementer management */
>  #ifndef NO_CPU_IO_DEFS
> 
> 

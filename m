Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRddK-0002sd-G9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRddF-0008B4-Hn
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:42:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRddF-0008AZ-BY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:42:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so8786860wmd.2
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:42:29 -0800 (PST)
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<154332390658.541746.14345430389973192696.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f7f8c40-df60-aa53-0203-b4823263cd4f@redhat.com>
Date: Tue, 27 Nov 2018 14:42:26 +0100
MIME-Version: 1.0
In-Reply-To: <154332390658.541746.14345430389973192696.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/9] target/ppc: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 27/11/18 14:05, Greg Kurz wrote:
> Because it is a recommended coding practice (see HACKING).
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/ppc/translate_init.inc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index 168d0cec28b7..03f1d34a9769 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9081,13 +9081,13 @@ static void init_ppc_proc(PowerPCCPU *cpu)
>              nb_tlb *= 2;
>          switch (env->tlb_type) {
>          case TLB_6XX:
> -            env->tlb.tlb6 = g_malloc0(nb_tlb * sizeof(ppc6xx_tlb_t));
> +            env->tlb.tlb6 = g_new0(ppc6xx_tlb_t, nb_tlb);
>              break;
>          case TLB_EMB:
> -            env->tlb.tlbe = g_malloc0(nb_tlb * sizeof(ppcemb_tlb_t));
> +            env->tlb.tlbe = g_new0(ppcemb_tlb_t, nb_tlb);
>              break;
>          case TLB_MAS:
> -            env->tlb.tlbm = g_malloc0(nb_tlb * sizeof(ppcmas_tlb_t));
> +            env->tlb.tlbm = g_new0(ppcmas_tlb_t, nb_tlb);
>              break;
>          }
>          /* Pre-compute some useful values */
> 
> 

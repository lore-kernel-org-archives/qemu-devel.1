Received: from eggs.gnu.org ([2001:4830:134:3::10]:47202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSpfR-0007JL-AZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSpfQ-0000Ts-I8
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:13:25 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882288685.114328.8550617676763950480.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9a605b69-a574-337e-b667-f7f8db20c84b@amsat.org>
Date: Tue, 12 Jun 2018 17:13:15 -0300
MIME-Version: 1.0
In-Reply-To: <152882288685.114328.8550617676763950480.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: fix leak in
 h_client_architecture_support()
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

On 06/12/2018 02:01 PM, Greg Kurz wrote:
> If the negotiated compat mode can't be set, but raw mode is supported,
> we decide to ignore the error. An so, we should free it to prevent a
> memory leak.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/spapr_hcall.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 022f6d810182..8b9a4b577fbf 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1547,6 +1547,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>                  error_report_err(local_err);
>                  return H_HARDWARE;
>              }
> +            error_free(local_err);
>              local_err = NULL;
>          }
>      }
> 
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTpnR-0003Et-6C
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTpnQ-0005C4-EQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:57:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTpnQ-0005Bi-8N
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:57:00 -0500
Date: Wed, 18 Jan 2017 10:56:57 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118125657.GW3491@thinpad.lan.raisama.net>
References: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1484743207-10721-4-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484743207-10721-4-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] cpu: make the function of
 cpu_common_map_numa_node more efficiently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, vilanova@ac.upc.edu, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

On Wed, Jan 18, 2017 at 08:40:07PM +0800, Dou Liyang wrote:
> Current function does some unnecessary operations, such as it makes
> the assert() in the loop, and the loop was not stopped in time.
> 
> This patch moves the assert() out the loop and stops the loop in
> time.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>


Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Can be squashed in patch 1/3.

> ---
>  qom/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qom/cpu.c b/qom/cpu.c
> index e08dceb..3c655b2 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -343,10 +343,11 @@ static void cpu_common_map_numa_node(CPUState *cpu)
>  {
>      int i;
>  
> +    assert(cpu->cpu_index < max_cpus);
>      for (i = 0; i < nb_numa_nodes; i++) {
> -        assert(cpu->cpu_index < max_cpus);
>          if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
>              cpu->numa_node = i;
> +            return;
>          }
>      }
>  }
> -- 
> 2.5.5
> 
> 
> 

-- 
Eduardo

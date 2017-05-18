Received: from eggs.gnu.org ([2001:4830:134:3::10]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dBMts-0000H0-0L
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dBMtp-0006UT-0U
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:59:36 -0400
Date: Thu, 18 May 2017 16:59:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170518165927.30087aad@nial.brq.redhat.com>
In-Reply-To: <149511591185.8828.11947901967942107196.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <149511591185.8828.11947901967942107196.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: ensure core_slot isn't NULL in
 spapr_core_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, 18 May 2017 15:58:31 +0200
Greg Kurz <groug@kaod.org> wrote:

> If we go that far on the path of hot-removing a core and we find out that
> the core-id is invalid, then we have a serious bug.
> 
> Let's make it explicit with an assert() instead of dereferencing a NULL
> pointer.
> 
> This fixes Coverity issue CID 1375404.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/ppc/spapr.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0980d733cd7a..1c5b814fc0bf 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2715,6 +2715,7 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      CPUCore *cc = CPU_CORE(dev);
>      CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
>  
> +    assert(core_slot);
>      core_slot->cpu = NULL;
>      object_unparent(OBJECT(dev));
>  }
> 
> 

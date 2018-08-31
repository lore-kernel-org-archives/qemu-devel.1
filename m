Received: from eggs.gnu.org ([2001:4830:134:3::10]:32811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fvaVz-0005sW-9T
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 23:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fvaHj-0007Lx-Gb
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 23:39:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fvaHi-0007J4-96
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 23:39:46 -0400
Date: Thu, 30 Aug 2018 23:39:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180830233835-mutt-send-email-mst@kernel.org>
References: <201808272317499067164@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201808272317499067164@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V4 4/4] target-i386: add i440fx 0xcf8
 portascoalesced_pio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: liran.alon@oracle.com, pbonzini@redhat.com, ehabkost@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn

On Mon, Aug 27, 2018 at 11:17:49PM +0800, peng.hao2@zte.com.cn wrote:
> >On Mon, Aug 27, 2018 at 04:25:00PM +0800, peng.hao2@zte.com.cn wrote:
> >> >> On 25 Aug 2018, at 15:19, Peng Hao <peng.hao2@zte.com.cn> wrote:
> >> >> 
> >> >> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> >> >> index 0e60834..da73743 100644
> >> >> --- a/hw/pci-host/piix.c
> >> >> +++ b/hw/pci-host/piix.c
> >> >> @@ -327,6 +327,10 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
> >> >> 
> >> >>     sysbus_add_io(sbd, 0xcfc, &s->data_mem);
> >> >>     sysbus_init_ioports(sbd, 0xcfc, 4);
> >> >> +
> >> >> +    /* register i440fx 0xcf8 port as coalesced pio */
> >> >> +    memory_region_set_flush_coalesced(&s->data_mem);
> >> >> +    memory_region_add_coalescing(&s->conf_mem, 0, 4);
> >> >> }
> >> >> 
> >> >Is there a reason to not register this port as coalesced PIO also for Q35?
> >> >In q35_host_realize()?
> >> >If not, I would do that as an extra patch as part of this series.
> >> Just as I mentioned in patch [0/4] , you can add pci->>host config port as coalesecd pio. I think  it works for q35 port 0xcf8.
> >> >-Liran
> >
> >What's the performance improvement for q35?
> q35 also has  the same pci-host config port 0xcf8  as  piix. I test the coalesced pio for 
> q35 pci-host config port 0xcf8. It spent less VM-exit avg time from 3us to 0.6us.

so pls include that patch too. piix is mostly feature frozen, piix only
features aren't likely to be merged.

> >-- 
> >MST

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dHnmd-000096-32
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dHnmY-0004Oy-8U
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:54:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:42800 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1dHnmY-0004NY-16
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:54:38 -0400
Date: Mon, 5 Jun 2017 10:54:32 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170605085432.GK9248@dhcp22.suse.cz>
References: <1ee3ccf0-2d91-86ec-628c-d50ae3ffbe22@cn.fujitsu.com>
	<20170605104508.1419d7af@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605104508.1419d7af@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] Memory Hotplug : Does QEmu support cold-plugged
 memory?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Mon 05-06-17 10:45:08, Igor Mammedov wrote:
> On Mon, 5 Jun 2017 15:53:02 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> 
> > Hi all,
> > 
> > I want to boot up a system with some removable memory.
> > 
> > So, i used '-object' and '-device' to cold-plug memory
> > in QEmu as following :
> > 
> > ./x86_64-softmmu/qemu-system-x86_64 \
> > 	...
> > 	-object memory-backend-ram,id=mem3,size=128M \
> > 	-device pc-dimm,id=dimm3,memdev=mem3 \
> > 	...
> > 
> > then i want to hot-remove this memory by 'device-del' and
> > 'object-del'.
> > 
> > But, unfortunately, I can't remove the memory device.
> > 
> > And, in guest OS, I found the memory's removable feature is 0,
> > But, in QEmu monitor with 'info memory-devices', I found the
> > hotplugged is false and hotpluggable is true.
> It's issue in the guest side kernel.
> In short it's not guarantied that guest kernel would be able
> to hotremove DIMM module (even if hardware is capable of) since
> kernel might use its memory as not MOVABLE, so DIMM might be
> temporally or permanently pinned by kernel allocations.

Yes and that will be always the case as long as you allow kernel
allocations to use that memory. I do not know of any other way to work
this around than online the specific memory range as movable.

-- 
Michal Hocko
SUSE Labs

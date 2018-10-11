Received: from eggs.gnu.org ([2001:4830:134:3::10]:44039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gAf0Y-0005qR-IP
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gAf0X-0005tq-MK
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:44:22 -0400
Date: Thu, 11 Oct 2018 14:44:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181011174412.GA27575@habkost.net>
References: <20181005092024.14344-1-david@redhat.com>
	<bdae39b9-830e-decc-eaca-abf636578f70@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdae39b9-830e-decc-eaca-abf636578f70@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/16] memory-device: complete
 refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Auger Eric <eric.auger@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 09, 2018 at 11:32:32AM +0200, David Hildenbrand wrote:
> On 05/10/2018 11:20, David Hildenbrand wrote:
> > This series completes refactoring of pre_plug, plug and unplug logic of
> > memory devices. With this as a basis, we can built e.g. virtio
> > based memory devices or internal "RAM chip" devices.
> > 
> > I dropped the virtio-pmem prototype for now, I will look into plugging
> > it differently next. But this part in this series here is independent of
> > hotplug handler changes required to make it work for virtio devices.
> > 
> > v4 -> v5:
> > - Added a bunch of RB's
> > - Minor spelling fixed
> > - Dropped "memory-device: add class function get_device_id()"
> > - Added   "memory-device: improve "range conflicts" error message
> > - Dropped "memory-device: handle integer overflows properly"
> > -- Will require more changes. But I am able to reproduce some overflows.
> > - "memory-device: document MemoryDeviceClass"
> > -- Changed documentation format as requested by Auger
> > - "memory-device: trace when pre_plugging/plugging/unplugging"
> > -- Include device ID and rename tracepoints.
> 
> @Paolo, @Eduardo this seems to be ready to get picked up. Thanks!

Queued on machine-next, thanks!

-- 
Eduardo

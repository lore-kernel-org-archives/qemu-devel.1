Received: from eggs.gnu.org ([2001:4830:134:3::10]:48958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9oOf-00005x-PX
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9oOa-0004qU-OB
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:33:45 -0400
References: <20181005092024.14344-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bdae39b9-830e-decc-eaca-abf636578f70@redhat.com>
Date: Tue, 9 Oct 2018 11:32:32 +0200
MIME-Version: 1.0
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Auger Eric <eric.auger@redhat.com>

On 05/10/2018 11:20, David Hildenbrand wrote:
> This series completes refactoring of pre_plug, plug and unplug logic of
> memory devices. With this as a basis, we can built e.g. virtio
> based memory devices or internal "RAM chip" devices.
> 
> I dropped the virtio-pmem prototype for now, I will look into plugging
> it differently next. But this part in this series here is independent of
> hotplug handler changes required to make it work for virtio devices.
> 
> v4 -> v5:
> - Added a bunch of RB's
> - Minor spelling fixed
> - Dropped "memory-device: add class function get_device_id()"
> - Added   "memory-device: improve "range conflicts" error message
> - Dropped "memory-device: handle integer overflows properly"
> -- Will require more changes. But I am able to reproduce some overflows.
> - "memory-device: document MemoryDeviceClass"
> -- Changed documentation format as requested by Auger
> - "memory-device: trace when pre_plugging/plugging/unplugging"
> -- Include device ID and rename tracepoints.

@Paolo, @Eduardo this seems to be ready to get picked up. Thanks!


-- 

Thanks,

David / dhildenb

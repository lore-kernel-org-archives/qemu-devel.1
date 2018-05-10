Received: from eggs.gnu.org ([2001:4830:134:3::10]:49994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fGpk4-0004hw-Tt
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fGpk1-0003QA-Ms
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:52:36 -0400
Date: Thu, 10 May 2018 14:52:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180510175222.GV25013@localhost.localdomain>
References: <20180423165126.15441-1-david@redhat.com>
	<20180423165126.15441-3-david@redhat.com>
	<20180504192635.GA4903@localhost.localdomain>
	<f2b567cb-8723-4e6d-b6ec-a6d97bffab10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b567cb-8723-4e6d-b6ec-a6d97bffab10@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] machine: make MemoryHotplugState
 accessible via the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu, May 10, 2018 at 06:57:32PM +0200, Paolo Bonzini wrote:
[...]
> > -    machine->device_memory = g_malloc(sizeof(*machine->device_memory));
> > +    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
> 
> g_new0 since you are at it? :)

Nice suggestion, but this was already merged.

I think we have a Coccinelle script that should detect this?

-- 
Eduardo

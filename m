Received: from eggs.gnu.org ([2001:4830:134:3::10]:49454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fHVoT-00040q-97
	for qemu-devel@nongnu.org; Sat, 12 May 2018 10:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fHVoO-00088s-Bb
	for qemu-devel@nongnu.org; Sat, 12 May 2018 10:47:57 -0400
References: <20180511131953.12905-1-david@redhat.com>
	<20180511131953.12905-5-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0ca94ed-ff7a-c08b-fea9-8d7e513a2519@redhat.com>
Date: Sat, 12 May 2018 16:47:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180511131953.12905-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/17] pc: route all memory devices
 through the machine hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 11/05/2018 15:19, David Hildenbrand wrote:
> +    if (dev->parent_bus) {
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
> +            return HOTPLUG_HANDLER(machine);
> +        }
> +    }
> +

How do you get here with a MemoryDevice that has !dev->parent_bus?

Thanks,

Paolo

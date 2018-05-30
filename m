Received: from eggs.gnu.org ([2001:4830:134:3::10]:34048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO250-0004hu-V3
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO24w-0000ne-0q
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:27:58 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-6-david@redhat.com>
	<20180530151212.47455e78@redhat.com>
	<b7e1f787-fb65-b64a-9e24-8edfa9d42fe1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc3d88f1-6f44-0330-8377-c56eb7d4f893@redhat.com>
Date: Wed, 30 May 2018 16:27:40 +0200
MIME-Version: 1.0
In-Reply-To: <b7e1f787-fb65-b64a-9e24-8edfa9d42fe1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/14] pc: route all memory devices
 through the machine hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 30/05/2018 16:08, David Hildenbrand wrote:
>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>>> +        object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE) ||
>> you probably could drop TYPE_PC_DIMM above, it's redundant since DIMM
>> can be cast to TYPE_MEMORY_DEVICE
>>
>> ditto for spapr
>>
> Yes, had the same in mind but left it for now this way (basically
> because we do special handling for PC_DIMM, so anybody reading this code
> is not directly confused)
> 

Hmm, I think what Igor proposes is nicer.  Can you send a v5 when he's
done with review?

Paolo

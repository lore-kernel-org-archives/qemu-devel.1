Received: from eggs.gnu.org ([2001:4830:134:3::10]:59188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRDdi-0001uG-S4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRDdi-00085x-3E
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:24:58 -0400
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-3-david@redhat.com>
	<20180608093406.30c878ec@bahia.lan>
	<4f518685-fcdb-7c3a-35d3-5a26374e0604@redhat.com>
	<20180608094657.4043502f@bahia.lan>
	<431d4fe5-5bfe-1ab3-00b5-610038a7a9ea@redhat.com>
	<2b431d32-9172-0517-4717-7ce50355b8db@redhat.com>
	<20180608103943.1d7e72ee@redhat.com>
	<673ffa52-1e24-5d6c-5d6a-927d3df79273@redhat.com>
	<20180608110612.18ac915c@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9eaefde2-b8aa-9072-610b-4236ce5c3913@redhat.com>
Date: Fri, 8 Jun 2018 11:24:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180608110612.18ac915c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 2/8] spapr: no need to
 verify the node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>


>>>> +1 for error_abort, even if it takes another line.  
>>> +1 for error_abort
>>> call shouldn't fail, but if does it won't be silently ignored
>>> and introduce undefined behavior.  
>>
>> Maybe we should fix the others that pass in NULL.
>>
>> (no, not me :D - I'm already busy with your requested pre_plug handling)
> Add it to wiki page for bite sized tasks?

Done.


-- 

Thanks,

David / dhildenb

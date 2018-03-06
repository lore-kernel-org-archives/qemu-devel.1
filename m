Received: from eggs.gnu.org ([2001:4830:134:3::10]:36462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etBfH-0002uY-NQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etBfG-0002Am-U0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:25:55 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180305083655.6186-1-pbonzini@redhat.com>
	<20180305083655.6186-2-pbonzini@redhat.com>
	<20180306001018.GP2650@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91d0763d-24e7-fd1e-3d32-a6dcbb5ace05@redhat.com>
Date: Tue, 6 Mar 2018 13:25:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180306001018.GP2650@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] openpic_kvm: drop
 address_space_to_flatview call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-stable@nongnu.org

On 06/03/2018 01:10, David Gibson wrote:
> On Mon, Mar 05, 2018 at 09:36:49AM +0100, Paolo Bonzini wrote:
>> The MemoryListener is registered on address_space_memory, there is
>> not much to assert.  This currently works because the callback
>> is invoked only once when the listener is registered, but section->fv
>> is the _new_ FlatView, not the old one on later calls and that
>> would break.
>>
>> This confines address_space_to_flatview to exec.c and memory.c.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Do you want me to take this through my tree?

No need since Alexey has already reviewed the rest.  Thanks!

Paolo

> 
> 
>> ---
>>  hw/intc/openpic_kvm.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
>> index fa83420254..39a6f369c5 100644
>> --- a/hw/intc/openpic_kvm.c
>> +++ b/hw/intc/openpic_kvm.c
>> @@ -124,10 +124,6 @@ static void kvm_openpic_region_add(MemoryListener *listener,
>>      uint64_t reg_base;
>>      int ret;
>>  
>> -    if (section->fv != address_space_to_flatview(&address_space_memory)) {
>> -        abort();
>> -    }
>> -
>>      /* Ignore events on regions that are not us */
>>      if (section->mr != &opp->mem) {
>>          return;
> 

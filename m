Received: from eggs.gnu.org ([209.51.188.92]:34975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtW6V-0002Q0-0I
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtW6T-0007UI-2n
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:19:54 -0500
References: <20190212093023.32466-1-david@redhat.com>
	<20190212121615.65bef23e.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f486ade5-5b4d-db15-9fac-0b5fad069236@redhat.com>
Date: Tue, 12 Feb 2019 12:19:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190212121615.65bef23e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x: add zPCI feature to "qemu" CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On 12.02.19 12:16, Cornelia Huck wrote:
> On Tue, 12 Feb 2019 10:30:23 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> As we now always have PCI support, let's add it to the "qemu" CPU model,
>> taking care of backwards compatibility.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c  | 3 +++
>>  target/s390x/gen-features.c | 8 ++++++--
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 3fb5c88af9..7f0d394fbe 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -657,7 +657,10 @@ DEFINE_CCW_MACHINE(4_0, "4.0", true);
>>  
>>  static void ccw_machine_3_1_instance_options(MachineState *machine)
>>  {
>> +    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V3_1 };
>>      ccw_machine_4_0_instance_options(machine);
>> +
>> +    s390_set_qemu_cpu_model(0x2064, 7, 1, qemu_cpu_feat);
> 
> Hm, don't we emulate a (stripped-down) z12 (2827)? Or am I
> misunderstanding?

Yes, stupid copy and past error,

0x2827, 12, 2 it is!

Thanks for spotting that!

> 
>>  }
>>  
>>  static void ccw_machine_3_1_class_options(MachineClass *mc)


-- 

Thanks,

David / dhildenb

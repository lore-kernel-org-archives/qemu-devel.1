Received: from eggs.gnu.org ([2001:4830:134:3::10]:56987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cuB9q-0005Nn-PF
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 01:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cuB9n-0007Pd-Ku
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 01:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cuB9n-0007H9-87
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 01:00:59 -0400
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-15-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439032C79@shsmsx102.ccr.corp.intel.com>
	<20170327091208.GG11497@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257439032D78@shsmsx102.ccr.corp.intel.com>
	<A2975661238FB949B60364EF0F2C25743903553F@shsmsx102.ccr.corp.intel.com>
	<9c3cda64-b4a3-6f9b-f951-bf73f6613faa@redhat.com>
	<A2975661238FB949B60364EF0F2C257439036D0F@shsmsx102.ccr.corp.intel.com>
	<81e79982-4af0-3b46-552c-eea4db05a362@redhat.com>
	<A2975661238FB949B60364EF0F2C257439036DF7@shsmsx102.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <216e2666-bd00-7f04-439b-0ed95a566feb@redhat.com>
Date: Sat, 1 Apr 2017 13:00:43 +0800
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439036DF7@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
 MemoryRegionIOMMUOps.replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>, 'Peter Xu' <peterx@redhat.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "'mst@redhat.com'" <mst@redhat.com>, "'jan.kiszka@siemens.com'" <jan.kiszka@siemens.com>, "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, "'alex.williamson@redhat.com'" <alex.williamson@redhat.com>, 'David Gibson' <david@gibson.dropbear.id.au>



On 2017=E5=B9=B403=E6=9C=8831=E6=97=A5 15:30, Liu, Yi L wrote:
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Friday, March 31, 2017 3:17 PM
>> To: Liu, Yi L <yi.l.liu@intel.com>; 'Peter Xu' <peterx@redhat.com>
>> Cc: Lan, Tianyu <tianyu.lan@intel.com>; Tian, Kevin <kevin.tian@intel.=
com>;
>> 'mst@redhat.com' <mst@redhat.com>; 'jan.kiszka@siemens.com'
>> <jan.kiszka@siemens.com>; 'bd.aviv@gmail.com' <bd.aviv@gmail.com>; 'qe=
mu-
>> devel@nongnu.org' <qemu-devel@nongnu.org>; 'alex.williamson@redhat.com=
'
>> <alex.williamson@redhat.com>; 'David Gibson' <david@gibson.dropbear.id=
.au>
>> Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
>> MemoryRegionIOMMUOps.replay() callback
>>
>>
>>
>> On 2017=E5=B9=B403=E6=9C=8831=E6=97=A5 13:34, Liu, Yi L wrote:
>>>> -----Original Message-----
>>>> From: Jason Wang [mailto:jasowang@redhat.com]
>>>> Sent: Thursday, March 30, 2017 7:58 PM
>>>> To: Liu, Yi L <yi.l.liu@intel.com>; 'Peter Xu' <peterx@redhat.com>
>>>> Cc: 'alex.williamson@redhat.com' <alex.williamson@redhat.com>; Lan,
>>>> Tianyu <tianyu.lan@intel.com>; Tian, Kevin <kevin.tian@intel.com>;
>> 'mst@redhat.com'
>>>> <mst@redhat.com>; 'jan.kiszka@siemens.com' <jan.kiszka@siemens.com>;
>>>> 'bd.aviv@gmail.com' <bd.aviv@gmail.com>; 'David Gibson'
>>>> <david@gibson.dropbear.id.au>; 'qemu-devel@nongnu.org' <qemu-
>>>> devel@nongnu.org>
>>>> Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
>>>> MemoryRegionIOMMUOps.replay() callback
>>>>
>>>>
>>>>
>>>> On 2017=E5=B9=B403=E6=9C=8830=E6=97=A5 19:06, Liu, Yi L wrote:
>>>>>> -----Original Message-----
>>>>>> From: Liu, Yi L
>>>>>> Sent: Monday, March 27, 2017 5:22 PM
>>>>>> To: Peter Xu <peterx@redhat.com>
>>>>>> Cc: alex.williamson@redhat.com; Lan, Tianyu <tianyu.lan@intel.com>=
;
>>>>>> Tian, Kevin <kevin.tian@intel.com>; mst@redhat.com;
>>>>>> jan.kiszka@siemens.com; jasowang@redhat.com; bd.aviv@gmail.com;
>>>>>> David Gibson <david@gibson.dropbear.id.au>; qemu-devel@nongnu.org
>>>>>> Subject: RE: [Qemu-devel] [PATCH v7 14/17] memory: add
>>>>>> MemoryRegionIOMMUOps.replay() callback
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Peter Xu [mailto:peterx@redhat.com]
>>>>>>> Sent: Monday, March 27, 2017 5:12 PM
>>>>>>> To: Liu, Yi L <yi.l.liu@intel.com>
>>>>>>> Cc: alex.williamson@redhat.com; Lan, Tianyu
>>>>>>> <tianyu.lan@intel.com>; Tian, Kevin <kevin.tian@intel.com>;
>>>>>>> mst@redhat.com; jan.kiszka@siemens.com; jasowang@redhat.com;
>>>>>>> bd.aviv@gmail.com; David Gibson <david@gibson.dropbear.id.au>;
>>>>>>> qemu-devel@nongnu.org
>>>>>>> Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
>>>>>>> MemoryRegionIOMMUOps.replay() callback
>>>>>>>
>>>>>>> On Mon, Mar 27, 2017 at 08:35:05AM +0000, Liu, Yi L wrote:
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Qemu-devel
>>>>>>>>> [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nongnu.org] On
>>>>>>>>> Behalf Of Peter Xu
>>>>>>>>> Sent: Tuesday, February 7, 2017 4:28 PM
>>>>>>>>> To: qemu-devel@nongnu.org
>>>>>>>>> Cc: Lan, Tianyu <tianyu.lan@intel.com>; Tian, Kevin
>>>>>>>>> <kevin.tian@intel.com>; mst@redhat.com; jan.kiszka@siemens.com;
>>>>>>>>> jasowang@redhat.com; peterx@redhat.com;
>>>>>>>>> alex.williamson@redhat.com; bd.aviv@gmail.com; David Gibson
>>>>>>>>> <david@gibson.dropbear.id.au>
>>>>>>>>> Subject: [Qemu-devel] [PATCH v7 14/17] memory: add
>>>>>>>>> MemoryRegionIOMMUOps.replay() callback
>>>>>>>>>
>>>>>>>>> Originally we have one memory_region_iommu_replay() function,
>>>>>>>>> which is the default behavior to replay the translations of the
>>>>>>>>> whole IOMMU region. However, on some platform like x86, we may
>>>>>>>>> want our own
>>>>>>> replay logic for IOMMU regions.
>>>>>>>>> This patch add one more hook for IOMMUOps for the callback, and
>>>>>>>>> it'll override the default if set.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>>>>>> ---
>>>>>>>>>     include/exec/memory.h | 2 ++
>>>>>>>>>     memory.c              | 6 ++++++
>>>>>>>>>     2 files changed, 8 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/include/exec/memory.h b/include/exec/memory.h inde=
x
>>>>>>>>> 0767888..30b2a74 100644
>>>>>>>>> --- a/include/exec/memory.h
>>>>>>>>> +++ b/include/exec/memory.h
>>>>>>>>> @@ -191,6 +191,8 @@ struct MemoryRegionIOMMUOps {
>>>>>>>>>         void (*notify_flag_changed)(MemoryRegion *iommu,
>>>>>>>>>                                     IOMMUNotifierFlag old_flags=
,
>>>>>>>>>                                     IOMMUNotifierFlag new_flags=
);
>>>>>>>>> +    /* Set this up to provide customized IOMMU replay function=
 */
>>>>>>>>> +    void (*replay)(MemoryRegion *iommu, IOMMUNotifier
>>>>>>>>> + *notifier);
>>>>>>>>>     };
>>>>>>>>>
>>>>>>>>>     typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>>>>>>>>> diff --git a/memory.c b/memory.c index 7a4f2f9..9c253cc 100644
>>>>>>>>> --- a/memory.c
>>>>>>>>> +++ b/memory.c
>>>>>>>>> @@ -1630,6 +1630,12 @@ void
>>>>>>>>> memory_region_iommu_replay(MemoryRegion
>>>>>>>>> *mr, IOMMUNotifier *n,
>>>>>>>>>         hwaddr addr, granularity;
>>>>>>>>>         IOMMUTLBEntry iotlb;
>>>>>>>>> +    /* If the IOMMU has its own replay callback, override */
>>>>>>>>> +    if (mr->iommu_ops->replay) {
>>>>>>>>> +        mr->iommu_ops->replay(mr, n);
>>>>>>>>> +        return;
>>>>>>>>> +    }
>>>>>>>> Hi Alex, Peter,
>>>>>>>>
>>>>>>>> Will all the other vendors(e.g. PPC, s390, ARM) add their own
>>>>>>>> replay callback as well? I guess it depends on whether the
>>>>>>>> original replay algorithm work well for them? Do you have such k=
nowledge?
>>>>>>> I guess so. At least for VT-d we had this callback since the
>>>>>>> default replay mechanism did not work well on x86 due to its
>>>>>>> extremely large memory region size. Thanks,
>>>>>> thx. that would make sense.
>>>>> Peter,
>>>>>
>>>>> Just come to mind that there may be a corner case here.
>>>>>
>>>>> Intel VT-d actually has a "pt" mode which allows device use physica=
l
>>>>> address even when VT-d is enabled. In kernel, there is a
>> iommu_identity_mapping.
>>>>> If a device is in this map, then it would use "pt" mode. So that
>>>>> IOMMU driver would not build second-level page table for it.
>>>> Yes, but qemu does not support ECAP_PT now, so guest will still have
>>>> a page table in this case.
>>> That's true. Without ECAP_PT, IOMMU driver would create a 1:1 map. So
>>> this solution can work well even a device is in identify_map.
>>>
>>>>> Back to the virtual IOVA implementation, if an assigned device is i=
n
>>>>> the iommu_identity_mapping(e.g. VGA controller), it uses GPA direct=
ly to do
>> DMA.
>>>>> So it demands a GPA->HPA mapping in host. However, the
>>>>> iommu->ops.replay is not able to build it when guest SL page table =
is empty.
>>>>>
>>>>> So I think building an entire guest PA->HPA mapping before guest
>>>>> kernel boot would be recommended. Any thoughts?
>>>> We plan to add PT in 2.10, a possible rough idea is disabled iommu
>>>> dmar region and use another region without iommu_ops. Then
>>>> vfio_listener_region_add() will just do the correct mappings.
>>> Good to know it. Actually, I also need to expose ECAP_PT for vSVM. So
>>> just comes to realize that the current replay solution may not work w=
ell when I
>> expose ECAP_PT to guest.
>>> I also have a rough idea here. The current listener in container
>>> listens to address space named with devfn if virtual VTd is added. Ho=
w
>>> about adding one more listener to listen memory address space. So tha=
t the
>> listener can build entire guest PA->HPA mapping.
>>
>> This is only needed for PT. So looks like current code is sufficient t=
o do this I think.
>> See the else part of if (memory_region_is_iommu()) of vfio_listener_re=
gion_add().
> Jason, when the listener listen to device address space, the "else part=
" may not work
> even we set the mr->iommu_ops =3D NULL. The mr would be a non-ram regio=
n when the
> time region_add is called since it is actually listen to changes from d=
evice address space.
>
> Regards,
> Yi L
>

See Peter's patch ("intel_iommu: allow dynamic switch of IOMMU region").=20
It has

+        memory_region_init_alias(&vtd_dev_as->sys_alias, OBJECT(s),
+                                 "vtd_sys_alias", get_system_memory(),
+                                 0,=20
memory_region_size(get_system_memory()));

We can enable sys_alias in when PT is used which should work I think.

Thanks

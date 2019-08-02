Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96213C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0A121842
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0A121842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htWSF-0000Bz-NA
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 08:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35497)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <borntraeger@de.ibm.com>) id 1htWRe-0008Bn-EN
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1htWRc-0007Eb-VJ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:14:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16320
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1htWRc-0007CN-P8
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:14:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x72C7tbP042796
 for <qemu-devel@nongnu.org>; Fri, 2 Aug 2019 08:13:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u4kahv7p5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 08:13:59 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Fri, 2 Aug 2019 13:13:57 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 2 Aug 2019 13:13:54 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x72CDr9S30081450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2019 12:13:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FABD4203F;
 Fri,  2 Aug 2019 12:13:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45E6942047;
 Fri,  2 Aug 2019 12:13:53 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.71])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  2 Aug 2019 12:13:53 +0000 (GMT)
To: Igor Mammedov <imammedo@redhat.com>
References: <20190802093854.5343-1-imammedo@redhat.com>
 <20190802093854.5343-5-imammedo@redhat.com>
 <d96d27c6-0bef-f319-bb92-98f654d7ba99@redhat.com>
 <f48d6578-7477-40ed-750d-055e13b4db41@de.ibm.com>
 <20190802134056.789f0b4c@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date: Fri, 2 Aug 2019 14:13:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802134056.789f0b4c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19080212-0008-0000-0000-00000303B4BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080212-0009-0000-0000-00002272BB62
Message-Id: <837ac64b-a1d0-e2f1-4056-a6e653da153f@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-02_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020127
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/4] s390: do not call
 memory_region_allocate_system_memory() multiple times
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: thuth@redhat.com, David Hildenbrand <david@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 02.08.19 13:40, Igor Mammedov wrote:
> On Fri, 2 Aug 2019 12:27:50 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 02.08.19 12:25, David Hildenbrand wrote:
>>> On 02.08.19 11:38, Igor Mammedov wrote:  
>>>> s390 was trying to solve limited KVM memslot size issue by abusing
>>>> memory_region_allocate_system_memory(), which breaks API contract
>>>> where the function might be called only once.
>>>>
>>>> s390 should have used memory aliases to fragment inital memory into
>>>> smaller chunks to satisfy KVM's memslot limitation. But its a bit
>>>> late now, since allocated pieces are transfered in migration stream
>>>> separately, so it's not possible to just replace broken layout with
>>>> correct one. To workaround issue, MemoryRegion alases are made
>>>> migratable and this patch switches to use them to split big initial
>>>> RAM chunk into smaller pieces (KVM_SLOT_MAX_BYTES max) and registers
>>>> aliases for migration. That should keep migration compatible with
>>>> previous QEMU versions.
>>>>
>>>> New machine types (since 4.2) will use single memory region, which
>>>> will get transimitted in migration stream as a whole RAMBlock.
>>>>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>> I don't have access to a suitable system to test it, so I've simulated
>>>> it with smaller chunks on x84 host. Ping-pong migration between old
>>>> and new QEMU worked fine. KVM part should be fine as memslots
>>>> using mapped MemoryRegions (in this case it would be aliases) as
>>>> far as I know but is someone could test it on big enough host it
>>>> would be nice.
>>>> ---
>>>>  include/hw/s390x/s390-virtio-ccw.h |  4 +++
>>>>  hw/s390x/s390-virtio-ccw.c         | 56 +++++++++++++++++++++---------
>>>>  2 files changed, 43 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>>>> index 00632f94b4..f9ed3737f8 100644
>>>> --- a/include/hw/s390x/s390-virtio-ccw.h
>>>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>>>> @@ -21,6 +21,9 @@
>>>>  #define S390_MACHINE_CLASS(klass) \
>>>>      OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE)
>>>>  
>>>> +#define S390_MACHINE_GET_CLASS(obj) \
>>>> +    OBJECT_GET_CLASS(S390CcwMachineClass, (obj), TYPE_S390_CCW_MACHINE)
>>>> +
>>>>  /*
>>>>   * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
>>>>   * as the dirty bitmap must be managed by bitops that take an int as
>>>> @@ -50,6 +53,7 @@ typedef struct S390CcwMachineClass {
>>>>      bool cpu_model_allowed;
>>>>      bool css_migration_enabled;
>>>>      bool hpage_1m_allowed;
>>>> +    bool split_ram_layout;
>>>>  } S390CcwMachineClass;
>>>>  
>>>>  /* runtime-instrumentation allowed by the machine */
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index 073672f9cb..9160c1ed0a 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -151,28 +151,47 @@ static void virtio_ccw_register_hcalls(void)
>>>>                                     virtio_ccw_hcall_early_printk);
>>>>  }
>>>>  
>>>> -static void s390_memory_init(ram_addr_t mem_size)
>>>> +static void s390_memory_init(MachineState *ms)
>>>>  {
>>>> +    S390CcwMachineClass *s390mc = S390_MACHINE_GET_CLASS(ms);
>>>>      MemoryRegion *sysmem = get_system_memory();
>>>> -    ram_addr_t chunk, offset = 0;
>>>> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>>>>      unsigned int number = 0;
>>>>      Error *local_err = NULL;
>>>> -    gchar *name;
>>>> +    ram_addr_t mem_size = ms->ram_size;
>>>> +    gchar *name = g_strdup_printf(s390mc->split_ram_layout ?
>>>> +                                  "s390.whole.ram" : "s390.ram");
>>>>  
>>>>      /* allocate RAM for core */
>>>> -    name = g_strdup_printf("s390.ram");
>>>> -    while (mem_size) {
>>>> -        MemoryRegion *ram = g_new(MemoryRegion, 1);
>>>> -        uint64_t size = mem_size;
>>>> -
>>>> -        /* KVM does not allow memslots >= 8 TB */
>>>> -        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
>>>> -        memory_region_allocate_system_memory(ram, NULL, name, chunk);
>>>> -        memory_region_add_subregion(sysmem, offset, ram);
>>>> -        mem_size -= chunk;
>>>> -        offset += chunk;
>>>> -        g_free(name);
>>>> -        name = g_strdup_printf("s390.ram.%u", ++number);
>>>> +    memory_region_allocate_system_memory(ram, NULL, name, mem_size);
>>>> +
>>>> +    /* migration compatible RAM handling for 4.1 and older machines */
>>>> +    if (s390mc->split_ram_layout) {
>>>> +       ram_addr_t chunk, offset = 0;
>>>> +       /*
>>>> +        * memory_region_allocate_system_memory() registers allocated RAM for
>>>> +        * migration, however for compat reasons the RAM should be passed over
>>>> +        * as RAMBlocks of the size upto KVM_SLOT_MAX_BYTES. So unregister just
>>>> +        * allocated RAM so it won't be migrated directly. Aliases will take care
>>>> +        * of segmenting RAM into legacy chunks that migration compatible.
>>>> +        */
>>>> +       vmstate_unregister_ram(ram, NULL);
>>>> +       name = g_strdup_printf("s390.ram");
>>>> +       while (mem_size) {
>>>> +           MemoryRegion *alias = g_new(MemoryRegion, 1);
>>>> +
>>>> +           /* KVM does not allow memslots >= 8 TB */
>>>> +           chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
>>>> +           memory_region_init_alias(alias, NULL, name, ram, offset, chunk);
>>>> +           vmstate_register_ram_global(alias);
>>>> +           memory_region_add_subregion(sysmem, offset, alias);
>>>> +           mem_size -= chunk;
>>>> +           offset += chunk;
>>>> +           g_free(name);
>>>> +           name = g_strdup_printf("s390.ram.%u", ++number);
>>>> +       }
>>>> +    } else {
>>>> +       memory_region_add_subregion(sysmem, 0, ram);
>>>>      }
>>>>      g_free(name);
>>>>  
>>>> @@ -257,7 +276,7 @@ static void ccw_init(MachineState *machine)
>>>>  
>>>>      s390_sclp_init();
>>>>      /* init memory + setup max page size. Required for the CPU model */
>>>> -    s390_memory_init(machine->ram_size);
>>>> +    s390_memory_init(machine);
>>>>  
>>>>      /* init CPUs (incl. CPU model) early so s390_has_feature() works */
>>>>      s390_init_cpus(machine);
>>>> @@ -667,8 +686,11 @@ static void ccw_machine_4_1_instance_options(MachineState *machine)
>>>>  
>>>>  static void ccw_machine_4_1_class_options(MachineClass *mc)
>>>>  {
>>>> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
>>>> +
>>>>      ccw_machine_4_2_class_options(mc);
>>>>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>>>> +    s390mc->split_ram_layout = true;
>>>>  }
>>>>  DEFINE_CCW_MACHINE(4_1, "4.1", false);
>>>>  
>>>>  
>>>
>>> As discussed, I am not sure if adding that compat code really is worth
>>> it. :)  
>>
>> Agreed. As long as forward migration (e.g. 4.2->4.3 will work) and we document
>> that migration will fails for 2.12->.....4.1 for guests >=8TB we  can simplify
>> things.
> 
> I'll drop 3/4 and compat code in this patch.
> 
> Christian,
> 
> could you test this series on big enough host to ensure that KVM memslot splitting
> part works as expected (i.e. it's possible to start >8TB guest)?

Can you send a v3 with all changes?



Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C901C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D829C205C9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D829C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htUll-0004vj-7W
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 06:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37095)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1htUl4-0004LX-8s
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1htUl2-0006BY-RK
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1htUl2-0006AD-Io; Fri, 02 Aug 2019 06:25:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5307C09AD11;
 Fri,  2 Aug 2019 10:25:55 +0000 (UTC)
Received: from [10.36.116.87] (ovpn-116-87.ams2.redhat.com [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92DD25C207;
 Fri,  2 Aug 2019 10:25:53 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190802093854.5343-1-imammedo@redhat.com>
 <20190802093854.5343-5-imammedo@redhat.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <d96d27c6-0bef-f319-bb92-98f654d7ba99@redhat.com>
Date: Fri, 2 Aug 2019 12:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190802093854.5343-5-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 02 Aug 2019 10:25:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 thuth@redhat.com, borntraeger@de.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.08.19 11:38, Igor Mammedov wrote:
> s390 was trying to solve limited KVM memslot size issue by abusing
> memory_region_allocate_system_memory(), which breaks API contract
> where the function might be called only once.
> 
> s390 should have used memory aliases to fragment inital memory into
> smaller chunks to satisfy KVM's memslot limitation. But its a bit
> late now, since allocated pieces are transfered in migration stream
> separately, so it's not possible to just replace broken layout with
> correct one. To workaround issue, MemoryRegion alases are made
> migratable and this patch switches to use them to split big initial
> RAM chunk into smaller pieces (KVM_SLOT_MAX_BYTES max) and registers
> aliases for migration. That should keep migration compatible with
> previous QEMU versions.
> 
> New machine types (since 4.2) will use single memory region, which
> will get transimitted in migration stream as a whole RAMBlock.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> I don't have access to a suitable system to test it, so I've simulated
> it with smaller chunks on x84 host. Ping-pong migration between old
> and new QEMU worked fine. KVM part should be fine as memslots
> using mapped MemoryRegions (in this case it would be aliases) as
> far as I know but is someone could test it on big enough host it
> would be nice.
> ---
>  include/hw/s390x/s390-virtio-ccw.h |  4 +++
>  hw/s390x/s390-virtio-ccw.c         | 56 +++++++++++++++++++++---------
>  2 files changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index 00632f94b4..f9ed3737f8 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -21,6 +21,9 @@
>  #define S390_MACHINE_CLASS(klass) \
>      OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE)
>  
> +#define S390_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(S390CcwMachineClass, (obj), TYPE_S390_CCW_MACHINE)
> +
>  /*
>   * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
>   * as the dirty bitmap must be managed by bitops that take an int as
> @@ -50,6 +53,7 @@ typedef struct S390CcwMachineClass {
>      bool cpu_model_allowed;
>      bool css_migration_enabled;
>      bool hpage_1m_allowed;
> +    bool split_ram_layout;
>  } S390CcwMachineClass;
>  
>  /* runtime-instrumentation allowed by the machine */
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 073672f9cb..9160c1ed0a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -151,28 +151,47 @@ static void virtio_ccw_register_hcalls(void)
>                                     virtio_ccw_hcall_early_printk);
>  }
>  
> -static void s390_memory_init(ram_addr_t mem_size)
> +static void s390_memory_init(MachineState *ms)
>  {
> +    S390CcwMachineClass *s390mc = S390_MACHINE_GET_CLASS(ms);
>      MemoryRegion *sysmem = get_system_memory();
> -    ram_addr_t chunk, offset = 0;
> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      unsigned int number = 0;
>      Error *local_err = NULL;
> -    gchar *name;
> +    ram_addr_t mem_size = ms->ram_size;
> +    gchar *name = g_strdup_printf(s390mc->split_ram_layout ?
> +                                  "s390.whole.ram" : "s390.ram");
>  
>      /* allocate RAM for core */
> -    name = g_strdup_printf("s390.ram");
> -    while (mem_size) {
> -        MemoryRegion *ram = g_new(MemoryRegion, 1);
> -        uint64_t size = mem_size;
> -
> -        /* KVM does not allow memslots >= 8 TB */
> -        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
> -        memory_region_allocate_system_memory(ram, NULL, name, chunk);
> -        memory_region_add_subregion(sysmem, offset, ram);
> -        mem_size -= chunk;
> -        offset += chunk;
> -        g_free(name);
> -        name = g_strdup_printf("s390.ram.%u", ++number);
> +    memory_region_allocate_system_memory(ram, NULL, name, mem_size);
> +
> +    /* migration compatible RAM handling for 4.1 and older machines */
> +    if (s390mc->split_ram_layout) {
> +       ram_addr_t chunk, offset = 0;
> +       /*
> +        * memory_region_allocate_system_memory() registers allocated RAM for
> +        * migration, however for compat reasons the RAM should be passed over
> +        * as RAMBlocks of the size upto KVM_SLOT_MAX_BYTES. So unregister just
> +        * allocated RAM so it won't be migrated directly. Aliases will take care
> +        * of segmenting RAM into legacy chunks that migration compatible.
> +        */
> +       vmstate_unregister_ram(ram, NULL);
> +       name = g_strdup_printf("s390.ram");
> +       while (mem_size) {
> +           MemoryRegion *alias = g_new(MemoryRegion, 1);
> +
> +           /* KVM does not allow memslots >= 8 TB */
> +           chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
> +           memory_region_init_alias(alias, NULL, name, ram, offset, chunk);
> +           vmstate_register_ram_global(alias);
> +           memory_region_add_subregion(sysmem, offset, alias);
> +           mem_size -= chunk;
> +           offset += chunk;
> +           g_free(name);
> +           name = g_strdup_printf("s390.ram.%u", ++number);
> +       }
> +    } else {
> +       memory_region_add_subregion(sysmem, 0, ram);
>      }
>      g_free(name);
>  
> @@ -257,7 +276,7 @@ static void ccw_init(MachineState *machine)
>  
>      s390_sclp_init();
>      /* init memory + setup max page size. Required for the CPU model */
> -    s390_memory_init(machine->ram_size);
> +    s390_memory_init(machine);
>  
>      /* init CPUs (incl. CPU model) early so s390_has_feature() works */
>      s390_init_cpus(machine);
> @@ -667,8 +686,11 @@ static void ccw_machine_4_1_instance_options(MachineState *machine)
>  
>  static void ccw_machine_4_1_class_options(MachineClass *mc)
>  {
> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
> +
>      ccw_machine_4_2_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
> +    s390mc->split_ram_layout = true;
>  }
>  DEFINE_CCW_MACHINE(4_1, "4.1", false);
>  
> 

As discussed, I am not sure if adding that compat code really is worth
it. :)

-- 

Thanks,

David / dhildenb


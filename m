Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154B0C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC4520776
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC4520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJbzQ-0004Jh-VM
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJbyc-0003eo-IG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJbya-0002WJ-Vj
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:56:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jJbya-0002UF-OU
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:56:08 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 031BXCYT096216
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2020 07:56:06 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3022r08dus-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 07:56:06 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Wed, 1 Apr 2020 12:55:49 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 1 Apr 2020 12:55:45 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 031Bstut40763676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Apr 2020 11:54:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD81A52050;
 Wed,  1 Apr 2020 11:55:58 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.71.143])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0E7EA5204E;
 Wed,  1 Apr 2020 11:55:58 +0000 (GMT)
Subject: Re: [PATCH v2] vl/s390: fixup ram sizes for compat machines
To: David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Cornelia Huck <cohuck@redhat.com>
References: <20200401085014.100125-1-borntraeger@de.ibm.com>
 <da218b9e-1551-08c5-86e4-9f9837901974@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Wed, 1 Apr 2020 13:55:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <da218b9e-1551-08c5-86e4-9f9837901974@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040111-0016-0000-0000-000002FC4D7A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040111-0017-0000-0000-0000336011C2
Message-Id: <5f3f603e-6e1e-d157-554c-219e63fb438c@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-01_01:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010104
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 01.04.20 10:58, David Hildenbrand wrote:
> On 01.04.20 10:50, Christian Borntraeger wrote:
>> Older QEMU versions did fixup the ram size to match what can be reported
>> via sclp. We need to mimic this behaviour for machine types 4.2 and
>> older to not fail on inbound migration for memory sizes that do not fit.
>> Old machines with proper aligned memory sizes are not affected.
>>
>> Alignment table:
>>  VM size (<=) | Alignment
>> --------------------------
>>       1020M   |     1M
>>       2040M   |     2M
>>       4080M   |     4M
>>       8160M   |     8M
>>      16320M   |    16M
>>      32640M   |    32M
>>      65280M   |    64M
>>     130560M   |   128M
>>     261120M   |   256M
>>     522240M   |   512M
>>    1044480M   |     1G
>>    2088960M   |     2G
>>    4177920M   |     4G
>>    8355840M   |     8G
>>
>> Suggested action is to replace unaligned -m value with a suitable
>> aligned one or to use a machine version >= 5.0 as future versions might
>> remove the compatibility handling.
>>
>> For machine types >= 5.0 we can simply use an increment size of 1M and
>> use the full range of increment number which allows for all possible
>> memory sizes. The old limitation of having a maximum of 1020 increments
>> was added for standby memory, which we no longer support. With that we
>> can now support even weird memory sizes like 10001234 MB.
>>
> 
> You should probably add while the maxram_size changes are done.

Yes, I need to mention the maxram changes.

> 
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -27,6 +27,7 @@
>>  #include "qemu/ctype.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/option.h"
>> +#include "qemu/qemu-print.h"
>>  #include "s390-pci-bus.h"
>>  #include "sysemu/reset.h"
>>  #include "hw/s390x/storage-keys.h"
>> @@ -579,6 +580,23 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
>>      s390_cpu_restart(S390_CPU(cs));
>>  }
>>  
>> +static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
>> +{
>> +    /* same logic as in sclp.c */
>> +    int increment_size = 20;
> 
> missing empty line

ack.

 
>> +    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
>> +        increment_size++;
>> +    }
>> +    if (sz != sz >> increment_size << increment_size) {
> 
> I'd just cache the calculation so ...

something like

    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
        increment_size++;
    }
    newsz = sz >> increment_size << increment_size;
    
    if (sz != newsz) {
        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
                    "MB to match machine restrictions. Consider updating "
                    "the guest definition.\n",
                    sz / MiB, newsz / MiB);
    }
    return newsz;

?

> 
>> +        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
>> +                    "MB to match machine restrictions. Consider updating "
>> +                    "the guest definition.\n",
>> +                    sz / 1048576,
>> +                    (sz >> increment_size << increment_size) / 1048576);
> 
> .. this looks less ugly.
> 
> Please use MiB instead of 1048576. (see my original patch)

ack.
 

>> +    }
>> +    return sz >> increment_size << increment_size;
>> +}
>> +
>>  static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -808,6 +826,7 @@ static void ccw_machine_4_2_instance_options(MachineState *machine)
>>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>>  {
>>      ccw_machine_5_0_class_options(mc);
>> +    mc->fixup_ram_size = s390_fixup_ram_size;
>>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>>  }
>>  DEFINE_CCW_MACHINE(4_2, "4.2", false);
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index d8ae207731..d843c8fea2 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -346,7 +346,7 @@ static void sclp_realize(DeviceState *dev, Error **errp)
>>       */
>>      qdev_set_parent_bus(DEVICE(sclp->event_facility), sysbus_get_default());
>>  
>> -    ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
>> +    ret = s390_set_memory_limit(machine->ram_size, &hw_limit);
> 
> I mentioned in my patch why I left this as is. But we can change that
> with memory hotplug support.

Ok, will drop this.

> 
> 
>>      if (ret == -E2BIG) {
>>          error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
>>                     hw_limit / GiB);
>> @@ -361,27 +361,20 @@ out:
>>  static void sclp_memory_init(SCLPDevice *sclp)
>>  {
>>      MachineState *machine = MACHINE(qdev_get_machine());
>> +    MachineClass *machine_class = MACHINE_GET_CLASS(qdev_get_machine());
>>      ram_addr_t initial_mem = machine->ram_size;
>>      int increment_size = 20;
>>  
>>      /* The storage increment size is a multiple of 1M and is a power of 2.
>> -     * The number of storage increments must be MAX_STORAGE_INCREMENTS or fewer.
>> +     * For some machine types, the number of storage increments must be
>> +     * MAX_STORAGE_INCREMENTS or fewer.
>>       * The variable 'increment_size' is an exponent of 2 that can be
>>       * used to calculate the size (in bytes) of an increment. */
>> -    while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
>> +    while (machine_class->fixup_ram_size != NULL &&
>> +           (initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
>>          increment_size++;
>>      }
>>      sclp->increment_size = increment_size;
> 
> IIRC one could define ram size in KB. Not sure if it is worth checking
> against that.
> [...]

If this is not aligned to 1MB, that would already fail when registering the memslot, I think.


> 
>>  static void sclp_init(Object *obj)
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 236d239c19..0532143327 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -152,6 +152,12 @@ typedef struct {
>>   *    It also will be used as a way to optin into "-m" option support.
>>   *    If it's not set by board, '-m' will be ignored and generic code will
>>   *    not create default RAM MemoryRegion.
>> + * @fixup_ram_size:
>> + *    amends user provided ram size (with -m option) using machine
> 
> s/amends/Amends/

ack
 
>> + *    specific algorithm. to be used by old machine types for compat
> 
> s/to/To/


ack

>> + *    purposes only.
>> + *    Applies only to default memory backend, i.e. explicit memory backend
> 
> "i.e.,"

ack



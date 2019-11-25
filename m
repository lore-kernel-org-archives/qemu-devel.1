Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C366C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062A120674
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7KBxTHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062A120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEEs-0005Xf-NC
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iZEAi-0002QX-47
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iZEAg-0001yt-CY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:12:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30568
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iZEAg-0001xI-7Q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574687573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCj9Yfp+83ssIsc/IRJb5o8YNorZE1O//gJcW+rMbFs=;
 b=M7KBxTHRSMqXTpjhq7aRxsaIMGgXaIJO/n74x/69e9VaID0Qwg1IOOOvGK0aKKGZfF58w1
 GFOsuLaE/ahzEvg98TRhGoBB1DmTDmY+orTt7lDMxwscc0McPKLn8H8ffs4a3Oe9IaAqRn
 xpXFipqb/3J8jUxJDmGdYVnugUvT74k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-bN1DQj8pMdCbiiwz9gW-dw-1; Mon, 25 Nov 2019 08:12:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70450805BC1;
 Mon, 25 Nov 2019 13:12:47 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 479535D6A0;
 Mon, 25 Nov 2019 13:12:37 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 12/20] qapi: Introduce DEFINE_PROP_INTERVAL
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-13-eric.auger@redhat.com>
 <20191122190343.GP2785@work-vm>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5b19eb33-ae98-d72f-3e6b-646543070388@redhat.com>
Date: Mon, 25 Nov 2019 14:12:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191122190343.GP2785@work-vm>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: bN1DQj8pMdCbiiwz9gW-dw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dave,

On 11/22/19 8:03 PM, Dr. David Alan Gilbert wrote:
> * Eric Auger (eric.auger@redhat.com) wrote:
>> Introduce a new property defining a labelled interval:
>> <low address>,<high address>,label.
>>
>> This will be used to encode reserved IOVA regions. The label
>> is left undefined to ease reuse accross use cases.
>>
>> For instance, in virtio-iommu use case, reserved IOVA regions
>> will be passed by the machine code to the virtio-iommu-pci
>> device (an array of those). The label will match the
>> virtio_iommu_probe_resv_mem subtype value:
>> - VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)
>> - VIRTIO_IOMMU_RESV_MEM_T_MSI (1)
>>
>> This is used to inform the virtio-iommu-pci device it should
>> bypass the MSI region: 0xfee00000, 0xfeefffff, 1.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/core/qdev-properties.c    | 90 ++++++++++++++++++++++++++++++++++++
>>  include/exec/memory.h        |  6 +++
>>  include/hw/qdev-properties.h |  3 ++
>>  include/qemu/typedefs.h      |  1 +
>>  4 files changed, 100 insertions(+)
>>
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index ac28890e5a..8d70f34e37 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -13,6 +13,7 @@
>>  #include "qapi/visitor.h"
>>  #include "chardev/char.h"
>>  #include "qemu/uuid.h"
>> +#include "qemu/cutils.h"
>>  
>>  void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>>                                    Error **errp)
>> @@ -585,6 +586,95 @@ const PropertyInfo qdev_prop_macaddr = {
>>      .set   = set_mac,
>>  };
>>  
>> +/* --- Labelled Interval --- */
>> +
>> +/*
>> + * accepted syntax versions:
>> + *   <low address>,<high address>,<type>
>> + *   where low/high addresses are uint64_t in hexa (feat. 0x prefix)
>> + *   and type is an unsigned integer
>> + */
>> +static void get_interval(Object *obj, Visitor *v, const char *name,
>> +                         void *opaque, Error **errp)
>> +{
>> +    DeviceState *dev = DEVICE(obj);
>> +    Property *prop = opaque;
>> +    Interval *interval = qdev_get_prop_ptr(dev, prop);
>> +    char buffer[64];
>> +    char *p = buffer;
>> +
>> +    snprintf(buffer, sizeof(buffer), "0x%"PRIx64",0x%"PRIx64",%d",
>> +             interval->low, interval->high, interval->type);
>> +
>> +    visit_type_str(v, name, &p, errp);
>> +}
>> +
>> +static void set_interval(Object *obj, Visitor *v, const char *name,
>> +                         void *opaque, Error **errp)
>> +{
>> +    DeviceState *dev = DEVICE(obj);
>> +    Property *prop = opaque;
>> +    Interval *interval = qdev_get_prop_ptr(dev, prop);
>> +    Error *local_err = NULL;
>> +    unsigned int type;
>> +    gchar **fields;
>> +    uint64_t addr;
>> +    char *str;
>> +    int ret;
>> +
>> +    if (dev->realized) {
>> +        qdev_prop_set_after_realize(dev, name, errp);
>> +        return;
>> +    }
>> +
>> +    visit_type_str(v, name, &str, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    fields = g_strsplit(str, ",", 3);
>> +
>> +    ret = qemu_strtou64(fields[0], NULL, 16, &addr);
>> +    if (!ret) {
>> +        interval->low = addr;
>> +    } else {
>> +        error_setg(errp, "Failed to decode interval low addr");
>> +        error_append_hint(errp,
>> +                          "should be an address in hexa with 0x prefix\n");
>> +        goto out;
>> +    }
>> +
>> +    ret = qemu_strtou64(fields[1], NULL, 16, &addr);
>> +    if (!ret) {
>> +        interval->high = addr;
>> +    } else {
>> +        error_setg(errp, "Failed to decode interval high addr");
>> +        error_append_hint(errp,
>> +                          "should be an address in hexa with 0x prefix\n");
>> +        goto out;
>> +    }
>> +
>> +    ret = qemu_strtoui(fields[2], NULL, 10, &type);
>> +    if (!ret) {
>> +        interval->type = type;
>> +    } else {
>> +        error_setg(errp, "Failed to decode interval type");
>> +        error_append_hint(errp, "should be an unsigned int in decimal\n");
>> +    }
>> +out:
>> +    g_free(str);
>> +    g_strfreev(fields);
>> +    return;
>> +}
>> +
>> +const PropertyInfo qdev_prop_interval = {
>> +    .name  = "labelled_interval",
>> +    .description = "Labelled interval, example: 0xFEE00000,0xFEEFFFFF,0",
>> +    .get   = get_interval,
>> +    .set   = set_interval,
>> +};
>> +
>>  /* --- on/off/auto --- */
>>  
>>  const PropertyInfo qdev_prop_on_off_auto = {
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index e499dc215b..e238d1c352 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -57,6 +57,12 @@ struct MemoryRegionMmio {
>>      CPUWriteMemoryFunc *write[3];
>>  };
>>  
>> +struct Interval {
>> +    hwaddr low;
>> +    hwaddr high;
>> +    unsigned int type;
>> +};
>> +
> 
> Just an observation that 'Interval' is a very generic name.
> We've got 'AddrRange' but that's Int128.
As it is defined in memory.h it may make sense to rename it
ReservedRegion then?

Thanks

Eric

> 
> Dave
> 
>>  typedef struct IOMMUTLBEntry IOMMUTLBEntry;
>>  
>>  /* See address_space_translate: bit 0 is read, bit 1 is write.  */
>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>> index c6a8cb5516..2ba7c8711b 100644
>> --- a/include/hw/qdev-properties.h
>> +++ b/include/hw/qdev-properties.h
>> @@ -20,6 +20,7 @@ extern const PropertyInfo qdev_prop_chr;
>>  extern const PropertyInfo qdev_prop_tpm;
>>  extern const PropertyInfo qdev_prop_ptr;
>>  extern const PropertyInfo qdev_prop_macaddr;
>> +extern const PropertyInfo qdev_prop_interval;
>>  extern const PropertyInfo qdev_prop_on_off_auto;
>>  extern const PropertyInfo qdev_prop_losttickpolicy;
>>  extern const PropertyInfo qdev_prop_blockdev_on_error;
>> @@ -202,6 +203,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>>      DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
>>  #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
>>      DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
>> +#define DEFINE_PROP_INTERVAL(_n, _s, _f)         \
>> +    DEFINE_PROP(_n, _s, _f, qdev_prop_interval, Interval)
>>  #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
>>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
>>  #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> index 375770a80f..a827c9a3fe 100644
>> --- a/include/qemu/typedefs.h
>> +++ b/include/qemu/typedefs.h
>> @@ -58,6 +58,7 @@ typedef struct ISABus ISABus;
>>  typedef struct ISADevice ISADevice;
>>  typedef struct IsaDma IsaDma;
>>  typedef struct MACAddr MACAddr;
>> +typedef struct Interval Interval;
>>  typedef struct MachineClass MachineClass;
>>  typedef struct MachineState MachineState;
>>  typedef struct MemoryListener MemoryListener;
>> -- 
>> 2.20.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 



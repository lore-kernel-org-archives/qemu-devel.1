Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D306C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AE12229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="AJOnJrzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AE12229C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPeP-00087Y-Bc
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hvPdu-0007Bq-Q6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hvPdt-0002Cy-AU
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:22:30 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:35982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hvPdm-0001xZ-GD; Wed, 07 Aug 2019 13:22:22 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 08E2D96F50;
 Wed,  7 Aug 2019 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1565198540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCtTvLmzSiemBHeANvk3b80SP/U/qrrMI3BjFMs0KRU=;
 b=AJOnJrzWYHNUUss0+v/S9TBZc/TWqzwacIPuR/3hSPDn/SHNYfAHPRhuchM4AOVfcaVDCJ
 ESIK6tdWl/GEvFImpIGawkX+BgEujUby2BYQ3MpE7asE0IbNCwRaGQiVI0rngD6GXtZcv+
 oUk17VmHNuZfs8aPSKA/KtGTRwLOo+U=
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-8-damien.hedde@greensocs.com>
 <CAFEAcA-W0SaaGbUnGZ0b61ngxKY8R9xjwGXeN+=MaUi4bMDgNg@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <b75f5edf-671c-8f7e-2dfe-a77f76117211@greensocs.com>
Date: Wed, 7 Aug 2019 19:22:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-W0SaaGbUnGZ0b61ngxKY8R9xjwGXeN+=MaUi4bMDgNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1565198540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCtTvLmzSiemBHeANvk3b80SP/U/qrrMI3BjFMs0KRU=;
 b=DvyqHwIR0zlLaLC844zu+6NM1fxkoRF20oj1zyZ6IrFK8gpFoKjnHodxuFhYNfW5L7nnzE
 HZlwRho2lonOK70CPqoF5aLHrnHU8BwREbh+MJpohSdINJBKNUGQYLc7O6u0reEvDEa8pK
 Xu6zAQOtdjL8xYEnQJ4Kab+MGZ40UT4=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1565198540; a=rsa-sha256; cv=none;
 b=67gyvM6WuhthLMBH/RWXiZvEfcG5al9dDr/VQ6mn4hy6HgpKmVEDfaejACpQ6bBJm8YO6Z
 RPXmwDyI8VrvhJ7fFZXj1g4hI/qQYLuYwf1Q/urvdLH3MH7flrkHFFJXqWfdojDrYEt0S8
 N1k6Rprr824vXOQmwDvesgQUPb2es7Q=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 07/33] automatically add vmstate for
 reset support in devices
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/7/19 5:07 PM, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> This add the reset related sections for every QOM
>> device.
> 
> A bit more detail in the commit message would help, I think --
> this is adding extra machinery which has to copy and modify
> the VMStateDescription passed in by the device in order to
> add the subsection that handles reset.

Sorry for that, thought I've added some...

I've kept this patch separate from previous one because this it is
awkward. I'm not sure this is the right place (I mean in qdev files) do
this kind of stuff. It basically replaces every static vmsd by dynamic
ones, so it makes it harder to follow when debugging since there is no
symbol associated to them. But on the other hand, I don't see an
alternative.

I copy there what I've put in the cover-letter:
For devices, I've added a patch to automate the addition of reset
related subsection. In consequence it is not necessary to explicitly add
the reset subsection in every device specialization requiring it.
Right know this is kind of a hack into qdev to dynamically modify the
vmsd before the registration. There is probably a much cleaner way to do
this but I prefered to demonstrate it by keeping modification local to qdev.
As far as I can tell it's ok to dynamically add subsections at the end.
This does not prevent from further adding subsections in the orignal
vmsd: the subsections order in the array is irrelevant from migration
point-of-view. The loading part just lookup each subsection in the array
by name uppon reception.

> 
> I've added Dave Gilbert to the already long cc list since this
> is migration related.
> 
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  hw/core/qdev-vmstate.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>  hw/core/qdev.c         | 12 +++++++++++-
>>  include/hw/qdev-core.h |  3 +++
>>  stubs/Makefile.objs    |  1 +
>>  stubs/device.c         |  7 +++++++
>>  5 files changed, 63 insertions(+), 1 deletion(-)
>>  create mode 100644 stubs/device.c
>>
>> diff --git a/hw/core/qdev-vmstate.c b/hw/core/qdev-vmstate.c
>> index 07b010811f..24f8465c61 100644
>> --- a/hw/core/qdev-vmstate.c
>> +++ b/hw/core/qdev-vmstate.c
>> @@ -43,3 +43,44 @@ const struct VMStateDescription device_vmstate_reset = {
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
>> +
>> +static VMStateDescription *vmsd_duplicate_and_append(
>> +        const VMStateDescription *old_vmsd,
>> +        const VMStateDescription *new_subsection)
>> +{
>> +    VMStateDescription *vmsd;
>> +    int n = 0;
>> +
>> +    assert(old_vmsd && new_subsection);
>> +
>> +    vmsd = (VMStateDescription *) g_memdup(old_vmsd, sizeof(*vmsd));
>> +
>> +    if (old_vmsd->subsections) {
>> +        while (old_vmsd->subsections[n]) {
>> +            n += 1;
>> +        }
>> +    }
>> +    vmsd->subsections = g_new(const VMStateDescription *, n + 2);
>> +
>> +    if (old_vmsd->subsections) {
>> +        memcpy(vmsd->subsections, old_vmsd->subsections,
>> +               sizeof(VMStateDescription *) * n);
>> +    }
>> +    vmsd->subsections[n] = new_subsection;
>> +    vmsd->subsections[n + 1] = NULL;
>> +
>> +    return vmsd;
>> +}
>> +
>> +void device_class_build_extended_vmsd(DeviceClass *dc)
>> +{
>> +    assert(dc->vmsd);
>> +    assert(!dc->vmsd_ext);
>> +
>> +    /* forge a subsection with proper name */
>> +    VMStateDescription *reset;
>> +    reset = g_memdup(&device_vmstate_reset, sizeof(*reset));
>> +    reset->name = g_strdup_printf("%s/device_reset", dc->vmsd->name);
>> +
>> +    dc->vmsd_ext = vmsd_duplicate_and_append(dc->vmsd, reset);
>> +}
> 
> This will allocate memory, but there is no corresponding
> code which frees it. This means you'll have a memory leak
> across device realize->unrealize for hotplug devices.

Right. I'll handle this along with the existing vmsd_unregister
in realize/unrealize method.

> 
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index e9e5f2d5f9..88387d3743 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -45,7 +45,17 @@ bool qdev_hot_removed = false;
>>  const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
>>  {
>>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
>> -    return dc->vmsd;
>> +
>> +    if (!dc->vmsd) {
>> +        return NULL;
>> +    }
>> +
>> +    if (!dc->vmsd_ext) {
>> +        /* build it first time we need it */
>> +        device_class_build_extended_vmsd(dc);
>> +    }
>> +
>> +    return dc->vmsd_ext;
>>  }
> 
> Unfortunately not everything that wants the VMSD calls
> this function. migration/savevm.c:dump_vmstate_json_to_file()
> does a direct access to dc->vmsd, so we need to fix that first.
> 
> Devices which don't use dc->vmsd won't get this and so
> their reset state won't be migrated. That's OK for anything
> that's still not yet a QOM device, I guess -- it's not possible
> for them to be in a 'held in reset' state anyway, so the
> extra subsection would never be needed.
> 
> The one I'm less sure about is the 'virtio' devices, which
> have to do something odd with migration state for backwards
> compat reasons. At the moment they can't be in a situation
> where they're being held in reset when we do a migration,
> but since they're PCI devices they might in future be possible
> to put into new boards/pci controllers that would let them
> be in that situation.
> 
>>  static void bus_remove_child(BusState *bus, DeviceState *child)
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 1670ae41bb..926d4bbcb1 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -120,6 +120,7 @@ typedef struct DeviceClass {
>>
>>      /* device state */
>>      const struct VMStateDescription *vmsd;
>> +    const struct VMStateDescription *vmsd_ext;
>>
>>      /* Private to qdev / bus.  */
>>      const char *bus_type;
>> @@ -520,6 +521,8 @@ void device_class_set_parent_unrealize(DeviceClass *dc,
>>
>>  const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
>>
>> +void device_class_build_extended_vmsd(DeviceClass *dc);
>> +
>>  const char *qdev_fw_name(DeviceState *dev);
>>
>>  Object *qdev_get_machine(void);
>> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
>> index 9c7393b08c..432b56f290 100644
>> --- a/stubs/Makefile.objs
>> +++ b/stubs/Makefile.objs
>> @@ -40,4 +40,5 @@ stub-obj-y += pci-host-piix.o
>>  stub-obj-y += ram-block.o
>>  stub-obj-y += ramfb.o
>>  stub-obj-y += fw_cfg.o
>> +stub-obj-y += device.o
>>  stub-obj-$(CONFIG_SOFTMMU) += semihost.o
>> diff --git a/stubs/device.c b/stubs/device.c
>> new file mode 100644
>> index 0000000000..e9b4f57e5f
>> --- /dev/null
>> +++ b/stubs/device.c
>> @@ -0,0 +1,7 @@
>> +#include "qemu/osdep.h"
>> +#include "hw/qdev-core.h"
>> +
>> +void device_class_build_extended_vmsd(DeviceClass *dc)
>> +{
>> +    return;
>> +}
>> --
>> 2.22.0
> 
> 
> thanks
> -- PMM
> 


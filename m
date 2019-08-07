Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD85C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93979222FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Yho5747o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93979222FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPFl-0001zJ-Op
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49329)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hvPFL-0001P3-84
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hvPFJ-0004OX-VU
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:57:07 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:35182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hvPFE-0004Em-8g; Wed, 07 Aug 2019 12:57:00 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 3415296F50;
 Wed,  7 Aug 2019 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1565197017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXY7K4YIlJui1wCXpDlV3I+Oqpy2MwzkeCka4cjwYn8=;
 b=Yho5747ojy5/6V1iP4phjGjCN1ktpQVkq1bQYc5yG9buJ9GGViz1bI6POH/7ILpXIySHz+
 H9i2FWYeu3OexK93xHFTYzshLYKnRsPe9JPnmojBveukIFZLEZAemO6mbLQvN++K/GN342
 9CDFX2pGQFWkkR+TuiQqfbwwTZZFTgo=
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-9-damien.hedde@greensocs.com>
 <CAFEAcA_M5fOoQ8yN_1QhJ-WOLxra6B-Ltwh2DHtq6erz4V0a2A@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <4958551b-0202-f82b-9133-457c8051e5aa@greensocs.com>
Date: Wed, 7 Aug 2019 18:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_M5fOoQ8yN_1QhJ-WOLxra6B-Ltwh2DHtq6erz4V0a2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1565197018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXY7K4YIlJui1wCXpDlV3I+Oqpy2MwzkeCka4cjwYn8=;
 b=61AVsz7zqLUFkN7BIfUVT8fBWXRM+POfnb7qv9KgmZ3QA48uaKuLCLP/znF8qEL7fS2qH7
 te+awcniYql1A1wryXGmDISY27u/v0haKL0XfNMRT0yJOdXelkmvY1tYWqMpKkHWYmWZrP
 rH4fyIiyL93t+1IxZtE79mzGZI21aP8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1565197018; a=rsa-sha256; cv=none;
 b=KwTYywea0LmbjsmozgCLPolJ4X58HGkBelUk2XYAzWuTyz0YR46sITCn1Eb2ZttN6yVvt2
 RtnJ0Al2UM+B+zh/TvtO9xgpSwZE1hyFHYj4qkfN8XSJrD32ahPrY5SDcilW2zwSxQ1kIS
 66cAsP+TYZmfhxdDhGCaOzrLNfCwxLs=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 08/33] Add function to control reset
 with gpio inputs
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
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/7/19 5:18 PM, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> It adds the possibility to add 2 gpios to control the warm and cold reset.
>> With theses ios, the reset can be maintained during some time.
>> Each io is associated with a state to detect level changes.
>>
>> Vmstate subsections are also added to the existsing device_reset
>> subsection.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  hw/core/qdev-vmstate.c | 15 ++++++++++
>>  hw/core/qdev.c         | 65 ++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/qdev-core.h | 57 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 137 insertions(+)
>>
>> diff --git a/hw/core/qdev-vmstate.c b/hw/core/qdev-vmstate.c
>> index 24f8465c61..72f84c6cee 100644
>> --- a/hw/core/qdev-vmstate.c
>> +++ b/hw/core/qdev-vmstate.c
>> @@ -24,10 +24,23 @@ static int device_vmstate_reset_post_load(void *opaque, int version_id)
>>  {
>>      DeviceState *dev = (DeviceState *) opaque;
>>      BusState *bus;
>> +    uint32_t io_count = 0;
>> +
>>      QLIST_FOREACH(bus, &dev->child_bus, sibling) {
>>          bus->resetting = dev->resetting;
>>          bus->reset_is_cold = dev->reset_is_cold;
>>      }
>> +
>> +    if (dev->cold_reset_input.state) {
>> +        io_count += 1;
>> +    }
>> +    if (dev->warm_reset_input.state) {
>> +        io_count += 1;
>> +    }
>> +    /* ensure resetting count is coherent with io states */
>> +    if (dev->resetting < io_count) {
>> +        return -1;
>> +    }
>>      return 0;
>>  }
>>
>> @@ -40,6 +53,8 @@ const struct VMStateDescription device_vmstate_reset = {
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT32(resetting, DeviceState),
>>          VMSTATE_BOOL(reset_is_cold, DeviceState),
>> +        VMSTATE_BOOL(cold_reset_input.state, DeviceState),
>> +        VMSTATE_BOOL(warm_reset_input.state, DeviceState),
> 
> If we're just adding these fields to this VMStateDescription
> then this patch should come earlier in the series than the
> patch where we create and start using the fields. Otherwise
> there's a migration compat break between a QEMU just
> before this patch and a QEMU with it. I think the simplest
> fix is to put this patch before patches 6/7 and have a note
> in the commit message that this functionality can't be used
> until after the patch which adds the migration support.

Independently of the compat break you mention, maybe it is better to
have 'conditional' subsection for each input ?

> 
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 88387d3743..11a4de55ea 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -450,6 +450,67 @@ void qdev_init_gpio_in(DeviceState *dev, qemu_irq_handler handler, int n)
>>      qdev_init_gpio_in_named(dev, handler, NULL, n);
>>  }
>>
>> +static DeviceResetInputState *device_get_reset_input_state(DeviceState *dev,
>> +                                                            bool cold)
>> +{
>> +    return cold ? &dev->cold_reset_input : &dev->warm_reset_input;
>> +}
>> +
>> +static void device_reset_handler(DeviceState *dev, bool cold, bool level)
>> +{
>> +    DeviceResetInputState *dris = device_get_reset_input_state(dev, cold);
>> +
>> +    if (dris->type == DEVICE_RESET_ACTIVE_LOW) {
>> +        level = !level;
>> +    }
>> +
>> +    if (dris->state == level) {
>> +        /* io state has not changed */
>> +        return;
>> +    }
>> +
>> +    dris->state = level;
>> +
>> +    if (level) {
>> +        resettable_assert_reset(OBJECT(dev), cold);
>> +    } else {
>> +        resettable_deassert_reset(OBJECT(dev));
>> +    }
>> +}
>> +
>> +static void device_cold_reset_handler(void *opaque, int n, int level)
>> +{
>> +    device_reset_handler((DeviceState *) opaque, true, level);
>> +}
>> +
>> +static void device_warm_reset_handler(void *opaque, int n, int level)
>> +{
>> +    device_reset_handler((DeviceState *) opaque, false, level);
>> +}
>> +
>> +void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
>> +                                   bool cold, DeviceResetActiveType type)
>> +{
>> +    DeviceResetInputState *dris = device_get_reset_input_state(dev, cold);
>> +    qemu_irq_handler handler;
>> +
>> +    switch (type) {
>> +    case DEVICE_RESET_ACTIVE_LOW:
>> +    case DEVICE_RESET_ACTIVE_HIGH:
>> +        break;
>> +    default:
>> +        assert(false);
>> +        break;
> 
> The usual way to write this is
>     g_assert_not_reached();
> (and no following 'break').
> 
> 
> But the whole switch statement seems to be a complicated way
> of writing
>    assert(type == DEVICE_RESET_ACTIVE_LOW || type == DEVICE_RESET_ACTIVE_HIGH);
> 
>> +    }
>> +
>> +    assert(!dris->exists);
>> +    dris->exists = true;
>> +    dris->type = type;
>> +
>> +    handler = cold ? device_cold_reset_handler : device_warm_reset_handler;
>> +    qdev_init_gpio_in_named(dev, handler, name, 1);
>> +}
> 
> thanks
> -- PMM
> 


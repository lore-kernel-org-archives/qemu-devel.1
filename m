Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54974C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991692151B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roamqtDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991692151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKIIN-0008Cn-FM
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKIHn-0007lW-Nr
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:39:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKIHl-0002LX-RC
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:39:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so11981516wrm.9
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VcLJFGG8URWd1OLhephwidSsluPQw+CIfQGJ8Sxq3ic=;
 b=roamqtDLAL5YsZfO9/KR5RG/2ffPLHHOoV9PSohEZHPVt4hKiXU/1zgQ+x+fyYAB2w
 BY0MhNgYdEOdRF2m+z6vf0jc+6gE5uKT2Ylw6kBq6IQ357GoK6ZHettEzHzLc6lVUWsL
 WRdvb96RXC0R0bzWDSjKXcoNTtpXt4EmlQ64nZ5IbNpohCI1FOxpSa8pOzSDwqHjIcnB
 Y7N5TNRI2ZIJzmvY2ofGksl14+rgPb5QtAOc7E827lCmBAA9frdcZs9CE8xqizsa5i1b
 JVBQFTmCSiTD701flUX33w6CZ9lATu2xYIjdD+OoU9pPpo5i1yWN3d0FOptE+JyznPHK
 uPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VcLJFGG8URWd1OLhephwidSsluPQw+CIfQGJ8Sxq3ic=;
 b=az2NBOBL5KnNmCAAzNxYhzAM+szIgm1L4uD/QZKLq7lKN6kXGU4hBsHdSIveurOOwp
 OkMR/N2+NdgtUSS3yG5Ez0dHLfPZDny19HCWFp6gPTx3QOMs55j3wb95yz31lbmkQm1/
 /4UeLL+mkDEZXTlrK5duM8ckNDWY3JtzTuCPPwB74a+Aml84CkuuyyBMFTpELheJpULa
 im/waxp+7bk3j+o+tVLx9zDAmEP+Rd5byEhVtpU8cBkB87WU39dRc2QdErIwNtmvzVJZ
 ff8cnPJL8dXUNqlEkYLN9SonwPY4DHu9Bm9abcmr7JGs/7NTabz9DejGSkaeZku2/ezY
 RF8A==
X-Gm-Message-State: AOAM533ImoDPESPH36Zy8F9kzm5teIaflCcqLy/Vpp8A/vKy1Pmpnrwt
 xme3baB7e5DJnI+/ouN1Urg=
X-Google-Smtp-Source: ABdhPJwe1po0r5iXHFfUJ6uusPCa0GAmbsUvJteSW+fc+yD8EG5VqjTwYwptFYKGoZiw51N7Y+du0Q==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr6532650wrb.70.1600681140139;
 Mon, 21 Sep 2020 02:39:00 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 91sm21212929wrq.9.2020.09.21.02.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 02:38:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] qdev: Let BusRealize() return a boolean value to
 indicate error
To: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20200920114416.353277-1-f4bug@amsat.org>
 <20200920114416.353277-3-f4bug@amsat.org> <87eemva6eq.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2ec97e06-8ecb-835f-f6e6-a0bbf8c4dc00@amsat.org>
Date: Mon, 21 Sep 2020 11:38:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87eemva6eq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 10:19 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Commit 9940b2cfbc0 introduced qdev_realize() and qbus_realize()
>> with the ability to return a boolean value if an error occured,
>> thus the caller does not need to check if the Error* pointer is
>> set.
>> Provide the same ability to the BusRealize type.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/qdev-core.h | 14 +++++++++++++-
>>  hw/hyperv/vmbus.c      |  5 +++--
>>  hw/nubus/nubus-bus.c   |  5 +++--
>>  hw/pci/pci.c           | 12 +++++++++---
>>  hw/xen/xen-bus.c       |  5 +++--
>>  5 files changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 02ac1c50b7f..eecfe794a71 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -32,7 +32,19 @@ typedef enum DeviceCategory {
>>  typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
>>  typedef void (*DeviceUnrealize)(DeviceState *dev);
>>  typedef void (*DeviceReset)(DeviceState *dev);
>> -typedef void (*BusRealize)(BusState *bus, Error **errp);
>> +/**
>> + * BusRealize: Realize @bus.
>> + * @bus: bus to realize
>> + * @errp: pointer to error object
>> + *
>> + * On success, return true.
>> + * On failure, store an error through @errp and return false.
>> + */
>> +typedef bool (*BusRealize)(BusState *bus, Error **errp);
>> +/**
>> + * BusUnrealize: Unrealize @bus.
>> + * @bus: bus to unrealize
>> + */
>>  typedef void (*BusUnrealize)(BusState *bus);
>>  
>>  /**
>> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
>> index 6ef895bc352..8a0452b2464 100644
>> --- a/hw/hyperv/vmbus.c
>> +++ b/hw/hyperv/vmbus.c
>> @@ -2487,7 +2487,7 @@ static const TypeInfo vmbus_dev_type_info = {
>>      .instance_init = vmbus_dev_instance_init,
>>  };
>>  
>> -static void vmbus_realize(BusState *bus, Error **errp)
>> +static bool vmbus_realize(BusState *bus, Error **errp)
>>  {
>>      int ret = 0;
>>      Error *local_err = NULL;
>> @@ -2519,7 +2519,7 @@ static void vmbus_realize(BusState *bus, Error **errp)
>>          goto clear_event_notifier;
>>      }
>>  
>> -    return;
>> +    return true;
>>  
>>  clear_event_notifier:
>>      event_notifier_cleanup(&vmbus->notifier);
>> @@ -2528,6 +2528,7 @@ remove_msg_handler:
>>  error_out:
>>      qemu_mutex_destroy(&vmbus->rx_queue_lock);
>>      error_propagate(errp, local_err);
>> +    return false;
>>  }
>>  
>>  static void vmbus_unrealize(BusState *bus)
>> diff --git a/hw/nubus/nubus-bus.c b/hw/nubus/nubus-bus.c
>> index 942a6d5342d..d20d9c0f72c 100644
>> --- a/hw/nubus/nubus-bus.c
>> +++ b/hw/nubus/nubus-bus.c
>> @@ -65,12 +65,13 @@ static const MemoryRegionOps nubus_super_slot_ops = {
>>      },
>>  };
>>  
>> -static void nubus_realize(BusState *bus, Error **errp)
>> +static bool nubus_realize(BusState *bus, Error **errp)
>>  {
>>      if (!nubus_find()) {
>>          error_setg(errp, "at most one %s device is permitted", TYPE_NUBUS_BUS);
>> -        return;
>> +        return false;
>>      }
>> +    return true;
>>  }
>>  
>>  static void nubus_init(Object *obj)
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index de0fae10ab9..f535ebac847 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -115,7 +115,7 @@ static void pcibus_machine_done(Notifier *notifier, void *data)
>>      }
>>  }
>>  
>> -static void pci_bus_realize(BusState *qbus, Error **errp)
>> +static bool pci_bus_realize(BusState *qbus, Error **errp)
>>  {
>>      PCIBus *bus = PCI_BUS(qbus);
>>  
>> @@ -123,13 +123,17 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
>>      qemu_add_machine_init_done_notifier(&bus->machine_done);
>>  
>>      vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_pcibus, bus);
>> +
>> +    return true;
>>  }
>>  
>> -static void pcie_bus_realize(BusState *qbus, Error **errp)
>> +static bool pcie_bus_realize(BusState *qbus, Error **errp)
>>  {
>>      PCIBus *bus = PCI_BUS(qbus);
>>  
>> -    pci_bus_realize(qbus, errp);
>> +    if (!pci_bus_realize(qbus, errp)) {
>> +        return false;
>> +    }
> 
> We now update bus->flags only when pci_bus_realize() succeeds.  Is this
> a bug fix?

Fortunate side effect :) I'll let the PCI maintainers
have a look at it.

> 
>>  
>>      /*
>>       * A PCI-E bus can support extended config space if it's the root
>> @@ -144,6 +148,8 @@ static void pcie_bus_realize(BusState *qbus, Error **errp)
>>              bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
>>          }
>>      }
>> +
>> +    return true;
>>  }
>>  
>>  static void pci_bus_unrealize(BusState *qbus)
>> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
>> index 9ce1c9540b9..d7ef5d05e37 100644
>> --- a/hw/xen/xen-bus.c
>> +++ b/hw/xen/xen-bus.c
>> @@ -444,7 +444,7 @@ static void xen_bus_unrealize(BusState *bus)
>>      }
>>  }
>>  
>> -static void xen_bus_realize(BusState *bus, Error **errp)
>> +static bool xen_bus_realize(BusState *bus, Error **errp)
>>  {
>>      XenBus *xenbus = XEN_BUS(bus);
>>      unsigned int domid;
>> @@ -478,10 +478,11 @@ static void xen_bus_realize(BusState *bus, Error **errp)
>>                            "failed to set up enumeration watch: ");
>>      }
>>  
>> -    return;
>> +    return true;
>>  
>>  fail:
>>      xen_bus_unrealize(bus);
>> +    return false;
>>  }
>>  
>>  static void xen_bus_unplug_request(HotplugHandler *hotplug,
> 
> I can't see an actual use of the new return value.  Am I blind?

You aren't, I'm trying to make a 240 patches series digestible
by splitting it. One device is a (hotplug) PCIe bridge, as we
can plug/unplug it, this calls multiple realize/unrealize, and
I want to be sure the children objects are properly realized
so I care about this return value.

As it seems an improvement from an API PoV (following your recent
cleanup and code style change: simplify returning boolean for Error
instead of checking *errp is set). I thought merging it the sooner
is better, but I don't have problem reposting that later.

Regards,

Phil.


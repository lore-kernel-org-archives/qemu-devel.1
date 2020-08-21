Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA491C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9625420FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+VrqfgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9625420FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97ir-0006fb-OM
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k97iG-00068u-GR; Fri, 21 Aug 2020 10:08:12 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:33266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k97iE-0004SA-Q6; Fri, 21 Aug 2020 10:08:12 -0400
Received: by mail-qv1-xf44.google.com with SMTP id dd12so679198qvb.0;
 Fri, 21 Aug 2020 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mMda8VSRHgdNRw751/JUh8T8arFMhUNr8BPRqbkx/3I=;
 b=N+VrqfgV0Ln8MyPzhySQV4zvuO70hXcVAOeF+DfaFsZkauvFR0bIDa7lBOiIuMejrU
 FpI6tlY4nIF9dhTUUV0hnXIm4+s6g+Aq8YZy4PMmGg0yXrBFebAz7R9ZwhEvwjRB8Jn1
 h+dlMge+NOF4ciIn/AzLLdX+EGJgH0phWDvJz+Wev1w+bO1HLyMsIKzf5qXeABkhH/DQ
 4LMACmB/DcjneD/9F2AGx9/NzODvbIiQsti5zz29Bq3lvyRbRcjk8iTOJhZo3yJroLHe
 5SkgFs6N/fAsnVo0MpnBYDV9qriopMxhXciAMEuF0EH7Lppn81KodHRLGRYfPvT5Xvyf
 bvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mMda8VSRHgdNRw751/JUh8T8arFMhUNr8BPRqbkx/3I=;
 b=cp8CADRJEFgOEtf+yg7HekOSnp4rSKOkBCArMrRqH9MoY0xTqsNYt/rsRuLV3FAQHd
 jKpfQqBSr0kM6pxfaGWC1B8dZbiceYfLaA8fbrA99YTxxHeeTxEXGdeVD0vYSrEw6YBL
 +8tYBEgsAlnpQFIUT9mXRqgWc+CQuq/XAzvfWgkRDUnR5nGJLOuHn+37BG8uObEh4R+e
 b8dIioV2VWeDD8M1l5oSRA1keJJHoAA3c70FVvw7b2qzxhe9KsubJIqxnM/MH8mlUWud
 bCCz17mFNVYJ4ItDqGszdjPZnyuY7rzPyyeVsmQTbQmAS7FR4xvQf4KyQIjKXV7V5zpL
 jeKQ==
X-Gm-Message-State: AOAM531SZcCJKwLxt9pSycXVaeimixgU2OkHmvY3p4BQVqQX2k3JvRsG
 aw+tYdD3ASM7P0G6bJEikc8=
X-Google-Smtp-Source: ABdhPJyIybMGaB9+5dnG2RmgLnWTZ8Z/JlNKkyKrMPkeXJaxCyYUh0OlPpAHz6oxHUVyAZUQun/mFg==
X-Received: by 2002:a0c:f4d0:: with SMTP id o16mr2460448qvm.225.1598018889363; 
 Fri, 21 Aug 2020 07:08:09 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c152:6ea6:a44d:671e:88f?
 ([2804:431:c7c7:c152:6ea6:a44d:671e:88f])
 by smtp.gmail.com with ESMTPSA id x137sm1821503qkb.47.2020.08.21.07.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 07:08:08 -0700 (PDT)
Subject: Re: [PATCH 1/1] spapr_vscsi: do not allow device hotplug
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200820190635.379657-1-danielhb413@gmail.com>
 <7f6ab4e6-42b1-3de4-5893-2ef09fc9dd26@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e9b2ce95-d920-24e3-14f7-cb41a5ce3caf@gmail.com>
Date: Fri, 21 Aug 2020 11:08:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7f6ab4e6-42b1-3de4-5893-2ef09fc9dd26@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/21/20 8:08 AM, Philippe Mathieu-Daudé wrote:
> Cc'ing Markus
> 
> On 8/20/20 9:06 PM, Daniel Henrique Barboza wrote:
>> We do not implement hotplug in the vscsi bus, but we forgot to
>> tell qdev about it. The result is that users are able to hotplug
>> devices in the vscsi bus, the devices appear in qdev, but they
>> aren't usable by the guest OS unless the user reboots it first.
>>
>> Setting qbus hotplug_handler to NULL will tell qdev-monitor, via
>> qbus_is_hotpluggable(), that we do not support hotplug operations
>> in spapr_vscsi.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1862059
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/scsi/spapr_vscsi.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
>> index d17dc03c73..57f0a1336f 100644
>> --- a/hw/scsi/spapr_vscsi.c
>> +++ b/hw/scsi/spapr_vscsi.c
>> @@ -1219,6 +1219,9 @@ static void spapr_vscsi_realize(SpaprVioDevice *dev, Error **errp)
>>   
>>       scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
>>                    &vscsi_scsi_info, NULL);
>> +
>> +    /* ibmvscsi SCSI bus does not allow hotplug. */
>> +    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
> 
> Can't this be a problem later in DeviceClass::unrealize()?

Not as far as I've tested. A call to qbus_set_hotplug_handler(bus,NULL)
after setting it to NULL isn't breaking anything either (just tested).

I verified before sending the patch that setting hotplug_handler to
NULL is done in some unrealize() calls in buses, but not on devices.
And I'm not sure which instance would cause an unrealize() in the
device to fail if the hotplug_handler of the bus is NULL. As far as
I'm concerned this shouldn't be happening in our case here, where we're
not dealing with hotplug devices in the bus at all.

Which potential problems are you referring to?

> 
> I was expecting something like, overwriting the parent bus type:
> 
> -- >8 --
> @@ -1271,6 +1271,7 @@ static void spapr_vscsi_class_init(ObjectClass
> *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);
> 
> +    k->bus_type = NULL; /* ibmvscsi SCSI bus does not allow hotplug. */
>       k->realize = spapr_vscsi_realize;
>       k->reset = spapr_vscsi_reset;
>       k->devnode = spapr_vscsi_devnode;
> ---

spapr_vscsi is not a bus, is an interface. Setting NULL to bus_type in spapr_vio
breaks guest init:


qemu-system-ppc64: /home/danielhb/qemu/hw/core/qdev.c:102: qdev_set_parent_bus: Assertion `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)' failed.
Aborted


I'm not so sure this would be better than what I'm doing either. qdev_device_add()
calls qbus_is_hotpluggable() to see if the chosen bus allows hotplug. This
function verifies if bus->hotplug_handler is NULL. What I'm doing is simply
setting hotplug_handler to NULL in the SCSI bus instance that belongs to
spapr_vscsi. As far as I understand this is a valid use of the qdev API - I
should be able to set hotplug_handler to NULL if I don't want devices being
hotplugged in the bus I'm instantiating. Either that, or qbus_is_hotpluggable()
must check for something else that I can safely turn off.


Thanks,


DHB




> 
>>   }
>>   
>>   void spapr_vscsi_create(SpaprVioBus *bus)
>>
> 


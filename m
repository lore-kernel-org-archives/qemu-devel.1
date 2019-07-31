Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E29C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C4220C01
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C4220C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsmpx-0005XT-Sg
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 07:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsmpT-0004oW-NX
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsmpS-00004v-GD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:31:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsmpS-0008UH-8C
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:31:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so69251318wru.13
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 04:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lEP6IXPqk0vLYPpY+J/LxmochL46RDx+GK85vbTDDWM=;
 b=TtqpSNQ83lWnBK2mvXI71xZxPjkvtHFKuezgzyy0UsV3h3wqYiojvND87bAO1Hb5kx
 ZYr+O3STUpn5rAZ+tAxpm/savIRuFwQ0xheRyiujxd9XrJpgGcPfdZXD41ZUUH+hXbII
 ssrm8rN0auJ8A688GRWR+X1SxsYsPU4PdJG7SwndYetNQuAbj8fs6BvkN+THsfpCfsmL
 ONxQqGdVF8WC77RBCjwFXSE/+wRO/JEGv1F/8nwr9BYrmOrKE5CVJWw3nlK14w7lw8j0
 OncIBp1kYPejEkR/YpH4lI4S2txOlC+7MjlHBh7RdM1mWZv+qsPG+IozB8iDxr2IYGht
 6Evg==
X-Gm-Message-State: APjAAAVUfoNdVGBkuRByKftVX8jlscNFkPzlypR1vrWx4ldN60T0b7pu
 2lGOcAzRYtxBvV+756WvVY4AFg==
X-Google-Smtp-Source: APXvYqwG5cCjcWc3pH+5uMLBTc5yI6iOEqgipleY0Y/oJREwSelWBEqfkAXisy29IEGEIws3g3w86Q==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr46524486wro.112.1564572693103; 
 Wed, 31 Jul 2019 04:31:33 -0700 (PDT)
Received: from [192.168.43.238] (44.red-95-127-154.staticip.rima-tde.net.
 [95.127.154.44])
 by smtp.gmail.com with ESMTPSA id j10sm117734735wrd.26.2019.07.31.04.31.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 04:31:32 -0700 (PDT)
To: Damien Hedde <damien.hedde@greensocs.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-6-damien.hedde@greensocs.com>
 <20190731060533.GD2032@umbus.fritz.box>
 <51aa7e6d-3568-8485-4b67-a598a24a1f3d@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e7b05c24-ecd1-a437-7d97-07d69ab759ec@redhat.com>
Date: Wed, 31 Jul 2019 13:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <51aa7e6d-3568-8485-4b67-a598a24a1f3d@greensocs.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 05/33] Switch to new api in qdev/bus
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, edgar.iglesias@xilinx.com,
 hare@suse.com, qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, thuth@redhat.com,
 ehabkost@redhat.com, alistair@alistair23.me, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com, rth@twiddle.net,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 11:29 AM, Damien Hedde wrote:
> On 7/31/19 8:05 AM, David Gibson wrote:
>> On Mon, Jul 29, 2019 at 04:56:26PM +0200, Damien Hedde wrote:
>>> Deprecate old reset apis and make them use the new one while they
>>> are still used somewhere.
>>>
>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>> ---
>>>  hw/core/qdev.c         | 22 +++-------------------
>>>  include/hw/qdev-core.h | 28 ++++++++++++++++++++++------
>>>  2 files changed, 25 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>> index 559ced070d..e9e5f2d5f9 100644
>>> --- a/hw/core/qdev.c
>>> +++ b/hw/core/qdev.c
>>> @@ -312,25 +312,9 @@ static void device_foreach_reset_child(Object *obj, void (*func)(Object *))
>>>      }
>>>  }
>>>  
>>> -static int qdev_reset_one(DeviceState *dev, void *opaque)
>>> -{
>>> -    device_legacy_reset(dev);
>>> -
>>> -    return 0;
>>> -}
>>> -
>>> -static int qbus_reset_one(BusState *bus, void *opaque)
>>> -{
>>> -    BusClass *bc = BUS_GET_CLASS(bus);
>>> -    if (bc->reset) {
>>> -        bc->reset(bus);
>>> -    }
>>> -    return 0;
>>> -}
>>> -
>>>  void qdev_reset_all(DeviceState *dev)
>>>  {
>>> -    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one, NULL);
>>> +    device_reset(dev, false);
>>>  }
>>>  
>>>  void qdev_reset_all_fn(void *opaque)
>>> @@ -340,7 +324,7 @@ void qdev_reset_all_fn(void *opaque)
>>>  
>>>  void qbus_reset_all(BusState *bus)
>>>  {
>>> -    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, NULL);
>>> +    bus_reset(bus, false);
>>>  }
>>>  
>>>  void qbus_reset_all_fn(void *opaque)
>>> @@ -922,7 +906,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>>>              }
>>>          }
>>>          if (dev->hotplugged) {
>>> -            device_legacy_reset(dev);
>>> +            device_reset(dev, true);
>>
>> So.. is this change in the device_reset() signature really necessary?
>> Even if there are compelling reasons to handle warm reset in the new
>> API, that doesn't been you need to change device_reset() itself from
>> its established meaning of a cold (i.e. as per power cycle) reset.
>> Warm resets are generally called in rather more specific circumstances
>> (often under guest software direction) so it seems likely that users
>> would want to engage with the new reset API directly.  Or we could
>> just create a device_warm_reset() wrapper.  That would also avoid the
>> bare boolean parameter, which is not great for readability (you have
>> to look up the signature to have any idea what it means).

If the boolean is not meaningful, we can use an enum...

> I've added device_reset_cold/warm wrapper functions to avoid having to
> pass the boolean parameter. it seems I forgot to use them in qdev.c
> I suppose, like you said, we could live with
> + no function with the boolean parameter
> + device_reset doing cold reset
> + device_reset_warm (or device_warm_reset) for the warm version
> 
> Damien
> 


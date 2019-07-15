Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8D9C76192
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53892217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53892217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1BW-00041x-E2
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50617)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn1BJ-0003PC-OQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn1BI-0004Di-Ea
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:38:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hn1BI-0004D1-8l
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:38:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so17119901wrl.7
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CGv8daBN78F3fs7vQSkYuBd/QM6pYOhv9U+pxIfUj4A=;
 b=jPS3vCFtV0z2sZn1iMcM5QoCO4/6ZY+YXWTgQr4eDF9nXzCqh2tToiIVfdBEy12SQe
 VIwrQyD8g7of/dmC259voBcMZ18/Xs3vQSzn5tO/GdFDcQK8tZ8847KKKs1gesMqjbGN
 C06sKHoQOC1SLpxAnajBovvblfCZQ/HWksPEVdwQO62hRW5rn1y65ZWWJWR28+ERvwQE
 /HEH1TeQy6Idvoh4PYYLlne4kYFN+iHXgU6VoAGyJKNjQvVMmdAQlbxxeDcuCdKQ4E8I
 N/iKWaOjy7V7yY8iHJdaRy1vVZtqOyL2JgjZNNVTZQE4ioqno5/hA0Xo9ikhy1d14wKj
 RUoQ==
X-Gm-Message-State: APjAAAVpyeWF5Cewt5NMt/bY3iF9jt9Lf3O7UCv3YTRC74BgJHgjTn3d
 rtQX1eJSFSrP1VKUeM2ps6UHvQ==
X-Google-Smtp-Source: APXvYqzv52vvyJ8udrEPcZgi/K/RhipRh2hvKTg+0shBuyl/mrr74n2zKWT29piXggF6Vdrqkix/mQ==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr23517341wrt.227.1563197894996; 
 Mon, 15 Jul 2019 06:38:14 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id b8sm16081336wrr.43.2019.07.15.06.38.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 06:38:14 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20190715095545.28545-1-philmd@redhat.com>
 <20190715095545.28545-2-philmd@redhat.com>
 <ca528cdc-6118-0b2f-c1b8-30b06875dde8@redhat.com>
 <CAFEAcA-wgTVfj0TUJ=piP0wEgLGiNpOYia5DK2GQAO4Q7gNaWg@mail.gmail.com>
 <6d69e8ad-d720-ce04-20f2-a03193903078@redhat.com>
 <20190715125653.6e65d575.cohuck@redhat.com>
 <c1c68faf-0424-6c7c-e39f-42159457c3ee@redhat.com>
 <20190715130955.4a117388.cohuck@redhat.com>
 <13fce62f-234c-1b13-595f-5910c066bc4f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6c39a198-e951-c0bd-1ddc-5d227afe72ff@redhat.com>
Date: Mon, 15 Jul 2019 15:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <13fce62f-234c-1b13-595f-5910c066bc4f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC PATCH 1/3] hw/Kconfig: PCI bus
 implies PCI_DEVICES
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Collin Walling <walling@linux.ibm.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 "open list:S390" <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/19 3:19 PM, Thomas Huth wrote:
> On 15/07/2019 13.09, Cornelia Huck wrote:
>> On Mon, 15 Jul 2019 13:04:28 +0200
>> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>>> On 7/15/19 12:56 PM, Cornelia Huck wrote:
>>>> On Mon, 15 Jul 2019 12:48:55 +0200
>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>   
>>>>> On 15/07/2019 12.19, Peter Maydell wrote:  
>>>>>> On Mon, 15 Jul 2019 at 11:15, Thomas Huth <thuth@redhat.com> wrote:    
>>>>>>>
>>>>>>> On 15/07/2019 11.55, Philippe Mathieu-Daudé wrote:    
>>>>>>>> If a controller device provides a PCI bus, we can plug any PCI
>>>>>>>> daughter card on it.
>>>>>>>>
>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>>>>> ---    
>>>>>>     
>>>>>>>> diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
>>>>>>>> index 77f8b005ff..0f7267db35 100644
>>>>>>>> --- a/hw/pci/Kconfig
>>>>>>>> +++ b/hw/pci/Kconfig
>>>>>>>> @@ -1,5 +1,6 @@
>>>>>>>>  config PCI
>>>>>>>>      bool
>>>>>>>> +    imply PCI_DEVICES    
>>>>>>>
>>>>>>> No, please don't change this. This was done on purpose, since almost all
>>>>>>> PCI_DEVICES do not work on s390x (so s390x does *not* imply PCI_DEVICES).    
>>>>>>
>>>>>> But that means that every board that provides PCI has to have an
>>>>>> "imply PCI_DEVICES" line, which is pretty clunky just to work
>>>>>> around an s390x limitation.
>>>>>>
>>>>>> Is there some way in the Kconfig syntax for s390x to say
>>>>>> "no PCI_DEVICES" so we can have the corner-case be handled
>>>>>> by the s390x Kconfig in one place rather than in 20 places
>>>>>> affecting everywhere except s390x?    
>>>>>
>>>>> IIRC the problem on s390x are the legacy IRQs. s390x has only MSIs. So I
>>>>> guess the correct way to fix this would be to introduce some
>>>>> PCI_LEGACY_IRQ switch and let all old devices that do not work with MSI
>>>>> depend on it.  
>>>>
>>>> s/MSI/MSI-X/, IIRC. Not sure how far 'legacy' would stretch.  
>>>
>>> Maybe we can have something like PCI_LEGACY_DEVICES and PCI_MSI_DEVICES?
>>>
>>> So if s390x only selects PCI_LEGACY (not PCI_MSI) bus, then it only get
>>> legacy devices?
>>
>> Wrong way around? We need MSI-X for s390x, not plain MSI or
>> 'legacy' (whatever that is).
> 
> With "legacy" I meant the old level-triggered interrupts from the early
> PCI (non-express) days. Sorry for being imprecise here.
> 
> So maybe we need two new switches, PCI_CLASSIC (or so) and PCI_MSIX, and
> then the PCI devices should be marked with "default y if PCI_CLASSIC" if
> they do not have MSIX support, and with "default y if PCI_MSIX" if they
> have MSI-X support?

Something like that :)

Per Wikipedia:

  Conventional PCI and PCI-X are sometimes called Parallel PCI
  in order to distinguish them technologically from their more
  recent successor PCI Express, which adopted a serial,
  lane-based architecture.

  The PCI-SIG introduced the serial PCI Express in c. 2004. At
  the same time, they renamed PCI as Conventional PCI.

  PCI Express does not have physical interrupt lines at all.
  It uses message-signaled interrupts exclusively.

What about PCI_CONVENTIONAL then?

Regards,

Phil.


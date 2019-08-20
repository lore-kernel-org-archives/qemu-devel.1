Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B3CC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42C622CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVKAcy3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42C622CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06Ea-0002It-VA
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1i06DY-00012G-3e
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1i06DW-0008MM-Oe
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:38:40 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1i06DW-0008LM-Ia
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:38:38 -0400
Received: by mail-pf1-x443.google.com with SMTP id f17so3605876pfn.6
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/ObV93ttAREOPDmOHbQr50jXFOVeczW7V/ttq69gcLw=;
 b=MVKAcy3JQccOiQzMjaG5KU+gt0On2HmrUFJ38+QesmHTaYsccaXWhrwmrRhuTtgzEn
 tr+HKPPG82H0zSHzp389Q6V6/pSjdDE2Lx6QeybMzfgRIFMD2Vb29duAUIJM6lHy3Tn/
 1qr37zDtmeUa5QxBvSX42riwOy2xlXk3B8OyfL679ZToQKqt2mUBKWofrdziKQ/80IoV
 G1sEhsSX+3IerozEzRtSo8njoUfoDFdezX+3IKj7uLnrDeKF/I8DzLCdWtgylWAvtiZu
 i9Uh+/SIwLHCjyxE+7UXLJVdaJE4RiMS6BtoLXBWs/0/pd7I91vVVqy6IKICRkVb2U3h
 1S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/ObV93ttAREOPDmOHbQr50jXFOVeczW7V/ttq69gcLw=;
 b=BQXdWm5MoEg6/CiY8fuiLaueKP3GFTgTBFmqLJO7y9AEJbiZMTFswbDNRM2Od8HaBC
 9VVkUeFTIa7H9w5ujFAmMGpophIkeWNOO8zO5rRZY1NNk1xl9jPE1WUkWIVqL1rio64g
 +oZvjmwuLiYY1Kyitpaf8NlkFDi/34Jcyl2pQ3/lFje26zhkCb6N5H64AQWs0xhNf0bh
 rvbSLUCw6Rk1jlAhj560rwMyqU5gy3xojBhshyBDErJanFQbdoUkYCCS5L40rAj/sEYU
 DnVg8bzEOYSLq/YksI2X/q57E3LivX1FgIRgop3SPV/rQHzFrR/Xrji+RkTmvYbWjLqB
 YYqQ==
X-Gm-Message-State: APjAAAVMvY5VA5rB3gQAkfNbr9dkTDwLIbJBo2M7JqJObZQfJwywKVA4
 hZQWe3yM/VWfwEKjzH17EHo=
X-Google-Smtp-Source: APXvYqxX9pH+wH3CD6SHiIVFQwUJ3LI6WjLKjMOfnnZuWXD7wr9rG99yd93iouYNOqTzrrNKj6yp/Q==
X-Received: by 2002:a63:e901:: with SMTP id i1mr24858784pgh.451.1566315517444; 
 Tue, 20 Aug 2019 08:38:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 z4sm19592653pgp.80.2019.08.20.08.38.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 08:38:36 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>
References: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
 <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
 <20190802141149.dj7zv5p5wscftvnr@sirius.home.kraxel.org>
 <14dfe5ce-d74c-dccd-a62b-753b2efa924b@roeck-us.net>
 <20190813114203.z62dgyyneqcp3mru@sirius.home.kraxel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ffd106b7-2310-ac52-bc33-d03c6a387c39@roeck-us.net>
Date: Tue, 20 Aug 2019 08:38:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813114203.z62dgyyneqcp3mru@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] ehci: Ensure that device is not NULL
 before calling usb_ep_get
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 4:42 AM, Gerd Hoffmann wrote:
> On Tue, Aug 06, 2019 at 06:23:38AM -0700, Guenter Roeck wrote:
>> On 8/2/19 7:11 AM, Gerd Hoffmann wrote:
>>> On Wed, Jul 31, 2019 at 01:08:50PM +0200, Philippe Mathieu-Daudé wrote:
>>>> On 7/30/19 7:45 PM, Guenter Roeck wrote:
>>>>> The following assert is seen once in a while while resetting the
>>>>> Linux kernel.
>>>>>
>>>>> qemu-system-x86_64: hw/usb/core.c:734: usb_ep_get:
>>>>> 	Assertion `dev != NULL' failed.
>>>>>
>>>>> The call to usb_ep_get() originates from ehci_execute().
>>>>> Analysis and debugging shows that p->queue->dev can indeed be NULL
>>>>> in this function. Add check for this condition and return an error
>>>>> if it is seen.
>>>>
>>>> Your patch is not wrong as it corrects your case, but I wonder why we
>>>> get there. This assert seems to have catched a bug.
>>>
>>> https://bugzilla.redhat.com//show_bug.cgi?id=1715801 maybe.
>>>
>>>> Gerd, shouldn't we call usb_packet_cleanup() in ehci_reset() rather than
>>>> ehci_finalize()? Then we shouldn't need this patch.
>>>
>>> The two ehci_queues_rip_all() calls in ehci_reset() should clean up everything
>>> properly.
>>>
>>> Can you try the patch below to see whenever a ehci_find_device failure is the
>>> root cause?
>>>
>>> thanks,
>>>     Gerd
>>>
>>> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
>>> index 62dab0592fa2..2b0a57772ed5 100644
>>> --- a/hw/usb/hcd-ehci.c
>>> +++ b/hw/usb/hcd-ehci.c
>>> @@ -1644,6 +1644,10 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>>>            q->dev = ehci_find_device(q->ehci,
>>>                                      get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
>>>        }
>>> +    if (q->dev == NULL) {
>>> +        fprintf(stderr, "%s: device %d not found\n", __func__,
>>> +                get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
>>> +    }
>> Turns out I end up seeing that message hundreds of times early on each boot,
>> no matter which architecture. It is quite obviously a normal operating condition.
> 
> Yep, as long as the queue is not active this is completely harmless.
> So we need to check a bit later.  In execute() looks a bit too late
> though, we don't have a good backup plan then.
> 
> Does the patch below solve the problem without bad side effects?
> 
> thanks,
>    Gerd
> 
>>From 5980eaad23f675a2d509d0c55e288793619761bc Mon Sep 17 00:00:00 2001
> From: Gerd Hoffmann <kraxel@redhat.com>
> Date: Tue, 13 Aug 2019 13:37:09 +0200
> Subject: [PATCH] ehci: try fix queue->dev null ptr dereference
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/usb/hcd-ehci.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 62dab0592fa2..5f089f30054b 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1834,6 +1834,9 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
>               ehci_set_state(q->ehci, q->async, EST_EXECUTING);
>               break;
>           }
> +    } else if (q->dev == NULL) {
> +        ehci_trace_guest_bug(q->ehci, "no device attached to queue");
> +        ehci_set_state(q->ehci, q->async, EST_HORIZONTALQH);
>       } else {
>           p = ehci_alloc_packet(q);
>           p->qtdaddr = q->qtdaddr;
> 

That seems to be working as intended. I have not seen a crash
since I applied it. I tested it on top of v4.0 and v4.1.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter



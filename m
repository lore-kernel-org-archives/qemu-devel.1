Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4280FC76191
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 17:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EF720823
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 17:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EF720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpF7R-000232-EP
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 12:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpF7E-0001Pn-Ux
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 12:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpF7D-0004kJ-2T
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 12:55:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpF7C-0004ie-RI
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 12:55:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so11868172wrr.4
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2019 09:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tgm7XgXGP0NGSUE3qrjMZYdJK5/qk2AQfKW3QG01FO0=;
 b=KGwkr8k4TaQ/PqHP80ma4Nq5GjmCDGGXibG7w+vSfIBMeTptW8ARZJ0FWQ0dgeMwXc
 SRq9SjGOUoIeSsFTWp4U820+1qYT0bxEDz6xFthHEad8TNriG9vOBsxEAwL8z6/qWT2g
 vAzuxLR6UNPM+BAtVVYDWq6/rdmwQNa6I7eTrwmXIdKx5+yN29MOmtMfJu1B1OSqmpgi
 IP+1ANM9OI+b+TOVumGEFwEzIsoGJt9gTeZui9cTrtfx6OBc+Dlsx5CRzGXOP6oaWHl3
 Qy60W3/AQki8O3rXCrV01RgfceMJ3kj8PgtnFeyGxOM3kpj6E/RAlrRtZSuG4qFqFjoK
 lSrw==
X-Gm-Message-State: APjAAAWAx71vEeIMULVWDXaxSpL/58r75qf67SD5kpP872qhUVzgwvrE
 TN+3JFOeuY3jVW0m+OCTyerzwA==
X-Google-Smtp-Source: APXvYqz/xJaqHphO08GeKZJhGqPbv8NonMqUiXfnAXQUb0uBurGpZKWgeAH3nx85WyaxwqaJV8nN4w==
X-Received: by 2002:adf:f60a:: with SMTP id t10mr30366986wrp.258.1563728112269; 
 Sun, 21 Jul 2019 09:55:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:59c3:355d:cfd:35b0?
 ([2001:b07:6468:f312:59c3:355d:cfd:35b0])
 by smtp.gmail.com with ESMTPSA id l8sm65915541wrg.40.2019.07.21.09.55.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Jul 2019 09:55:11 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>
References: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
 <20190602174041-mutt-send-email-mst@kernel.org>
 <2d735fe7-d451-207d-eca9-2796cad7e778@web.de>
 <20190721060409-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0b4d43a0-92f7-21da-7330-6a831fc68828@redhat.com>
Date: Sun, 21 Jul 2019 18:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190721060409-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] ioapic: kvm: Skip route updates for masked
 pins
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/07/19 12:04, Michael S. Tsirkin wrote:
> On Sun, Jul 21, 2019 at 10:58:42AM +0200, Jan Kiszka wrote:
>> On 03.06.19 02:36, Michael S. Tsirkin wrote:
>>> On Sun, Jun 02, 2019 at 01:42:13PM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Masked entries will not generate interrupt messages, thus do no need to
>>>> be routed by KVM. This is a cosmetic cleanup, just avoiding warnings of
>>>> the kind
>>>>
>>>> qemu-system-x86_64: vtd_irte_get: detected non-present IRTE (index=0, high=0xff00, low=0x100)
>>>>
>>>> if the masked entry happens to reference a non-present IRTE.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>>> ---
>>>>  hw/intc/ioapic.c | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
>>>> index 7074489fdf..2fb288a22d 100644
>>>> --- a/hw/intc/ioapic.c
>>>> +++ b/hw/intc/ioapic.c
>>>> @@ -197,9 +197,11 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
>>>>              MSIMessage msg;
>>>>              struct ioapic_entry_info info;
>>>>              ioapic_entry_parse(s->ioredtbl[i], &info);
>>>> -            msg.address = info.addr;
>>>> -            msg.data = info.data;
>>>> -            kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
>>>> +            if (!info.masked) {
>>>> +                msg.address = info.addr;
>>>> +                msg.data = info.data;
>>>> +                kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
>>>> +            }
>>>>          }
>>>>          kvm_irqchip_commit_routes(kvm_state);
>>>>      }
>>>> --
>>>> 2.16.4
>>>
>>>
>>
>> Ping. Or is this queued for 4.2?
>>
>> Jan
> 
> Paolo was queueing ioapic things recently. I can take this if
> he doesn't respond until I pack up my next pull req.
> 

I've already sent a pull request and had missed this patch, so please go
ahead.

Paolo


Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFABBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD1A2145D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2Xn7TA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD1A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmaD-0002GC-UA
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrmZV-0001cW-UY; Sat, 04 Jul 2020 14:07:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrmZU-0006HZ-Ea; Sat, 04 Jul 2020 14:07:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id l2so35923603wmf.0;
 Sat, 04 Jul 2020 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mZdfCBg4VmKOePgd4ZgEELl6kuOuKz4YZpkDO2WK/mg=;
 b=F2Xn7TA1uzAW8ytlKaIyS4FH6AXRlqhnEh7Gf8jIRWpe90/Agn2zEndE5uWg9TPPh2
 Pd+k1nFdIKd+lXbzlYVKgulsRPdNpaouObDppl6bLj9NDRrdIRhocgN+39xEMxQ98cMf
 27x2Ptfr6Coh+Aigug48khlW9MFKrzmZuNnBRyDt7CNNbUZomH0+JTZEgQ/b5OKydcQx
 824lfbGdQS3XigbBcy4nRTe0/gidZZnSa6IlBmoXqY9JM760s1WPVoc9nWLewNsAzsUx
 kH6yf1LuXqBVqa54YPW0eSuyYOLMVB6E2FDl83IBeGRwUHx9Z+eo3n9GLk3WoxviLU5+
 W1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mZdfCBg4VmKOePgd4ZgEELl6kuOuKz4YZpkDO2WK/mg=;
 b=I4EiGi5VSih6uyC4dkkeMblPwwWpgsS7bNQel6AZ9aTth8ZER55tFLg8DG+8Jt4u6n
 PROnbS5hyNVcE5jw8GpZ3xrMOJABqUAHXR4Y+4vgmsdm3w2mahZgritQy4houEuywZr4
 X4QWg27zsc74alJc20MHolr5YnTvlQzmYJxMfwJFB9r6i9iNvGZxjJ8NB9wwEJMTKHy0
 HsuA3/Q+1OIHniuR6XN31kkLNBAZZghofEV0a9+GC5M7pHgezSQapADS1J+VL4B/heUj
 WBNGdL1RuJjgUrSWZFo/dK6oVplsv9Z9FNhlcnZ04thh9qYZZwZQHTZoct1f2fxlAD8e
 loaA==
X-Gm-Message-State: AOAM532/lVk2R+jEsZ38USzpVtZHaONQpmIQMu43efVRahpDZb01hb80
 Lw5NCRV60Xflj5MqUsmKYMc=
X-Google-Smtp-Source: ABdhPJzZWrQ0HgNVFoE6cODEZmoDzuftK1C6O0pwc+VU4hGUi2ilcK4PyTG4adTP9B6gXrmR2BdtTw==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr42349957wma.102.1593886046288; 
 Sat, 04 Jul 2020 11:07:26 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h14sm18374863wrt.36.2020.07.04.11.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 11:07:25 -0700 (PDT)
Subject: Re: [PATCH 25/26] hw/usb/usb-hcd: Use XHCI type definitions
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-26-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2007041918320.92265@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5520c5eb-b80f-4a44-8aa5-7512048482d1@amsat.org>
Date: Sat, 4 Jul 2020 20:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2007041918320.92265@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/20 7:19 PM, BALATON Zoltan wrote:
> On Sat, 4 Jul 2020, Philippe Mathieu-Daudé wrote:
>> Various machine/board/soc models create XHCI device instances
>> with the generic QDEV API, and don't need to access USB internals.
>>
>> Simplify header inclusions by moving the QOM type names into a
>> simple header, with no need to include other "hw/usb" headers.
>>
>> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> hw/usb/hcd-xhci.h        | 2 +-
>> include/hw/usb/usb-hcd.h | 3 +++
>> hw/ppc/spapr.c           | 2 +-
>> 3 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
>> index f9a3aaceec..b6c54e38a6 100644
>> --- a/hw/usb/hcd-xhci.h
>> +++ b/hw/usb/hcd-xhci.h
>> @@ -23,9 +23,9 @@
>> #define HW_USB_HCD_XHCI_H
>>
>> #include "usb-internal.h"
>> +#include "hw/usb/usb-hcd.h"
>>
>> #define TYPE_XHCI "base-xhci"
>> -#define TYPE_NEC_XHCI "nec-usb-xhci"
>> #define TYPE_QEMU_XHCI "qemu-xhci"
> 
> Why is qemu-xhci left here? Should that be moved to public header too?
> (Maybe no machine adds it but that's a public type too I think.)

I don't know because I never used it, but I guess you are right.

> 
> Regards.
> BALATON Zoltan
> 
>> #define XHCI(obj) \
>> diff --git a/include/hw/usb/usb-hcd.h b/include/hw/usb/usb-hcd.h
>> index c9d0a88984..56107fca62 100644
>> --- a/include/hw/usb/usb-hcd.h
>> +++ b/include/hw/usb/usb-hcd.h
>> @@ -30,4 +30,7 @@
>> #define TYPE_VT82C686B_USB_UHCI     "vt82c686b-usb-uhci"
>> #define TYPE_ICH9_USB_UHCI(n)       "ich9-usb-uhci" #n
>>
>> +/* XHCI */
>> +#define TYPE_NEC_XHCI "nec-usb-xhci"
>> +
>> #endif
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index db1706a66c..d8b3978f24 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2961,7 +2961,7 @@ static void spapr_machine_init(MachineState
>> *machine)
>>         if (smc->use_ohci_by_default) {
>>             pci_create_simple(phb->bus, -1, TYPE_PCI_OHCI);
>>         } else {
>> -            pci_create_simple(phb->bus, -1, "nec-usb-xhci");
>> +            pci_create_simple(phb->bus, -1, TYPE_NEC_XHCI);
>>         }
>>
>>         if (spapr->has_graphics) {
>>


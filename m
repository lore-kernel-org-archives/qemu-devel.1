Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650BD205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650BD205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1Kg-0008Vb-30
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iO1CH-000580-4D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iO1CF-0007OT-Sf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:08:12 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iO1Bs-0007EH-U8; Fri, 25 Oct 2019 11:08:11 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N18MG-1hzV0S03ek-012bbB; Fri, 25 Oct 2019 17:07:22 +0200
Subject: Re: [PATCH v14 1/9] esp: add pseudo-DMA as used by Macintosh
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20191022111738.20803-1-laurent@vivier.eu>
 <20191022111738.20803-2-laurent@vivier.eu>
 <6dd7dbbb-dc48-7705-3865-e8a7bed75394@redhat.com>
 <0f308a0d-f73b-29a1-0177-49a6e0a1eda9@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <da4bb972-bcc6-3fa1-f82b-096265807fd7@vivier.eu>
Date: Fri, 25 Oct 2019 17:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0f308a0d-f73b-29a1-0177-49a6e0a1eda9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f+u1+jreEyEb6QH3i5SMVfV+y+Ej1kxvBNwc2VK0YMFU9gq0xAg
 SzHnxEdAGg4W8B3NG5SGbCL9o0oOMIHVl1KpRWHSOsOvYT6DsAWBo6GNf7diTir5LDZ/bSH
 lD4RxKaGTsCGA/gBO344w9j6lZWP3vI8m2BTlWAPMKNDAEpB5Cw387GOmE98VnpjNnwuW66
 F992rOPn0i5d6XPfb3p/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EFPaW8g4r6g=:+duNIi3VkFUx93Qeg1ly6E
 TNofp9DWiU4x7y3ff4Gec02zFeK5w0+o22k3L9TiFBulMhaWI5wd7gM6WaNV4nt7SDPUYzY0e
 pF+NTEIuT4kz+3nEJi9KFqb1Fs38TWqyEzewP/gvZ6y/Sc4Qn2ljE2pDMNSDeJIIPHtB6D4pu
 lpWwF+DeIzNWKuNrnK4dLyxUQ+yth0/0n7mVCVkVaOho5Y7IE9BMC6g5KkrDQXFYAbznNiUo5
 5X1dGQ3qbp1l4H6dMpGvYNKWmgZ4abWSx0ZuPlV526saUq+hEStNtgSEif5Ad57NVfy2GWSOT
 zwgSeAtHwdpdNQGyc5BkADabuxhvl2By7ct/fhYexF5OmGzqR2ovXFLaWRB7P/tPJ6DEUPNPS
 7eDAGItJYrgUEqqY6gVToLUpavS01Okjz63m/nmsTvzOSlJyZc9ZMFONibjJUaDaZ15f32xs6
 4WPgAu4f+offJ67bUEvJF0siNpNlCTDm6tIOsWAIo0mQhv2HPnY3uFG/hJ1vM85Ip5xgNUeOG
 VyzxPdqJf3/6I55hBrnzPxb3wVFPEWWDkT9CwelGadKgJUBRW1VV51QP8O1EThdav2MKPSGkw
 eldXn0kUlI/EbGvcikBhc+g3pWg6MR0/V+qrL34Jt8X5MgazOG+dwdRGRifgURCeYU/vUihrm
 SWsmKK7ABWOQVRBMqyF4m4QbGPBhgkD2pBqnOR9tn2VLhCDjTZ8F3HekpM8NQQt+fPCVS5eVM
 7KhXoD8H94vV5TH0LksWAgt3BjoYYOMT2+eATbxOrucBoArw70W5m1s72H8wCk8ZHtylq9Wee
 2/IBtLGGEB6GiGS6FGSscz0c+n7edtWgZPxWGZXLO6HmfiLP/mvQGq5MaAW/UDKeIn2pVvp02
 MOtZzvpz1rEFbuzbJGJhKEzk2fF4mewpJupRVCLDg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/10/2019 à 16:54, Philippe Mathieu-Daudé a écrit :
> On 10/25/19 4:01 PM, Paolo Bonzini wrote:
>> On 22/10/19 13:17, Laurent Vivier wrote:
>>> +        if (s->dma_memory_read) {
>>> +            s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen],
>>> len);
>>> +        } else {
>>> +            set_pdma(s, CMD, s->cmdlen, len);
>>> +            s->pdma_cb = do_dma_pdma_cb;
>>> +            esp_raise_drq(s);
>>> +            return;
>>> +        }
>>> +        trace_esp_handle_ti_cmd(s->cmdlen);
>>> +        s->ti_size = 0;
>>> +        s->cmdlen = 0;
>>> +        s->do_cmd = 0;
>>> +        do_cmd(s, s->cmdbuf);
>>>           return;
>>
>> Can you explain these lines after s->dma_memory_read?  I suppose they
>> are related to
>>
>>> -    }
>>> -    if (s->do_cmd) {
>>> +    } else if (s->do_cmd) {
>>
>> If so, it would be nice to make those a separate patch.  Otherwise seems
>> okay.
> 
> Third reviewer asking, so it seems worthwhile.

It seems, yes :)

I'm going to try to make a separate patch.

Thank you to all of you.

Laurent


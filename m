Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC258C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0847B2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD+tPiNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0847B2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmjU-0000GI-VL
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 09:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmiJ-0007vl-8W; Sat, 17 Oct 2020 09:57:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmiH-00037W-Kx; Sat, 17 Oct 2020 09:57:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id j7so2474265wrt.9;
 Sat, 17 Oct 2020 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fGn0YYuoNOd5X123Mc0MgEI1oVwesEf6kfO4p6objls=;
 b=JD+tPiNE+iIhKGoLLUpqSWGxtYXKZfExrXKnNq1L620hJMQcIA1tUZZ9ECIDjZV/c9
 NVOvswV7FMiw+fyUsjQ+xtkNNksliZ0bGo/AVbNpl+gBJYg0ZTfUzBPz2N3RUF2UNCeS
 5m5S/xU2XK2aUUu1eY7YeqZisRhIJ+vZZz2KJgE0XtpLOQZJuRqQ+r0yInaj2MT/8Gb+
 sFHPj1ANtI/R8lD1mBazwta7TkfowGswf2Mrgj6Xun8KVdpM3zVK1HZTP9H0716BNGHj
 QQBtOJOEeYz6IqHNBMybc+Iwkje/MjPNJ4ZlbJsBMju/vL4ujMHiXFrEgD4o766j1ULW
 r4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fGn0YYuoNOd5X123Mc0MgEI1oVwesEf6kfO4p6objls=;
 b=gy9moEd49m60eiJqbcGfdTzytZWLhRKoUuF8qfNv9rbavJIF6LZrL9pye4iBvc+W8e
 Wc2PT2gDAfz0N+IzmxFgtiOUiiIvxAdzxjtrcWqkpDmXllrkJJDXRMjIehuhxb/Pv4Iq
 gizRjLsDHVrJkgytUsR1pmBnJPRY7hjPOjUWtXaRV+ghT8GT5Q132WazGoslsTsrq4VA
 2e9RpdIQVoAuKM5EKxnLykksiMdBU/pdkrACvI9qEnUCce+rPU0xo7jMZ+MoS7SOvgL8
 gc3nTInDBGVQZGIqErsRL5pktooagAXwVeh7TKdlpRr9GJiP74/1ZoHerkKCOuYJMZZM
 8kWg==
X-Gm-Message-State: AOAM533F0oBWFKm8mk5IVc54XW93HpJqFaH4YXJ+/D64XGngUl4Y8Vxr
 miLsNsy8/UGH119XSiXNTik=
X-Google-Smtp-Source: ABdhPJyqcXYJiO6NWWL4MWTptr8L/9qrr8xmEQq5Y+aHbC+NY5hlziy58CbZt7wIMtNR8g6ikm29CQ==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr10245011wrr.304.1602943055227; 
 Sat, 17 Oct 2020 06:57:35 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id f14sm8749691wrt.53.2020.10.17.06.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 06:57:34 -0700 (PDT)
Subject: Re: [PATCH 5/5] m48t59: remove legacy m48t59_init() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, hpoussin@reactos.org, qemu-ppc@nongnu.org,
 atar4qemu@gmail.com, david@gibson.dropbear.id.au
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-6-mark.cave-ayland@ilande.co.uk>
 <ad533302-e715-cc8a-12ec-d7e4ad75c120@amsat.org>
 <3a5a388d-8be7-dc1b-401f-ed9e8fa3b554@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d8c67fcf-c05a-8f1d-4aa6-9d4cede2be32@amsat.org>
Date: Sat, 17 Oct 2020 15:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3a5a388d-8be7-dc1b-401f-ed9e8fa3b554@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 1:19 PM, Mark Cave-Ayland wrote:
> On 17/10/2020 10:53, Philippe Mathieu-Daudé wrote:
> 
>> On 10/16/20 8:27 PM, Mark Cave-Ayland wrote:
>>> Now that all of the callers of this function have been switched to 
>>> use qdev
>>> properties, this legacy init function can now be removed.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/rtc/m48t59.c         | 35 -----------------------------------
>>>   include/hw/rtc/m48t59.h |  4 ----
>>>   2 files changed, 39 deletions(-)
...

>> static void m48t59_class_init(ObjectClass *oc, void *data)
>> {
>>      M48txxISADeviceClass *midc = M48TXX_ISA_CLASS(oc);
>>
>>      midc->model = 59;
>>      midc->size = 8 * KiB;
>> };
>>
>> static const TypeInfo m48t59_isa_register_types[] = {
>>      {
>>          .name           = TYPE_M48T59_SRAM,
>>          .parent         = TYPE_M48TXX_ISA,
>>          .class_init     = m48t59_class_init,
>>      }, {
>>          .name           = TYPE_M48TXX_ISA,
>>          .parent         = TYPE_ISA_DEVICE,
>>          .instance_size  = sizeof(M48txxISAState),
>>          .class_size     = sizeof(M48txxISADeviceClass),
>>          .class_init     = m48txx_isa_class_init,
>>          .abstract       = true,
>>          .interfaces = (InterfaceInfo[]) {
>>              { TYPE_NVRAM },
>>              { }
>>          }
>>      }
>> };
>>
>> I guess I didn't pursue because I wondered what was the
>> best way to have the same model usable by sysbus/isa.
>>
>> IIRC I wanted to proceed as having TYPE_M48T59_SRAM being
>> an abstract qdev parent, and then TYPE_M48TXX_SYSBUS /
>> TYPE_M48TXX_ISA implementing the SYSBUS/ISA interfaces.
>>
>> As it need some thinking I postponed that for after 5.2.
>>
>> Anyhow back to this patch:
>>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Ha indeed, I think you also came to the same conclusion that I did in my 
> previous email :)
> 
> I'm also not convinced by the dynamic generation of various M48TXX types 
> using class_data - this seems overly complex, and there's nothing there 
> I can see that can't be just as easily handled using qdev properties 
> using an abstract parent as you suggest above.

Yeah, no advantage except having uniform code style that serves
as example.

> 
> 
> ATB,
> 
> Mark.
> 


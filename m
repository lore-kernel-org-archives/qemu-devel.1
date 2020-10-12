Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BE8C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A4A2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO5/L4gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A4A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxUI-0007hK-Va
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxSf-0006x4-JS; Mon, 12 Oct 2020 09:01:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxSd-0002bj-S0; Mon, 12 Oct 2020 09:01:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id q5so17454030wmq.0;
 Mon, 12 Oct 2020 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5ctyKcMcLkw0p2grTwMXcK0kjDzhIaiNn9fFKueBmBE=;
 b=HO5/L4gZB7yx+OpPxarWsjplCorye+JyDyjbKqsNpqrmpu/wFMHhOVpCmgvVvcvwMp
 /a9hUHjGC7QYkurPvQ4gsSZuyoUMgCS+l75tLltOc6daEgukcCujDTY0CjkirkzlIGJ3
 iSdQZGeZSPp0L2x6N/Ra8E+GM4liewmOBfuQSfWluOWUpuZd0hPPYv5EFdnp1bpvV3HA
 P+mBLyYhLj4DtrIXC2hnoQqDQFqHAXHNqwlBx9b+HXBs19yyIf0W/ehl7hmHa9XZEahG
 BsK7eH1iK5x+AIkgtxW+RqOG0eDj9uiRjzmgDVoWHWgbUWtrViz0vKdC0HA+3UGNLhvt
 8PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5ctyKcMcLkw0p2grTwMXcK0kjDzhIaiNn9fFKueBmBE=;
 b=qvCDS+as6h6IpYsofw/ci0Ys4HM5KVhUlOZW+lElkDtgGjStycfSVV1OlWZ9AQts0v
 Osjfv6QLRpqKQromxBE38F79zhY+n5mWEZX41ZhcnxJoAYZ4W0OFkbwB1iofSEMPAIHS
 ZfVyAGz1GQ4lLaf1FIN+p7Cg3ewTjqObBcDZ7KB9PTVL6hwtMgR/3g670OfdXqVlsy5E
 FJFlKzlP+/A4i1CqIGBliTd8S11ryukj+zVeRsxXjx6hRpEw08D6nLI9kzH+UcurTXCO
 7ZBhfW5y8wy3CtgjiKyLZQKyF6AdVIiOfbXycEXO9OMMty3+NPykAD74biLRQkK0ALau
 G4oQ==
X-Gm-Message-State: AOAM5327uma7yeMtShndeb8v/O8Tgp/O4BhHFStwM0x2Lr5kAwP5Ah3+
 YVmi3jxIc0TC2HY1zFKwp58=
X-Google-Smtp-Source: ABdhPJwtbHS2RFbeo4kVpBYuLegUv2JDTPcrNjb/7jnD2d47dIRB2tp0AZClzuHpx7t2+9fr4+WJmg==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr10740158wmh.92.1602507713610; 
 Mon, 12 Oct 2020 06:01:53 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a7sm23130788wmh.6.2020.10.12.06.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 06:01:52 -0700 (PDT)
Subject: Re: [PATCH 3/4] hw/pci-host/versatile: Add WINDOW_COUNT definition to
 replace magic '3'
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201011194918.3219195-1-f4bug@amsat.org>
 <20201011194918.3219195-4-f4bug@amsat.org>
 <CAFEAcA8hbkrTo0VpLtjFDtXc5CL7zK+X8ppX==P9_+q_V8-pAw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1998e286-b4f4-2e2a-2342-ff5e748abcea@amsat.org>
Date: Mon, 12 Oct 2020 15:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8hbkrTo0VpLtjFDtXc5CL7zK+X8ppX==P9_+q_V8-pAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/20 10:46 PM, Peter Maydell wrote:
> On Sun, 11 Oct 2020 at 20:49, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Use self-explicit WINDOW_COUNT definition instead of a magic value.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci-host/versatile.c | 28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
>> index b4951023f4e..4d9565de4b1 100644
>> --- a/hw/pci-host/versatile.c
>> +++ b/hw/pci-host/versatile.c
>> @@ -72,6 +72,8 @@ enum {
>>       PCI_VPB_IRQMAP_FORCE_OK,
>>   };
>>
>> +#define WINDOW_COUNT 3
>> +
>>   struct PCIVPBState {
>>       PCIHostState parent_obj;
>>
>> @@ -86,18 +88,18 @@ struct PCIVPBState {
>>        * The offsets into pci_mem_space are controlled by the imap registers.
>>        */
>>       MemoryRegion pci_io_window;
>> -    MemoryRegion pci_mem_window[3];
>> +    MemoryRegion pci_mem_window[WINDOW_COUNT];
>>       PCIBus pci_bus;
>>       PCIDevice pci_dev;
>>
>>       /* Constant for life of device: */
>>       int realview;
>> -    uint32_t mem_win_size[3];
>> +    uint32_t mem_win_size[WINDOW_COUNT];
>>       uint8_t irq_mapping_prop;
>>
>>       /* Variable state: */
>> -    uint32_t imap[3];
>> -    uint32_t smap[3];
>> +    uint32_t imap[WINDOW_COUNT];
>> +    uint32_t smap[WINDOW_COUNT];
> 
> Strictly speaking, this is conflating two separate
> things which both happen to be equal to three.
> 
> The versatile/realview PCI controller has:
>   * three memory windows in the system address space
>     - those are represented by the pci_mem_window[] array
>     - mem_win_size[] holds the size of each window
>       (which is fixed but varies between the different
>       implementations of this controller on different boards)
>     - the device IMAPn registers allow the guest to
>       configure the mapping from "a CPU access to an
>       address in window n" to "a PCI address on the PCI bus,
>       and our imap[] array holds those register values
>   * three PCI BARs which represent memory windows on the
>       PCI bus which bus-master PCI devices can use to
>       write back into the system address space
>     - the device SMAPn registers allow the guest to configure
>       the mapping from "a bus-master access to an address
>       on the PCI bus wherever the guest mapped BAR n"
>       to "a system address", and the smap[] array holds
>       those register values
> There's no inherent reason why the number of PCI BARs
> needs to be the same as the number of system address
> space memory windows, so they shouldn't really share
> the same constant.

Thanks for the detailed explanation, I'll update.

> 
> (We don't actually implement the behaviour of the SMAP
> registers and the BARs, because Linux always configures
> the PCI controller to a 1:1 mapping of PCI space to
> system address space. So we get away with just having
> our implementation be "always do direct accesses".)
> 
> thanks
> -- PMM
> 


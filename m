Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E0EC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D563F24649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D563F24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBeWZ-0005ZT-0s
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBeVC-0004es-UF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBeV7-000820-Pt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:00:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53565)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBeV7-0007zD-FN; Tue, 10 Mar 2020 09:00:49 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYedH-1iowfq0WOZ-00VdvT; Tue, 10 Mar 2020 14:00:25 +0100
Subject: Re: [PATCH v3 04/12] scsi/esp-pci: Remove redundant statement in
 esp_pci_io_write()
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-6-kuhn.chenqun@huawei.com>
 <111d4416-2281-6f8d-9b1d-66e60a05e02a@vivier.eu>
 <7412CDE03601674DA8197E2EBD8937E83B681D85@dggemm511-mbx.china.huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <88cf82c2-9318-1be9-1d56-b1af891acdea@vivier.eu>
Date: Tue, 10 Mar 2020 14:00:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B681D85@dggemm511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g1D0t4oSLKzMdYiH8RvEfUeTUQxuSFR/83A2KrcieVp+T0GOrAK
 s60038tBQVkEhqcA1vL+LRQrHjOWW5/KFnw1sfHIrIIlylldH4Q5DUzurOPNBwWsq1D9eOn
 zSn3hcSAGS/dlJRvT7o8Ht6H73dKr8iEjo+TGE4Ry25bGOLGizEd4BI02Cx6zMfbKfBb6h9
 5GXwczOZif2gy/l5dBTvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rBU6bvA0PWE=:AuomNXMMOv5cfSnv+2O66o
 LPj8uGFbx9ZhTLeBEv0qzmxCRuR9nODcuRkLk7vfnV8Az0dj9Zh6Ar30jX43YdEAzVW6yJkYU
 o+w5aCKHIomCU/3SYXqNtEFM+EfdwTITI2G7av5GdCzXs7Gv8Y3+CUJ3mDi1pvBMjOfxLttVD
 U5bT6UPKiQrlY9KGl7vQsGRninAfj5dTL35ZRYxri0njvyS4qkEs2DOmvwbfyS7Y8pH1Guk7S
 VpBjl4fua4pvgOoNGrR27PFWVvFIxT7jQwm0c0avmkG7sDhntLo0PzNCQ0qAD4wMZVlCV2wnZ
 6g8Xmtd2xkPxnAIuGHbeo1oa99nclCiFhKrKS4+KTlXk8xnXmTxxe80yWrKEiQixcVsYqRPBF
 SUfKtFWOwNW/aBuzhdBao1A89c61dExHMNqjLtgygN5Zz2Zjuv9fMUEx2EEpKhWuGNl+LzA24
 ulj25aLvvio89A2TcfLhdVEYTOlN+aH8b8lmtOld/S4a695WDYjy0/912B+BPlNzB86DjCU7X
 Cv3OURgFBl5IxUpPPUWV2aYVmAHj9NP9NiOvUgExSyTGk7tuhyJ7ca4qXhsn5YyxmL5995FhW
 lnVttYiC21EeMctE7K3wWqJ4IWlagSZsf7IOST3PanDTlHaPc/zBHXGCounEYjBbJFVQ7Y+ba
 y8H9kzGcyEyc5cevf8e3T3Sb5XHACDfEWk/iuwpjS0covsR0Cn+mXCc2fSlfdpdDENGSMCGYQ
 TgSc8ZHlkx0COYvU8NWlKZDc9LGzn61nf2b7fDaHfBihT9aKndhJ3HYWGKZxihphRKX8uTcfZ
 7uYURgaJylFKzhC+4BwcECV2mNWnbhCUgxvlSjUA9FTCDiAfEwemq3x1orEAM5r4FzXaZfg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/03/2020 à 12:52, Chenqun (kuhn) a écrit :
>> -----Original Message-----
>> From: Laurent Vivier [mailto:laurent@vivier.eu]
>> Sent: Monday, March 9, 2020 8:22 PM
>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-
>> devel@nongnu.org; qemu-trivial@nongnu.org
>> Cc: peter.maydell@linaro.org; Euler Robot <euler.robot@huawei.com>;
>> Zhanghailiang <zhang.zhanghailiang@huawei.com>; Paolo Bonzini
>> <pbonzini@redhat.com>
>> Subject: Re: [PATCH v3 04/12] scsi/esp-pci: Remove redundant statement in
>> esp_pci_io_write()
>>
>> Le 02/03/2020 à 14:07, Chen Qun a écrit :
>>> Clang static code analyzer show warning:
>>>   hw/scsi/esp-pci.c:198:9: warning: Value stored to 'size' is never read
>>>         size = 4;
>>>         ^      ~
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>> ---
>>> Cc: Paolo Bonzini <pbonzini@redhat.com> Cc:Fam Zheng
>> <fam@euphon.net>
>>> ---
>>>  hw/scsi/esp-pci.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c index
>>> d5a1f9e017..2e6cc07d4e 100644
>>> --- a/hw/scsi/esp-pci.c
>>> +++ b/hw/scsi/esp-pci.c
>>> @@ -195,7 +195,6 @@ static void esp_pci_io_write(void *opaque, hwaddr
>> addr,
>>>          val <<= shift;
>>>          val |= current & ~(mask << shift);
>>>          addr &= ~3;
>>> -        size = 4;
>>>      }
>>
>> perhaps a "g_assert(size >= 4)" instead would be cleaner to mute the warning?
>>
> Yes, add 'g_assert(size >= 4)' can mute the warning.
> 
>>
>> I think it's a good point to update the size if in the future the code below is
>> modified to use size.
>>
> Hmm, maybe it is true.
> 
> So, let's  keep ' size = 4'  and  add 'g_assert(size >= 4)' after if() statement , shall we?

Yes, it's what I would prefer. But it's a question of taste...

Paolo? Fam?

Thanks,
Laurent



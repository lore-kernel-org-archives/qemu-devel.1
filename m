Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075DBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74972075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCJe7OSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74972075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k14Ho-0001Pu-2o
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 04:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.emanuelegiuseppe@gmail.com>)
 id 1k14H2-0000sf-Tu
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:50:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <e.emanuelegiuseppe@gmail.com>)
 id 1k14H1-0000kK-6q
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:50:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id 88so24086547wrh.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G9MTJyZmidfbZihL+PltADIgkT8tJ22EtYR7CyngKsM=;
 b=CCJe7OSXZO0iLAstW2KUncF5mFK0j7oVHFipfWf5LUK9tv5YOyPFRE5peNMs40jDRb
 BcxsVO8xAADlt2i5kYzfuz55qoYdB2lT1V6aBKT/PqOpAlFNciPuWOjtTm8jekwL5tp9
 tNYh+LBl3qTpKBnJ2UTOue9upNpwdpCXWIjooUBfc2jmpCQZ8iW9fjA4LZgam3jqtTyR
 iqOUO7xfRje1qbeBkVEk5ftR2VTV5fSFQkZZGCnR8yadKpj7tjwKajbh/YC58LeGZzHv
 hMFHxPjfpxPRPYEBZHfRXunwKj6foXP436/5NtWXhZHri8glg5Mmz1/YYmJe4FZdTxu1
 zvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G9MTJyZmidfbZihL+PltADIgkT8tJ22EtYR7CyngKsM=;
 b=HVaeLSgAtzr+v7+QNzaBYwIJmELXKIXPSiRycQHh9W7z0SafaTJWee/P27L7fP1Sc6
 qF+AdHO+HjPLE9JURJVCf7e87fE/flcCjsoF409lz5Cw9pL88N74/3k6zhlwdqIH0HE4
 sp4eWUHsLf0APYUakX1oaR4vtCXeedSZ9KtM6uooMjP0tUr5EdUZHCpO6f4kwr7Qj5vD
 ZzsTfFpy9SXWQCDgjm18aHETDZoiPifpNl05zlE0G24nyxCA/iwrKzPNBUL3BduFfCdo
 enRUVCuPnFY9BX4y0RW1DR/NvO90qfx7DI3D6ats0KLdxK0JzqUg+TgtRfpUn/g5pfAD
 qDoA==
X-Gm-Message-State: AOAM5335dBDBdnJ48ZGQFCZ3HFgZbq2+bEtbgT+hgPoMUPVBqipbTJum
 J2jZ17e5GQDuKhBE6jLtdrg=
X-Google-Smtp-Source: ABdhPJxE+UCyhfl7/Ny1m276EuRfx0a/Xh65yGok89q3L6Ct2RYysLqkIpegLDGJ5U714BxtS7jtEg==
X-Received: by 2002:adf:9ec5:: with SMTP id b5mr1669726wrf.190.1596099045195; 
 Thu, 30 Jul 2020 01:50:45 -0700 (PDT)
Received: from [192.168.5.11] (net-130-25-47-175.cust.vodafonedsl.it.
 [130.25.47.175])
 by smtp.gmail.com with ESMTPSA id x82sm8956664wmb.30.2020.07.30.01.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 01:50:44 -0700 (PDT)
Subject: Re: [PATCH] pci_dma_rw: return correct value instead of 0
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20200729221732.29041-1-e.emanuelegiuseppe@gmail.com>
 <20200730074146.b66tur2v7tx4uo3d@steredhat.lan>
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Message-ID: <68b64151-6c5f-64e2-f9cb-baa460b6b985@gmail.com>
Date: Thu, 30 Jul 2020 10:50:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730074146.b66tur2v7tx4uo3d@steredhat.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=e.emanuelegiuseppe@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 30/07/2020 09:41, Stefano Garzarella wrote:
> On Thu, Jul 30, 2020 at 12:17:32AM +0200, Emanuele Giuseppe Esposito wrote:
>> pci_dma_rw currently always returns 0, regardless
>> of the result of dma_memory_rw. Adjusted to return
>> the correct value.
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>> ---
>>   include/hw/pci/pci.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index c1bf7d5356..41c4ab5932 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -787,8 +787,7 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
>>   static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
>>                                void *buf, dma_addr_t len, DMADirection dir)
>>   {
>> -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
>> -    return 0;
>> +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
>>   }
> 
> I think it's a left over from when we used "void cpu_physical_memory_rw()".
> 
> I agree that it is better to return the dma_memory_rw() return value, but
> at first look, no one seems to check the return value of pci_dma_rw(),
> pci_dma_read(), andpci_dma_write().
> 
> Should we make them void?

I noticed that nobody checks the return of those functions, but I think 
checking for possible error is always useful. I am using the edu device 
and clearly doing something wrong since with this fix I discovered that 
the pci_dma_read call returns nonzero.

Keeping the function as it is or void would make it harder to spot such 
errors in future.

Thank you,
Emanuele

> 
> 
> Anyway, for this patch:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Thanks,
> Stefano
> 


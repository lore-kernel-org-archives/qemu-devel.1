Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21331C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAA5223DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAA5223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpqwA-0000na-L6
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpqvv-0000JL-Tl
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpqvu-00031o-OK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:18:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpqvu-00030z-He
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:18:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so27343740wrr.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 02:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qSYGNxJQtzSSbHhLWI05cVRnJc1oheCotBXXqY5OUnI=;
 b=NcxLkrBTXwy+IjcKVUQrP7LhOeQKsqS8+L/1dINFn5pdPHRoYbjy+ofMZaGKwNjm0a
 9tgzp8HmqB+wQqkcA163SXHMsS44csB9sZU5Qdh0gtPfq40jZHbt33u/Xi/zrwIAI8fy
 TMTdo3olRZs6x7sDUBMsVcEU2Y3KVP6Ta0QyjEp03/5d9S2jmwOeg8HF4Pk8XAVYqtlD
 Rl6GhIGgPwG5YRDEWKny3ZCKzti97BIwxNLpyLMd7VZtanBHzsWe3kPbUffuhtjxLgHD
 oVr+pC1JoeYG/uSjuEIXSpumev7Gfct/DNQdjqG6P+dveBrExzUzplnwnm8p+JyXusZM
 GTFA==
X-Gm-Message-State: APjAAAWA0h1yp3plYhBcnmBCST+UbYd4Z60RLHYj6lHA/Bx+iLzsEp1N
 BDI5Qdqy0uv23uL2UHdiTCQ8nQ==
X-Google-Smtp-Source: APXvYqx4P3PROtMuOFaH7g3DwhuVOirqgmhSUiIGg3kC6LLIIyeRCFMVFpauVbyhj36to0G9wppFkA==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr51873405wrw.185.1563873485487; 
 Tue, 23 Jul 2019 02:18:05 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id d16sm34801964wrv.55.2019.07.23.02.18.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 02:18:04 -0700 (PDT)
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0259E1C966E8C54AA93AA2B1240828E672DF1C92@dggeml509-mbx.china.huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <79415991-ec1a-fac3-801d-2cfc446e8e11@redhat.com>
Date: Tue, 23 Jul 2019 11:18:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E672DF1C92@dggeml509-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] pcie: fix device hotplug failure at the
 meantime of VM boot
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
Cc: fangying <fangying1@huawei.com>, "mst@redhat.com" <mst@redhat.com>,
 "limingwang \(A\)" <limingwang@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Oscar,

On 7/23/19 9:47 AM, Zhangbo (Oscar) wrote:
> If the PCI_EXP_LNKSTA_DLLLA capability is set by default, linux kernel will send 
> PDC event to detect whether there is a device in pcie slot. If a device is pluged
> in the pcie-root-port at the same time, hot-plug device will send ABP + PDC
> events to the kernel. The VM kernel will wrongly unplug the device if two PDC
> events get too close. Thus we'd better set the PCI_EXP_LNKSTA_DLLLA
> capability only in hotplug callback.
> 
> By the way, we should clean up the PCI_EXP_LNKSTA_DLLLA capability during
> unplug to avoid VM restart or migration failure which will enter the same
> abnormal scenario as above.
> 
> Signed-off-by: limingwang@huawei.com
> Signed-off-by: fangying1@huawei.com

QEMU contribution guideline says:

  Please use your real name to sign a patch (not an alias or acronym).

See:
https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line

We can infer limingwang@ real name is Liming Wang, oscar.zhangbo@ is
Oscar Zhangbo, but for fangying1@ it is too hard.
Can you provide his real name?

Thanks,

Phil.

> Signed-off-by: oscar.zhangbo@huawei.com
> ---
>  hw/pci/pcie.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index a6beb56..174f392 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -75,10 +75,6 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
>                   QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1) |
>                   QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT));
>  
> -    if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
> -        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
> -                                   PCI_EXP_LNKSTA_DLLLA);
> -    }
>  
>      /* We changed link status bits over time, and changing them across
>       * migrations is generally fine as hardware changes them too.
> @@ -484,6 +480,11 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> +    if (pci_dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
> +        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
> +                                     PCI_EXP_LNKSTA_DLLLA);
> +    }
> +
>      pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
>  }
>  
> 


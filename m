Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3B3C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5767A20872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkJySGth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5767A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBl9-0000dp-Cp
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJBkC-00085N-Mw; Fri, 18 Sep 2020 04:27:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJBkB-0005eJ-Aw; Fri, 18 Sep 2020 04:27:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id a17so4699167wrn.6;
 Fri, 18 Sep 2020 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mkrw5km5VK9LfPXgdELjiSc0W0DAvu+zPnqJ5yNS+Ek=;
 b=UkJySGthCZI4QCQy78FFDgfJ3E1nAx8VFAn2hVvOXYjfo1Dy8LTgPeUF3IxVWco478
 KBvfmUD3TkL0AuGv6dnAxq8gDlVL0ODe9HGMKcmOAj5RzHm7vnClbabr/7iFTlq1i83P
 8c/FJz4aW1MaSw9o3ejDuoC/wDdQTmXBNAxYy9WyOyuswpSqOJPtzUi6aIfstg+oWqRG
 WT3V4Q5ov8fbeC1UYjRwBRwPC4ZuAVD50WCBvssV+aQMk0Pvz/a8BIY8rad7vY4ZcrJm
 kugr7S/C1Ym/wOonnCnm1bXDMYLtZCZvtr5rpJu4+9rn15/KIff3A68MJRrC1/8Kqw67
 Naug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mkrw5km5VK9LfPXgdELjiSc0W0DAvu+zPnqJ5yNS+Ek=;
 b=toKS+HqF81If43p894/if1KgjXqeAQa4W99043hLeqJWC+ILqvy+zUFCslx89Kh91S
 V/rhUEl5AHv5c31QcWJs/bNMk1Rs79PDeoKDNp8QgGJ7YG8a46HoZbakon9d0/6DZZ4t
 5MkVeq10wUEtQaHPZQlkMj81/HXuQEf8E/l/NwMS+Huh6RryxUkU7LtAzdsBE1pl8Hxm
 oSnNHtG4xbiUJygyRzyR1VCymAUpNqONPLqVSl62jdwgjF1OfeFHtLRyDt/kQa86L2LS
 eFqHZQ9KuX/JTn87gI2kIp+9l8Gy4W3UIHk9OGsPoJiJsWTP+SppawUffriM3kVE/A64
 ZFWg==
X-Gm-Message-State: AOAM533HrRfUEnTvz/0LaRQXtdnkqaw0y4Q9GA5QYK+yPvJnITU9YQad
 865t31eindPqJ7yu6J0/sUk=
X-Google-Smtp-Source: ABdhPJw1jIjNiRO2AXfwORyEGfpMdCsG7s12F5LBSmWzQEsS8p66NgbB/JrBT5xZGWCAiz805kJhFQ==
X-Received: by 2002:adf:eb8f:: with SMTP id t15mr12969087wrn.417.1600417665377; 
 Fri, 18 Sep 2020 01:27:45 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id s2sm4270678wrw.96.2020.09.18.01.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 01:27:44 -0700 (PDT)
Subject: Re: [PATCH 0/4] hw/sd/sdhci: Strengthen multiple DMA transfers
To: qemu-devel@nongnu.org
References: <20200903172806.489710-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <621986c9-5a52-383b-9cff-fef2696207bc@amsat.org>
Date: Fri, 18 Sep 2020 10:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903172806.489710-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 Ruhr-University <bugs-syssec@rub.de>, Prasad J Pandit <pjp@fedoraproject.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 7:28 PM, Philippe Mathieu-Daudé wrote:
> Still trying to fix the bugs reported by Aleksander...
> 
> - Do not send 0 block count
> - Reduce DMA to MMIO re-entrancy by yielding when pending IRQ
> 
> Based-on: <20200901140411.112150-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (4):
>   hw/sd/sdhci: Stop multiple transfers when block count is cleared
>   hw/sd/sdhci: Resume pending DMA transfers on MMIO accesses
>   hw/sd/sdhci: Let sdhci_update_irq() return if IRQ was delivered
>   hw/sd/sdhci: Yield if interrupt delivered during multiple transfer

Thanks, series applied to my sd-next tree.



Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBBCC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573672072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMniXMAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573672072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m4I-0006IL-Iv
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m3b-0005O9-45
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m3a-0002hM-55
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:27:51 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m3Z-0002gv-U4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:27:50 -0500
Received: by mail-pf1-x441.google.com with SMTP id 2so9400300pfg.12
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jbUdH6Eujzo6rno2n4kS6BU6fJkjgt6ImnztGIZKbEs=;
 b=uMniXMAsxv5xq8ECHkS8KWuiLMfnSjpuwtqJ1ddSFvq6pO6gByRtNJH4eNPhdrCRfX
 lu7AeIgC3vd5FY9F+2CKH0KXpYAxd88xiFKbLYp2Ys2n3o8qqIO4vVPxozNFLlyknRdd
 +SvvwskyEsjr/s2jrZLF6KquUj+4c1YBP7RjCivWtE7cs9yR8iLwbkWa3ltQHZLS0qrV
 sLk76mbAiCQu5R1w76AXHmFKmk2XI6RssuB1EzfdC1IQXP6XIoZH0VifeQt8faWArcmZ
 GKXbHdxnt7SDrc6PCIsjkKQVmC/VUpL+NKNqqedrPVhhWcyt8a37pHhqWV+iyuQBlzZ4
 fQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jbUdH6Eujzo6rno2n4kS6BU6fJkjgt6ImnztGIZKbEs=;
 b=pkCQKDxBJzPCN1WAWdDTNFhpRn144un1i934nk/mUN2kx8t1MOtIFEaSaTaxwqfuxq
 WuoShBOiWhaSLO15mq75kRPKmgczSgbI5vXojTiMBEsu23eLUddzZzPhZnT1Ej9yHagP
 elM9NNe+tkDpPZ/i3RmIbyDJq/XhyZKslwjrPSyzDbh86PP/L+MCJ/TFJOsOsVYbBK3y
 DoPT2Gb3WgF2qJa+bxxufUZ2T5YATXoEIyYxXuSVcvs9Qoc2izvX/ecOLbZr4DpWrit1
 WDO8j3s4+d4PoMyhlXm5dBxR2P8Syq1BRnhbTC+3RGCvoBA84u4gv8HApqRdROsb7pt/
 MofA==
X-Gm-Message-State: APjAAAXBib8lrjlN7p2/NLiuVeMCuLt2Hmrm349HbIIw/QfJdtSdvmIW
 J4vShlnlX9TXKV6J2tqex2sdHA==
X-Google-Smtp-Source: APXvYqw9cnXhyYwwSEX71V1KuIUv4jz5iaCoc0coC6KVmVpINQ1ahMiGAQh4BzucfBEknKZXD7W+SA==
X-Received: by 2002:a63:131f:: with SMTP id i31mr19700589pgl.101.1581967669116; 
 Mon, 17 Feb 2020 11:27:49 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w11sm1231659pfn.4.2020.02.17.11.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:27:48 -0800 (PST)
Subject: Re: [PATCH v5 42/79] x86/microvm: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-43-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f0cd1eb-8d4e-a275-19f6-eb60ad891979@linaro.org>
Date: Mon, 17 Feb 2020 11:27:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-43-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, ehabkost@redhat.com,
 slp@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF8C34024
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB267214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DV+fl/qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB267214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lHi-0005Jc-48
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lGy-0004fO-FG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lGx-0005dN-Er
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:37:36 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lGx-0005d0-7n
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:37:35 -0500
Received: by mail-pg1-x543.google.com with SMTP id j15so9652019pgm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=la17vLsy/KSK2gv+zXQ44smB0vizNcJ1TlcaQOFbtO4=;
 b=DV+fl/qCRfLykCkolwF4+d26qDgvll8yXxAONVzvSHBoCAMr37xPQBnk7EnGbi4qPi
 EUP7NtQDSoIhOTWfI1tSTmO05IRQL4oE+jhET9T1uPVPokOwpA9XuM69FjbtrPHW5Tlw
 OjD7dATIIZrvCc+M47ij6WlISrEMVpxekyVSb8f++eQGMwUkjrrhHcVvQ7ANVPrB7cnS
 Emn1eoGDsy/bD6NK9gME9JgRwy2I54y9vzjL4u6WICA7333B9ltOMfyVgRiWkd0u2qGa
 qY/05WYsb1MvHMXak5FUrPPN9KycvGFYpOiQQmiyJKlfIwJodi9MmWMpt0Hn6MGcyqL4
 8RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=la17vLsy/KSK2gv+zXQ44smB0vizNcJ1TlcaQOFbtO4=;
 b=B1wJK6R1JxaFifdb8OWwPdtr7Bx8S2uiks8qCdNrNtEz4fOztMUf26P2L6GyKB/x+W
 IQZcSqYBT9ece53ksjYDaJDIY2PFjZTfDP31ij/ITMrqmQ6U2NWUcjuu9Q+lu9aiBs4B
 7n9UESWB4EEanPRBNeuICdTEpbRE0XDCDoS2rbuhsCEYcvNT5ywPKeHs4mezCbR5UbLv
 gnx8tHJ/aeP1/qVVDJWcr7lU//bFxIzMAZ+OG78v0QLkwdISyQtW4oClpH9t6Rmb+C6y
 PkARh3ihixdB72H7KWSfzHZpXcT3mtSRoqD1/aL0jkj0bmxhMWsJH8nXkdzjD5OSx1My
 LWoA==
X-Gm-Message-State: APjAAAW20oaahKshy5I8A722FQ38EAUqD1H+KGHezOJnlQL/8V/AKqxb
 gs9GQCto+QstLJ4WTp4Ysjn/zQ==
X-Google-Smtp-Source: APXvYqx4+mJS0/UzLC+G3yJ6OPxD3LUKFiek9D7Wn972W7/OGBh8Wj+7c+slJxAlniSlcSiAW5Y8kA==
X-Received: by 2002:a17:90a:d80b:: with SMTP id
 a11mr444886pjv.142.1581964653632; 
 Mon, 17 Feb 2020 10:37:33 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d64sm1633358pga.17.2020.02.17.10.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:37:33 -0800 (PST)
Subject: Re: [PATCH v5 72/79] remove no longer used
 memory_region_allocate_system_memory()
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-73-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f388171-3893-0544-7a59-503a509baf9e@linaro.org>
Date: Mon, 17 Feb 2020 10:37:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-73-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> all boards were switched to using memdev backend for main RAM,
> so we can drop no longer used memory_region_allocate_system_memory()
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: ehabkost@redhat.com
> CC: pbonzini@redhat.com
> ---
>  include/hw/boards.h | 32 --------------------------------
>  hw/core/numa.c      | 34 ----------------------------------
>  2 files changed, 66 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


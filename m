Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D468C34026
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD1720725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYH6gmdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD1720725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m1w-0002cM-0F
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m0y-0001iM-GJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m0x-0001Oh-JM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:25:08 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m0x-0001O5-C3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:25:07 -0500
Received: by mail-pf1-x441.google.com with SMTP id k29so9394765pfp.13
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cPGkuief6c1gMx0IQQHkieq2SiUsEqNdkxvRQsC4DHg=;
 b=wYH6gmdQxMe3xIkUBJAE4Q9vMHNX8A3dJjimdINr9pNqhvU58L4TUaA7unXmdZ/rYD
 ND9xiAUyc59LxSak4R0AD7x1G0TJNNOfihAgW1N1uk5NSUTx89ueUaKXvYSWkaU3agxl
 eEv3FW9upDKIJURRFn5RcMudcC6l5PnAAoywQyUFVdvFvaT2uk3QGESXMQXI5tYEG2lg
 rO+8wQWUvxmD7l1kRyQbImr2bN8draNeFvucswEfwjYses/Wt9uzgIRGS/YwChVSTiLb
 BmofFVxYxhfVMR+3bAwVKd7A/GJt785X5NLeHr+6U4yko5+fw8g/XlpgBxMlg3q527+z
 RPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cPGkuief6c1gMx0IQQHkieq2SiUsEqNdkxvRQsC4DHg=;
 b=Lc6bh/UOG2d2qUMWDCmoKXmLgbII8IvPoyEVJYbirTKzWAwIqdaPr/oNw5miDxgynn
 +71Grc5ERJ17225BIBw3X/N3NW3/ST+HTKQzWdr4H0Ya/waHFtiUJjYcE3z/dUbKilfK
 NuuoWodtvN6yTobK5fgLhpZaOpLEIbKjyFgbIdX4I3JMfVWnC/1Fx/NOUF+iKMVDBfm6
 tZWQFC4mi3Y7WYn+9+eeQEcaELBq19XiSR9S4nuLV0Vz6TCr11oClRAe/47PybL47hu+
 /hrQBwhUIrx2/coxcHNVgoVoNW8q1fPzjzBbDb78Mvytv8+84A4w5YrgGuEzuSy+oGky
 hGQg==
X-Gm-Message-State: APjAAAXuVmVwUiMM7Fm4WoyryRN+F0bHR2torf0yRZ2OEteqpgkUBqYG
 DPukCq1EuOA+Qlmfw5tz4OlG9w==
X-Google-Smtp-Source: APXvYqx9n0rnwq26QGqeo59WoOnZNo9WgZpFCsllnG3UI9mgeOJUCQfWi8civwX/jNqK5iqHrvg5sQ==
X-Received: by 2002:a62:a515:: with SMTP id v21mr18219202pfm.128.1581967506331; 
 Mon, 17 Feb 2020 11:25:06 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 10sm1172753pfu.132.2020.02.17.11.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:25:05 -0800 (PST)
Subject: Re: [PATCH v5 36/79] arm/xlnx-versal-virt: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-37-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db61c803-3c48-0907-22c2-2040317a8068@linaro.org>
Date: Mon, 17 Feb 2020 11:25:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-37-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
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
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



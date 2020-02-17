Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0386FC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49412072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ta9tj7Ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49412072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m5C-0007SK-VE
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m2y-0004bB-Jn
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m2x-0002S6-Kn
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:27:12 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m2x-0002Rg-FW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:27:11 -0500
Received: by mail-pl1-x641.google.com with SMTP id e8so7102225plt.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0JXBjTsj59hubbgQEw+E94ZUzjwM8GP16u5Yl6V3o6I=;
 b=ta9tj7Nye/lLqX3icfZy32fH+YAYC0ygjWfKWoHDBLv6ptiQt70R+WE1netY8Fc971
 jQX+hoYU0oZ5fO+cUPJnU21FJTrUGDzw7H/b0LSCYUXqBS+jQVfdzwFImgyPi1GAGQhL
 7EBltHaJGqs5mhaeww/yLTfwXzc5yCjRLCUkuOuBOKk0acb/9jKKfc6GlZsa7N3ENNxU
 fd4J0aPipRVU+lcBwpoK6SeM7qbN/1pD7vfX9jB7Y5j7YbAhCuePiEIgYfYh7X6xKZDc
 gOh7lKe6se0RckZ/IrKH4cRsl+o6cj/8Ia4W9yi9+ctnHg0MAaadPNlp8tS27sReaQGT
 X2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0JXBjTsj59hubbgQEw+E94ZUzjwM8GP16u5Yl6V3o6I=;
 b=aniuQcXkwPwwfZ0QPbE0Wv7WrMqhHF0fd8njuT4upB624aQD1VhbGj5qeeDbyVPXDH
 zz+RKePK7TrgMiEJdOhM9zf5UjoC/VqeBx4VP8VVhpszutV5fN1tX3cHKUQR/VTte6Qj
 dosio9CT6Md4ium+kA8XW7H2pZNn62rH8JKB7Rc3e7BgTXuyJeluEyHnXj0/pOYtLRli
 uhXEVkrniX5kwSvQX0EfSHzc2K8Iz7DigHwgXejR6H6mvqFj7svJvThv1mOmByPE6cMB
 G+Ctk3UoRdMQnqxpa93Kb6aqKI6SGjwHLKLxGoUiHsMuSQ/JsmiqCvwOXE2LKWT6017f
 pIuw==
X-Gm-Message-State: APjAAAVb9YYv62RwvdCwkPbBmERyVs8fEeDxAsyg9/ECxgm+LUIBFnSP
 /DMeKhZIqtjElBe9fc39m4gRzA==
X-Google-Smtp-Source: APXvYqy3O3EP9Hbq4G5ZP4WjY5hPmRJVzVDFkoOeucf67kbrttnlHuOm7sGjNewIcSACvy6YnC+XIw==
X-Received: by 2002:a17:902:8d94:: with SMTP id
 v20mr18022653plo.259.1581967630430; 
 Mon, 17 Feb 2020 11:27:10 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q13sm1265403pfn.162.2020.02.17.11.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:27:09 -0800 (PST)
Subject: Re: [PATCH v5 40/79] cris/axis_dev88: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-41-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55d5aa6e-740e-0caa-ecc4-6718845f00fa@linaro.org>
Date: Mon, 17 Feb 2020 11:27:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-41-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, edgar.iglesias@gmail.com
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
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



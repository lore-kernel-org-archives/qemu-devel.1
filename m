Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934CBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470CE20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUa8b4w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470CE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv5Z-0005PK-Dz
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuVz-0006h1-Qn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuVy-00007k-3t
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:31:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDuVx-0008TX-Pv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:31:01 -0400
Received: by mail-pl1-x641.google.com with SMTP id t16so1365977plr.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S33O+59yUNyR/4TdW05LxJ20iOUiDU40+t27Gi7WHR8=;
 b=fUa8b4w6NEpO9GUovi1qZ8+UpVGYv6UNZ4I6FndOFrXka6Sf9MaJirqfcJE3oe8IMr
 08oTQAy9pFYZFOMK7enm1keuZZA4kvOSd6pY2OagV9RH3rWxHTOE/cqqCt9ut4NpR84+
 ZR1GVZxwohZoyZB9PkMv07p1+6BoQh31RBIlHjokfAriUJ/9H2MiYyJ3fByehMeVj8NV
 xzfuVXhGQXrnSrWQVctRuWgwvZwnew34K0OYUhbmuYRyAdfEC0EgmXz9i5xjDJn7HF3b
 sKKIkNY3UlABXu/U27zYKEekv1Ovp8zhIt7FV5adLPSBs/r50C1dhAYaOEtnpnk5FJtC
 Tpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S33O+59yUNyR/4TdW05LxJ20iOUiDU40+t27Gi7WHR8=;
 b=BnFH0Ivu9DJc0iiE5jT9STlOC09W2F3ox9bVjhrW2rOZ69H3cUi0MZ+VXbwzDYWZR9
 PXIKO36lm/Sdf2R6JB4wg5vFQ15QPJXFYQry8+mCwTa9w4fsO9/ljoG9DM4FCrr72Jmx
 aQVMD6S7HfPJ8OBQU4EJ7lcwCoMQXFn8e5twOM+faAcfjTD1ZoXRRruiz0ANy6ULLQHq
 jYjSpAIrla9kDJE7UdjCnE9hFve9c6uwlt6dKuw8kGZkUnxGxvTjoD3noEus4lSEL9Gt
 BgrVpOMBWbQIJEHvAtGnfusjD9fzQzWm2mbeRqus7QwAtVZ11ntwex9p7fp0/U1RhyDA
 kSlg==
X-Gm-Message-State: ANhLgQ0UbflpEyqMT0c5H5kYscAfv/AScwKBIOGL+IhsYz4NiP+WSbcD
 uAPHRQECqcWlFLxet3SDaONv8A==
X-Google-Smtp-Source: ADFU+vsAabYYuX0vZmCuyuGtqpyJigTx0sYHz6Hy3VHBLxBY4KIvEjEl1QsEeKaXZpc7oyR+KB+ecg==
X-Received: by 2002:a17:902:8bc3:: with SMTP id
 r3mr491960plo.220.1584383460850; 
 Mon, 16 Mar 2020 11:31:00 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a19sm580988pfk.110.2020.03.16.11.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:30:59 -0700 (PDT)
Subject: Re: [PATCH 06/11] accel/Kconfig: Extract accel selectors into their
 own config
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-7-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13d79ca7-f993-5159-d974-25c40640a2ef@linaro.org>
Date: Mon, 16 Mar 2020 11:30:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316120049.11225-7-philmd@redhat.com>
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 5:00 AM, Philippe Mathieu-Daudé wrote:
> Move the accel selectors from the global Kconfig.host to their
> own Kconfig file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  Makefile      | 1 +
>  Kconfig.host  | 7 -------
>  accel/Kconfig | 6 ++++++
>  3 files changed, 7 insertions(+), 7 deletions(-)
>  create mode 100644 accel/Kconfig

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


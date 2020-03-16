Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E0BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A13F20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1XCsAUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A13F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvun-00055e-KY
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 16:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvtw-0004VV-F0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvtv-0005Mz-IG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:59:52 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDvtv-0005EG-Bq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:59:51 -0400
Received: by mail-pl1-x641.google.com with SMTP id f8so8486671plt.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X1tKqmz/aUUBrpVIGZqEIbolTnTtNvj1VUuBBuqsIao=;
 b=O1XCsAUG7KnQFPKeGcLaEnNHnts31SOTIrdIbJu3e6fk4jvtpMrwmXunYe9CL6LPSc
 NFRAaX5PcMT+2dkVmzm3w97N841SGDkQwAZwnLoGrTArmAdrrbYKPpkXcJc9Hq/BtJXq
 EBlBNq0GKrwszdKdR18nR9ZgHoUlUoJe2lyorRroTRllKUF10Le6jDA9hn0pBmG84BVS
 iNZmv0Mmvs8RFJeelNzvaeKcv26SlVeQjoCDcQjFQeZ+2Q4cpGmflCydmJoSsVHKxbfN
 8SRhC5sfUZ4rivdreL5dDeuxEYQZIMVDQcGiMFdlyFalDEseIafZ+RgjfLZD04AuaBM4
 9Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X1tKqmz/aUUBrpVIGZqEIbolTnTtNvj1VUuBBuqsIao=;
 b=I4NEffVdHme/OBr6kOffBn8d/+tp71HZwhX72h3sD6agQc96uS7HB1DhLNaPnpktzy
 sOjsq5oSZU2xAgnrHg83mODWXoVb9uFnlfJ23oFx5u+Np/Xin+6O5Oap7ZAV+0l50ATY
 VamwZS1Qx6P/8oQOLHXIkmS3YaMCjqVSYNRZDsYVOiLyXk95eP1hxcHEaIAwysoOJlb5
 WzzkQZglOQNqNrz1eNqXL7PIWH4SD6Lgo6XKRVkyH/HmtB0smczIP843HJOGOdmvTNvV
 gok3oJDHuC4Io1tGuHJGUARBdZ+HMygiyiYNwzMOwS3fBkP+hAFLJOgsBberjalY6gGb
 HcxQ==
X-Gm-Message-State: ANhLgQ3Qak9xwoG3ric1H17Q/H3MzrHsHdPxclCONU4aCUwGjrU0wswc
 6vt/7uzt6F5cwYDrx8xRP/iIjg==
X-Google-Smtp-Source: ADFU+vua8Y62HO68abSCHtVU6brXjQrZ4youYgBHnfTiLCJjZ9G81h3Y7J8Tb2KOdrRA4wWxqf1Xuw==
X-Received: by 2002:a17:90a:d103:: with SMTP id
 l3mr1232122pju.91.1584388790059; 
 Mon, 16 Mar 2020 12:59:50 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e9sm688015pfl.179.2020.03.16.12.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:59:49 -0700 (PDT)
Subject: Re: [PATCH v3 15/19] target/arm: Make m_helper.c optional via
 CONFIG_ARM_V7M
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-16-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03a44ee7-bf2c-645a-d3c5-3a4dc484e6bb@linaro.org>
Date: Mon, 16 Mar 2020 12:59:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-16-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> @@ -1,11 +1,5 @@
>  # Default configuration for arm-softmmu
>  
> -# CONFIG_SEMIHOSTING is always required on this architecture
> -CONFIG_SEMIHOSTING=y

This doesn't belong to this patch.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


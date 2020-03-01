Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91FAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9696024699
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owD4r6/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9696024699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8Sew-0001Nx-FM
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 12:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8SeC-0000cd-VF
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8SeB-0006eG-Uw
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:45:00 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8SeB-0006e5-O8
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:44:59 -0500
Received: by mail-pj1-x1042.google.com with SMTP id cx7so220631pjb.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 09:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nkQT6rGBKPnYMtm8URmV1zH8tf60jZBKAmIPjfh9ms0=;
 b=owD4r6/4DLF8lGJ2ttx9PBrPkMS2THxsYk7XSO3cfqkxg6vv7IvbloSbhachO5ex/q
 lL5eKKxOIIw/aU5w5kNIqw66S9dSXehGFwdgj3dxVIVf+H4XObAXSHS6HPidjK6dgr3B
 0fHj5kwICq9INdxoz4jo/Os+4Sou5jiiXVzhs+XgjbpyyJ6V6lWNT5m3lQnixbFHpPXg
 Jjjeuldl/04o0FwaDt7R4Y9doBgt318y7+ihXsdyWCPPM94Kaug24a9xQqhMR6LHjHtw
 cY2GxS4OMm26v6ptCHGTU6YPCgBBLobistY3f4vKI18TLUCBVmvyEhx1nvIQwxOovWtI
 G4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nkQT6rGBKPnYMtm8URmV1zH8tf60jZBKAmIPjfh9ms0=;
 b=poJImjnITQ20skTEzV/c8L0abNaPEs+y9LEsOylk4KcRylPVhtH3WXBmTCwX/VUiSo
 WjO9N2bcY4TmM4us9h+al99ZHbLVeQD3Uiz0H/h6hX7t/fbh3XnPH6nMSWV+tSuZJ1+w
 j4K/YgMbO1xuNsB+0aeZ13VQkUJcQgxb+fXZB2DgwKINSDwLmBPgtsCW2DDta8Y7UHd3
 fVM6Gmyui4JkwkDaiMPKViKAFtguYMdhfAu5kJbzty88N5PbLpNSf7UGiuPlPCjfba/D
 tAWna6pUmErCBlZuf58ztPISAKcMF0PfOSPlnSNqbOpg/TwKtG7XxxZ/f5Qtm+xXrYe2
 0zZw==
X-Gm-Message-State: ANhLgQ1xcBCjkVl9ZscqFYm50UCqzvuMumahiJY1cBSUAg+oftKOF+bL
 DySW4cQO8kCfVgcUy4Us2hkf5A==
X-Google-Smtp-Source: ADFU+vsSVd1jv2zuyzM/Z5GNzQ0cs7AdhDR1/TimwgZL9GxeEOW09c+m/cXVs6WSumzzuUo8TQUfaA==
X-Received: by 2002:a17:902:8c91:: with SMTP id
 t17mr775590plo.98.1583084698558; 
 Sun, 01 Mar 2020 09:44:58 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p14sm16866957pgm.49.2020.03.01.09.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2020 09:44:57 -0800 (PST)
Subject: Re: [PATCH v2 2/6] hw/arm/virt: Use VIRT_GIC_VERSION defines
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200301104040.15186-1-eric.auger@redhat.com>
 <20200301104040.15186-3-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7cdcb20d-4490-8f5c-2af0-0114142327d4@linaro.org>
Date: Sun, 1 Mar 2020 09:44:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301104040.15186-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: maz@kernel.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/1/20 2:40 AM, Eric Auger wrote:
> +#define VIRT_GIC_VERSION_MAX    (-1)
> +#define VIRT_GIC_VERSION_HOST   0
> +#define VIRT_GIC_VERSION_2      2
> +#define VIRT_GIC_VERSION_3      3

Any reason this shouldn't be enum VirtGICType?

Anyway, this is an improvement.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



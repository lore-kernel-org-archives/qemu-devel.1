Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C863C4647B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045F2218BB
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dck8+jWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045F2218BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJl6-0007i8-MP
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hiJjT-0007CI-4K
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hiJjP-0007r1-FE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:26:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hiJjO-0007nv-5C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:26:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so18102534wrs.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1GmLVttNOUZxp6SYzluPdJGQYRkjz7uL3ItIO5/bLzg=;
 b=Dck8+jWnJnMCdErjJQ5UcQjkJUoyNr4vTISq66TSkTM2a4MHpahTaaSMIMK/dKR5jx
 zNkTuvVOMzZ+/2NupfYr4ii0u+lJBG0N7b7xmVvb85jCa3R3nxmPnvyezBHD17xi/qN/
 aOYuesN6mi9nTXxmMb+OU0zqLID1pieF3pt10QT5i/bGMtNI/IZ6JEB7pItTtu8zLepu
 /kxmPNSLkRICIM4jPYafQj0HO6A/KiUMhEAh72HlF/C3LPtle4qhMO8m2UgGeqQfrVvW
 uc9R2LeN/vjM8IKf5zcCwwW2qsanIqkwd69LcTbFwJ3OpFc+TX8t5O8onmQeXZ2TKq6G
 seIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1GmLVttNOUZxp6SYzluPdJGQYRkjz7uL3ItIO5/bLzg=;
 b=ueJxlmoj/2Nny1rjzc1QSN5CgZyDodTivHTq0x8GPk47dgJ3zo7NDeOt9E7u6bFAuh
 xUDbETdOwH4ry9vuVJsi/WEjZfvBjjm1ZUvAyK8KrqGTe3rJyAbITLphEI96cAJLs0pC
 CNHzprm09H1qTLs4OXQLOzxkWUGqo9LnTKgzvaU8kwtN6kUjrU2oequfFqf3ahVHYAyp
 G4Jpq+AG0j77bIAOSNocsRo0S6xuTOiGKxIIONpc8dpL/7NkglXAEaHA/kuNm9BdF4Zw
 cQzMR9+tfPYrXM9DaNPvEIMYXB4KVF1/hsBcI8NQH02mpmAeURjCLub16xEGEms1hs6Z
 hm0A==
X-Gm-Message-State: APjAAAVYH1kBhsUpzhzFVO4d0kanGLQwxDNr2cPVIhbiJ3KIVhmt6hUy
 9PDdlYgauKeRCQhBHvX8GmwsVw==
X-Google-Smtp-Source: APXvYqw+P8UAHiU0ccVQIBZUfBd2vPjSDExClsgTlLS82+7FuBko3fHEDWoL+tad1LkrihA0ihwHXg==
X-Received: by 2002:a5d:4909:: with SMTP id x9mr7946582wrq.226.1562077560118; 
 Tue, 02 Jul 2019 07:26:00 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id q10sm14845171wrf.32.2019.07.02.07.25.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 07:25:59 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-16-richard.henderson@linaro.org>
 <CAL1e-=ghMjUtEyqKX+s15RcyQp6uQO_hJ_u4RTSJ5ZyPvFnymw@mail.gmail.com>
 <b376dc86-6879-2a72-3261-7fdf06172456@linaro.org>
 <CAL1e-=hS_nQQYY39j-mx1QBFw+Xe3V5NgFW7ifrkMZRxFbB=OA@mail.gmail.com>
 <38326483-d804-02c6-42bc-9633fc4d5028@linaro.org>
 <CAL1e-=gWBkA+tWZJ9E7JNk1X_gwnhKbRfT_CtNr+o5uy+e-oDw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <97e10fdb-8271-c2e1-7094-1246064d0bb8@linaro.org>
Date: Tue, 2 Jul 2019 16:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gWBkA+tWZJ9E7JNk1X_gwnhKbRfT_CtNr+o5uy+e-oDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v6 15/16] tcg/ppc: Update vector support to
 v2.07
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 1:41 PM, Aleksandar Markovic wrote:
> If we go back to my example, it appears to me that doubleword
> integer max/min Altivec instruction do not depend on VSX in any
> way, or, at least, I did not find anything in Altivec docs that
> mentions it (I could be wrong).

You are correct, for the case of min/max -- and indeed all of the other
arithmetic added in this patch -- we do not need VSX.

However, the load/store instructions added by this patch do require VSX.

AFAIK, there is exactly one v2.07 core design, the power8.
It has both Altivec and VSX, so it's really only a technicality
to check both v2.07 + Altivec + VSX, but I do anyway.  It does
not seem worthwhile to decompose these checks further.


r~


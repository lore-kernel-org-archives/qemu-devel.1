Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7492EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C5920717
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pq92iD6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C5920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibo1A-0000QP-9S
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibo0A-0007k6-Be
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibo09-0005rK-4m
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:52:42 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibo08-0005qV-TM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:52:41 -0500
Received: by mail-pf1-x441.google.com with SMTP id y10so2735779pfm.13
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gqxsmiAV7JV1SONG7XrgAI1qIjgS9GyeEQFLfkiVFD4=;
 b=Pq92iD6jSYY+Ddpfv6Dp5gg9SJCEnRLUPS/7ajDa44KmJyecfS+x5TfeL0on5o0Lwm
 zwzTjOSIB7OZsF+OA4+WPsaL0FEvikO/O28zSNB5JAyGCiNXhIw2Zq2NhrBUZPRWacfv
 jTOAYx9vZh3m/OTCYSls3KNvpKcUiHjmE2+lalTeRUt5QH8lhbXIJhe041ROhTFU4Sfz
 2oTO4y9yWpde03wDwWg8EYE0bJeFQ+5Paya0+LcGHIsya6BCP3JbXF+qd/mv6D6ktB20
 PhBbj9uW9j7vh/yUAKzEeh+CmP6SJW4Z02muxIYGE0Z9O96JNFQsG0CGEomZwaWFALPm
 y8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gqxsmiAV7JV1SONG7XrgAI1qIjgS9GyeEQFLfkiVFD4=;
 b=Js1SB5bQqFY1cZqJ+azTxkUXSsoRrVJNPqKMgLluRnRQVnS+8dC8/WlS88orHfrG5M
 eF3fLdmvYy/Cm6yBUAccUnEBkUJ/TJLIBqrBKlc67Tsnx5stXczmScuOv6Szu0JA/vSD
 uCCxGcFEQ23L/FFrBTDVixpabL+JwtjoTFZSgnWltZGNPXYbhm6J5KpuT36javNBAfGz
 1aKcEBCtc9EO7Bc5kiRQvu8W8MCL8RnKqmY7I7Gy2Oc2oxxx5kcGGIrGZ5FSsKNAGa6m
 bRLMLBqW20ZMtxFYL2KRy3s6Y08Fwcv95njZZ3Y2kVnqr21sJ8IOycxoDi91h5N8u0+s
 2nvA==
X-Gm-Message-State: APjAAAXMlFNko7sN23UwpjzHkqTanRPFK33zaxS1iac+hvBUD8oL2GxL
 YQYwPv7BtsweVBz1lXzHjhs5dA==
X-Google-Smtp-Source: APXvYqxxWz256voFtzIHZgU8EratAp/k2RNw2W/RSW4y9Und1CdhZvQjCmdQlDoVfX8eKNj8bdDasA==
X-Received: by 2002:a63:364d:: with SMTP id d74mr32507600pga.408.1575301959004; 
 Mon, 02 Dec 2019 07:52:39 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o23sm35484257pgj.90.2019.12.02.07.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 07:52:38 -0800 (PST)
Subject: Re: [PATCH v2 4/5] target/arm: Handle AArch32 CP15 trapping via
 HSTR_EL2
To: Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-5-maz@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be437b20-20d7-ebbe-b3b2-8db45774fbbf@linaro.org>
Date: Mon, 2 Dec 2019 07:52:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191201122018.25808-5-maz@kernel.org>
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 12:20 PM, Marc Zyngier wrote:
> +    /* Check for an EL2 trap due to HSTR_EL2. We expect EL0 accesses
> +     * to sysregs non accessible at EL0 to have UNDEF-ed already.
> +     */

We're enforcing

    /*
     * Multi-line comment
     */

for qemu now; checkpatch should be reporting on that.

> +    if (!env->aarch64 && arm_current_el(env) < 2 && ri->cp == 15 &&
> +        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {

Use is_a64(env) not env->aarch64 directly.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


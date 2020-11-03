Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF5CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97BD20870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E87H5ZRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97BD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZznV-0007Ms-Qo
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzha-0007ps-NW
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:02:35 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:47020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzhY-0000DS-Rm
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:02:34 -0500
Received: by mail-pf1-x444.google.com with SMTP id y14so14730603pfp.13
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Jxkel3JJmrCgif24PtuabRaQPDHuLtWFpcFv0QUuq/A=;
 b=E87H5ZRO3+u7x72vXH+uj+vJIqqUQzBW1Vx1V12rUb/oeP2n95K9JNuHgsAIqJ5y9e
 ogKdOskxBR5jdk47Cm2OBeCyim281MyXvnjTyo72YUbpLZ0jdMlTiVwUW6w2rKAO0L+h
 5V9bggcA+0I7CL6WbaPwVDU7JZC98cyDomY/M0vp93D7fRISq40MQ7k/Gh3WFyTgxPTp
 V3rlkrRZz5cNbR8QE9Js3NwD6trWHIJMjHBuPccpbPl+aNJjDTBZFGmoO9CM6tF9yomf
 8vxXE2F/RWbobw2nsQaI7zE0pB0SedIUeso9i+Xsl8026BpWDnfNYSuz/lAi0FV9nA0i
 Mtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jxkel3JJmrCgif24PtuabRaQPDHuLtWFpcFv0QUuq/A=;
 b=LoHQU6PN+byVu4qIi91dK7MdodG9P197MNDAOkDYCtQX+01ek8KEzcVDhqNEjz9QYd
 OR+A50NZezSC6E/tVcEEmVSWELdMWCuSnYYdrywauVAHi1GP14714AuzagSbmeGGSHdx
 4DP7PNzqyyyZgM9ltC10ijalb63cFQLOoZjrNTs8dA8YD7ic7C5mjtKA4grplvI28qli
 jR9BdQ2VJg7iDUaYT94gtIAcyXlYgycSWgoL29z9HwBcNWgaVrGYBlvgqzfYLgcO12zV
 t7S51tjSH9CSxEt7KI8Py4tbeY61cRmk3gZX0I2hRi94Mnfcc+yWM7d2XHdRdwz+diLj
 tatA==
X-Gm-Message-State: AOAM5336WY2Ku4qS21F0benybifjb6G5COFGVSrFzqWdAsTa10xW0QzX
 moUlh9Hfmdw+FVOzIA6CibFxcJYv6zL9zA==
X-Google-Smtp-Source: ABdhPJwk3sBXLhMMmeBYtICuTsoXbO6kkgYYGKg13EISa4+csArKdEq4jsgAwwZs4s72/cPbSM5K8A==
X-Received: by 2002:a62:6496:0:b029:155:b152:f0cf with SMTP id
 y144-20020a6264960000b0290155b152f0cfmr26922040pfb.75.1604422949849; 
 Tue, 03 Nov 2020 09:02:29 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id e9sm6863292pgi.5.2020.11.03.09.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 09:02:28 -0800 (PST)
Subject: Re: [PATCH 05/14] target/arm: declare new AA64PFR0 bit-fields
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-5-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <10a9c623-6969-a656-d44e-350e26cfb57b@linaro.org>
Date: Tue, 3 Nov 2020 09:02:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-5-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


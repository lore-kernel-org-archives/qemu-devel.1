Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1968C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFFC20936
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHolv7mT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFFC20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCUeC-0008LJ-J4
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 17:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCUdf-0007wS-B0
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:13:23 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCUdd-0007Yl-Mr
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:13:22 -0400
Received: by mail-pl1-x642.google.com with SMTP id l9so455829plt.8
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YVOviIW5wTEzNq9upYse/kB6TeNnSA7t6xmTtQ+W+Es=;
 b=qHolv7mTkBNtyS05EXUHCo5tMDQuIDB8nB+2WxD8GU/7Ga3Q48y+4vgTYFv4ZaXnNS
 /1gB5fk4GGLJL+OmFyNVc9u1X7N7zs3ZjLjRgER01OGJDe2tn7apqCv40PsfvjktKm3Y
 7x4JNo8USxIm9544qFgA+z30bszrxBj+ticcbaWjr2KyddkZ5NBDmLa613I6Ta0rytxM
 APVNClIFcFcVzwrz6OzNFCEDrzdRCvAvhDlaYxHgHeN87Pgj5vkmE9A5CNtPl0Deyj2u
 q22A6up0tmuerxG7Xjw7x14fmguA5a4hRBm2NHj521MSM6MqkZb5oE198z1mekqetIkx
 dZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YVOviIW5wTEzNq9upYse/kB6TeNnSA7t6xmTtQ+W+Es=;
 b=H3UJ+E1358hHNucUy6BCr+vdxH2gvtpaknjW5smcxZ/pe1ULT5iFyPhiY9xBkpzxcF
 XzgYdWyXxwGHs7w1ZCYHkm9fXk/8ixOf9Zsk1bpUZPvcIbE8l+g0943fNxyPFfXO5HMd
 yZN/KeKuMkN9maylxVq7WpBRGtIki20/5cTU7tX4akJpm07ZzQoXyR4+O0ROjexqTHCi
 kYQXIS2HYpUGKx6FGQpGBW5wws05AW9xrkjp3Lkoflb7p16m+2N421RYEBp4ifRUEQ2k
 FC3XNM15Eefsi/ldzwuCeCO6h2855cMkU8m1U5PXNfimLovgIazdTSAEilQTIcMbuq5H
 SqXA==
X-Gm-Message-State: AOAM531TMx+arNfoRXpZ7D2Fyl0Wn8CU71LDKk2/Jy/qDzWHtmg2qETw
 WVteb7ccjbEAig97ky9V5rR+2g==
X-Google-Smtp-Source: ABdhPJwp7EOzRM6Os0Orv/6mP7Eq+9lmpeYsIg/bXsm0uu0/kt/SJfjnZRUB4JRNeTaQkAKAEFMZ7w==
X-Received: by 2002:a17:90a:fc98:: with SMTP id
 ci24mr8020875pjb.101.1598822000110; 
 Sun, 30 Aug 2020 14:13:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c203sm5664631pfc.156.2020.08.30.14.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 14:13:19 -0700 (PDT)
Subject: Re: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
 <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
Date: Sun, 30 Aug 2020 14:13:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.207,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 12:48 PM, Taylor Simpson wrote:
> I'll add the following comment to indicate what's going on
> 
> /*
>   * Each of the generated helpers is wrapped with #ifndef fGEN_TCG_<tag>.
>   * For example
>    *     #ifndef fGEN_TCG_A2_add
>    *     DEF_HELPER_3(A2_add, s32, env, s32, s32)
>    *     #endif
>   * We include gen_tcg.h here to provide definitions of fGEN_TCG for any instructions that
>   * are overridden.
>   *
>   * This prevents unused helpers from taking up space in the executable.
>   */

Ah, hum.  Well.

How about we figure out a way to communicate to the generator scripts which
functions have been implemented "directly", and don't need to be generated at all?

I don't see why we have to wait until the c preprocessor to remove this unused
code, and the less we have of it, the better.


r~



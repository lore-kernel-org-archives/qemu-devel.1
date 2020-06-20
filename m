Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653BEC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE0424658
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUn6+By+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE0424658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmsp-0000X9-H9
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmms8-00087W-WE
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 19:26:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmms5-00054E-Qi
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 19:26:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id x6so13139403wrm.13
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Fehqy12PdO65VmD8jglJiMOtsauotR0PNCnAFIOMS0w=;
 b=JUn6+By+D30XwDNmPI8tAC5rCNv6/XgyDBX4luJVH1HmTS8do1KdK0yi5v90pDZLrC
 eqL/H2KNyvWLaIhRzJbf7j6hgju0NfnJVgPoNB1RIs5L/dsHCzS4j2DDzBTNUslAG/HE
 5cbJwZPK16hMeje72K6rkAoIQno/xg2cO2LuWuXlopxgVGoyx/pp7fbInUwfhQwy1VKs
 Gp1jhAL2JGxgf9HHZDwD6Gi4wPjeXoBWvuXDOA8ikx+XbJ7r3nB1oQhT+qHz0ET+pKCU
 Ii92fF7r0k5s+xfeISjd7kv+kJWMxFzF4qnZD5HCSzCbCmNKg2eNstzXzbXyTQG9VJw8
 HqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fehqy12PdO65VmD8jglJiMOtsauotR0PNCnAFIOMS0w=;
 b=hi9QRUo/BrPPM6vWS161x2ij/rGXjv9jb+xy0UVq/us9ekyMy7Ue1FbNvE+Q/3PjZL
 uNy1YcY1zvh0N5uGsPWyu1VXzubCQA3kSQF6FnqIUbbb754mbLRBcDIFZ22Qpk3Xl0mV
 /nqIb3bpOupA20Ai8ycFnbBZZoz5u0oX53TXeAnCzid9XjWYZYw/2ppdTe/OEjvRikAT
 05sENt9JNa3O3jYBb6yG2GXPr+L/82oPgiNbukv2KyQNOEJTJo2VyoCT3/DTmObq59ej
 b28ZjutgxV6/816dckaaehvGGCKsmVPfOM0A/pdZd7s2QUZ2aJsR5pJdYA8A8Ay2MA/2
 iftg==
X-Gm-Message-State: AOAM531E5Vt62skNHVSp+SyndMyiPUaLQeBre88QkHYas8JSmELQM9E9
 gzKfSTR57P5OC5v/5grJmTA=
X-Google-Smtp-Source: ABdhPJwVSOVCQz5hsS8eqm0ox646S7hfYcB+z45NmElP1jjL0kJB9a0XpIY/vrBhzR65GPWOYFVe8g==
X-Received: by 2002:adf:e545:: with SMTP id z5mr10700775wrm.89.1592695560307; 
 Sat, 20 Jun 2020 16:26:00 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d24sm10843580wmb.45.2020.06.20.16.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 16:25:59 -0700 (PDT)
Subject: Re: [PATCH rc1 12/15] hw/rx: Register R5F562N7 and R5F562N8 MCUs
To: Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200617191519.14842-1-f4bug@amsat.org>
 <20200617191519.14842-13-f4bug@amsat.org>
 <424fef31-e380-14c1-1432-4a9a17c85ab7@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <65bd759e-3c8a-f003-7f24-ac7da5cec049@amsat.org>
Date: Sun, 21 Jun 2020 01:25:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <424fef31-e380-14c1-1432-4a9a17c85ab7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/20 7:31 PM, Richard Henderson wrote:
> On 6/17/20 12:15 PM, Philippe Mathieu-Daudé wrote:
>> +    /* XTAL range: 8-14 MHz */
>> +    if (s->xtal_freq_hz < 8e6 || s->xtal_freq_hz > 14e6) {
>> +        error_setg(errp, "\"xtal-frequency-hz\" property in incorrect range.");
>> +        return;
>> +    }
>> +    /* Use a 4x fixed multiplier */
>> +    s->pclk_freq_hz = 4 * s->xtal_freq_hz;
>> +    /* PCLK range: 8-50 MHz */
>> +    assert(s->pclk_freq_hz <= 50e6);
> 
> It's just startup, so it's not vital, but forcing floating-point comparisons
> just because the notation is shorter isn't ideal.

OK.

> 
> Perhaps just a local "const uint32_t MHz = 10000000;", and some multiplies.

/10 :P

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks a lot for reviewing all the patches!

Regards,

Phil.


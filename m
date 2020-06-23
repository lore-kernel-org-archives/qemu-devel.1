Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8D0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661392073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+p3+zqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661392073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndeS-0001RX-LO
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndd3-0008W1-S0; Tue, 23 Jun 2020 03:46:01 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndd2-0008IA-6k; Tue, 23 Jun 2020 03:46:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id u26so1606021wmn.1;
 Tue, 23 Jun 2020 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZvcA7g2Qkj1AOQ15Z8eg4byP0PCtRVIbTzCf5HrSQrI=;
 b=h+p3+zqTF/Z3YnFztdYCqZFnqe6qx9wzVvSwKFgT9wFpZHxHagHuJpjqafe37rw3i/
 oZYDc/jzETWUKzR47ulVyI/C//j862XpPXW72vVlkkQm0GIp5eJtXGpVMijJ6/AbvQkR
 Kr55o2Bnjh9CqZ2NKLJBqZWMqGpYlfN5+2PRYKfRLixdxO7tKa/Ru+r2YmY4pwiW6avI
 FI/aUDnBHJVUa0FIBsue3OC6fJTpDwmB3FPoiMcNICrkG8uXVRPRvq2t2UhSQCDMJF02
 hv0qKmQ7A0vfcYpYBdwpzQ3eFg022HM7PRdKOnCaY/Hj7JEflgjzrwHg7dR8Kz476Pxs
 yhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZvcA7g2Qkj1AOQ15Z8eg4byP0PCtRVIbTzCf5HrSQrI=;
 b=OYK/82U3Je11NlpUXaaipkw+9MzjXJNB/o9KKKxXHASmgeJxo+3FuEGrcYC6gTi2Ie
 1Nibm7MIPPcy5izyhUfgriyTNp51kqdvBg8qpdUw3Rb2QF0EuDNJjpcUTFpA+ejKrp6G
 2HHImU7epqqLzBE8yHXawqGu4gw9nKLNl1n8YJd8HmapklnVwQc6YIXUTOqTtXBvJh9N
 P/uo9v+vLXpgWPUR+3RlhwJoxO4jIt3d78eA5X+4zSsRPkFTAPvF967jp+7x7UA20ZCd
 8+uLNQgoaKJjQKvb+bKR4hLDi5kkUl7agnVpfHAmLDOiQcf9NOIL5/KupcUvxuoDy03B
 HUPg==
X-Gm-Message-State: AOAM532+cLQ31drqOSRU87w7LrsVU0dqyqD3pAg+9I6HlpgUpTYW97kf
 wNBq+ESJu58h7RzDWNhx54w=
X-Google-Smtp-Source: ABdhPJzHN1IxbLyr/YgjCVR3wyr6NGoSotHL0FHAdklNeZhAA4IyPJo3QSg4RIbEUR5qhVYgE3bBMg==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr11598858wmh.165.1592898357801; 
 Tue, 23 Jun 2020 00:45:57 -0700 (PDT)
Received: from [192.168.1.41] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x5sm2634104wmg.2.2020.06.23.00.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 00:45:57 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] hw/misc/led: Emit a trace event when LED intensity
 has changed
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-4-f4bug@amsat.org>
 <ae4a7411-7042-3530-3faf-e25368080820@linaro.org>
 <c9e3897b-c711-f59b-d400-0bd01fd320b5@amsat.org>
 <191eaa28-7ff4-38f6-9489-612ac984f20f@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e1cec572-5645-65fb-95d0-a3ed8a094181@amsat.org>
Date: Tue, 23 Jun 2020 09:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <191eaa28-7ff4-38f6-9489-612ac984f20f@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 6:48 PM, Richard Henderson wrote:
> On 6/21/20 3:25 PM, Philippe Mathieu-Daudé wrote:
>> Anyway I switched to a percent value. What is better to hold
>> it, an 'unsigned' or 'uint8_t' type?
> 
> Might as well use unsigned; you'll not be saving space with uint8_t.

Bah if we want to migrate the intensity, we can't use 'unsigned',
so I'll keep uint8_t / VMSTATE_UINT8.


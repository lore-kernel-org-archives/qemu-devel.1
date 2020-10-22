Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1513C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151A722267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp5LXvOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151A722267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYTk-00072j-Od
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVYRg-0005lM-Ge
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:07:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVYRe-0002FY-SI
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:07:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id j7so1779457wrt.9
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rvqmUBtW2jiyAiLy4+WPWMTW0+TLkG73waxEA/eNBhM=;
 b=Gp5LXvOfDh2N/PUPwKqv6V2N8eZ8G3CqmdwFXFuklmmErsKg0BZ/n5p92XezYukhts
 Y1aEy3Qb9AhHsMMbScUu4HVZNU/53jzZ2vOqrc8PvtrJEe0Ol+SOmxn6/l0gu780YXBN
 UUI03o0TjykMiWgolFT2NGWrbfGE3ByLYKz1qo/VApPK8up1fe1nTJdv+bnCw43yywIO
 8zzYZOlQTK5Ep5LdjuZZG4ObCBkkoAHKdvtrhuWQ0EHUlOErTd4CNu2CKFeVKu0KXxVu
 FLbPa7tW7Dya0yf+CauQ2KVSz2klcPAjrLBo7IchoyE1zfaMBdJ0jgSrMh1Wv8HWhiXW
 Y6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rvqmUBtW2jiyAiLy4+WPWMTW0+TLkG73waxEA/eNBhM=;
 b=Xh0+awpfTlN8Sv7sSmlxLe0tkROv6B4b/GT7Wd1DygIuFjclLQcLdzKGP12wd6qgvt
 XT9GsutPdY5X3zv9S2ICq+cj7C9mRx9pay4Ey9iug6f9NHGAKOfpPxlDUJ/qquaU9DZI
 CWiuuWaKZ8gH6PH5fM4zc4cV4Wv7zVwkAF8O+YCXGoWandGDywE0nuRr/qe1l3UdqUfa
 +E1+GzLitoW1grKMxhH2TlE9lZVygftv0ueuXzVfnIcVLp30tlPFsDgnKkmOjZDIrgRf
 TmEvfxiNyBBBZXazdpBIP833kLDWUcDurEcmu0+xDlWdt6RUB/dol/72Y2iWM+bdl5IG
 KeqQ==
X-Gm-Message-State: AOAM531/7DzjPPPjdi31g6TWt5kzjY0NXyRAf1dwNZyRA4zDPh0f7Tb1
 ZEnKF1m3oI9Aj8pS6gh5230=
X-Google-Smtp-Source: ABdhPJwkK4KzRztNWxh9tLiRHPuyimqCzJU0vzGkwgkn/a6kPm/PWkSSMTwvDBWiWsVNSwmrZezU+Q==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr2028546wrw.47.1603364864854; 
 Thu, 22 Oct 2020 04:07:44 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id t12sm3154566wrm.25.2020.10.22.04.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 04:07:44 -0700 (PDT)
Subject: Re: [PATCH v1 6/6] tests/acceptance: pick a random gdb port for
 reverse debugging
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20201021163136.27324-1-alex.bennee@linaro.org>
 <20201021163136.27324-7-alex.bennee@linaro.org>
 <546fc49b-bde8-99f5-8489-295764afe44f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8682564e-6ea1-d8eb-dc12-bf0a926c156b@amsat.org>
Date: Thu, 22 Oct 2020 13:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <546fc49b-bde8-99f5-8489-295764afe44f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/20 7:20 AM, Thomas Huth wrote:
> On 21/10/2020 18.31, Alex Bennée wrote:
>> Currently the test randomly fails if you are using a shared machine
>> due to contention on the well known port 1234. We can ameliorate this
>> a bit by picking a random non-ephemeral port although it doesn't
>> totally avoid the problem. While we could use a totally unique socket
>> address for debugging it's impossible to probe for gdb support of the
>> feature which makes this a sub-optimal but less fiddly option.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   tests/acceptance/reverse_debugging.py | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Certainly better than before!

I'd prefer another chardev that tcp, but as you said this is
already an improvement, so:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 



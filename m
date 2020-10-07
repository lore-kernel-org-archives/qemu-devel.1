Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A6BC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB4720797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzZPlBWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB4720797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQB6V-0002QV-5y
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQB5T-0001xE-4p
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:10:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQB5R-0001J8-LP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:10:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id m6so2631945wrn.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q97gs/6bBVy1GK5WTI7ZnjHK9l2a7Jjd1L7fk1Du1r4=;
 b=DzZPlBWbKEDo1pNt+tSvAump8SU69xLc+QoZdEpiVUfU/hj6Y7g3QLMbdPlEyheVSJ
 +i6OVA0sz9puaxwmaTcSXlNVFoGTSOnLGsyiyul+f6t7sSjmcGffMmVsleZUCzQy1kxj
 ruV/jXsRWccgRTi3YDgspbemAsMPm9Dfo2TkMPAJBabiI1hcS5oKsnvikhR3x4JicDhQ
 dYtpV+MTynobV8Lvob6yxCwD0YhyZa7hHT4ne94NCmRg5qdVeHBU8YkUxkcskVoSix+z
 nKemvU51w3uzWEiTzli58Kqyqob0pIVHGnUmud8bBgLe28TBhINFzQ/Uxf6cfYM3fHwU
 YKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q97gs/6bBVy1GK5WTI7ZnjHK9l2a7Jjd1L7fk1Du1r4=;
 b=s8IM+4p7UdEni5LwQkxb6aZpgdfKFMW7mJtTKGlehCel4TpTaRLc9OLUVAA/pF7ikC
 ui1gN2iVwZ5xVVFRwyo7et6tkAsXT6Ii09U2uGd25VbJZxPy3FisD20k6vxzUo4LM06S
 DprQObocLUmB7a+upZ5/YsPejXybz8eFQzE79tLnkWUjAuLZXiS2W9p+s0hy1ZjkfQBP
 yXqVJT2oB+HnzGREHtBFfbTq/M/qNW36SwviiWiy4Wkd6JhwKE3tbIufbBTQYLlKrQ4c
 ciBTqIBNyQi0eOjr96JmNHae5+tRAtV6MsX80peD7U4qb6SKVIw1A01DycPXvgq0kkQr
 1bJA==
X-Gm-Message-State: AOAM533Br9ti+qRzr7ERlXn2zfIplz5988npHqLfjFLT+eB/nf5x+yGp
 ygPjwtqVlZNxxBuXo/5pu9o=
X-Google-Smtp-Source: ABdhPJyWXOiYAi1KEExPtVNOnKl1ZumJpRFbCCHVYqXuRhPp5M2ukmNTZnCjIzXFeLCoUVsPglC7hw==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr4336388wrq.313.1602083435099; 
 Wed, 07 Oct 2020 08:10:35 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x10sm3124907wmi.37.2020.10.07.08.10.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 08:10:34 -0700 (PDT)
Subject: Re: [PATCH] cirrus: use V=1 when running tests on FreeBSD and macOS
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201007140103.711142-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3f5a5f58-5a34-bbba-c5ac-5bf4f6152f4f@amsat.org>
Date: Wed, 7 Oct 2020 17:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007140103.711142-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 4:01 PM, Paolo Bonzini wrote:
> Using "V=1" makes it easier to identify hanging tests, especially
> since they are run with -j1.  It is already used on Windows builds,
> do the same for FreeBSD and macOS.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .cirrus.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


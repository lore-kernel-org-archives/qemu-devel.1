Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180A1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81D820637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXOWwZ3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81D820637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifCmR-0002Rc-0B
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 19:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifCle-0001nT-M1
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifCld-000704-Da
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:55:46 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38523)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifCld-0006wp-5w
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:55:45 -0500
Received: by mail-pj1-x1041.google.com with SMTP id l4so279148pjt.5
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Len6tZyHmfGHMmylbxusBCppMCH5HZKLBxqirR/6e3E=;
 b=dXOWwZ3NAX2LER55++YdXd9rP2vtCX1CVWfwE8io5eXwoTISDTUvLy4q6pSDMJuVWG
 qL1vgriRNW3quwyzwzvJm3BKh7kKJIuvep55umWyEIQ4BVRI4kneVEgnV5jlCM4MFFAz
 6h9sCMTwninjJTW13csusQ+DT4Ge5e3v0ZVlU68EbxMMLcbSGvabq3mrphuVAMsSlCTE
 rvcC2WrKAWqVvv3mhJB/iqAnNms6H3RK+mhUZ+R66+in241UWDJy3w1iNnX6rYPi5RaM
 iN0RcwASkmTdOuVtMWvU+6MBBuS1yBwo3saSyYUALdQvA28mP1nzA/sxNxbwI3GWCYB/
 cWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Len6tZyHmfGHMmylbxusBCppMCH5HZKLBxqirR/6e3E=;
 b=HIQoVRlIJQVVMVSoUmvPx1emAOz3De6TebvAM2wioyep4ni4QS71Xy7V8ARC22jaBv
 04kSmYmKYzIYcyvNpgXqhCpcmPZ4GNh+zZyeRfZkhM8NJoFtIqE4EptlAz89/4oaoyA2
 pRtIVs6hn78a0L4QF9H63UIzv+RP3b7eXUwEZWiTIYduRtL+P9ZsBXx0CrkQzIDNKOlU
 EcfuZOVJvGCfVsvt+n93vy/8rwakEWz1yLK6MmocUaL9TaVbJe4JFK9bfnQqcDXDB5l8
 FUw8WAFQXizeY1S4CKSHLdKWeSzBLwLwPxtNU/0yLzKf8S36E+fArMWG97oU6vACkeWm
 dBCg==
X-Gm-Message-State: APjAAAVvH+XZWEnqSAYXclcAA1U/UTa4nBmEaN/BSNh6FmsHaxcOSZ9L
 wHlLpLLn6g9O1qpcdqBUTeO3nw==
X-Google-Smtp-Source: APXvYqxTTmiP9OBN5IFQ8R7jLG6RFZoXwKi8AzROi7uxTHB4vByT1Mm2kZKPwN7s2D6TTxye7QUENQ==
X-Received: by 2002:a17:90b:3cc:: with SMTP id
 go12mr6785115pjb.89.1576112140970; 
 Wed, 11 Dec 2019 16:55:40 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm4429843pfn.42.2019.12.11.16.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 16:55:40 -0800 (PST)
Subject: Re: [PATCH] migration: fix stringop-truncation warning
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576074210-52834-3-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce08ed58-78f0-83c8-404c-4caa76d38569@linaro.org>
Date: Wed, 11 Dec 2019 16:55:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576074210-52834-3-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 6:23 AM, Paolo Bonzini wrote:
> @@ -44,8 +44,7 @@ void global_state_store_running(void)
>  {
>      const char *state = RunState_str(RUN_STATE_RUNNING);
>      assert(strlen(state) < sizeof(global_state.runstate));
> -    strncpy((char *)global_state.runstate,
> -           state, sizeof(global_state.runstate));
> +    memcpy(global_state.runstate, state, strlen(state) + 1);

We should assign the strlen result to a local variable rather than compute it
twice.


r~



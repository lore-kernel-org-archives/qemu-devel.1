Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CA2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA2320774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K73EHBlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA2320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5udo-0003Sv-RV
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ud4-0002cS-Bq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:33:34 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ud2-0002rM-CY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:33:34 -0400
Received: by mail-pl1-x642.google.com with SMTP id p1so1427719pls.4
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=voG1CSlE9ZqJSfu6A2vHQLCeiVaeQCiT6oCqz2AvI/4=;
 b=K73EHBlUiCmyzvbWzsu9yG+zTXGYgouumovclvXRZJEJRwpQSqQbCIl0qDJ4Z1Yttn
 hUkPco5VRB1eTmVSibXTJS+VBcq1EGTlyQQmg4N5WAIKVzFPkq0mURvTt9RxCmNjp5g2
 fX4xp42aDQbwG1P18RqMi8RhnAIwFwExV+CQe/x2MxEV6slMdXL/lIDPvaZK1IKcV0AN
 ANHFr1id/O0qOyvVzAEDXDk05hNr99Ld/hSh5qi0dZ1WKzL1mWiz54hwt8BqHtTCpXG0
 rsM6KIgSTur83+fbaoLHpeValW2BmECzhjMusdzld68OExG/hFYwnx9fHxKXzlDhdzIO
 5uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=voG1CSlE9ZqJSfu6A2vHQLCeiVaeQCiT6oCqz2AvI/4=;
 b=rYcyH3zLddcCkiMPJswipq3tDyMttqoJWz/T8ewnoPki25wAJ3Vc4Jw3w7WvORfHxA
 nD39G8W3vx2vrd2oqKGbXTGUapj+ujmNjZ2T2Iqe83XaSC23yrbxuUQxCToUKRRgMy1d
 f49A8z1vWv/cgJ5SNYHsz5erRDXrjLTkEGQ0eXSYm82JPwRotj1xEE4FTo2lglJaw9E6
 N7GrqjJjCwg/T2lLwqZk4tZFv/CLrWblsb5h3HldNVMlswIjgKYf8Cb40BIqXio3V4fj
 XxbBjz8GTy26PXfb0mQ69hPtIhTe+J2pmP12GtdeKYof4Dl5QFangs8vOjXIZFdEVXt8
 a4/A==
X-Gm-Message-State: AOAM533il/CgA6xn/cjySXlwiKfMPLyTlvS6u694Mgfacvh9oB1HNZSV
 QkWUOWQrQFSe1teHBBa7XqOqIw==
X-Google-Smtp-Source: ABdhPJwMohUFzUC8gloSCXZgjlaMLKKgjCkaCa3YTdybdvwr+aCx3bpzD//N04HteKS79324GDgp2Q==
X-Received: by 2002:a17:90a:20af:: with SMTP id
 f44mr991894pjg.169.1597253610970; 
 Wed, 12 Aug 2020 10:33:30 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u40sm2904271pjb.39.2020.08.12.10.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:33:30 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 2/3] hw/misc/unimp: Display the value with width
 of the access size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200807143705.30066-1-f4bug@amsat.org>
 <20200807143705.30066-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c817266-4cf8-c5f4-a5f0-08c0951bf194@linaro.org>
Date: Wed, 12 Aug 2020 10:33:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807143705.30066-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 7:37 AM, Philippe Mathieu-Daudé wrote:
> To quickly notice the access size, display the value with the
> width of the access (i.e. 16-bit access is displayed 0x0000,
> while 8-bit access 0x00).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/misc/unimp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


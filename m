Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DFCC433F1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CDB206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXdwxCMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CDB206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2Po-0001w8-4I
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz2NF-0008PU-I0
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:24:49 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz2ND-0000zM-VS
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:24:49 -0400
Received: by mail-pj1-x1041.google.com with SMTP id f16so5792316pjt.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=exLsDMmU2xmMz7/P/5ESHMQa8jWXGYJwO3BUjfimIOw=;
 b=eXdwxCMCT/a1yKNITrtV++uneW05l6dOfyt5hFA+DRrFTRAeCHYWqdK6IzkcRyZ1Aw
 UDk8QpSMziKPkMKIkPF1JXh/pel42jBB5hb/nBUO69CHdyUdTfXKtII798GcG6b46lTQ
 f1EVw2gozcJGMpFG3ud3CRobKTX46LQWtkItz2gEoc98ykcLoaionQwmG3EbhRDfvcC0
 B3RU2venhHfVfCRFp6mvXZncBCDgSBOUPnI6l2jADQghQhXazRJ8FjaWSuExeG+pAT8Y
 4YvbfrIGutuxRqclxzOf7Bu2N4z3d+3Xevz+YF/BIOvIh3KuoaAfcAQxW4zU8IE0Mp1w
 80rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=exLsDMmU2xmMz7/P/5ESHMQa8jWXGYJwO3BUjfimIOw=;
 b=jDu1f2AfAKftSz0DWV6rsUPy50ZVoB9cSY9HFWBTEz9CRv4h1JltPDP3ueytNLvt8O
 IX5Wrc7LkldmCEH8V5tSkW1GvQtlAmgD+NjAwIn4GxNpu28YXbW3i08dfcBwbgm9CA93
 0jGjji5NCpbBEFaAexuB62fyzEgBI23eL5NsVRDoEgnAUa+V2ooYP6xqxnmR1yuxuC4B
 NHx5roscn/nRp0Bo/9FvJxSDoW2Bg5OkYqU9J3esofIkIx6tjJZisapnjeOlun0J95x2
 SaIBVnnyWB1bIhyj9k/6r1rKGBw9oSrbS6MsQphNw8JFAhgNhYx0hySXJWLE3985ZsBK
 K/KA==
X-Gm-Message-State: AOAM53310Y7b1QlPQ55HIkIP3stLdzn99wNftSW6zy9Sl8FecpnwpIYu
 CAtOYxk6Gaw9mD+B7m9pB+KWWQ==
X-Google-Smtp-Source: ABdhPJxoW5lFy/f+I9ImAYjG2l/lIiYAppKcQPlGzPerPcD0jf9MPjevkMaQYfVeLDdEXBg/9Rqd7Q==
X-Received: by 2002:a17:90b:3555:: with SMTP id
 lt21mr7075309pjb.234.1595615086562; 
 Fri, 24 Jul 2020 11:24:46 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 g5sm7190650pfh.168.2020.07.24.11.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 11:24:45 -0700 (PDT)
Subject: Re: [PATCH v3 13/16] linux-user,ppc: fix clock_nanosleep() for
 linux-user-ppc
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200724064509.331-1-alex.bennee@linaro.org>
 <20200724064509.331-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5fc08ee0-0543-6e0a-05d1-5f4ef93a4b6e@linaro.org>
Date: Fri, 24 Jul 2020 11:24:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724064509.331-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, f4bug@amsat.org,
 Laurent Vivier <laurent@vivier.eu>, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 11:45 PM, Alex Bennée wrote:
> From: Laurent Vivier <laurent@vivier.eu>
> 
> Our safe_clock_nanosleep() returns -1 and updates errno.
> 
> We don't need to update the CRF bit in syscall.c because it will
> be updated in ppc/cpu_loop.c as the return value is negative.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200722174612.2917566-3-laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



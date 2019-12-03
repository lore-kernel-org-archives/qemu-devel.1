Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AE1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942CE2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKQXvk2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942CE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icGXX-0003wo-Lw
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 17:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icGF8-0002Si-OL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icGF0-0000C9-19
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:01:55 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icGEz-00088v-NC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:01:53 -0500
Received: by mail-pl1-x644.google.com with SMTP id az9so2218153plb.11
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZkorNiSV8mY4s8BteLlFOWaxGAii7jGXcLfYVp/MbOY=;
 b=wKQXvk2XpG1PvlaoGbJBNhaa5KHDJl4IVDdVfDCBUhL/fWlUT45ST86FCm24hSqOPq
 UY7BPywo2r0k4FJPkM5xYWCnzE8fkw0fV7oHjBtWqx6nSfwXFQxV5TiDJmmUATNIjtXy
 hs7OimCsXgOU3LcQa44nJErpHARapo6266m3Vd0eFpTL1eduJ61baBMyFCF9GZW1ABbG
 JcCShrnuKaRhB1qc3jmLhtZ2dIlcNMJ3kuTa+he///tVh/qQI9K7rjgVISIOww9eCoiD
 BWVj9u2wmbh9bplktE54kt95XBfM6ohDIx3NNeb1h7mwVUhvl99KqnDYhbUakIMwUyfr
 Kz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZkorNiSV8mY4s8BteLlFOWaxGAii7jGXcLfYVp/MbOY=;
 b=DCQVB/s/z4J3ZJOUqkTz8DuGTuJ1jJUaRSq1naljUbcV2ThLXdKH4yVufX3du6bS88
 9n8bKG2ZLkL03/jbKl0SkJoJ6F+fywv/y+voFcAUSutsNehkyDnhRF9dc5VzWouL9WCM
 LCaVyylpqhgqXf8ogjaF84s/Vtzg9cetpRU+R8Sra7ACAsIAQcXWRsUsS5GaE3JGVyEO
 x0ewYTLRVKSWWADjuj1muGbTbL2zanFum7VaHOVeSTtKOiToYoU2DTqnS7kdlRPHQ2rf
 OYI0LoepH7lKuHJlmYst2qrQR6Mhto2AdP4h7Uxm1aOuLLG2BbicdcZwxNb4Vf6VdmZB
 UE+A==
X-Gm-Message-State: APjAAAVxij1C6t6/G6GVbhydVAh6ZzYdQrD1xa8BPRFk9hNlLgxxSqtp
 ynhPODTgj2cpOXObxAyvP3BCjQ==
X-Google-Smtp-Source: APXvYqyu/xT+b8ONXC3Ye2G3GVVGEvowATKKE8qq37x/CltSJ2X1cOkW+TkX8IDTusGf7bUFkHQ7Ag==
X-Received: by 2002:a17:90a:8a8d:: with SMTP id
 x13mr7862942pjn.97.1575410506481; 
 Tue, 03 Dec 2019 14:01:46 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k101sm3935284pjb.5.2019.12.03.14.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 14:01:44 -0800 (PST)
Subject: Re: [PATCH v4 06/40] target/arm: Split out vae1_tlbmask,
 vmalle1_tlbmask
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-7-richard.henderson@linaro.org>
 <82c07397-e462-9408-67eb-09ba089b5f39@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3b461e75-66b4-58f7-6d96-eaa6417bc0a0@linaro.org>
Date: Tue, 3 Dec 2019 14:01:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <82c07397-e462-9408-67eb-09ba089b5f39@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 10:25 PM, Philippe Mathieu-Daudé wrote:
> On 12/3/19 3:29 AM, Richard Henderson wrote:
>> No functional change, but unify code sequences.
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Easier to review in 2 patches: vae1_tlbmask first, then vmalle1_tlbmask.

Ok, done.


r~


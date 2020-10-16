Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AC8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C9A20897
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hik6f+y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C9A20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTAv-0008AA-K2
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTT9c-0007W8-Ml
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:04:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTT9b-0006OI-9o
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:04:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id d81so3126985wmc.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CRsoSZkh7JrJ/4kxw24xexTlcbMjEnURmtxXwgHGsew=;
 b=hik6f+y1kl4nLiN20uiHUBFUoeKaxtOot+GdcxoGFC2d9gXDPqdulWheHljFCZ0yQM
 bcIRHj/4qUBZSdNS7JUrLVPRmEwCVJNF6gxhBlITu98JVnFYEoidQi+VWzB0yaUFgWwL
 5N5dblSbNhZZtHndZzBsUbS0tEsQlgFC7UzFBxPJRV7inYnShiH9Yt9nzf4w5WXMimqn
 sQxKUh/hWafUglJgJw7Vy/QmY8oGLQ84kD33m7JV3AuFQImzJxT7/1UdlOgt1U7S++kc
 ASrcXRII8p2yOC591htwPSS5sJ+e4wIhEVM2FO34+nw2TkG7xO7xkBL17owDLuexveMM
 nSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CRsoSZkh7JrJ/4kxw24xexTlcbMjEnURmtxXwgHGsew=;
 b=O5g9qIO60tMTxGXwsOgFOuVWnPDTbVf3yPLKfb4hj/HZzFt2iCPry2s763ofoMYQMJ
 /AdhtyBeCJph6wLMzCriNuwzV2JRJ5wlEjzTtPx+rm0rWi2YxMnSyDxHDtudrUM4KU9q
 svfWWWiUGmZ3IzAXxqIsQwyuSuUhEIJ3zbchsVpIR3M0eo0qin8Ak4u+HL9xBG8/6NqC
 dUkYlZJiyxuQsiGMBNDIzD7i5/86F5rnrsSNVld4znO2aaoJoV/1n7jbOimB1mCj7MYN
 HF6sHF7reo8dZ0EFsqnUgYI1IxNqNHFKFQeP6LvtZvUUcJ+szG9DVZOFODNBkttQWBqs
 6hwA==
X-Gm-Message-State: AOAM5312dHpOGs2qB6v9OAhDKAwFiViC5/sTY1LrE8uZYpAaPLQ8+l0u
 tpgOO7IKmdx+FSzcpbQn6AA=
X-Google-Smtp-Source: ABdhPJxGkyU4COxPbnRYl3Q9lu5DvAXtm9Q5U+mm8T76I5CZGVZLVCtfhgE3Lv/YTE5Yzv7cd3te8A==
X-Received: by 2002:a1c:7dc5:: with SMTP id y188mr4598429wmc.37.1602867869297; 
 Fri, 16 Oct 2020 10:04:29 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d3sm4476672wrb.66.2020.10.16.10.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 10:04:28 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] softfloat: Tidy a * b + inf return
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200925152047.709901-1-richard.henderson@linaro.org>
 <20200925152047.709901-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9c2cc62-2c55-af87-f63c-361d81c5f872@amsat.org>
Date: Fri, 16 Oct 2020 19:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200925152047.709901-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
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
Cc: david@redhat.com, alex.bennee@linaro.org, bharata@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 5:20 PM, Richard Henderson wrote:
> No reason to set values in 'a', when we already
> have float_class_inf in 'c', and can flip that sign.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>



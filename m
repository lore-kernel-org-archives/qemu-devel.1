Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3064C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF902067C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzV1iFuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF902067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYOk1-0007Wx-JE
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYOjJ-00077h-AK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:21:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYOjH-0000ud-V4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:21:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id v5so1922270wmh.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iBTsGSCaAocV5TKHy2UKI8xGQGjbmASLMEhFp7aPZIk=;
 b=lzV1iFuEnQ1hznShSWPtVGAtxSvjqU7F/KasdyfRdYltlqH5bx2dSNyJwafGN6HtmR
 G6/nO3luYd9WF7msR9KwFcaqOKaVWITHeE99gaYDG0we8i9A07wmzWxhAACotEnLluRV
 4SFbYgBQVDbp7BTr74gfpDNUWcYIf8NpljJZvmktn1/7E/sTN8uF8FHgDr1GKdJduyww
 8ABXIdvd0UxTZBGA33vwKgCG3/ElMLq2i6b52BBwjQ3EGh6lp2BM1GLrh8R6976Ow4WH
 ywq0yHd51hEGZEBvyYbWN8e5Clx60k1qTy+73xATQlVVOLN39IjguWQ9CarD7wQStLW/
 dSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iBTsGSCaAocV5TKHy2UKI8xGQGjbmASLMEhFp7aPZIk=;
 b=IFFiXsw5FJ+NNkXePu3qtBFl6rT8UHs+ENOSRPh6Xld7R7AiWMtRE3eJwGRa3G1GBQ
 yzfmGpnN1KTjwyQXLlYKEMk1zobpftty4as8qW3P6E5rlGA02sDXs2RWMOjhIfYadIo+
 VNWdUpiJpb1IEEdFyW1gXLChtAdEHF3a/rdV7Jfikf+8gc4gS8dJdXQxQz8kt1O94tx+
 Mblj6x7UKgk6qrSDtTX0mNWkjZOqXmQlNLeZbndcq49vRlEdNMpy/vccuwEEr2l1wC4G
 kccrm4DAV2Vc93GkIy7D05aytaTF5EtRwTmlG7fYH6+kcYKMEq+wgjJ97Nls+n54RvrW
 q8gw==
X-Gm-Message-State: AOAM532b7AofVx1iD+KftnP6Kr64AcdjIx6h1ZQe+IOJCSQT6h8VL2QH
 2YVD3OWvejSWDz6xdMaRJ6I=
X-Google-Smtp-Source: ABdhPJzoORN8aMnBFWmP37H2CWqMwASlRD52C4xLH4Nc4lhG2R4+g0yhaR+cFz+XZEBqzlnnQLfTgQ==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr667351wmi.122.1604042502473; 
 Fri, 30 Oct 2020 00:21:42 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 1sm10456398wre.61.2020.10.30.00.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 00:21:41 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] hw/rx/rx-gdbsim: Fix memory leak
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201028192219.833329-1-f4bug@amsat.org>
 <cf44f3b3-c604-0b02-f37a-271f238956fa@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ec2f194-8b05-e0c4-1f78-ff6c9ce0520f@amsat.org>
Date: Fri, 30 Oct 2020 08:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <cf44f3b3-c604-0b02-f37a-271f238956fa@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.261,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 8:57 PM, Richard Henderson wrote:
> On 10/28/20 12:22 PM, Philippe Mathieu-Daudé wrote:
>> +            g_autofree void *dtb;
>>  
>>              dtb = load_device_tree(dtb_filename, &dtb_size);
> 
> With g_autofree, we must initialize the variable on declaration.  Often this is
> with NULL, but in this case, just merge these two lines.

OK.

> 
> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


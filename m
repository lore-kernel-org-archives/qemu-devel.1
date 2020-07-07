Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1BC206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPkjjrph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1BC206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnil-000196-SQ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsniA-0000Lf-Bm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:32:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsni9-00031o-0t
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:32:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so45133176wrs.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 06:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WA6LfBidRYluue6sATZUfu3w/RV16WPdDJ59OFGpbC4=;
 b=qPkjjrphC9wuD8drctAJGQfmWIqCySmsAAm0wXO4AMmAyERvHDMry8oy7PNjQ637Cg
 TUu0+5VwvZy9uLWnH8NJdFkCfSID07Mxq0h+XbfSOPkHP/6C7jtBNbIKJV+VY2wp2TWI
 lewbSMxu1WRCcYyrVZcfLcC09F+zhOUe6xst1s1FPpIrHsKR44s/d1ayY+WQRxxTZurq
 wW93SKx2tZ8y5WCG/437PmXVCp1VBDdHq8qLTdRW6nvrgBV7lbw5nA5PI441K8Hmve5W
 /wc4sSxoK1ohgcE16YBsH0rkXB0Bucb0bqljDwBVzn4CM5WInDzofE9lh2RDfNYlqqxr
 kzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WA6LfBidRYluue6sATZUfu3w/RV16WPdDJ59OFGpbC4=;
 b=sa9PCvW4fn6rPe7o0lR/83OmARt7XFedBEQFX4F5VicBZJtS2809VI5xruasIj01I3
 lKF8qCuPz9g29DXFbNhThiVSP+3BSWWrt38ZChtgioURqhcWsV2ecio4QJ5N+uIWzlfX
 Y7GyFKXaCCSmXWwmG0GOYSd49mSPw4SQLNQl6K0C7JrhruJjgiDelGXaelNR8/fpaYcp
 7PRBMpxYAHg/l1kf7U7bI8UVxT0vCVQWcxC0S0jrgtbdbosW1cXxDFNwau9SJcZbioM7
 0y+9JW9DeBOqhf6YYO8Vk4gLNHly5nNOYLLe9n8AKaQ5kcirTrXnoBKh4gM3C9Vbg6qt
 R9dw==
X-Gm-Message-State: AOAM53161H6O8pE14kw0FFIoDbwr96ZGbaeO455tiG6uEFPJaDa7Isvd
 DmRwO8wL6VS7umbhT33AESw=
X-Google-Smtp-Source: ABdhPJxSJgq13rcSW8G1Ng17us6HCnhMCGCOcALflqb9HD2spFHdfktaiW0Lqywo9MQljPqz8qzmkg==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr53120511wrr.259.1594128754704; 
 Tue, 07 Jul 2020 06:32:34 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y77sm1260743wmd.36.2020.07.07.06.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 06:32:33 -0700 (PDT)
Subject: Re: [PATCH] tests/qtest/libqtest: Do not overwrite child coredump
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
References: <20200707031920.17428-1-f4bug@amsat.org>
 <9a16d2d9-405c-2110-debe-c92b8dbece33@redhat.com>
 <2e62e2a9-6fd0-fe6a-6122-2e10aab265e1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <12844fd3-19f9-11e9-0572-09d17dff68e5@amsat.org>
Date: Tue, 7 Jul 2020 15:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2e62e2a9-6fd0-fe6a-6122-2e10aab265e1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 11:29 AM, Paolo Bonzini wrote:
> On 07/07/20 11:03, Thomas Huth wrote:
>>> +++ b/tests/qtest/libqtest.c
>>> @@ -173,7 +173,12 @@ static void kill_qemu(QTestState *s)
>>>          fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
>>>                  "from signal %d (%s)%s\n",
>>>                  __FILE__, __LINE__, sig, signame, dump);
>>> -        abort();
>>> +        if (WCOREDUMP(wstatus)) {
>>> +            /* Preserve child coredump */
>>> +            exit(1);
>>> +        } else {
>>> +            abort();
>>> +        }
>>>      }
>>>  }
>> Would it maybe rather make sense to always use exit(1) unconditionally here?
> 
> But why is it a problem to overwrite the child core dump?  Aren't both
> stashed away if you use the core.PID name as is common?

I'm not sure what you mean. Without this patch, the coredump I get
is qtest parent, coredumpctl list the child but the coredump is
unavailable. With this patch I don't get the uninteresting (for my
uses) qtest parent but the child coredump. I'm using Fedora 30,
I don't remember changing the coredumpctl default config. Travis-CI
is based on Ubuntu.

> 
> Paolo
> 
> 


Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4815C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 17:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8EF2078D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 17:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c68RE57L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8EF2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9XmW-0003rX-VH
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 13:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Xlp-0002xo-5a; Sat, 22 Aug 2020 13:57:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Xll-0005vm-FK; Sat, 22 Aug 2020 13:57:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id c19so3308441wmd.1;
 Sat, 22 Aug 2020 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4lq9MiktgJLSW3xe5r7N/GJL5nKudgRFWs3ZWW5EXa4=;
 b=c68RE57L1XsvCNVtdKljCxqHAfM6s7WfV6C3BGqngOhES1GRS7Hg/v9sNx5qCejnol
 HXEsX/n4iENGUfYGvcn1zYVijnK1dp53hbyLIo3Y1e2OAjjXswoF6VcZtMM93jG7E3zY
 DTKsyoQTmdVUdnPqdf7B6gwCCEOq0LO/XCON494dEI5XgXLSSBIEyYzYos4VfvvwDmMk
 2AkmPTL7IMO9RvtkC9afTdysKHSVfaD+vv0O+M9rRggIQ48vTeXrk1bA0jxTlLHlJda+
 /EO8pqW6rhWBHxxt0w8EDiomjYDcBwLP4GhNIYRZREZqdlmE19OQGRjJckQ9wQw7Dyf+
 asxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4lq9MiktgJLSW3xe5r7N/GJL5nKudgRFWs3ZWW5EXa4=;
 b=huyokMtDp9qyDRnuXe7bjMOkfzYZcT9M4ynFs21wWF9Jl4NiqLc0tSNl2/bD0v4CZW
 4gElBvnLFY4V+U+8h1v5OT3dSItaFE/5eHehIt9+I4NCT7VLG2u1viDLb4FVZ+GeRHjQ
 rScg62U11gZxOwRKx3m1oXPg0ixgtA/1QEA9BI03/V+u2HRJLYGXdb3XK1LCJbRUq7tu
 oEKJ+RP9NhGjPQrykQrHu0XOFoyueCJw2PSoXt0+cWGKRsaLTeon0AeUWQEHTyg1lYI4
 g92hdy/kZNqRa1Dbco/6PcolK8aSxtzZqUtNBKYqyGDsWlSsLKjm4n3kwCyK9MWavTxQ
 5GCw==
X-Gm-Message-State: AOAM532DLB+JDBvbK+bIgpbyQRo87HbnZ4wDy6ComIcwg3MsbiKg28Eb
 n6GYIEvu4Aj4mfRAfLLgWj51YbLScR4=
X-Google-Smtp-Source: ABdhPJzXZ0shoJouSLpIIZaDGXuCbff2t1tps908NJpjpgW1Z0efAErHnQDasKMhoQeUCl+fM/b3NA==
X-Received: by 2002:a05:600c:4112:: with SMTP id
 j18mr8800458wmi.187.1598119050596; 
 Sat, 22 Aug 2020 10:57:30 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 33sm12823150wri.16.2020.08.22.10.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 10:57:29 -0700 (PDT)
Subject: Re: [PATCH] util/hexdump: Convert to take a void pointer argument
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200822150457.1322519-1-f4bug@amsat.org>
 <CAFEAcA_VexUZ70aL+6ecf2MNoFCVtRfPOUJf2Z8DQJqPDJbAKA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <921af58a-5715-ce09-fd7d-8326550610d5@amsat.org>
Date: Sat, 22 Aug 2020 19:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_VexUZ70aL+6ecf2MNoFCVtRfPOUJf2Z8DQJqPDJbAKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Qemu-block <qemu-block@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <chen.zhang@intel.com>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/22/20 6:18 PM, Peter Maydell wrote:
> On Sat, 22 Aug 2020 at 16:05, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Most uses of qemu_hexdump() do not take an array of char
>> as input, forcing use of cast. Since we can use this
>> helper to dump any kind of buffer, use a pointer to void
>> argument instead.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> -void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
>> +void qemu_hexdump(const void *ptr, FILE *fp, const char *prefix, size_t size);
> 
> Changing the type seems reasonable, but it is still a pointer
> to a buffer, so I think keeping the name 'buf' is more descriptive.

I'll use 'bufptr' so I don't have to modify the function body.

> 
> As an aside, is it just me that finds the order of arguments
> here a bit odd? The pointer to the buffer and the length of
> the buffer are closely related arguments that are widely
> separated in the argument list order, and the FILE* that
> you might expect to come first doesn't. "fp, prefix, buf, size"
> would seem more logical. Not sure it's worth the effort of
> changing, though...

Can do that. I expect this function to eventually disappear,
as there are many efforts to not directly write to stdout/stderr
(this function support generic FILE, but all callers use stdio).

> 
> thanks
> -- PMM
> 


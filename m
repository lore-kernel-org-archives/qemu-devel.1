Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88283C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDFD20723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yucbn9dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDFD20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbSy-0004QR-G3
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdbS0-0003Nh-LX
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:25:08 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:35997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdbRz-0005EK-R6
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:25:08 -0400
Received: by mail-ej1-x644.google.com with SMTP id z5so24299887ejb.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L0bnXrHWnP29F9tx2KheZXNVrXy6NLxkJkFuvfKHe+o=;
 b=Yucbn9dwmgPct8UMC5DE/+ewBFc62UBJWaX7tYqhlKLfwIcVJOJ1wUB0/SmthebAN9
 j+JDn3Y3AiM/ljlO3uyN8JQ6CLarR7fuVsOWRGFSBb6tKPnmZzf4elpzlIdSuFa4PBQZ
 PdtJyWx6wX2lG/i3tmDqFH2V+Sb9bvlR+quY5Rt8R8AQw0AfAty5U2Okh70zJD4hRUA1
 +H0TXUqigEMdpuYmkt3cQ+D9UzOTmPWBx5+dV0iD/adDTFp9ssNVkRuHi0W6qBZHNdZs
 HGfAq1iRs+YUNJS0eKG06SD0ULxjCCQA8O6aGu2/ENVBV4HEaDcmIqBev8uSrchatQUo
 J3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L0bnXrHWnP29F9tx2KheZXNVrXy6NLxkJkFuvfKHe+o=;
 b=jm8Dhv40kxV4XRuu5+FvSEgAXqdgjJjuspfEoky8ndlwiWDhuhNthrnjM1VrcocqCn
 XxErAV33niG+i1z32RgayE5JqkMRFCu8F7kL60Wgp82j5iqDsy5OJM9oyYyvex18ulEl
 La/MhHYzv/6yNcWRZws3eCOnGScZSj26QZIjd020i/cQvP4HhEK5PhG4VLzvZ9FBu6f0
 57G9PLSWfaTLEf6FP85A0rnXwNzfwWzEBYxky3prT9ETGZlsfKt5wjf3by9c5OY3LezC
 dhrbHlHgSnemLsZmD9/0oJx8jwVreynQYR26aGkNHyVgFotEEKVrtvgWiEOs039P7EDo
 annQ==
X-Gm-Message-State: AOAM532bpINvv7/2VP9wrEGGDT7R/Q31ZihdMn6wqb0hwRBLvNJQFjJO
 nT3Dljcn6jmTqs+OjsNa9hk=
X-Google-Smtp-Source: ABdhPJyAEdQ70O9EsAgrtJpEnykVPNyEEwBhm9adDJgMcKSoPP/+hygkWX9mJAmXfJl0x2WjKzvOng==
X-Received: by 2002:a17:906:27c2:: with SMTP id
 k2mr1512451ejc.239.1590506706361; 
 Tue, 26 May 2020 08:25:06 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id i2sm198974edy.30.2020.05.26.08.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:25:05 -0700 (PDT)
Subject: Re: [PATCH 0/2] tests/qtest/fuzz: Avoid QTest serialization
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200526055820.12999-1-f4bug@amsat.org>
 <20200526085609.GA766304@stefanha-x1.localdomain>
 <0e3f6528-b26e-6b5b-be23-f7cf79c216f5@amsat.org>
 <20200526145632.65uxxj7qk2lrwxsv@mozz.bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e9429d6-7309-4f1e-4a72-6d4d28eea956@amsat.org>
Date: Tue, 26 May 2020 17:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200526145632.65uxxj7qk2lrwxsv@mozz.bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 4:56 PM, Alexander Bulekov wrote:
> On 200526 1105, Philippe Mathieu-Daudé wrote:
>> On 5/26/20 10:56 AM, Stefan Hajnoczi wrote:
>>> On Tue, May 26, 2020 at 07:58:18AM +0200, Philippe Mathieu-Daudé wrote:
>>>> Hi Alexander,
>>>>
>>>> I forgot to share these 2 patches wrote before
>>>> the direct MemoryRegion fuzzer sent yesterday.
>>>>
>>>> Regards,
>>>>
>>>> Phil.
>>>>
>>>> Philippe Mathieu-Daudé (2):
>>>>   tests/qtest/fuzz: Avoid QTest ioport serialization
>>>>   tests/qtest/fuzz: Avoid QTest mmio serialization
>>>>
>>>>  tests/qtest/fuzz/i440fx_fuzz.c      | 19 +++++++++++++------
>>>>  tests/qtest/fuzz/virtio_net_fuzz.c  |  6 ++++--
>>>>  tests/qtest/fuzz/virtio_scsi_fuzz.c |  6 +++++-
>>>>  3 files changed, 22 insertions(+), 9 deletions(-)
>>>
>>> Will it still be possible to print qtest reproducer commands when a
>>> crash is found?
>>
>> Yes, there is no change in the corpus format.
> 
> Yes, though with these patches, the qtest-based code will be gone.
> Should there be some option to switch between the two modes?

How so?

How do you generate your reproducers?

> 
>>>
>>> Other than this concern, higher fuzzing rates would be great.
>>
>> Thanks,
>>
>> Phil.
> 


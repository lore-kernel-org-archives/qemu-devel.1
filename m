Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22B8C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F211320732
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8cHTCN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F211320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI4M5-0000hw-R7
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 02:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kI4Kp-0007qp-C5
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:20:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kI4Kn-0004vA-Qx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:20:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10so1985098wrv.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 23:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AGFs98nfeklUiguXJUuIkK81BtdIARYbgXGeco8Pl5s=;
 b=Y8cHTCN3nsH2FBFff81MVU7KLjGS/e5Kw9umZJhBcRK4Z57JrukgKUmesMWIMlc0or
 LO6BiPTsO7RWsSnEl/wi6dVUMZuyLA/kUCZtwW9n3OjXTpzZrbVT9XXcT56aYQGwv7Cd
 WTQzVP2zBlaFn6pgRQEILaYnxSvoMW1TohsUTvK9lo9qkbHyuOhvb1A1wrg02iPSTDhq
 1kXB2P0zpZ88BsdGCupW58mcBUGQQb/0Qcp7hnci/fMSKxBVh8aVOWWL+ISXxYlI7xS+
 KkTIpr8QerzyjPCJtE3mk/+A/DGSU5o4k318FRFqVJ2++NtZTU9i0FVZrmGQ3m5FnIKD
 c/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AGFs98nfeklUiguXJUuIkK81BtdIARYbgXGeco8Pl5s=;
 b=mWIhTFa8Hucha39W7Dq0gg/UkSiWseGxn8nHuYWmJKpo8KNjv/y4sXu0nghWlwVhob
 P2eOjAJ8LBtQzTri8b+dZK8k4OMSkHhS6VJKmEOxEzHCAfd1JIGN8Jz5EYOsPZq+ujJ8
 XUBGHqblxmdkfUWvB4zpOzLY8Su75GMCaHbzJUsXuFeY5S7/s3HjYGhIO2KulE9PS5Qj
 tk9JVImoR4cxUF1yB/g3JMgw0JsyRkqShrzOr71blpDdZFjGvtffLV1qE1sBlPVhh7YT
 HIHm1m/LnzHIC5mQ4eOCcBzaHnqvOF5AKFcBCayz04P7K9sGtHSZEjF0bfL+WBIGU+5w
 7nhg==
X-Gm-Message-State: AOAM533WVv1KcgonQcCeKkG6+fuj+vNJH/5BpkL6VAxpAk7zV1ifjh91
 ioESFOhqhy23dnPHJt+RePg=
X-Google-Smtp-Source: ABdhPJzvMqReUIepGzrwWRKYAzD7Cg///Phc67tuIp5QZQ05Xs1tAfIj4EkJsiSARJPTWFSDyhYS3g==
X-Received: by 2002:adf:f106:: with SMTP id r6mr19939453wro.106.1600150855290; 
 Mon, 14 Sep 2020 23:20:55 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q4sm25996947wru.65.2020.09.14.23.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 23:20:54 -0700 (PDT)
Subject: Re: [PATCH 11/11] disas: Enable capstone disassembly for sparc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
 <20200914000153.1725632-12-richard.henderson@linaro.org>
 <85136547-9be9-f89e-eabb-fb4a0117c46e@amsat.org>
 <664ad3cb-7c27-41a0-9a10-3c6fd9cfdd5a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <40884a02-3adb-ec5e-dfaa-6d85c8c42464@amsat.org>
Date: Tue, 15 Sep 2020 08:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <664ad3cb-7c27-41a0-9a10-3c6fd9cfdd5a@linaro.org>
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
Cc: alex.bennee@linaro.org, luoyonggang@gmail.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, thuth@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 11:07 PM, Richard Henderson wrote:
> On 9/13/20 11:23 PM, Philippe Mathieu-Daudé wrote:
>> The old disassembler is easier to follow:
>>
>>  ----------------
>>  IN:
>> -0x4000d214:  lda  [ %g3 ] #ASI_M_FLUSH_PROBE, %g6
>> -0x4000d218:  sta  %g6, [ %g4 ] #ASI_M_FLUSH_PROBE
>> +0x4000d214:  cc80c060  .byte    0xcc, 0x80, 0xc0, 0x60
>> +0x4000d218:  cca10060  .byte    0xcc, 0xa1, 0x00, 0x60
>>
>> ^ lda/sta opcodes not supported (there might be more).
>>
>>  ----------------
>>  IN:
>> -0x4000d22c:  sethi  %hi(0xf01f0000), %g1
>> -0x4000d230:  mov  %g1, %g1     ! 0xf01f0000
>> -0x4000d234:  jmp  %g1
>> -0x4000d238:  nop
>> +0x4000d22c:  033c07c0  sethi    0x3c07c0, %g1
>> +0x4000d230:  82106000  or       %g1, 0, %g1
>> +0x4000d234:  81c04000  jmp      %g1
>> +0x4000d238:  01000000  nop
>>
>> ^ hi()/lo() macros not expanded (easier to read!)
> 
> Hmm, yes.  I'm going to drop this for now.
> Maybe revisit if this gets fixed upstream.
> 
>> Can we restrict dumping the encoded hex content for debug
>> profile only?
> 
> Why?  Including the hex content was in fact requested when I first added the
> capstone code.

Ah, OK. Now I wonder if I hadn't asked you the same when
you introduced capstone :)

Maybe we could include the hex content in the current
disas.c as a first step, that would ease diffing for
missing opcodes.


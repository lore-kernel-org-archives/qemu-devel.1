Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9CAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DFA206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecpZGgv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DFA206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTiBb-00018i-3r
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiAc-0000Fl-Q9
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 05:06:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiAa-0004UX-Un
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 05:06:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so7708718wme.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sqBWhbUMPpjlVFdpNnrVkGeGJpiSkb4f1isu+DuJpGs=;
 b=ecpZGgv3mOvZROFVTjVAYBVUYehOuf5pN00BKDQRtIkMsAt7Dwznk9DBzDBQXVy90s
 xVZupbdgZNdxdCN9CgsrrVfwu7MyfDHcac9d7cdFNzqu1rzeJ7C0NjgKpsTbGZCLfJ53
 No1rcL39LG8Iydv/dtMs4QpHL0HbRx0DWp8X+X94r86TdjiqhWknZHdas+m7QTJp/Ko9
 idxc+VvqU5vN0skYHZUHwl2ZuLS+r15I4znOOy0ost7mRxE0yXLRaMahgvhvgpNTZ7eH
 Y6nYovpuicaNjV3SIstVofpqR+7Hv5SyxbdqqjiePTR4TsGDAjJZBSWocnP+xkL+53EH
 wzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sqBWhbUMPpjlVFdpNnrVkGeGJpiSkb4f1isu+DuJpGs=;
 b=ADjxIhaiM867tZ6YezgaVCMXd+gZGUJZ6YxMlbfiHwOjchSV/Ejz60sCOWHqAyVU5i
 WNKXU9693ZwP7vo9DZpbZSra2XkLn1TDQot51Yi9+AV8knObsDUWWv7g+egGwc65ZoVE
 G9x+GaVa00MY2sMj8qV89R9CyDL/1mh5U/9TLwVtxZmbio7eMke6F0aQPCzFT8LTvKRf
 SeIvVK2PoV+xHbqUB+KY4GwFbgKxlCl76WZpjMbVg3udtTpcw443ma/vVUqr/OJIIgCn
 rgPbWzD1lRdKNoSO6JvKWa/w7JYarIh8SKR4svYt0fmWGqqMC4mX08BbywgNz0Z4me/U
 463g==
X-Gm-Message-State: AOAM531arKvuQvIM5iSuS3UTBhKeYdV+dyjxOrS8o4S9Aca1MPOn4Hv4
 KdAssFpeG1cKu22p++uZ+qs=
X-Google-Smtp-Source: ABdhPJz1iP5hraIitHMdfD6VqHSx/qAjOZOG+SQwT4TRyiBcWYaWc93xB9l/7ZbARGKefjzr1xdTyw==
X-Received: by 2002:a1c:5685:: with SMTP id k127mr7887597wmb.135.1602925591507; 
 Sat, 17 Oct 2020 02:06:31 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id o194sm6364018wme.24.2020.10.17.02.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:06:30 -0700 (PDT)
Subject: Re: [RFC PATCH v3] target/mips: Increase number of TLB entries on the
 34Kf core (16 -> 64)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Victor Kamensky <kamensky@cisco.com>
References: <20201016133317.553068-1-f4bug@amsat.org>
 <89c6f926-9692-2b8e-617c-6c950bfd1945@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <621b7f92-c37b-1fc0-dff5-a241c2068733@amsat.org>
Date: Sat, 17 Oct 2020 11:06:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <89c6f926-9692-2b8e-617c-6c950bfd1945@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Khem Raj <raj.khem@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 7:28 PM, Richard Henderson wrote:
> On 10/16/20 6:33 AM, Philippe Mathieu-Daudé wrote:
>> Per "MIPS32 34K Processor Core Family Software User's Manual,
>> Revision 01.13" page 8 in "Joint TLB (JTLB)" section:
>>
>>    "The JTLB is a fully associative TLB cache containing 16, 32,
>>     or 64-dual-entries mapping up to 128 virtual pages to their
>>     corresponding physical addresses."
>>
>> There is no particular reason to restrict the 34Kf core model to
>> 16 TLB entries, so raise its config to 64.
>>
>> This is helpful for other projects, in particular the Yocto Project:
>>
>>    Yocto Project uses qemu-system-mips 34Kf cpu model, to run 32bit
>>    MIPS CI loop. It was observed that in this case CI test execution
>>    time was almost twice longer than 64bit MIPS variant that runs
>>    under MIPS64R2-generic model. It was investigated and concluded
>>    that the difference in number of TLBs 16 in 34Kf case vs 64 in
>>    MIPS64R2-generic is responsible for most of CI real time execution
>>    difference. Because with 16 TLBs linux user-land trashes TLB more
>>    and it needs to execute more instructions in TLB refill handler
>>    calls, as result it runs much longer.
>>
>> (https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html)
>>
>> Buglink: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992
>> Reported-by: Victor Kamensky <kamensky@cisco.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> v3: KISS
>> Supersedes: <20201015224746.540027-1-f4bug@amsat.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   target/mips/translate_init.c.inc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, applied to mips-next.



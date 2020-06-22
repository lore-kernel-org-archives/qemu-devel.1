Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F09C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FB8206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbPlQymT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FB8206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIBC-0003FI-Sl
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnIAM-0002VW-Q6; Mon, 22 Jun 2020 04:50:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnIAL-0003U6-5Y; Mon, 22 Jun 2020 04:50:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id g21so10436426wmg.0;
 Mon, 22 Jun 2020 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HrOENJmFxClmzMDmvyXZ+378Oo/y3SnM5i2nKt8Zhcc=;
 b=QbPlQymTFOTixdlgICYer0yrOWJ+8tx423l9IWQMx5A77PpmQ92x1Wxy/xrZopt9I1
 uwfjZHhqCO43q8OX+9WpLdvJHSLLxNy+duFWnBVieoA03okEZNv4Qt/3KW+9zEJP/4e7
 DObK5aRAllPgrg0+Q4tpW+uDd9JxkzPqfZGTNiPIG3T42CS1o91Fjorvz/OO40+5xEOW
 VVLbDtz7PqvbDDGZhf8stBI1IazN8UZc6nxVd7ovb4LvdayXcDS0ZNABfToQSLImmmkJ
 yWHNrB52Y+glY5wjs85EwKoPD5uxSQA6wqPX8ICxMDXEWCfDZoMkeYA5BeY4RYlRdHLf
 D+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HrOENJmFxClmzMDmvyXZ+378Oo/y3SnM5i2nKt8Zhcc=;
 b=MgwiXPEL+8NLY8boN0wxKPYV3c9pjWPfNm/D48xscYfLw+eEpH0RRLjUBvDl5CVIrN
 QiHwrnx9YwCY58goZy3Lu+AA+dXe4RfO1coxvIDynQafHIkN9JSZ8PWUchp/WSLWolpt
 NtjKZw6o4Przz87wBwQu1EKer3uPWJi9zKdbx2rLgopH8zrZGrq41lntrmoOclwD5+h4
 0Oqc6Dn8Ub1E5/VxfMDuwAebZxR43doAax/lEnQLPrFUmIq0elahG26lAQVb+WL8VRcW
 Ihgx/LL5F+443/AbA6zyprdsOojNxwveTB0dd5gVGKc9kb+Dz4wH9TZy7WGLuraLRH9C
 DBbQ==
X-Gm-Message-State: AOAM532DIcfPqbr4kcgqcgBGfdgwwz3TmtlVnR3TjrokSqFPN+43BEzZ
 +4qG/x7xvplGadXIN6QXRZg=
X-Google-Smtp-Source: ABdhPJwcRaamhE8pfkRFCPjzbc0Vw6ucJK2fDh9xICT8PVbhTh+Ai4Qccf9VZDQMhJOtmi4Ktymn+w==
X-Received: by 2002:a1c:3bd5:: with SMTP id
 i204mr17047565wma.134.1592815854869; 
 Mon, 22 Jun 2020 01:50:54 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h18sm16876590wru.7.2020.06.22.01.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 01:50:54 -0700 (PDT)
Subject: Re: [PATCH 1/7] qemu-common: Briefly document qemu_timedate_diff()
 unit
To: Markus Armbruster <armbru@redhat.com>
References: <20200616075121.12837-1-f4bug@amsat.org>
 <20200616075121.12837-2-f4bug@amsat.org> <87d05xsz6y.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <499650b0-63ca-6882-bf63-dd91ffdebdcc@amsat.org>
Date: Mon, 22 Jun 2020 10:50:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87d05xsz6y.fsf@dusky.pond.sub.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <minyard@acm.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 7:47 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> It is not obvious that the qemu_timedate_diff() and
>> qemu_ref_timedate() functions return seconds. Briefly
>> document it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/qemu-common.h | 1 +
>>  softmmu/vl.c          | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/qemu-common.h b/include/qemu-common.h
>> index d0142f29ac..e97644710c 100644
>> --- a/include/qemu-common.h
>> +++ b/include/qemu-common.h
>> @@ -27,6 +27,7 @@ int qemu_main(int argc, char **argv, char **envp);
>>  #endif
>>  
>>  void qemu_get_timedate(struct tm *tm, int offset);
>> +/* Returns difference with RTC reference time (in seconds) */
>>  int qemu_timedate_diff(struct tm *tm);
> 
> Not this patch's problem: use of int here smells; is it wide enough?

I'll add a /* FIXME */ comment.

> 
>>  
>>  void *qemu_oom_check(void *ptr);
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index f669c06ede..215459c7b5 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -737,7 +737,7 @@ void qemu_system_vmstop_request(RunState state)
>>  }
>>  
>>  /***********************************************************/
>> -/* RTC reference time/date access */
>> +/* RTC reference time/date access (in seconds) */
>>  static time_t qemu_ref_timedate(QEMUClockType clock)
>>  {
>>      time_t value = qemu_clock_get_ms(clock) / 1000;
> 
> time_t is seconds on all systems we support.  Using it for something
> other than seconds would be wrong.  The comment feels redundant to me.
> But if it helps someone else...

Ah, TIL 'time_t' is the arithmetic time type to represent
the number of seconds since the epoch.

I guess I almost never used it ... (Not something real time
embedded systems care much) :)

So scratch that comment.

> 
> 


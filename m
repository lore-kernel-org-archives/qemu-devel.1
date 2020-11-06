Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D52C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FDA20719
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drdSPF+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FDA20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb2aD-0006bV-Dy
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb2ZE-0005mg-Kb
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb2ZA-0001JA-GA
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604672291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fosMAQmbhAi5xlqDEKEqu4kiz3808IUhWO0rlufz+SQ=;
 b=drdSPF+VangGoYY+MInO7Nmz26OiVOJXdFNq87VhDdCdpOC2nbQKzIRbdAsZKEs+fKjoR7
 FRLcF2GHow8nGJnVpaJLL587g0ZNXuSpWevRvLBz5XibP2430RZPyxhiN40wMS3R++t2ko
 5EFG4BmhZdr/H19JCrbegIkrWy/DsiQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-TM-JVedpOZ2HU0qumwJusA-1; Fri, 06 Nov 2020 09:18:10 -0500
X-MC-Unique: TM-JVedpOZ2HU0qumwJusA-1
Received: by mail-wr1-f70.google.com with SMTP id v14so520815wro.12
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 06:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fosMAQmbhAi5xlqDEKEqu4kiz3808IUhWO0rlufz+SQ=;
 b=uS1VV92P2zuZSFdM6/Hi2xpc8dr7wVhYkFLJg7s/V/edL3j4YV+YglVPev9Z1htij5
 sbJYYIUx1mihUuHczAZqRszuZES/0J7cXsJaD1TK8oqgjn+0Qx8nKgOwbM/9p1Z4zxOq
 zEcdHHxInsJCxRp9fDPQxs2ryVLZ4rW0M8jg2/HBe7vHbefcmBrw13IJ9y7GGSHLAjxA
 IfSaQXAMC8cUL186MTtU7al7hQ7th4E7cdxNOpj/hmSw6A4FlQLfNnIDo+5r6QHpfz3h
 RIOCZ4ENZROnzriGkYGfadLPYaZm5leEe2eABgn6BCMV/xpMjFZu0Lp8LW1c6ot0MsXK
 MD3w==
X-Gm-Message-State: AOAM533KSWsqI8nSxi2vtI+7hPaFfDWzWGKS/uhetn9F+VCjRDfR2Mc1
 Cj/t4k3cD4ICu4Ew8dW+rIeklqn+MRqkUMJRydca8nF7UL2CWolgfGdInrTAfY0Ah3JOk/q9lVa
 JXU3OjY8/842Ysgs=
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr2834255wrx.278.1604672288480; 
 Fri, 06 Nov 2020 06:18:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL7i0yGFn/i7AtbaHmfMTB3TY7sDatjmGvJEFgEg8ltdYLy1tnRmZnKqUN1YvhExSQxIvbtA==
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr2834241wrx.278.1604672288251; 
 Fri, 06 Nov 2020 06:18:08 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g14sm2374017wrx.22.2020.11.06.06.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 06:18:07 -0800 (PST)
Subject: Re: [PATCH] qtest: Fix bad printf format specifiers
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <5FA28117.3020802@huawei.com>
 <67eca43e-99ea-f2ce-5d9e-a9cb5c7a3a83@redhat.com>
 <5FA38A32.2020008@huawei.com>
 <18690aa2-3de9-70ad-477f-934724b284a0@redhat.com>
 <87wnyzouy4.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1fd5965d-cf5e-b41b-2029-bd3e52c3e498@redhat.com>
Date: Fri, 6 Nov 2020 15:18:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87wnyzouy4.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: AlexChen <alex.chen@huawei.com>, lvivier@redhat.com,
 QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 7:33 AM, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 05/11/2020 06.14, AlexChen wrote:
>>> On 2020/11/4 18:44, Thomas Huth wrote:
>>>> On 04/11/2020 11.23, AlexChen wrote:
>>>>> We should use printf format specifier "%u" instead of "%d" for
>>>>> argument of type "unsigned int".
>>>>>
>>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>>>>> ---
>>>>>  tests/qtest/arm-cpu-features.c | 8 ++++----
>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
>>>>> index d20094d5a7..bc681a95d5 100644
>>>>> --- a/tests/qtest/arm-cpu-features.c
>>>>> +++ b/tests/qtest/arm-cpu-features.c
>>>>> @@ -536,7 +536,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>>>>>          if (kvm_supports_sve) {
>>>>>              g_assert(vls != 0);
>>>>>              max_vq = 64 - __builtin_clzll(vls);
>>>>> -            sprintf(max_name, "sve%d", max_vq * 128);
>>>>> +            sprintf(max_name, "sve%u", max_vq * 128);
>>>>>
>>>>>              /* Enabling a supported length is of course fine. */
>>>>>              assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name);
>>>>> @@ -556,7 +556,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>>>>>                   * unless all larger, supported vector lengths are also
>>>>>                   * disabled.
>>>>>                   */
>>>>> -                sprintf(name, "sve%d", vq * 128);
>>>>> +                sprintf(name, "sve%u", vq * 128);
>>>>>                  error = g_strdup_printf("cannot disable %s", name);
>>>>>                  assert_error(qts, "host", error,
>>>>>                               "{ %s: true, %s: false }",
>>>>> @@ -569,7 +569,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>>>>>               * we need at least one vector length enabled.
>>>>>               */
>>>>>              vq = __builtin_ffsll(vls);
>>>>> -            sprintf(name, "sve%d", vq * 128);
>>>>> +            sprintf(name, "sve%u", vq * 128);
>>>>>              error = g_strdup_printf("cannot disable %s", name);
>>>>>              assert_error(qts, "host", error, "{ %s: false }", name);
>>>>>              g_free(error);
>>>>> @@ -581,7 +581,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>>>>>                  }
>>>>>              }
>>>>>              if (vq <= SVE_MAX_VQ) {
>>>>> -                sprintf(name, "sve%d", vq * 128);
>>>>> +                sprintf(name, "sve%u", vq * 128);
>>>>>                  error = g_strdup_printf("cannot enable %s", name);
>>>>>                  assert_error(qts, "host", error, "{ %s: true }", name);
>>>>>                  g_free(error);
>>>>>
>>>>
>>>> max_vq and vq are both "uint32_t" and not "unsigned int" ... so if you want
>>>> to fix this really really correctly, please use PRIu32 from inttypes.h instead.
>>>>
>>>
>>> Hi Thomas,
>>> Thanks for your review.
>>> According to the definition of the macro PRIu32(# define PRIu32         "u"),
>>> using PRIu32 works the same as using %u to print, and using PRIu32 to print
>>> is relatively rare in QEMU(%u 720, PRIu32 only 120). Can we continue to use %u to
>>> print max_vq and vq in this patch.
>>> Of course, this is just my small small suggestion. If you think it is better to use
>>> PRIu32 for printing, I will send patch V2.
>>
>> Well, %u happens to work since "int" is 32-bit with all current compilers
>> that we support.
> 
> Yes, it works.
> 
>>                  But if there is ever a compiler where the size of int is
>> different, you'll get a compiler warning here again.
> 
> No, we won't.
> 
> If we ever use a compiler where int is narrower than 32 bits, then the
> type of the argument is actually uint32_t[1].  We can forget about this
> case, because "int narrower than 32 bits" is not going to fly with our
> code base.
> 
> If we ever use a compiler where int is wider than 32 bits, then the type
> of the argument is *not* uint32_t[2].  PRIu32 will work anyway, because
> it will actually retrieve an unsigned int argument, *not* an uint32_t
> argument[3].
> 
> In other words "%" PRIu32 is just a less legible alias for "%u" in all
> cases that matter.

Can we add a checkpatch rule to avoid using 'PRI[dux]32' format,
so it is clear for everyone?

> 
> And that's why I would simply use "%u".
> 
>>                                                      So if we now fix this
>> up, then let's do it really right and use PRIu32, please.
>>
>>  Thomas
> 
> 
> [1] Because promotion does nothing either argument, and the usual
> arithmetic conversions convert to uint32_t.  See my first reply.
> 
> [2] Because uint32_t gets promoted to unsigned int.  See my first reply.
> 
> [3] Because variable arguments undergo default argument promotion (§
> 6.5.2.2 Function calls), which promotes uint32_t to unsigned int.
> 
> 



Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C28BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583B12078D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvXEg/3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583B12078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96TZ-0005zv-LZ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k96SZ-0005Sl-O3; Fri, 21 Aug 2020 08:47:55 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k96SX-0003LC-P0; Fri, 21 Aug 2020 08:47:55 -0400
Received: by mail-qk1-x743.google.com with SMTP id 2so1194474qkf.10;
 Fri, 21 Aug 2020 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q0yFN49bJUXLUtZTtYFUqfjHLv1446SG+JNw0BQfEGA=;
 b=HvXEg/3gd/SVq7rCaGMqvgLlAPjGEoKchvrxhuasPoBLfwfiFFtA+ztdtZ8Ulchdmv
 UwCb2jo6FYVpzJ1V6tBfgyZAq2FYF4AWXsfKsPaY4IXerxQDyAO9rmH1/4f4/tPFLStP
 qrD3VfUqZM+TRNkR49EnC06vXOBb0W4xJF5U5fWEPmNcoPA/8Z27TG/58ndghHFEEC+f
 HYUvt6lqN6TxIqd7iHRcd7QaGFlJNISckLOFv+W4ivU7mpu67ALmL7ekxvl8ogtWM2WV
 xp/pTOw4+djiVYcVGQd6veDJvWJRYKRYCfG4mYk9/U0E0do3DLiqdTRDZ2x+iUagmXip
 zavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q0yFN49bJUXLUtZTtYFUqfjHLv1446SG+JNw0BQfEGA=;
 b=m1umujv1DMl8LqGO7w2IKe8tHQN3jCL3VGeJu7JWrJsSCpyLlWvHxR2ybwQJpKaj0R
 6CmWAmPqDXnPtQyUyMYAF7EoPS65wLI7lVN9uLoIJPjdVB8nGUCTIKFCb6/d4idzLboI
 n3OLtZ9ohVBEjHwbQTh4S3gL8Q9nY0yPaRS9CqaTpETcFCmFqGzp14Dkzn3flbk2qvWV
 F7q4if1Bs8wZLcrPzsGzJ0Z9D4OYEEMdHhzS9UMVQHo7h3VTZKwmHuoRO7I0BDiCjxf2
 bGAvOJI2qB+GJUbnIUG4MRNvF7d3BX3UW8a9TTGFkNTvwxFwPyjSCK30wufbyyg+nOWo
 ARGQ==
X-Gm-Message-State: AOAM5337AdMAaHlS8144rzSZ7cUOemt6eUrk6guKmG0P5zcMXmtscFH6
 LO92H9iHa0O+ALwDaXPNaVjNei9gMsk=
X-Google-Smtp-Source: ABdhPJwwuROA0MMIRFDgTaddnx6n4ObIV281hyDCH8NQswZVcsev29qTU6Kpb2YonB25FbtcYOyzzw==
X-Received: by 2002:a05:620a:4ed:: with SMTP id
 b13mr2703039qkh.493.1598014071766; 
 Fri, 21 Aug 2020 05:47:51 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c152:6ea6:a44d:671e:88f?
 ([2804:431:c7c7:c152:6ea6:a44d:671e:88f])
 by smtp.gmail.com with ESMTPSA id h20sm1580203qkk.79.2020.08.21.05.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 05:47:50 -0700 (PDT)
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-3-danielhb413@gmail.com>
 <20200820011726.GF271315@yekko.fritz.box>
 <20200820021128.GC642093@habkost.net>
 <20200820041504.GN271315@yekko.fritz.box>
 <20200820165103.GD642093@habkost.net> <20200821105538.6f6b46c8@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e007c59f-9533-48f0-a08a-6745a29b6600@gmail.com>
Date: Fri, 21 Aug 2020 09:47:47 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821105538.6f6b46c8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/21/20 5:55 AM, Igor Mammedov wrote:
> On Thu, 20 Aug 2020 12:51:03 -0400
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
>> On Thu, Aug 20, 2020 at 02:15:04PM +1000, David Gibson wrote:
>>> On Wed, Aug 19, 2020 at 10:11:28PM -0400, Eduardo Habkost wrote:
>>>> On Thu, Aug 20, 2020 at 11:17:26AM +1000, David Gibson wrote:
>>>>> On Fri, Aug 14, 2020 at 05:54:16PM -0300, Daniel Henrique Barboza wrote:
>>>>>> The pSeries machine does not support asymmetrical NUMA
>>>>>> configurations.
>>>>>
>>>>> This seems a bit oddly specific to have as a global machine class
>>>>> property.
>>>>>
>>>>> Would it make more sense for machines with specific NUMA constraints
>>>>> to just verify those during their initialization?
>>>>
>>>> This would be much simpler.  However, I like the idea of
>>>> representing machine-specific configuration validation rules as
>>>> data that can eventually be exported to management software.
>>>
>>> Ah, ok, so basically the usual tradeoff between flexibility and
>>> advertisability.
>>>
>>> So, in that case, I guess the question is whether we envisage "no
>>> assymmetry" as a constraint common enough that it's worth creating an
>>> advertisable rule or not.  If we only ever have one user, then we
>>> haven't really done any better than hard coding the constraint in the
>>> manageent software.
>>>
>>> Of course to complicate matters, in the longer term we're looking at
>>> removing that constraint from pseries - but doing so will be dependent
>>> on the guest kernel understanding a new format for the NUMA
>>> information in the device tree.  So qemu alone won't have enough
>>> information to tell if such a configuration is possible or not.
>>
>> Requiring both QEMU (and possibly management software) to be
>> patched again after the guest kernel is fixed sounds undesirable.
> If we drop this restriction, then we don't need to touch QEMU when
> guest kernel is ready.
> 
> Btw, what spapr spec says about the matter?


LOPAPR support a somewhat asymmetrical NUMA setup in its current form, but
the Linux kernel doesn't support it. The effort to implement it in the current
spapr machine code, given that Linux wouldn't mind it, is not worth it. This
is why I chose to invalidate it for pseries.


> 
>> Perhaps a warning would be better in this case?
>>
>> In either case, it sounds like this won't be a common constraint
>> and I now agree with your original suggestion of doing this in
>> machine initialization code.
> Agreed, if it goes to spapr specific machine code I will not object much.
> (it will burden just spapr maintainers, so it's about convincing
> David in the end)

I believe he's ok with it given that he suggested it in his first reply.

I'll move this verification to spapr machine_init in the next version.



Thanks,

DHB


> 


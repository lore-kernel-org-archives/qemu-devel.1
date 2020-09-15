Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37099C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 21:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942DD2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 21:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIREcKbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942DD2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIIZy-0003XD-FT
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 17:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIIXC-0001l1-En
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 17:30:43 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIIX9-0002ix-4y
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 17:30:42 -0400
Received: by mail-pj1-x1044.google.com with SMTP id t7so457796pjd.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zxy8V1MNkV+mqhUqTlm+FEkBAi1RK8rG5fspzNc+5Hw=;
 b=nIREcKbxawTBr1qw3b8gEyS72A3YWaXu2fbFqReT7PqkMwOftoPzxV6hJpg+XsGVdE
 xgincoC1CoJPho+OnHIJiuhMrUSa4jPoyaf6F1o7JImUrCITiAlWhQUaHepckN0egCnd
 fSFqWWGutj1OsJYgkF9FTu4+LVZNzsnKqC/L/35jrBDvBoI8og3Ve4MRrRdJk1jC7BQf
 M+3aLZm4A9ZA3RpY4u5RacexiiCW4ui50/4lGsW6cbEMM0Sr4JiBkEBZJh4tyIytO6Ku
 Ja+m0L7uMdSd6jB/00TwnNtgsu0iRQ88ii6GOi4WQo3plBqocIRfLbAHaIxKSRUOGvhJ
 oOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zxy8V1MNkV+mqhUqTlm+FEkBAi1RK8rG5fspzNc+5Hw=;
 b=JwDn4FFYrMXuWo6S/Wf+fId4VkkB6wRDYIT93AkPlDMUTBh3LvyTRk5Ltyj/SLOGVd
 DtlNSJQJLAY+F6YxZpMVkyOP2XiwaFu2zHXQJWEpcd8iNbigK2qGWWmPukqzOePALIEm
 BHDlJ14xWuPOkRO8Gto4yG4+csPdbxrarjItvxS5naQI0H9q/G+scbmYm88PU5QhXL2H
 drg8rYptd+A+ycsc7Qse3WiEOp/RABY+xu+C9oEaTn6uamlt0/5MbIE5LATsqTUSiIa6
 nzLeRO+VsgxaBf9fekmG2FOZzr8NoCcdJfeE42adZ+OhuReDfcRm+DW04gwHF+tKHv9d
 D2AA==
X-Gm-Message-State: AOAM531kJnrlklJoqDqw8xk5aIu5HkV2lQVpG2xo0JISSsmLQCCF/9nr
 nW0RuToVW2P29Z6XsXUsBqWHlg==
X-Google-Smtp-Source: ABdhPJxytltE+/fLGA+hEcdOJLbjWxPv0hx2NAbR0EiWJU3pIRJYgtRfpEl/UNKhHYNt3Md3eGGnkg==
X-Received: by 2002:a17:902:8f88:b029:d0:cbe1:e719 with SMTP id
 z8-20020a1709028f88b02900d0cbe1e719mr21431895plo.39.1600205437147; 
 Tue, 15 Sep 2020 14:30:37 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y126sm14724600pfy.138.2020.09.15.14.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 14:30:36 -0700 (PDT)
Subject: Re: [PATCH 1/5] qom: Allow objects to be allocated with increased
 alignment
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200915174635.2333553-1-richard.henderson@linaro.org>
 <20200915174635.2333553-2-richard.henderson@linaro.org>
 <20200915180736.GB7594@habkost.net>
 <6d6a80bf-a542-6818-1638-0318f4aab336@linaro.org>
 <20200915201901.GD7594@habkost.net>
 <74c1e091-63c4-9ea0-c515-ad977ffa1d98@linaro.org>
 <20200915212732.GE7594@habkost.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7c827913-db00-ab68-94fb-8512f716356c@linaro.org>
Date: Tue, 15 Sep 2020 14:30:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915212732.GE7594@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 2:27 PM, Eduardo Habkost wrote:
> On Tue, Sep 15, 2020 at 01:51:48PM -0700, Richard Henderson wrote:
>> On 9/15/20 1:19 PM, Eduardo Habkost wrote:
>>> Once we move to C11, we can just use max_align_t.
>>
>> Yes.
>>
>>> While we don't move to C11, why not just use
>>>   __alignof__(union { long l; void *p; double d; long double ld;})
>>> ?
>>
>> For i386, this is 4.
> 
> Is i386-linux the only case where there are additional alignment
> guarantees not covered by C99?

I think so.

> I would prefer a i386-linux-specific #ifdef for that case instead
> of guessing based on undocumented libc internals.

I was thinking abi, not internals.


r~



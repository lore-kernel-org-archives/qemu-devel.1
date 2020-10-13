Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A3FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AB420789
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDKUrqOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AB420789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFMq-0000cT-SE
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSFJj-000803-76
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSFJe-0000xB-0w
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602576345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKLNlBhLwm5aeHNl3kOcqgs3elfNIgQm4UUEWyLw4S0=;
 b=BDKUrqOaVgSFUDOklSw2vx4P6rWKV8L995pPKtkI6L3nMl1C15TVJjle3KilUut49ruOuW
 40EEDEjQ7GBaaYabE0QbF8KRzjRTyNsAhvhz56OeNiE+f3QtfhAUm6u2QbzxMW7uIg+y5f
 BRhlJRxBnGveDX0QtxjTXLfooUbmjWw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-U4rOHsnCOGu3jjdIlqx-ow-1; Tue, 13 Oct 2020 04:05:44 -0400
X-MC-Unique: U4rOHsnCOGu3jjdIlqx-ow-1
Received: by mail-wr1-f70.google.com with SMTP id 2so1368383wrd.14
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 01:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DKLNlBhLwm5aeHNl3kOcqgs3elfNIgQm4UUEWyLw4S0=;
 b=huppJJMj0ct1J960Nx+FpSwQ9zPl/H/Rv3ZMuSn6A6KbvSOdOA8BHUGBxyPqQjGGAn
 bKc8DqG9Bozcvl/Y3HM8DDDEYRDizzQNBQcU7U2yN69dXMNvN7yx29WGZXFlEnT7NhHD
 DeDD/g08j8eXA08XvLFg29Dcl/+JJi54LDQsVnY+yt8cHUaSfMWlWcAzbaF2xYyQv0ig
 is1vI1OGFYAw0C9/QdY3rhhPjxgW5o9GC3rKalsFiIATc2OmFfWNWtj0HByDWhfyt/3D
 ux1U1Kup0iQ1o1qHcW+atfpDiE9WgJX6xcxLgkfV+KIdgL8tkLpWGpPdDa6L1zpJ9bAX
 VN1Q==
X-Gm-Message-State: AOAM530bn56lIT+DNw+oj92+WdUPMCS+XPyhtdkhcZYdJXr1Hy9q70xw
 6vRvmtTk58xt+z8L8XbNUoIMEyWRdg/nIJjVqBcxzvt0dA6LANb4fQlxAWbrm9PquovD6degNki
 2PLCPE6saAaBl3Fg=
X-Received: by 2002:a5d:4691:: with SMTP id u17mr20597491wrq.324.1602576342878; 
 Tue, 13 Oct 2020 01:05:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/Fz9CDnlmfNDcqLHX1/Rj7yECe63MXP5Wt+EIC5jOoan9AvzinsQGC9M1C9oBwssF6lXnKQ==
X-Received: by 2002:a5d:4691:: with SMTP id u17mr20597468wrq.324.1602576342670; 
 Tue, 13 Oct 2020 01:05:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:61dd:85cb:23fc:fd54?
 ([2001:b07:6468:f312:61dd:85cb:23fc:fd54])
 by smtp.gmail.com with ESMTPSA id t10sm25560142wmf.46.2020.10.13.01.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:05:42 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] replay: do not build if TCG is not available
To: Claudio Fontana <cfontana@suse.de>
References: <20201012214527.1780-1-cfontana@suse.de>
 <20201012214527.1780-4-cfontana@suse.de>
 <22f05da9-311b-d8e7-0052-2163f9e6c1e8@redhat.com>
 <0c9eb5ef-5817-06f6-f622-09cb9a22505e@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2fb23024-6a20-2d0e-19e9-21e648212308@redhat.com>
Date: Tue, 13 Oct 2020 10:05:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0c9eb5ef-5817-06f6-f622-09cb9a22505e@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/20 09:56, Claudio Fontana wrote:
> Hi Paolo,
> 
> On 10/13/20 12:29 AM, Paolo Bonzini wrote:
>> On 12/10/20 23:45, Claudio Fontana wrote:
>>> +    ctx = blk_get_aio_context(blk);
>>> +    if (!replay_bh_schedule_oneshot_event(ctx, error_callback_bh, acb)) {
>>> +        /* regular case without replay */
>>> +        aio_bh_schedule_oneshot(ctx, error_callback_bh, acb);
>>> +    }
>>
>> Why can't the stub just call aio_bh_schedule_oneshot?  
> 
> Absolutely, it can, I just considered the option and dropped it in the end.
> 
>> This makes the API even more complicated.
> 
> In my view not really, the API just returns a boolean that tells you if the event was consumed or not.

The question to ask is, is there _any_ other way to use 
replay_bh_schedule_oneshot_event other than

    if (!replay_bh_schedule_oneshot_event(ctx, error_callback_bh, acb)) {
        aio_bh_schedule_oneshot(ctx, error_callback_bh, acb);
    }

and I think there isn't.  Your point of avoiding functional code in the stubs
is also valid though.

Perhaps you could have replay_bh_schedule_oneshot_event as you have it now, but
also add a wrapper (called for example replay_bh_schedule_oneshot) that takes
care of calling aio_bh_schedule_oneshot too.  But in my opinion the "if" has
no place in block/io.c.

Paolo

> If people feel strongly that this is a wrong step, we can do the alternative and put production code inside the stubs, but it just seems wrong.
> 
> Thanks!
> 
> Ciao,
> 
> Claudio
> 



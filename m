Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20417C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F358208B3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+RWN71g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F358208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb347-0001Gw-Fm
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb33W-0000k0-H2
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb33U-0003cV-TM
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604674172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3RAt5gU4b6xZjcbF/eXTV1ap+70W4fuDZRQSNFImrY=;
 b=D+RWN71gN+YCKScQVY75EPiLhI1XMurpgiVXYVXdQC08830yHy7YdbKOaWHYu+Ml66dAOu
 q09/gdV32LoL6dufyJE3jFjHakz5oYphI477+bDS51D1wrtr/ySTT6bv3KPp4/mReO0xCr
 TyDp52RQw4iUJLodHnHseP+WepCyrN0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-Mr0TLYQhNg-pfCHMZSbFbQ-1; Fri, 06 Nov 2020 09:49:30 -0500
X-MC-Unique: Mr0TLYQhNg-pfCHMZSbFbQ-1
Received: by mail-wr1-f69.google.com with SMTP id i1so546449wrb.18
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 06:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p3RAt5gU4b6xZjcbF/eXTV1ap+70W4fuDZRQSNFImrY=;
 b=E8BgAHZLAkOYTeHDARu7Ev/3puVeZk3yYXG95mSAs/fM8pOTm9SEL7u1HSDETB5X/m
 6XiwiZNDdUtFxE9JP8OQ5BzqYkknOEDvT8cgC+bGdv5GRuYhh4R2OFE0dIUqnxRdNCSg
 VeoJYOt2etUrvlHBnTqI1XAJFqOWSf/51Ji0twMhDu1BSMsSD8MQ1AH60Z0c6m1o1l2L
 o81u8977ZEpXcdOAccRJ8QWnu/pDunWCDNTnLVh97mDKcXP5SwmJbymaxDQhxu2QU618
 Qv0JrNAaJLZMQK45/Mn2XQ+rZTwojmI/azKbm72kkB1VH771+aWLBkwb25rguxWTDpGp
 HEyQ==
X-Gm-Message-State: AOAM5330LnaAOnXS3Q77MmUK0J/9LwwAdbzosNQLtd3Y9KyAb8PP7b60
 hl3cTGNcmkCdyu6bn+ctzj4uczWyvafXcCNyGs+iwkyLb3wz2zLCOSAtT160MzdkqT3y4K5el8F
 vXhQoghN1U6y8RM8=
X-Received: by 2002:adf:9e48:: with SMTP id v8mr3316866wre.55.1604674169203;
 Fri, 06 Nov 2020 06:49:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNfigChjYNIUrTqxd+fy+WfbQTdIDSXPIZDwDpHhVixTnfa37iHhJT2gOCgcgD1CLFm82j1A==
X-Received: by 2002:adf:9e48:: with SMTP id v8mr3316838wre.55.1604674168965;
 Fri, 06 Nov 2020 06:49:28 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 89sm2739596wrp.58.2020.11.06.06.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 06:49:28 -0800 (PST)
Subject: Re: [PATCH] scripts/checkpatch.pl: Modify the line length limit of
 the code
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201105154208.12442-1-ganqixin@huawei.com>
 <CAFEAcA9QMBqF0Bm44q4m1d=QaPVBJodH9rwuYhGx5H6zy6ULcg@mail.gmail.com>
 <87d00qk51l.fsf@dusky.pond.sub.org>
 <CAFEAcA-_5vRbsi5fFpyLV2OyDX5TVrpAx7_Z43wqvb1zhQO_8w@mail.gmail.com>
 <37c519e4-d72b-944c-ed70-038f9c606be9@redhat.com>
 <CAFEAcA_a=vBjLM8_-KDkYfFuTLDW6cMsQ48or70uwwVusW2q7w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <66edd934-0ff0-bc91-7539-a6792c1906e9@redhat.com>
Date: Fri, 6 Nov 2020 15:49:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_a=vBjLM8_-KDkYfFuTLDW6cMsQ48or70uwwVusW2q7w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gan Qixin <ganqixin@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 3:16 PM, Peter Maydell wrote:
> On Fri, 6 Nov 2020 at 14:08, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> Can we keep the error please? Maybe 132 is the next display logical
>> limit once we increased the warning from 80 to 100.
>>
>> I understand hardware evolved, we have larger displays with better
>> resolution and can fit more characters in a line.
>> I am a bit wary however functions become heavier (more code into
>> a single function). Maybe this checkpatch change should go with
>> a another one warning when a function has more than 80 lines,
>> excluding comments? (Even 80 is too much for my taste).
> 
> Personally I just don't think checkpatch should be nudging people
> into folding 85-character lines, especially when there are
> multiple very similar lines in a row and only one would get
> folded, eg the prototypes in target/arm/helper.h -- some of
> these just edge beyond 80 characters and I think wrapping them
> is clearly worse for readability. If we don't want people
> sending us "style fix" patches which wrap >80 char lines
> (which I think we do not) then we shouldn't have checkpatch
> complain about them, because if it does then that's what we get.

I think I was not clear. I am not arguing against changing the *length*
limit of a line (although I'd still keep one, as I don't think we want
lines with 500 characters). I'm suggesting an orthogonal change,
restricting the number of lines in a function :)

> 
> thanks
> -- PMM
> 



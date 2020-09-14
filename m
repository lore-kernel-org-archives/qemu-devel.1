Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A81C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D5D217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhYnaKv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D5D217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHj4g-0003x9-NC
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHj40-0002nU-CO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:38:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHj3y-0004PH-PF
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:38:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id l9so10149918wme.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FvVHLh7YFNqB6s28oq9lofBcqQHPOS24jr4ykVIP6bY=;
 b=bhYnaKv30GwzX97l2MXVgneiXYO9De0lHx2/1pXUi+HKvFtGC0V5dB2E5TmbgtpF79
 Bq6TMs74pzkSX0N4JGGEuwHQEwSQaez9057jvD4sxzxvpHHGtgQ7DoKYI8hNp8dJE29l
 oGsciI9kucdExCniuqalri3NE7tcv9ESRdOjHpyW+PNMScumnUWShK7cSN9fqlr6P/Dw
 adYNz65ymsXZRfMF+/HgQwSkSIy6DZ1CxSx7smmsTu5ckzMmqClDCm2DsZ+/I8eUNL1a
 km7nskZ4PpUjAmbEefT54w6tJo7/0jXIvBOVpXW9EXvDWbdNk3ceuUxe2mOGYQGnK+f0
 niqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FvVHLh7YFNqB6s28oq9lofBcqQHPOS24jr4ykVIP6bY=;
 b=BhniwO0ftnVAmRcQN2SFMA4O8fzXRWv6+lthb0tKfnhM/WfqVr0Wa8wWy89dhe/XY+
 G5QM6XcQPPw8W9RKLyXdq1OvqKJwcjtTh5yaWO3RT2TSmCVl03nbumo9qqLVk7K0EWhx
 SKk731s+JlqrKKkwpFYtxjkMAAxOXrBTRonN2hjA3YaK9CVj6VIcHOXqWuKuxadt6cRs
 DyqprRHbdNu0HLA5bMlQ5w03jiUoMUfE+FNx5gFs2bPebddJN/LN+Fh/rombQX2vE956
 Mm88rkYM7fx3Jx0ODWZwe+zG7oMm5zXD3GFosjHiHM7/iXBOOXEbHXtnRx+CHto7qoQf
 jPMQ==
X-Gm-Message-State: AOAM532BBl/CIEFbV/Bmaxh7J92h6//9mRR1m7gk6PJmOhGAc+7gqX+R
 czxEB+rK+fS6oEoP0agw53HqLrkWOKQ=
X-Google-Smtp-Source: ABdhPJyopObD9xLYMRrP3E0boQDjT6KGd1ompzKi4Up0E2lpyeDTQUk+zAkAVQMtVxqUW6jKIH1TyA==
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr14537417wmd.82.1600069088934; 
 Mon, 14 Sep 2020 00:38:08 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q18sm18810602wre.78.2020.09.14.00.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 00:38:07 -0700 (PDT)
Subject: Re: About 'qemu-security' mailing list
To: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <25dc926b-7bc0-930e-109a-1cb3c03565c7@amsat.org>
Date: Mon, 14 Sep 2020 09:38:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 5:51 PM, Peter Maydell wrote:
> On Fri, 11 Sep 2020 at 15:22, P J P <ppandit@redhat.com> wrote:
>> Proposal: (to address above limitations)
>> =========
>>
>> * We set up a new 'qemu-security' mailing list.
>>
>> * QEMU security issues are reported to this new list only.
>>
>> * Representatives from various communities subscribe to this list. (List maybe
>>    moderated in the beginning.)
>>
>> * As QEMU issues come in, participants on the 'qemu-security' list shall
>>    discuss and decide about how to triage them further.
> 
> Way way back, the idea of a qemu-security list was proposed, and
> it was decided against because there wasn't a clear way that
> people could send encrypted mail to the security team if it
> was just a mailing list. So that's why we have the "handful
> of individual contacts" approach. Is that still something people
> care about ?

I don't think so, as I took care to encrypt a bug report and
received the reply unencrypted =) Not sure this is the default
although, as this was my unique experience following the security
process.


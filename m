Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942B4C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057852075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="fIUhBGdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057852075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDeM-00004t-Vf
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1kFDdd-0007c5-Ag
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:40:37 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1kFDda-0005KL-R5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:40:36 -0400
Received: by mail-oi1-x242.google.com with SMTP id d189so13044307oig.12
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x0DpBTBpkMG2MJ2vLiOL6mRffvT7xAVShmNIa7/ahZ0=;
 b=fIUhBGdBo+/FQ3eQztL5h33318oVtP6W4AFA2ehNRuCbHmhHsZIjadJ+3s7gwoS+R6
 mTZW6JzB+A6Yx+SzWdP2SypyXauP0FumQiFC9vGjgr45y7aqdSOrOf1t3AEYwsvFybgC
 zoMLcjxJFwCOcbkbcb5eQ5yne1uFDlXKSc7kZrvc445IBPNV2ZRAvbeOCOQyNgB6ATUk
 jHpUE757NaML6NuFmH4wKvT0oaW9vhuW88OKZBdoRAA+Ts9VhlFrsDxJFzG8NNwMlbZo
 AZs3d3wo/xJrR1A1xmqBby63N9cCLMdrjCxyTZxQO/qu67xvlPW7lXrFGd9Twxq+YXgQ
 iOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x0DpBTBpkMG2MJ2vLiOL6mRffvT7xAVShmNIa7/ahZ0=;
 b=suIA7HnVmmStqcjPWSU0cWXszVeCzHtCMGwuU3l0GErd1+bZZHAvcJ6/4nQbtQPZyB
 xJ1EgwQN5LBU9vxhs3TAj28/Y4+/Hp+jSiKm0buH3zkwYl2Rx7z8zqCz6F/8UEtrS36+
 pqehBBphkC0Ni6iyPzMoQ7S025Fcfvf9ZTaX8YGuxHhv31Pv5wILFU1ebjSj5Xk5LAFN
 RPL5huvSV8FmlvLSKRrg1glPcG/ILjhwuuEY0QzfjmRpe/7BcPV8jMKU2G0fprcadQud
 ijcpfWFylnEcFSfSkFvK1GbVoIzr6uH46LpWwdhvhFKmPmDoQlbTWEwdVOQZZHmUdCux
 Yhag==
X-Gm-Message-State: AOAM530guCMo1FvcZnVW4XmO9qGl2mp7PInHBQOcpRReZccTlZA5jyFj
 RKWFstH7PVHKIRvSJW7PEXJ+tQ==
X-Google-Smtp-Source: ABdhPJy0X1iMy+WtC8C8vDx9MCMrUVs2doXEBDma8TzYP6he/kV9DbtebVwk1JZDVOURTamUv+YlGg==
X-Received: by 2002:aca:5d89:: with SMTP id
 r131mr11378884oib.120.1599471632964; 
 Mon, 07 Sep 2020 02:40:32 -0700 (PDT)
Received: from ?IPv6:2607:fb90:839:54f:e8ff:7fff:fe76:c1b2?
 ([2607:fb90:839:54f:e8ff:7fff:fe76:c1b2])
 by smtp.gmail.com with ESMTPSA id d26sm2728055otl.10.2020.09.07.02.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 02:40:32 -0700 (PDT)
Subject: Re: [RFC PATCH v3 00/34] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <fbb5a85b-6208-1791-0d3e-7e741e674a70@linaro.org>
 <BYAPR02MB48862BC00AD7217B715EBFC7DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Rob Landley <rob@landley.net>
Message-ID: <ac0e68a8-671c-7d6d-f85f-0d25d5775cca@landley.net>
Date: Mon, 7 Sep 2020 04:49:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48862BC00AD7217B715EBFC7DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::242;
 envelope-from=rob@landley.net; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 3:47 PM, Taylor Simpson wrote:
> Richard,
> 
> Thank you so much for the feedback.  I really appreciate it.
> 
> I'll get to work addressing the issues.  Since some of the items will take longer than others, please advise whether it's preferred to send intermediate updates or wait until they are all addressed.
> 
> Taylor

Which branch of https://github.com/quic/qemu do I pull to try this without
scraping 30 patches out of the mailing list?

>>> Once the series is applied, the Hexagon port will pass "make check-tcg".
>>> The series also includes Hexagon-specific tests in tcg/tests/hexagon.
>>>
>>> We have a parallel effort to make the Hexagon Linux toolchain inside a
>> docker
>>> container publically available.
>>
>> Oh, excellent.

Is that a follow-up to https://www.spinics.net/lists/linux-hexagon/msg01706.html
and is this a clang toolchain or a gcc toolchain?

I've noticed gcc 9.2 has hexagon in config.guess and config.sub, but the only
other file outside of the test suite containing the word "hexagon" in a case
insensitive match is the Changelog saying Linas Veptas added it to config.guess
and config.sub in 2011. And while https://github.com/quic has a musl fork it
doesn't have any compiler or linker forks...

Rob


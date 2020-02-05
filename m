Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAD2C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E6F20674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4QBuU6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E6F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHmv-000507-IE
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izHm6-0004RV-AN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izHm5-0004fw-CF
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:19:14 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izHm5-0004Vr-60
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:19:13 -0500
Received: by mail-wm1-x343.google.com with SMTP id s10so1793460wmh.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 02:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cheKAPsPgiaBJIzhq1a63cWBr231jEjpWu3kGAqeVc8=;
 b=s4QBuU6EEzgY6T/cy6w8iECthSNEHJckwyExzoY2T4Ml1v6jtAVrtmM9KkSQjmogbW
 j9xTpwlpqwbiBum7JZfQHMVgwFP/2YN87AS7ABFIt1Wu7w7V+5deA3EbBMiAe2byNX7n
 NerVI9NpgpOWlFk4JZX0do0Lynvd7l0UxOVxxmNUaEN9r8iz3lfyiS2FVecNSlRB8ScD
 QIQDJVcWkhGJVSWoWInn9fW1BuQgpjLydfftGf6Wt543swhuvfZFE6GifQZzI/N6cusM
 ZETv3nPU4oABCynatusWfApmxiRq5ahrwZ9vrugYlaU6wEA7/pYaI8DZAuswOJ80dXyl
 Bx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cheKAPsPgiaBJIzhq1a63cWBr231jEjpWu3kGAqeVc8=;
 b=OduqMt0t+f4PLzroR6LG9fvra0rMT+nMEUsP6YfGA1WMip7MJ+d3NS6l8bMNgiQTKv
 bBG+tjWZ9lPkqyvl8xlf696+cijO+c/wgjMzd+hmYoeKIOl9CjTmicucKFb/Z9PmzWwB
 gPCOUxTL9LIRLKV5pTqJsi+XO+p95bcr5JnftOvnWpbojDSmygD+Wwtl0GRfRZUfG5w3
 DTPMSPsqfVvrB++4RXncFEq/kc5YbzZwFqlmGXokHDD0NtCAGIQLU29kNq0VwBnMPTxs
 UyFh0ww961/RcJqdNM33C6acyvj8Eh0lHzyYzL7xcdP5eJq3WDt3BlT9PDn8K8CLAJiQ
 ZaXQ==
X-Gm-Message-State: APjAAAXRdmPk+NCltPDK8KhBhP/NXgBEiD5zKJsGiDETDGg42vx6twVZ
 wkfBB4Umm3tDX+86pZoXCd57CQ==
X-Google-Smtp-Source: APXvYqzS6N41oLXqSKUb5BITACNMA0uXEY14OATW2UonILjtqc6AtJciBlYwL9VTjxd0Ief1Dy5WAg==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr4850483wmi.58.1580897950601; 
 Wed, 05 Feb 2020 02:19:10 -0800 (PST)
Received: from [172.27.246.193] ([212.187.182.166])
 by smtp.gmail.com with ESMTPSA id g18sm7273906wmh.48.2020.02.05.02.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 02:19:09 -0800 (PST)
Subject: Re: [PATCH v5 20/22] tests/tcg/aarch64: add test-sve-ioctl
 guest-debug test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-21-alex.bennee@linaro.org>
 <2731815f-9a72-390b-0a8e-73b77c4b62b6@linaro.org> <87lfpi81sn.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a361a310-f6f8-9c17-6846-64e9f0b189f2@linaro.org>
Date: Wed, 5 Feb 2020 10:19:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87lfpi81sn.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 9:45 PM, Alex Bennée wrote:
>> Also, ZCR_EL1 it itself not correct if the
>> hardware does not support all vector sizes.
>>
>> See some of Andrew Jones' qemu command-line work.  Try -cpu max,sve512=on and
>> then use the ioctl to set vq to 3 (sve384).  The result will be an effective vq
>> of 2 (sve256).
>>
>> We *really* need vg, as computed from sve_zcr_len_for_el().
> 
> How come TARGET_PR_SVE_GET_VL is happy to compute directly from ZCR
> then?

Bug.  It didn't get updated with Andrew's changes to limit the set of supported
sve lengths.

> I'll put the vg back in but it seemed a little pointless given the
> gdbstub ignores it.

I'll say again that this is a gdb bug and we should simply report/fix it
upstream.  Don't try to work around it in qemu.


r~


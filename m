Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9999C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7919621556
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jz3H4yzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7919621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nsZ-0007S6-Mo
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8nrX-0006h0-FN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8nrW-0005pX-Ep
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:24:11 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8nrW-0005o7-6X
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:24:10 -0500
Received: by mail-pj1-x1043.google.com with SMTP id l8so27748pjy.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 08:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f8AKfAHHGMpYmAG6DRQLoSeEzgdkqBERrzsCEzwD3ks=;
 b=jz3H4yzK+o0uU+Flvzdus3+Rr8MVLgkHxe66nr2gGz8+835SHGJctMQh6ykXkS4eRO
 j54jgKf7iwzDSrvQMxFoHH2J6wBKpcfJmpRxtxVpKFcYiVk8/rkFvtXykABQSU8MnSWh
 lJBO7r/nfKl2xi+YfRUOztXhal116pLHz0cxYs+QX2weI18R3B4dlOZ+rIu6bqRkCFZZ
 TDSUgRvD7uNPQQAKjoZDtd5gnqQBZLtd4rxqLc7K4SvipTlS5wH2wo26p92zgHedKH+X
 V+AeCM+rE98Y+yHOv56bP+I+a/nIKxWoMDO0OI0VjjCjKuG1QH7rViPUIBeeJlUbS8yZ
 COZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f8AKfAHHGMpYmAG6DRQLoSeEzgdkqBERrzsCEzwD3ks=;
 b=bi1gAH+PSJ0zLIra8oapyb6dKMnBvI6cMI1PWVBB5egto+Gr647TfNErVPo+oDjzD1
 QLFcdonZjgSQ4XMA1qp674Vgds/Tgun+yGgnzQgBQAnXThEhF+64fczWrJM2fqVfbRsL
 9yWlkqgHjeQKtMXnUSwFhRniM8wxAXlkqMSnlbRlJE7G6TSMsYRReYWgLlMCD8xkkg8s
 Ap7WOu79RCOTF2GRyBmXF6CMRjvvwmPUW7xDUgg5ZZJQN4gs7CEIH/iRXR+VHArprVpC
 koQCO5aSmsGeuQ/QECHj34aiG++79Htghbf4EIqbr1QVBDuD+PCxFS/Oj9NVoWhKufU8
 qvSg==
X-Gm-Message-State: ANhLgQ3gNVzspz63o2mCfA7i4+DlclOLD2m54TMtMHajlEURzY7WM3X2
 om7NxiFgerzaetCCZkUOr58YhA==
X-Google-Smtp-Source: ADFU+vtHCQnnvycms/VulyzM0pBXkuw6Wnl2HkN5sDgEZuUnExeWHukszB+2kiMCTq3swBIlTeCLzw==
X-Received: by 2002:a17:902:6b48:: with SMTP id g8mr12895plt.149.1583166248362; 
 Mon, 02 Mar 2020 08:24:08 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d14sm92154pjz.12.2020.03.02.08.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 08:24:07 -0800 (PST)
Subject: Re: [PATCH 2/8] target/arm: Optimize cpu_mmu_index
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200225031222.15434-1-richard.henderson@linaro.org>
 <20200225031414.15649-1-richard.henderson@linaro.org>
 <CAFEAcA_S9SPLoC9E6naZi9pkfxzz=UTvUss=H4jDff4tgdToAQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4674d1cc-e6f1-fcf1-3fc7-6d275bb5b477@linaro.org>
Date: Mon, 2 Mar 2020 08:24:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_S9SPLoC9E6naZi9pkfxzz=UTvUss=H4jDff4tgdToAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 4:03 AM, Peter Maydell wrote:
> On Tue, 25 Feb 2020 at 03:14, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We now cache the core mmu_idx in env->hflags.  Rather than recompute
>> from scratch, extract the field.  All of the uses of cpu_mmu_index
>> within target/arm are within helpers where env->hflags is stable.
> 
> Do you mean "within helpers, and env->hflags is always stable in
> a helper", or "within helpers, and env->hflags is stable for the
> particular set of helpers where we use cpu_mmu_index, though it might
> not be in other helpers" ?

The former.

With the caveat that it's pretty clear when a helper is doing things that make
it the exception to that rule.  E.g. helper_exception_return, which itself
invokes rebuild_hflags.


r~


Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1AC4BA21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C9521556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZqWSQ679"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C9521556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j732n-0007LR-U3
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 15:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jimw@sifive.com>) id 1j72zl-0004VO-Ae
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1j72zk-0003Rl-AA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:09:25 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1j72zk-0003Lx-2a
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:09:24 -0500
Received: by mail-pf1-x441.google.com with SMTP id i13so172518pfe.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yyJNMLyrTyG3x116AuLrSuDe5q6fImd01Q5NIv53YPk=;
 b=ZqWSQ679yOiFiKrnknXVFrf33Pg/TulmzRwAvD6lmC1AT2rXyCo/1dOF9bZ+KSKmHe
 BAiS89w6dVuQjI9jwM4ajmzMOXIgSzX9OEHu+4feZDJDYLSUdktqsoIzLg7Yg+Mvnj8V
 Hun4LWLJZn0ab2Eh4CuPfAiDsiGVCHhgDnoX8X5CFQ5s9GOWRq5EqRSBR1LbCvx5LLF3
 aa6rBuRq+ZJR4ocRkSCGQxIKF+qI94BK1M9kXrPYJE4+HP27TZLZJACI1ie2Bbp9pgo7
 JI1+SQ8kXrOvFPTh/uooc7G04QZoNxPVd9ZrujF8q3LRthdBkccA52fb2NKiEEpawMce
 f2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yyJNMLyrTyG3x116AuLrSuDe5q6fImd01Q5NIv53YPk=;
 b=jOkB44tyg7qdjXK1o5GouTK2pKouNH2ic0ms4IDYoKFsJ9Rr889tuUAkkuAPKhdD34
 HcZhviMRQjY4xDpnp8Bzna2CFOCmjUbtIwm4tZMzjc3C7InrTf5jI8tHZlAWj5mOLg9c
 Xv56c7ZjAH5OcqQu+7jjS+jZM9ZJpYEhGY0XTJWcono2v1kjADUJZSiN2GJJk0mrg+lg
 sb4/qPSg5fyvMh6kAmzfRaoV3cceEQdIUxlJCcrTSW8TCBb5mJdTs1Eos7CEM2bcuRiu
 6DaBI5EHqGGAD7UNATfruesQyOPrQcFYniKzgk+ZlRykctshTmXtcjgKtmcvXVbXWu22
 7a4Q==
X-Gm-Message-State: APjAAAVf2YkLY4vYtNI82KsQsorcasi0UGxH2h089GpMJu1YltaXL3tf
 hmGgHruo8cZjU4P6fgRThsKuAw==
X-Google-Smtp-Source: APXvYqwr4VOX3K3N87ePFT3LjDqtMkDqMtqA4FcnFkePcG6ossUeRtmCjH8TfSDQWq8NSHKFrUyC0Q==
X-Received: by 2002:a63:2b93:: with SMTP id r141mr511283pgr.306.1582747762481; 
 Wed, 26 Feb 2020 12:09:22 -0800 (PST)
Received: from [10.17.0.226] ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id dw10sm3594375pjb.11.2020.02.26.12.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 12:09:22 -0800 (PST)
Subject: Re: [PATCH v5 0/4] target-riscv: support vector extension part 1
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, richard.henderson@linaro.org,
 alistair23@gmail.com, chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
From: Jim Wilson <jimw@sifive.com>
Message-ID: <ac290e38-bb39-6551-0758-95d087fa568c@sifive.com>
Date: Wed, 26 Feb 2020 12:09:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 1:45 AM, LIU Zhiwei wrote:
> This is the first part of v5 patchset. The changelog of v5 is only coverd
> the part1.
> 
> Features:
>    * support specification riscv-v-spec-0.7.1.

I'm still concerned about versioning issues.  This implements an 
unofficial draft of the proposed RISC-V vector extension.  This draft is 
not compatible with the current draft, and will be even less compatible 
with the final official version of the vector spec.

The patch adds a version which is good, but there is only one check when 
qemu starts.  Probably something like 25% of these patches will be wrong 
for the official vector extension.  How are we going to handle this when 
someone submits patches for the official support?  It would be better if 
everything in these patches were conditional on the version number.  It 
might also be better if we stopped calling this the 'v' extension and 
maybe used another name like Xrvv071 to make it clear that it is an 
unofficial draft of the proposed vector spec.  Or maybe be we can use 
v0p7 but that isn't an officially supported extension name.

If this rvv 0.7.1 implementation is considered a temporary solution, 
maybe we can just remove all of this work when the official rvv spec if 
available?  But presumably it is better if we can have both this 
implementation and the official one, which means everything needs to be 
conditional or tied to an Xsomething extension name instead of the V 
extension name.

Jim


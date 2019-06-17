Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82AEC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D56620644
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dC4garua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D56620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51870 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcyVP-0001dF-TF
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 16:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39669)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcyTk-0000Xv-Br
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcyTi-0006WI-Eo
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:43:48 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcyTi-0006V1-9D
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:43:46 -0400
Received: by mail-pl1-x642.google.com with SMTP id e5so4609844pls.13
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=brmCa9gmGYna31TvYbg3RScHU2eVYIZzpnsF8XcjOXA=;
 b=dC4garua5J+aewdL7ZhRBpy7AWoJnDfbZhDgivsus6T5Hxf8QqUTPvg+ShS+BVTWDM
 HPZMipuka3Z1Cx1TbJplSZB7wY4Tw0Gs7zhfnScEKQ3RWKEYB18DNd/EuxbVBlJfqJ3U
 SnMV2yWW9Tv/X2xBzmabECQedGtUB8CkSfsH8lrAFQdez/rWa8Noo2ExIR3QXyPu/Kd/
 FXRZcVDA3+Z4StA0kBesW1SH3jtaNpLOeQ3nFlxd22aODivDpp4KHFPkRdo1SITSoDEo
 nejltD+dVbxJKZ0DN7UX57dqOSfT2LR1mDYj6EV1R9GA/W9eZfboRMd1gpdJe/mCpDbu
 q8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=brmCa9gmGYna31TvYbg3RScHU2eVYIZzpnsF8XcjOXA=;
 b=n/qarch4LiSRSLWv+zRQ2VDNp5UB3egrStIOu+JrT7+KcCf8tcjshz+qKZ9oNBoEut
 UKw9U3YLMZBYGhYds0jsMseg/b6nK+ioE8UcMBQvWCytkUKh1o6cLkUn5wJj+kfionEm
 ls5zlO+b/dqQWIfxiOinYuPB52KjrHFw+dJbSk00AlUeE/oErotv4orUJmYXj9i9JCBX
 PUaFEfvRyYAympx0z8H9R5ghPoWMCmeOlefCKa9XBgqe5UngkeAsGbw5xqWVbb3WafU1
 6O0XNmYOcQldsvUp9oYZQ9nDMAZ9CdEhx4gHZu+kdb9Y31fH5mzJwpmDWVPVQJgrLCEV
 oPFA==
X-Gm-Message-State: APjAAAX/S883ixj/Df6exrum8GG3RFJWiWAUmB33eqLvn3XYh254uCcl
 0J1cHvPmcHpTb8JvM8bl05ioLg==
X-Google-Smtp-Source: APXvYqxnLBFw1qXFZ0Dg9EXeSnEpF07NtxhnHpwVkWjbDjajOl5Lor1Yo1JIc8hkrz0lfcnAa3GqPw==
X-Received: by 2002:a17:902:7581:: with SMTP id
 j1mr109370131pll.23.1560804224061; 
 Mon, 17 Jun 2019 13:43:44 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id j14sm12682789pfe.10.2019.06.17.13.43.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 13:43:43 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9a0b3e0e-3e75-54ff-ace5-af4feac09ff9@linaro.org>
Date: Mon, 17 Jun 2019 13:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v3 16/50] atomic_template: fix indentation
 in GEN_ATOMIC_HELPER
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/atomic_template.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


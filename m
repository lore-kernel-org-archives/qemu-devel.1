Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE35C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9CA21532
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXIfl0JH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9CA21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmMf9-0004hi-PY
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmMeQ-0004AL-53
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:26:10 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmMeO-0002io-6v
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:26:09 -0400
Received: by mail-pl1-x644.google.com with SMTP id j4so4299406plk.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TJlps8KoSmjaLf7uOiyh88B4yeRZgq7XCqlG0Om+4HM=;
 b=GXIfl0JHnGc2oYD5fIwZFaqgNmBG0iKsIBIMECayK4Tp2ke1rO+DKwYweGhT6Vax9g
 Vv+wMp2cDit5VK/f6DbS0MqZCidRpJV8uuRJV9jDRo7JyhWM1sQ37xBXPDx4DTliVDxg
 NedcAL7ZNOKPlFiMI7rLRJD2cGz7R5Vd/VfK3otnn1o10QeQiV1zKde5+/Ynxb9vx3zB
 yRSbB6s7hghK3+2uKP5zN2WvlmVxNax18VGUZITus3rxaV5uxIy3C5d1gnueVmwDPMCZ
 TZCB8G6dPjnly+KbEZL46s5M7wIGmfg2I87kxt7xQvY1HPVJa7sBSII+O1k9yCp1MsTf
 O43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TJlps8KoSmjaLf7uOiyh88B4yeRZgq7XCqlG0Om+4HM=;
 b=M5QYGHwYIhL84HNcMASXjy1aEekFjZv47oyQr+LAS+B8xsph33As49fepLJj1LQu3b
 cv18aZMOi857THNvV8oCjTv7WUdYiWzLJXXd5qhJyuSluvwU/OYuSnEtFZcvWaZ3ghro
 lorYi2J+P+xB7tyP2ZrGBMA7HBr0WGgKNrNizeh7/YOI8hLH42OMw1SELz/xpzkS5/qw
 RAn3Rz5EvU6xiFsoJI0jCRMSeOnloxuHRG2nPe0ibezDk4Axumw1J+dqKBMB8lZAgXxI
 ENVsesMj5bGZXOu1lzq4IgHJqgnE76cqtuARvtx4xA7Ej82jrpfGGg9XCAkdGlz2aBIJ
 QJDA==
X-Gm-Message-State: AOAM532aoN/iTGoGNNRIW+bjB4OY2+W2rG9PILZH1eAkdpRyYotF/QWs
 DiVf9BCJye+g4HV9EslB8v1n6A==
X-Google-Smtp-Source: ABdhPJy0fAYC94KFy9xX0XJE9YFQVtn38eE1lA9H2uSYwd8ure66lD9JBkoHBcbEd6Wn2I+NL+xnQw==
X-Received: by 2002:a17:902:968b:: with SMTP id
 n11mr9140381plp.331.1592594766507; 
 Fri, 19 Jun 2020 12:26:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 84sm5901012pfu.167.2020.06.19.12.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 12:26:05 -0700 (PDT)
Subject: Re: [PATCH v7 28/42] target/arm: Use mte_checkN for sve unpredicated
 loads
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-29-richard.henderson@linaro.org>
 <CAFEAcA8ZYhqbO-A=FkVzgKkcTm1tVVZSB0C9HOFAnYG7jaFPpA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e2ad7bf4-7972-5640-244f-e25ef29c6ec7@linaro.org>
Date: Fri, 19 Jun 2020 12:26:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ZYhqbO-A=FkVzgKkcTm1tVVZSB0C9HOFAnYG7jaFPpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 6:58 AM, Peter Maydell wrote:
> On Wed, 3 Jun 2020 at 02:13, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Commit message suggests we should be just adding an MTE check
> but patch contents appear to be moving insn implementation from
> inline codegen to a helper function? If you want to do that
> it would probably be easier to review done separately from
> adding the MTE check.

I don't recall why I did that.  I've made a more minimal change for both of these.


r~


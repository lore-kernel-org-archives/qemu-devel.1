Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F71C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 04:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5772074A
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 04:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPyqbEfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5772074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZoCY-0003Xu-BM
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 00:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZoBo-0002kr-IE
 for qemu-devel@nongnu.org; Sat, 16 May 2020 00:12:44 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZoBl-000341-Tt
 for qemu-devel@nongnu.org; Sat, 16 May 2020 00:12:44 -0400
Received: by mail-pl1-x641.google.com with SMTP id k22so1738824pls.10
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 21:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZDKRidBIC85qhIE/mm8bhXDBJw4FDy1it2kQO0M3tLU=;
 b=rPyqbEfxzphncRuD58gLnYXZrshpk5d5NAKlcfjktRCfrPie+KzCYs6iIEXWaxym7b
 4xFmyv+FUkqbNI+LgqAsUvOxKmYC4NjxTrS+18tKEs0LGWxtF2xH85XpnnG+9IEQ0AXo
 z4uMs8q51o8ixucIpsgEsdNNBRmhad+yoPsr4XEUUJ0pIEShhg5HV1Zeb5Y09dj1guVR
 KvRNh8ljovte0nQAZrv33+JZFK/AimPKbYOpzwg+OTKZPBfSL9DqA4f1JnZZRMJ0pdUx
 lK5bdQmI9WJU4uk4RlcUqdtfjRzEpsORL+LT/YhtNFu6FtUKARxC7eY5WGTDfJuXc65p
 /S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZDKRidBIC85qhIE/mm8bhXDBJw4FDy1it2kQO0M3tLU=;
 b=c41RlWMhai6t51zS+WCaBCuh+Di5RJUwRo35jUQtbFTvc5lRoYAcTLsxomAvCTczqq
 ammBOvXuoO5xOi+p0+SzRlKaRMdC+4lr01/iisJXvGA7tguzrUQzCajVUfoJvvCb1dhR
 R/rmLgm/tAkTBxRlcaDqHdvaV8ATJY1ycYvwZb+WK+qVSX7iZZQukiMGhkWlR5Z3Zc5P
 d/PlFmAHM/t1bk/vTm9gFb9eKSUGAF+20ZHp4Vz75lHIZEH/ssdwQsx6n1vXstBoctuw
 jJYPTFiiQzAo9x0dnevVyAkM5+BJmGVj6F0EqdtcoA8f3IsQ+zkj/wRP+JU11Z52rUxH
 adRQ==
X-Gm-Message-State: AOAM5312Q8lLCtQC3yIzKOjLlfqjMzG+f7r/voFvzzYoeNrFKwdZIEmC
 /VCrQpNI7jBbxs7TXw9AYMjEmw==
X-Google-Smtp-Source: ABdhPJywXK8WV7Xe0acmFavEOud9EpZKYOSDTmjL+YZ/G1uqdzyUvC6/jjqRGmu0mx/EnGJj4VAO4w==
X-Received: by 2002:a17:902:6f0f:: with SMTP id
 w15mr5734373plk.191.1589602360109; 
 Fri, 15 May 2020 21:12:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l6sm3121033pfl.128.2020.05.15.21.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 21:12:39 -0700 (PDT)
Subject: Re: [PATCH] linux-user/arm: Reset CPSR_E when entering a signal
 handler
To: Peter Maydell <peter.maydell@linaro.org>,
 Amanieu d'Antras <amanieu@gmail.com>
References: <20200507202429.1643202-1-amanieu@gmail.com>
 <CAFEAcA-n8-pOcwovsS1Z3T4AMa1Nueo2yik9zX5H16QAHeE05A@mail.gmail.com>
 <CA+y5pbSueV8HQKQEZnBS4DvOvMDXUY7HMaODNhY7v-fKkJJPYw@mail.gmail.com>
 <CAFEAcA8etD+V3KrCFwvqfDuZ0x4_cW-RN423WG13iVpJBRvq4g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <47fd7f16-a7ed-e3ee-9a97-b2b21f43e7b7@linaro.org>
Date: Fri, 15 May 2020 21:12:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8etD+V3KrCFwvqfDuZ0x4_cW-RN423WG13iVpJBRvq4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 2:25 PM, Peter Maydell wrote:
>> You also need to call arm_rebuild_hflags() after modifying CPSR_E
>> otherwise the change doesn't take effect.
> 
> Hmm. I was expecting cpsr_write() to take care of that if we
> updated a cpsr flag that was in the hflags, but it looks like
> the rebuild_hflags() is in the HELPER() wrapper but not in
> cpsr_write() itself. Richard, does anything go wrong if
> cpsr_write() proper does the hflags rebuild ?

We wind up rebuilding hflags multiple times, is all.

Most of the time we call cpsr_write we also do something else that also
requires a rebuild.  So we do it once after all updates.

We could probably rearrange code such that the cpsr_write is last, and then
sink the rebuild.  But I don't know if that's clearer, hiding the side effect.


r~


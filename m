Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB67BC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B86120760
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7HtZAQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B86120760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kElMz-0003vh-Ta
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 23:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElMQ-0003VM-CJ
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:28:58 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElMO-0001q5-HV
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:28:57 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a9so1809738pjg.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 20:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GM5GxuSwUXd4HA9aQks/8/UeKS6woBVL1eS7wfsmIWM=;
 b=f7HtZAQcyaaTCx+ImybAFQ9RBgltHzPk38+AFwF98daRVUifWxxgiYiDvyVvQOL4tx
 Ze8LSE9ueAF0dUb2vcVS9zaGJHbjlvWL2q3p9iieXQ5I4l/Nr6IY65BUL/hrgk45JH4d
 8RD9iZsOusfVOjLayLZC5jVddxYvGowUclB4DH14ugCHaXtNzo6y36BWWBSk43otZHdH
 VUyzXugKFpSITeEB8oIkM6OavXHzOybWhzDa7AJWvgMZfXZtHmGb6ol2fepl7YW8BvfF
 DgKNsZ7lDICzeyaRC/fyfZiufYHIoDnZtGTWaa2hpjjP+lBATaQ2J+tFeNqxB37mAtbd
 xIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GM5GxuSwUXd4HA9aQks/8/UeKS6woBVL1eS7wfsmIWM=;
 b=qDfMADTcGYJgBz/4zeQoHhABzX5z35dwu3Lm6+HjVPH6VUd6hC736XpDzbILpXBSYN
 A0quHmsOJPJx06bGR1VBF1LzxHy+pgp128VDDRcXF5Nf/FxrnMKpT2jycEMCiodI5PoK
 H9f6bqJlg8BqNydo1ylf/Q+pBuG5C/hU9GsZNt1RlGkLsuBRq96hSPw3XL7IB/iG7wZh
 bALHNI1nWAe+uVAWo5DYpRoMBfkvfNLP1BFkE4LHst5vRogZli7Z/ZjIoWgVoxPzawlz
 kT6cZcZHgIicY6QN8kP+Vp5vCXRZTxhrCe9cjznuzD886qDYvwC3UvylolPTya1pfb3H
 4fqQ==
X-Gm-Message-State: AOAM533SrUEOAstZHcq3wrjWLrTjtRMJ6+A912eYfc9X8BKktdRG4GqN
 LeUk4HtwVboBrSd+zhY15uBBIg==
X-Google-Smtp-Source: ABdhPJzbNXn0BbvWZI4BApDqvOQeV6HkVyH8xoXxZ9SNfF04+m5nJWNyHUoAi9nI3XbGMy85quEqWw==
X-Received: by 2002:a17:902:8c90:: with SMTP id
 t16mr14045931plo.55.1599362935029; 
 Sat, 05 Sep 2020 20:28:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b203sm10588738pfb.205.2020.09.05.20.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 20:28:54 -0700 (PDT)
Subject: Re: [PATCH] configure: Fixes ncursesw detection under msys2/mingw and
 enable curses
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200905204236.1508-1-luoyonggang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b40c03d0-99bc-eb94-200f-7cf9a7734797@linaro.org>
Date: Sat, 5 Sep 2020 20:28:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200905204236.1508-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/5/20 1:42 PM, Yonggang Luo wrote:
> +    nativecharset_to_ucs2 = iconv_open("UCS-2", g_get_codeset());

g_get_codeset():
"a newly allocated string containing the name of the character set. This string
must be freed with g_free()."

You need to plug the memory leak.

It's probably worth fixing the mistake in which we call this function four
times from the same function.


r~


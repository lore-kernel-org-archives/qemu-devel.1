Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69141C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355732171F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RR16TQZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355732171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyCVj-0008SW-DO
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 05:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hyCTi-0006JG-2S
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hyCTh-0001qW-3M
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:55:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hyCTg-0001n4-SQ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:55:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id z23so792061wmf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZW2T1vmf8XKEUsqHbxNytDwjB69u6YNytrlyj5m+Qng=;
 b=RR16TQZEYotiWj2F6/n7eq7LrINLpFKtUNgRzsO5SLxlq/h3TwK83RaS9AZYMcezGA
 9Hj4cYPWZ2aMnEABSdMC3l7TfGjn4IwcIvNBjRwZyDEJW6vR6iCzuwK/VVVTpCG+Ia7t
 aboxYtqgxtefui/3AWMtYQ6cyWds+6OjMMga0+m5sCfJ6Z8hgTWCMtVX6rzURALWoTQd
 Qc6PCf1usicG5n3/NLr8NZuxuXK1Wuayx4OsmQxNoYNmy9GCxbVgZZTmC6XxmCHma15H
 SDcLi/YXHMarrRfiOuSmipusuW1s0kMO7ATYviGjfmRILSNaF44lzKD8He/4KMx/nW4J
 77ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZW2T1vmf8XKEUsqHbxNytDwjB69u6YNytrlyj5m+Qng=;
 b=BU59FFN8v34jIHkj3ySmWjDl31kLrJR8XIMuY6d947vUNfsSdtSOMUX29wB77i/SfN
 uWqESBbSJOwd8chBPWu+o1qYXzoziejwybmEIhihgtpaXpLVPLNzWXwssKKNFrq/hbrb
 PeDifqsgzgKd8ri00pFzP2nlIFU7i++UolWaq/XVwAiFapDuIfpP7/4iqdc0yb+Ojzbe
 8j0dSBPBLV3adSHhBlyBLvnQ0vSPb3AWRZMzEDgkFMP1O+eu2K6U/iGiYCThunY8vNUU
 l+mpQaXx9oWk7XOuchNlKLo5iJZjsFN5dZX5AvgbwVTNyQ52w9aOf25x0xEqn38eYkPS
 OJhg==
X-Gm-Message-State: APjAAAXFjwVpycotQiyupV67Sz+k746kYRoQ/+wnWU9dy2HZP5GzuUzs
 bM1I3uMHssjSNFj4MCzlNEu+5XTpl3xjTQ==
X-Google-Smtp-Source: APXvYqzalFxOhkywKIPbY74hFJ4eyr1uLQ5LYCukDNneeOtdeUsdoYbPImYezNmpdK3uGdLiiJmjBQ==
X-Received: by 2002:a1c:c584:: with SMTP id v126mr1964980wmf.27.1565862926426; 
 Thu, 15 Aug 2019 02:55:26 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id 6sm1007886wmf.23.2019.08.15.02.55.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Aug 2019 02:55:25 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Jan Bobek <jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-47-jan.bobek@gmail.com>
 <CAL1e-=gZF1+=Gduqm4TwS0p-G6rvb4q+rw+hL9nzAz3P-r3+BQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9240f24b-3f3c-531c-5c7d-06f359c26fd1@linaro.org>
Date: Thu, 15 Aug 2019 10:49:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gZF1+=Gduqm4TwS0p-G6rvb4q+rw+hL9nzAz3P-r3+BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [RFC PATCH v3 46/46] target/i386: introduce SSE3
 instructions to sse-opcode.inc.h
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/15/19 8:02 AM, Aleksandar Markovic wrote:
> A question for you: What about FISTTP, MONITOR, MWAIT, that belong to SSE3, but
> are not mentioned in this patch?
> 

They are also not vector instructions, which is the subject of this patch set.


r~


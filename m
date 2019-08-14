Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13719C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 09:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D358620578
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 09:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cyy39J04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D358620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxpoO-0008Al-U2
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 05:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hxpnW-0007JX-9J
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 05:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxpnV-0003PY-2E
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 05:42:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxpnU-0003Oz-Sc
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 05:42:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so3854134wmj.5
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=10KoO6qmVYt6TVIo10maoPOMop1aTRf3LCg9dYo0J3k=;
 b=Cyy39J04zWsx59JSabnBaWrm2CVXvoQ5n9WACQPnSuGr4f/jXQuIgNP4fQroPMP8S1
 wGYo29nwG+BqYeKruJz1Of9MGtGQYxs/Bh8sajLm14WKoKUK4yhx4IchEGmNLRsrH6Ev
 3u2fovZH6k9K79EkE4gF72S10IsLqUTsN9U1qbGLV00282dCA53X8rbamHuiNnpIMckA
 X2WEJrrcaxyrJP27iszoLoeJzLVk7xiRQrZD3j1lHIGHCizTk3KSPFWLyYNenfKUPzSO
 rnJ6CESZBx1tfIPlqlj9xKhjYNJc4hKBxi3lWmRsabb8/632ULpDRDPSgZwegwPAhQ8E
 AOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=10KoO6qmVYt6TVIo10maoPOMop1aTRf3LCg9dYo0J3k=;
 b=I4KYAZJGTXfhDOnQp8QQmYAkziT70d1VLYAyatejSObl9WCkwQ0gM2GS6ikYVJOMcM
 NUv5i6gSmly3vRL5l+udTqpRX0fjsQX9NixjoZnEpJcxXbMvdrNg1vzJzDIFi8yXghOI
 kJqLiEQdu4ZI4cR+ZmzzVdNs6Wk6siKAPz+jreut7pSmMIaBmzvqphZuJ8e7ueiT04/v
 0Y1p4J2eIza9iFPxsLBPyuojdcEbHnUX9tNCPI74iGVUAaCUdjb1zYhpo00J+rZzxpWV
 dSfJh2+yaRJPVMHVGyD32+rvovMFf2q/eIH7ntUSiyUcu2Ql0iSK98Dh8oscyR3I51i4
 hKgg==
X-Gm-Message-State: APjAAAUUSsK41bHEG/B37F+ZKRkYy8nZuWSVTEk+eU3/ebghA22Hgg91
 7cckoOgQem/4wN2rUvBkjD+igjLpSakRgQ==
X-Google-Smtp-Source: APXvYqyJtDNkEwQ15dzvS2citzsqbljRR9hR5kz2UEiqxz01mIg+oSjQAqRUoxj0lJf7yOmhh8Al/Q==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr7761561wml.175.1565775743268; 
 Wed, 14 Aug 2019 02:42:23 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id u186sm7410172wmu.26.2019.08.14.02.42.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 02:42:22 -0700 (PDT)
To: "Paul A. Clarke" <pc@us.ibm.com>, david@gibson.dropbear.id.au
References: <1565710319-1026-1-git-send-email-pc@us.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <92c05982-9c2a-a5dc-3f26-84cd9a61d4aa@linaro.org>
Date: Wed, 14 Aug 2019 10:42:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565710319-1026-1-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] ppc: Add support for 'mffsl' instruction
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 4:31 PM, Paul A. Clarke wrote:
> +        TCGv_i64 mask = tcg_const_i64(FP_MODE | FP_STATUS | FP_ENABLES);
> +        tcg_gen_and_i64(t0, t0, mask);

Better as

  tcg_gen_andi_i64(t0, t0, FP_MODE | FP_STATUS | FP_ENABLES);

You failed to free the temporary that you allocated here.


r~


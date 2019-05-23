Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D08C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E423520862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZiFYd8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E423520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41759 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTsd7-0002as-7Z
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 14:39:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTsc2-00021S-1R
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTsc1-0000bA-5y
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:38:46 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:43104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTsc0-0000aE-T2
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:38:45 -0400
Received: by mail-yb1-xb42.google.com with SMTP id n145so2640156ybg.10
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=CqxdqTThfh1zZg49Kg9lAhNIaoJtbScxLDJtvMI2oDs=;
	b=uZiFYd8bbqcAVDecSuWx/JGRhn0JoP4a8J/d3el4/BiXbDYjsXX45k2l3vwPp4ABsZ
	FIzVZG8VBvw7757gzwSPVGll2rwvxaoCBX9aG/EwJeWQO56J8MpjGOS4Ua8Hnz3MvjjR
	wR3lVDTo2OsHFNLUJtBOVUGrLfWzO3PwnD172tHelCE5o2etenPpF9ACE/gBW+ZQMQUv
	vsy7eX+dVJDtDqpAwnCVrky48404qMwxzUV/+IBA02DWNLr3/n5MFQ9U6hwPKn2XfJj2
	nL3D+EW5g3+kTS9vdT38gceBk2qAShiVDqw/psd7Tg6w+dPYqDs1/w7nX7F26IaPKEQg
	2Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=CqxdqTThfh1zZg49Kg9lAhNIaoJtbScxLDJtvMI2oDs=;
	b=oqlGwkH9HJSbg1n4+uN6QhVKnDdapX5NSt1vhXqL4T6oYGD+oMxLAnlKXcXZNN2Nzc
	sHHZdSbgYmy1bYrWp1R8q6pn1jLmcE6zA/TFUA7mgjjeVlzar03Hw7ohsvGsSrlyWiMp
	PbhstRftKtCiM6s5hTfjkMjOjh6bdZO/k5eupsHl9Rcv0dJCueK0igo1cL0wRqVyZFjl
	CiiH4CdOnsfKlY89t9Vn09wfT8+UcAZBdpkx1Ww/Zr+9nseHqhbqluoj4IGwKsupGIKe
	lCnTwfcN4FVB7YVPgM7EOZXwSdTccQfaeIEiYJ/wyeUGg4Z+48i4/i3Sam/GVLp+OkID
	SjuA==
X-Gm-Message-State: APjAAAVOmHaySjmvqToDff9NT6pXh41txTHtzKLKY84ilqhhA1hWN/Ap
	4VMLS0zNh+tstqVT2cSZXN1XyQ==
X-Google-Smtp-Source: APXvYqy/ickebNu453q8nfzwXFAVzv9kFdbsRsV0WKAFJZd92n3w20bQV73Q2oFVWuJatO2zPS1uww==
X-Received: by 2002:a25:7056:: with SMTP id l83mr16506816ybc.426.1558636723927;
	Thu, 23 May 2019 11:38:43 -0700 (PDT)
Received: from [10.241.6.101] ([71.46.56.12])
	by smtp.gmail.com with ESMTPSA id m10sm10515ywm.80.2019.05.23.11.38.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 11:38:43 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523143508.25387-1-armbru@redhat.com>
	<20190523143508.25387-2-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0b1f943b-b8c6-5b1d-7a40-bc1db86d8ccf@linaro.org>
Date: Thu, 23 May 2019 14:38:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523143508.25387-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: Re: [Qemu-devel] [PATCH 1/4] qemu-common: Move tcg_enabled() etc.
 to sysemu/tcg.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 10:35 AM, Markus Armbruster wrote:
> Other accelerators have their own headers: sysemu/hax.h, sysemu/hvf.h,
> sysemu/kvm.h, sysemu/whpx.h.  Only tcg_enabled() & friends sit in
> qemu-common.h.  This necessitates inclusion of qemu-common.h into
> headers, which is against the rules spelled out in qemu-common.h's
> file comment.
> 
> Move tcg_enabled() & friends into their own header sysemu/tcg.h, and
> adjust #include directives.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


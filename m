Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DFDC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092C32183E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+JZJz3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092C32183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ0K8-0008S9-5q
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:39:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ0Ir-0007od-Fi
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ0Io-0000NH-7t
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:38:00 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ0In-000081-81
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:37:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id y3so8018907pgk.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=tEsIe7HDtrY1NvdfIxb87cYDh78a1WRGzfUfpaZLye0=;
	b=Q+JZJz3SN9V/++sd4Ob5NtvFtqF9Lfm0ALTY0XKZfaUQaAx/6wSlh8hHCssPQAX1BV
	kbmSz3n09JFpNlPicpsO6mUfJnMIjkbyf0ob4ZP8nJ6VBmS+8RCZq/6ZmF0Bq7egZdGF
	uLbWFTvxwhN2iBuzqIzYwRT028JGJfWFPKehxWov7RtOpUTtcv6f8t8TA605ZKAC5n61
	5PF+XzJtPu/PawA9WV04xvzYt/IjZyQfLpTxtLCF8V1e+Tzzv0vl3ZZid1Mw3wcHM4my
	QSS5UaCHhBCDkBDX1sxosTpeaL+ovdyfOyJTzw0KnfBzVOpXkSAiN1BBafcTdcNNk0Q5
	1QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tEsIe7HDtrY1NvdfIxb87cYDh78a1WRGzfUfpaZLye0=;
	b=OKb/2BhCnsC4eXnbBSfetkaCpI4ZVF/bhp7MNKvjTPh7Y06IZ2UKw51u2sQ0LBceuW
	xqUFS7QL+ShLt1c8NdFC+YA6PvPPP28qj9tYuglmBEoQ0L51pySaBrZIfem6rduu5PMR
	EKCYJJkOxYvQL57gVeUCqmzqyTM42j4zGjMSrJ1mocWxcuLBsN3dCYBHe3gKdTpQBg7E
	HO7WVack2oFDQ/bJQ9L8PNvB5hCqvCLNH3uO+5N90fdrwzGLSckBm+ZCi01ixvTaT41P
	hHFEPCJ26WXg1QoBLCRFLeJYsVdgsI2GNmCgtMKUlx+KzCfQ28fqTiaUkYgGrZxCNZ1i
	FO1w==
X-Gm-Message-State: APjAAAVBtiGi5nXk5gHLCLjdXFugPXM3EVM2synXVJ2kbqG5keMwjQU/
	4nNRpRYKad508wFnQSfI0ixeYhEi3O0=
X-Google-Smtp-Source: APXvYqzZtDVIuOoj70A/tBH1b07DbVkNQbaallF/K+ulZy4CnZnPSntiAsTwpoIx0Ia4nYpCNPm3aA==
X-Received: by 2002:a65:6294:: with SMTP id f20mr25829055pgv.415.1556044649792;
	Tue, 23 Apr 2019 11:37:29 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	h187sm29343296pfc.52.2019.04.23.11.37.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 11:37:29 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <db9ceec5-3297-bbcd-be28-b4bdbd0f6b5d@linaro.org>
Date: Tue, 23 Apr 2019 11:37:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 06/26] target/arm: Decode FP instructions
 for M profile
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423183727.oTWfl2Ql07vVl7nOojEwrLAZH1-BIpZX6L5FoVWsbNs@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Correct the decode of the M-profile "coprocessor and
> floating-point instructions" space:
>  * op0 == 0b11 is always unallocated
>  * if the CPU has an FPU then all insns with op1 == 0b101
>    are floating point and go to disas_vfp_insn()
> 
> For the moment we leave VLLDM and VLSTM as NOPs; in
> a later commit we will fill in the proper implementation
> for the case where an FPU is present.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



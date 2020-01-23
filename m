Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C264C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C2124125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPIKQyhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C2124125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiKn-0005gg-2v
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuhbC-0001hp-PF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuhbB-0005u1-N1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:53:02 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuhbB-0005tX-Fo
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:53:01 -0500
Received: by mail-pf1-x444.google.com with SMTP id z16so1962184pfk.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=96KWtnOVDOdsQC6ur6NpenM8hW28TBg5RkdeVWugRFM=;
 b=PPIKQyhlnF6qzfbVjLZf0axLydF+ARGKvoS2NKY3zKG8oXHEj/6ByWx5U+Ow+aGE5q
 /OVCYfNY6gCRXUS50iFnPrnLZWDKjgbv7hgUKNSpnHs/bBJ4LvJNJ38IZLsZX4PUjMYr
 GgiHA9kbEikB09p4dAu4RjvvlLotiZV5cs8jdd/SUNMfrXkkm/flx7y7dlXcbLCnyEUG
 zyQAnbdLIcybzE90VJw+FTtO0t/xuRWhuRQ6RFzusBQuqTfJ06cRCrWeVKr1R9bombo+
 tx8Mxa1KwBSWEjgtZPLRrg0UInstUqGwMK+WCMo1P/9uKVWFF1cmj6V6Q1k1wqYI0mLR
 thEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=96KWtnOVDOdsQC6ur6NpenM8hW28TBg5RkdeVWugRFM=;
 b=njj6BFUkGNI2/HVu4OwaEgyz7YlK6WGR/b5Oofl31VJuUaIEEOp/d17YR6a69MZ8fB
 b9m1uH5pl8wHFLDOfJ4CYYy58tSuXWrQMwdn2V4Iqs50+hhljjoJ5FKXTxjIRX/ehsQV
 OSxrvUC4rbXuMUTWbmOmadEuEVWmNxvBVOq/GvpLTL40eyGk9wNzoxhN0pPbL7cMhc8A
 JitEfYkVNX8+4drw/vISbjnTp+14aqFNKotSa2gb6bYBurH/31V2Y1gU6v2zAUZL9Cn2
 h/sYmwwX+xb9ynRotlehO+jMGafjU59xedV91LBRkdShZX0cdv7c/KdGLE+lAGuWYw1X
 BZeg==
X-Gm-Message-State: APjAAAV8dMnTyiwPeCR4PYQ3FkXiE1fd3KSVBOVP+ryOUhuIT/BoTukv
 unsoKNoKffsaDvMoETO82m1eOw==
X-Google-Smtp-Source: APXvYqxrvkTC4LkWWaxeESGYTsYcLbyCdYJtCX9biL4ujMlwMraAvbCfMl+p6snq3yb7530d2/BE2g==
X-Received: by 2002:a63:3cb:: with SMTP id 194mr194987pgd.123.1579805579771;
 Thu, 23 Jan 2020 10:52:59 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c18sm3638069pfr.40.2020.01.23.10.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 10:52:59 -0800 (PST)
Subject: Re: [PATCH] riscv: Format Rd of FMV.W.X with NoN-boxing
To: Ian Jiang <ianjiang.ict@gmail.com>
References: <20200122072448.18510-1-ianjiang.ict@gmail.com>
 <b9084f13-0836-7f74-a870-608bf3f8f6a9@linaro.org>
 <CAMAD20=RS=tt04db3NfiPfXJo2Cr5PfCF-39E8qeuehnVGMdKg@mail.gmail.com>
 <25fb635f-6d92-70d0-9bcd-7f5a5de1a97b@linaro.org>
 <CAMAD20mgs=wBbsXAa6KsPP7SjNu1xfcM3wnqsAVExps3oufrtw@mail.gmail.com>
 <a7b4ec6a-1f41-45c3-d7a6-0b69fef1f379@linaro.org>
 <CAMAD20nWyApK7-uFNvMpXmzfiTohLOhPgD+TTNr+ZWVn+QA7Tg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ddd76565-4139-35e6-a23d-9e2c13fc613c@linaro.org>
Date: Thu, 23 Jan 2020 08:52:54 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMAD20nWyApK7-uFNvMpXmzfiTohLOhPgD+TTNr+ZWVn+QA7Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 6:05 PM, Ian Jiang wrote:
> But I am not clear where to call this new helper gen_nanbox_fpr(). Is
> there a position that could affect all floating-point instructions? So
> that we don't have to modify so many translating functions. Please
> give more details.

No, this will have to be called for each instruction individually.

That said, all of the insns that use helper functions, such as fsqrt_s, should
be doing the nan-boxing within the helper function.  Thus you'll want a
different helper function for use within fpu_helper.c.


r~


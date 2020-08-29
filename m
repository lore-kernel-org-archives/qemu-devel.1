Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64725C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 23:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222852076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 23:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQaDF9tT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222852076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCAkV-0007sR-Bz
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 19:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAju-0007T1-1F
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 19:58:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:45265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAjs-0004cB-HH
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 19:58:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id bh1so1326209plb.12
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gIrjLz/WZNqiwA0pGwBTIya9EXCQAeOV4Ox98+rP3z4=;
 b=oQaDF9tTUUGRloKnU/xlFghJ+SIjcsqXmGnzxuMxJVDEGNEy6UTGkXigifSlWlJawr
 eCGWja4B/bdHTsMIh+7gZSx/BemNlsVZlqdmRYxo2i2a77kITlIardO/J8FP4xFyiEov
 uzsJo2/dh4HuP9oM/sbxLUl3Mryn98QTpD1F7y1r0ZcCzOYVc7m7q1EyG+BV9r6RVB5l
 Vg3FbUqHLSgx4oGBbNBGPH2XBBG9aiwmrpiMb6UBIO4G5znma6PGGylFlHjJINKVFBkn
 rK47OHtYjg0nCi9PJ/CvIlukk6QNjxIYSLiwgypptmJ/s/OAYrliVn3C27lhll24weHC
 cfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gIrjLz/WZNqiwA0pGwBTIya9EXCQAeOV4Ox98+rP3z4=;
 b=qQrUvtIIlEOAY1QdVsy4GJDNhN6cZjSXlofAXVXO8kT6YPOGthUjhpZ2qtRv+zONm6
 m+UwoITDyjb83yb8NyMzzDq17zeH43cmmgwhd4LuqeKMJ/1uOtB2WL6XA0k6SCAPhaj8
 drFE7TnaiqUg7ksQb2DPCeZTpmgSv6uJTTdZe4zecAvfKiUOWNFG9TY+mRf3Ew5DQTo7
 OqM8tLGbGq5wJ6D89yKrslh66krpoE7dJGWNYS3OlppbCc4D8ojL1D1z7firCpzBi5HL
 5pABLJjBwk3mMOFDyktm21eOFtaA1e/01o12sdAzkUX9sQRvwoMS9PSt0PcGSAbr9P8v
 huoQ==
X-Gm-Message-State: AOAM530uZnRUyYZ10LEfpE+Nj4VvVymWZ2g111qai4GlXpimuRnWiyPD
 ePS+kEh2s7+/tx1GsVcdkzz0AA==
X-Google-Smtp-Source: ABdhPJwgqAgfEQDUp0OtOcFIehrPMTM54LDlrAXvRsKmXTjELXoFfBJJDn5u/dHkVUlb9yIl/+eNKw==
X-Received: by 2002:a17:90a:a50d:: with SMTP id
 a13mr4597363pjq.180.1598745507088; 
 Sat, 29 Aug 2020 16:58:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t19sm3853868pfq.179.2020.08.29.16.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 16:58:26 -0700 (PDT)
Subject: Re: [RFC v4 55/70] target/riscv: rvv-1.0: single-width floating-point
 reduction
From: Richard Henderson <richard.henderson@linaro.org>
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-56-frank.chang@sifive.com>
 <d94182cc-8846-9eb6-6a93-87968d0d32c1@linaro.org>
Message-ID: <2cbf253f-8fe1-d840-50f1-582767bf600c@linaro.org>
Date: Sat, 29 Aug 2020 16:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d94182cc-8846-9eb6-6a93-87968d0d32c1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/20 4:50 PM, Richard Henderson wrote:
> It doesn't actually say anything about the way in which we've implemented the
> *_noprop functions.

Ho hum.  It seems v2.2 has changed fmin/fmax for the fpu as well.

We really should fix that too...


r~


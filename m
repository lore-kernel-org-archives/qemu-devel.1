Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5012FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20495207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tS6mFymc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20495207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEgB-0002av-EE
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBEfe-0002B8-5V
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:58:14 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:56270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBEfb-0007lq-9I
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:58:13 -0400
Received: by mail-pj1-x1043.google.com with SMTP id 2so2346124pjx.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uVper52yUxvXFoa7vjhvEw+B+Qfgyt+174M4HcDFFlc=;
 b=tS6mFymcOr38OCZZCJeIcW4t7SvKIzmiHyZWaVqk0KDM42Po3jSelbb8Ltj/Qotl0s
 0XJCjv8xoBm4ElnlxSLKY8f+WiqY2p8BRvCx2ePsGy31Mu0bYva2cyvp1SNSuiGMHvQx
 NhEWQhBna0uxZ/2wNxk6n0UJnn+xVtrHVMshXDIyPiGGgfim8redHIzxlYknElDaLOs9
 U2lCXsRstYGbaZ3DGFBnw7oveAKhYC8FCe9sn9/cPFaovr3aQFouahTm3zS/TWBeDRqe
 4b2T2a93T+i7P2xh5lmXa3711QyOvKprCED/guKl/XjDuLQE91DOb1Oa7L4GkcMXVQBR
 ornA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uVper52yUxvXFoa7vjhvEw+B+Qfgyt+174M4HcDFFlc=;
 b=pZIhzSJJk01kHS1Llxiv6mepdUPUpIKApxR87dfKaXXo4ImyzbUFDIx7pEFwo7i93y
 HGihAe0iseaY4KmTOxo0/g1EGGvzkS80N2PWU0pT3aPWUBHreEskQFYF9cGUVqNjiVTs
 zHuujfIAAv+sEmZNyBWB7xYMtPSUoPCn+vLFeJx9kISQZl6D22TnCEg7YJD/WpXa3G0n
 5Rkw3nus1iSCXfpdDIMdgH82mLK3hJTfLH2OD9Ih0+KMej1d0rAw6Y87Q/VJWHImufN8
 wQynehivSi9yNnc+GSZzI3824NE7iidhxYsGcRzq05fAdaP3+x9wvsxBt0ETCt54d2+o
 fBmA==
X-Gm-Message-State: AOAM533xDmzwQ7R9gJwt+IUOg2PlMen4KMv4nhMyey/vkCs7dORemthG
 bQ4WSl1GGUuRFhwi2YicKkI4NkPMmMM1ZQ==
X-Google-Smtp-Source: ABdhPJxv7+H7k27m+wzWQFn9XQomp/nRptfXWT7KXM59gkjWy903xrpj+AfpKzXW7KOVNzQGfD5Aew==
X-Received: by 2002:a17:90b:4d0d:: with SMTP id
 mw13mr9715320pjb.43.1598522289129; 
 Thu, 27 Aug 2020 02:58:09 -0700 (PDT)
Received: from [192.168.101.174] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id u62sm2216212pfb.4.2020.08.27.02.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 02:58:08 -0700 (PDT)
Subject: Re: [PATCH 64/77] target/microblaze: Convert mbar to decodetree
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-65-richard.henderson@linaro.org>
 <20200827092413.GL2954729@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7e242b2a-d582-059c-f282-9e001653b627@linaro.org>
Date: Thu, 27 Aug 2020 02:58:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827092413.GL2954729@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 2:24 AM, Edgar E. Iglesias wrote:
>> +    /*
>> +     * Instruction access memory barrier.
>> +     * End the TB so that we recognize self-modified code immediately.
>> +     */
>> +    if (mbar_imm & 1) {
>> +        dc->cpustate_changed = 1;
>> +    }
> 
> This should be (mbar_imm & 1) == 0
> But even with that fixed it fails some of our tests because interrupts
> that should become visible within a couple of cycles after a
> memory data barrier can now be delayed longer.
> 
> I think we should always break the TB.

Ok.  I assume this follows a write to something like an interrupt controller
register?

> 
>> +    /* Data access memory barrier.  */
>> +    if (mbar_imm & 2) {
>> +        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
>> +    }
> 
> This should be (mbar_imm & 2) == 0

Oops.  ;-)

Applying the following incremental patch.


r~


diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a391e80fb9..1e2bb529ac 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1170,16 +1170,8 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
 {
     int mbar_imm = arg->imm;

-    /*
-     * Instruction access memory barrier.
-     * End the TB so that we recognize self-modified code immediately.
-     */
-    if (mbar_imm & 1) {
-        dc->cpustate_changed = 1;
-    }
-
     /* Data access memory barrier.  */
-    if (mbar_imm & 2) {
+    if ((mbar_imm & 2) == 0) {
         tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
     }

@@ -1204,6 +1196,19 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)

         gen_raise_exception(dc, EXCP_HLT);
     }
+
+    /*
+     * If !(mbar_imm & 1), this is an instruction access memory barrier
+     * and we need to end the TB so that we recognize self-modified
+     * code immediately.
+     *
+     * However, there are some data mbars that need the TB break
+     * (and return to main loop) to recognize interrupts right away.
+     * E.g. recognizing a change to an interrupt controller register.
+     *
+     * Therefore, choose to end the TB always.
+     */
+    dc->cpustate_changed = 1;
     return true;
 }



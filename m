Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B67C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAAA205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNMBiH1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAAA205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGRoX-00040J-NF
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 13:24:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGRnT-0003Qi-Sn
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGRnS-0006RS-Ve
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:23:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGRnS-0006Pz-Iz
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:23:02 -0400
Received: by mail-pf1-x444.google.com with SMTP id z5so10734455pfn.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=9ireNXBEenac/bpbP2qhhiCHhvW1o/b4CWXejO6S1ZY=;
	b=ZNMBiH1pqVRL666B5ZlIeUsk3NQewI/ZuL3sGngtPWU/zRjwYdk+PNhl9/0vFTZfsU
	xTAHTQViYb2ln7n6I2LDO4j2jii4hpKt49LoJy2GPUr8cCR35NMT05q+B93xFwVR4w/8
	mS6zmgqcBK1teYr5489NYK/q4754jf14mZWH2Y/Y0w2l2XLK1xDuPantcAsm666ZOpRv
	Yi6ja3nlDSe6aWAs/I888cKsPUFM6zItkSIAfAselSttqNsouB6OhFMB++jxNYIINjv4
	UR6cfD2J/jDykEGn2VufTCEGVYCVobI9tyT/yhCo82Rl2J3GWlTAW+RhgvsfMZqdxkQP
	8Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9ireNXBEenac/bpbP2qhhiCHhvW1o/b4CWXejO6S1ZY=;
	b=bxF1WvCjWGFMuzEktrQy5OtSz6LqfbgA7mvamxBvN/V2E0tvxYN3cR9b7Kr1AYAAqW
	iiVe5Dh4QeNwLnEdSonTQg3Q/XxXniRb3fPpfhqymVltAlLATnIO2j+Uc11w8zNBUcTw
	jkQSr9YIdgPqC9n37qBQaiWVPIsbdPvO048IR1OZ3BzEFN1TkN84KDQl+L2jS4ZdzLVj
	cR0UVzb3OlB2PVmQgwQvLsI5anO3LXHTGDWzc4J8nVno/qx7UBWjjesRJ0MlRm3MbaRV
	ubmaoH0csffufWWM0OZlx5Xee/qxM7XtLr5pkjruRs09H5APlddsa7waSLVy7ETeRbc+
	fJFQ==
X-Gm-Message-State: APjAAAWYt7WuPGaNwQhKutAbxcwDDWlcAINc58DLhObRZe065B1cdEqG
	ZP+43nG84v9bqVD16SGFjoJDHQ==
X-Google-Smtp-Source: APXvYqy8gXc5B34agVJd8MihQzZ560DKc9MAxgRaLT3m/yqdq3lcgFJOCGutCDsGYvDH6lSxVK08Ow==
X-Received: by 2002:a62:19c3:: with SMTP id 186mr85403794pfz.172.1555435380730;
	Tue, 16 Apr 2019 10:23:00 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	w10sm53683820pfi.126.2019.04.16.10.22.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 10:22:59 -0700 (PDT)
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20190401031155.21293-1-richard.henderson@linaro.org>
	<20190401031155.21293-4-richard.henderson@linaro.org>
	<c6b66db9-24d5-b55b-8b45-e73f3d7c3fba@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <50effb1c-3bbe-126b-9bfb-0b65eacc9c36@linaro.org>
Date: Tue, 16 Apr 2019 07:22:55 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c6b66db9-24d5-b55b-8b45-e73f3d7c3fba@mail.uni-paderborn.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
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
Cc: qemu-riscv@nongnu.org, palmer@sifive.com, Alistair.Francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416172255.OzdDZa6rXjdG4J1WMi2F46AoP2xy9Ch8v9pqq9m0e5g@z>

On 4/16/19 2:02 AM, Bastian Koppelmann wrote:
> 
> On 4/1/19 5:11 AM, Richard Henderson wrote:
>>     # *** RV64C Standard Extension (Quadrant 0) ***
>>   c_addi4spn        000    ........ ... 00 @ciw
>> -c_fld             001  ... ... .. ... 00 @cl_d
>> -c_lw              010  ... ... .. ... 00 @cl_w
>> +fld               001  ... ... .. ... 00 @cl_d
>> +lw                010  ... ... .. ... 00 @cl_w
> 
> This leads to a redefinition of arg_lw and arg_fld for which clang emits a
> warning as found by Peter as he wanted to merge the original pull request for
> RISC-V-dt. The same goes for all other merged args.

I thought that would be handled by the #pragma, but it seems
that we need another one for clang-6.


r~


diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index fb66e886bf..c96c616539 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -695,6 +695,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
  */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wredundant-decls"
+#pragma GCC diagnostic ignored "-Wtypedef-redefinition"

 #include "decode_insn16.inc.c"




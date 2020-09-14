Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CFFC2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD64022240
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP010MbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD64022240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHoBT-00085o-EQ
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHoAl-0007di-9O
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:05:31 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHoAj-0005eM-8J
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:05:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id w2so10567997wmi.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rs7lwjnfA1/UMTKz1lapaEoXPhEklrl/TiGlRC5Bgq8=;
 b=rP010MbVt/DMOq0j0TQrF2XGg1dfQoZ8jotzlDPjSFzzwTGmC3Wb9v32g6fgbV5o4Q
 uHVGj2kK1bIdeoEfUaO82aVhmB5mhgRjMrnEdU22ZOePnpTuIumPBl/7fMh9v4aSb8Cy
 a/SRD6Kj7HtNSS7Ooj7iHWSXeT8jAagPSJsb657Yno8nfj6jEZ2/TkVGjtYeXSOSmr7M
 0mfilnVD0AxybB7c5mjptV2prHKcnzkA3BLAt1zW094FTxJRroYC6pV4yCVjmVbkB8Y9
 xtArIXsyuNHqneNB2r5ocfYKH3LOnzTZ4BZd+o0rGTRh7fMMD0q4NQtyFffO2Dr0oJIa
 y0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rs7lwjnfA1/UMTKz1lapaEoXPhEklrl/TiGlRC5Bgq8=;
 b=hPGjJDvYwg1TK/ArNcaizN8ZT0A5RAnhbyxD3/eEHQt9sLXPPC5LQpeMXLyUAgfUMX
 Jf+Lhgi2RY3ONscetpWMY3NucWkDh97k7JGPZKUs8MRwleqdhLop+SKtF62WdEmGoqCw
 rQKat3BKDu2Z1wdgScmhvWqT7rlGcL9pDniqMWK1UUH2j5SByivYf1XmDViEC/myBAiw
 bQdHlfJr9jm2o0vR+Evj718mOWElai/EsejV002YMCrWVzk5jLgIRr/DjQ5c3ttrocyh
 bX+uWlFdeU40Rhhpb60LmkoSPRppOibEbLky44Q9uknqyuhrHIZufQ4tTXq/dD8UB5HC
 u8jg==
X-Gm-Message-State: AOAM531mg2mtsYunvXgfiId+RhPtXM1rDaxUaQd6nCLRNiY0HYHN4+Km
 4Ipr+oq+SMwI6G2ktybvjnM=
X-Google-Smtp-Source: ABdhPJwqWFeDGKblX5yZf1lSi6fiHsMT4rPw1CtTvbdWwhWn3Oyn07khP1WbzM2PKFay8eWIMWVNpw==
X-Received: by 2002:a05:600c:2183:: with SMTP id
 e3mr15817656wme.49.1600088726842; 
 Mon, 14 Sep 2020 06:05:26 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q18sm20182220wre.78.2020.09.14.06.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 06:05:26 -0700 (PDT)
Subject: Re: [REPORT] Nightly Performance Tests - Sunday, September 13, 2020
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
References: <5f5e9831.1c69fb81.bdbec.98b8@mx.google.com>
 <ea64c109-6bd9-c0f1-964c-46be5c6ba020@amsat.org>
 <CALTWKrW-U261HNc8mSxmu1uYKqrZxZM4+661ZK_m-W_Ky8eiFQ@mail.gmail.com>
 <CAL1e-=hivWj2zvE9hXPdyfVFyBCYn5np0Y8wuFQHg9s0qtQsMg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <112cbca0-daae-3591-722b-a6e2d8091fba@amsat.org>
Date: Mon, 14 Sep 2020 15:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hivWj2zvE9hXPdyfVFyBCYn5np0Y8wuFQHg9s0qtQsMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 2:43 PM, Aleksandar Markovic wrote:
> On Mon, Sep 14, 2020 at 12:52 PM Ahmed Karaman
> <ahmedkhaledkaraman@gmail.com <mailto:ahmedkhaledkaraman@gmail.com>> wrote:
> 
>     On Mon, Sep 14, 2020 at 8:46 AM Philippe Mathieu-Daudé
>     <f4bug@amsat.org <mailto:f4bug@amsat.org>> wrote:
>     >
>     > Hi Ahmed,
>     >
>     > On 9/14/20 12:07 AM, Ahmed Karaman wrote:
>     > > Host CPU         : Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
>     > > Host Memory      : 15.49 GB
>     > >
>     > > Start Time (UTC) : 2020-09-13 21:35:01
>     > > End Time (UTC)   : 2020-09-13 22:07:44
>     > > Execution Time   : 0:32:42.230467
>     > >
>     > > Status           : SUCCESS
>     > >
>     > > Note:
>     > > Changes denoted by '-----' are less than 0.01%.
>     > >
>     > > --------------------------------------------------------
>     > >             SUMMARY REPORT - COMMIT f00f57f3
>     > > --------------------------------------------------------
>     >
>     > (Maybe this was already commented earlier but I missed it).
>     >
>     > What change had a so significant impact on the m68k target?
>     > At a glance I only see mostly changes in softfloat:
>     >
>     > $ git log --oneline v5.1.0..f00f57f3 tcg target/m68k fpu
>     > fe4b0b5bfa9 tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem
>     > 6a17646176e tcg: Eliminate one store for in-place 128-bit dup_mem
>     > e7e8f33fb60 tcg: Fix tcg gen for vectorized absolute value
>     > 5ebf5f4be66 softfloat: Define misc operations for bfloat16
>     > 34f0c0a98a5 softfloat: Define convert operations for bfloat16
>     > 8282310d853 softfloat: Define operations for bfloat16
>     > 0d93d8ec632 softfloat: Add fp16 and uint8/int8 conversion functions
>     > fbcc38e4cb1 softfloat: add xtensa specialization for pickNaNMulAdd
>     > 913602e3ffe softfloat: pass float_status pointer to pickNaN
>     > cc43c692511 softfloat: make NO_SIGNALING_NANS runtime property
>     > 73ebe95e8e5 target/ppc: add vmulld to INDEX_op_mul_vec case
>     >
>     > > --------------------------------------------------------
>     > > --------------------------------------------------------
>     > > Test Program: matmult_double
>     > > --------------------------------------------------------
>     > > Target              Instructions      Latest      v5.1.0
>     > > ----------  --------------------  ----------  ----------
>     > > aarch64            1 412 412 599       -----     +0.311%
>     > > alpha              3 233 957 639       -----     +7.472%
>     > > arm                8 545 302 995       -----      +1.09%
>     > > hppa               3 483 527 330       -----     +4.466%
>     > > m68k               3 919 110 506       -----    +18.433%
>     > > mips               2 344 641 840       -----     +4.085%
>     > > mipsel             3 329 912 425       -----     +5.177%
>     > > mips64             2 359 024 910       -----     +4.075%
>     > > mips64el           3 343 650 686       -----     +5.166%
>     > > ppc                3 209 505 701       -----     +3.248%
>     > > ppc64              3 287 495 266       -----     +3.173%
>     > > ppc64le            3 287 135 580       -----     +3.171%
>     > > riscv64            1 221 617 903       -----     +0.278%
>     > > s390x              2 874 160 417       -----     +5.826%
>     > > sh4                3 544 094 841       -----      +6.42%
>     > > sparc64            3 426 094 848       -----     +7.138%
>     > > x86_64             1 249 076 697       -----     +0.335%
>     > > --------------------------------------------------------
>     > ...
>     > > --------------------------------------------------------
>     > > Test Program: qsort_double
>     > > --------------------------------------------------------
>     > > Target              Instructions      Latest      v5.1.0
>     > > ----------  --------------------  ----------  ----------
>     > > aarch64            2 709 839 947       -----     +2.423%
>     > > alpha              1 969 432 086       -----     +3.679%
>     > > arm                8 323 168 267       -----     +2.589%
>     > > hppa               3 188 316 726       -----       +2.9%
>     > > m68k               4 953 947 225       -----    +15.153%
>     > > mips               2 123 789 120       -----     +3.049%
>     > > mipsel             2 124 235 492       -----     +3.049%
>     > > mips64             1 999 025 951       -----     +3.404%
>     > > mips64el           1 996 433 190       -----     +3.409%
>     > > ppc                2 819 299 843       -----     +5.436%
>     > > ppc64              2 768 177 037       -----     +5.512%
>     > > ppc64le            2 724 766 044       -----     +5.602%
>     > > riscv64            1 638 324 190       -----     +4.021%
>     > > s390x              2 519 117 806       -----     +3.364%
>     > > sh4                2 595 696 102       -----       +3.0%
>     > > sparc64            3 988 892 763       -----     +2.744%
>     > > x86_64             2 033 624 062       -----     +3.242%
>     > > --------------------------------------------------------
> 
>     Hi Mr. Philippe,
>     The performance degradation from v5.1.0 of all targets, and especially
>     m68k, was introduced between the two nightly tests below:
> 
>     [REPORT] Nightly Performance Tests - Thursday, August 20, 2020:
>     https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg04923.html
> 
>     [REPORT] Nightly Performance Tests - Saturday, August 22, 2020
>     https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg05537.html
> 
>     It looks like the new build system is the culprit.
> 
>     The "bisect.py" script introduced during the "TCG Continuous
>     Benchmarking" GSoC project can be very handy in these cases. I wrote
>     about the tool and how to use it in the report below:
>     https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Finding-Commits-Affecting-QEMU-Performance/
> 
> 
> Hi, Ahmed.
> 
> I think the bisect.py script will work only if both "start" and "end"
> commits are before build system change, or if both of them are after
> build system change.
> 
> In other words, the script is unlikely to work if "start" is before, and
> "end" is after build system change.

Good point.

> This means that, most probably, one should resort to manual analysis of
> origins of performance degradation on Aug 22nd.

What would be useful is a report from the build system change
(commit 7fd51e68c34), then as Aleksandar suggested, resume normal
bisection (range 7fd51e68c34..66e01f1cdc9).

> 
> One area that definitely might be the culprit is the difference in
> CFLAGS before and after.
> 
> Yours,
> Aleksandar
>  
> 
>     Best regards,
>     Ahmed Karaman
> 


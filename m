Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B6C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 10:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0FD207DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 10:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX+0MinL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0FD207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9QeN-0004sV-LP
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 06:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Qdl-0004SU-PN
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 06:20:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Qdj-0003A0-Vv
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 06:20:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id l2so4102736wrc.7
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r0FX1+5i04n8tq4CIn80B0KxbiJtPbxv7ftN7+8z3pM=;
 b=bX+0MinLyAwK7985wD+BKPqGA1cgWGEt9sbuIY6gil001w3i5B21hiXJ4jWmjE82AR
 1f8AH2IBMZM/P9Ts6gqALh1FzYTNa2RdFr8JKmLoRaAVX7VxkD9Bevkr3fo+OD6/yuix
 YX0hUlCxGNVMkPiBbSNKp9dkOFrV6bctyLGpZx0cpnUljCZvEnzBNLS7UKdxJNZ9OyOh
 JpMJAyNTq5VbEOwpxIVSUKF9wGYTXv7yBFOf9QiyN24Nrgwaj/iW/ihvhM0C/1WonziM
 lP4XORfFNsdCivm8hbhrNvH/N1cXt3GtFlE5JUWbCJVc7RflpMQbkiu7LWr7TxlF5nwZ
 mP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r0FX1+5i04n8tq4CIn80B0KxbiJtPbxv7ftN7+8z3pM=;
 b=VC41Yrt4WNJjg7EV+ifMkJJLEcTLXvsb/ppNoJrhRTMDxfmBc5L00svVvkM5aES+Qa
 C3Tkw7hq/7e+dVZWIty3ZdkgrmkDtUtyr2CVJLveTwwV2odo/dx0bBJWuww2TyrUb9va
 MPi1z1H3zWttrHHegSzVmL62C4Rh+rsGYpY8y/is2FDqr0RldMTWVBjM3g3gwyoC85Ab
 bnJKWFEXALTebxxjGEUdgcJ533KJF80hcsWh6JiaX7kI+km4i2k1e34Uw4sCJvWb1o6G
 +OiMCirkqLuh3GG4i8WMvyS+GKHmc7If7tUqzn/BYW8s9CJZwFvVzWijDLxayfOtBIcT
 DW7Q==
X-Gm-Message-State: AOAM530HNOEajtvnbHt93gRMxQ2/Td+ARjiSsCatQyl2lj7nYBv4gGmC
 zhqs3Fsfj9NMQB29F0tWr98=
X-Google-Smtp-Source: ABdhPJwa4poNfB+kt//g2TveRbLsjTP2VAp3PX7RCqfPbziyY8jlNnzQ1q+3rKgFVXFt18iAU6eaag==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr6369808wrp.32.1598091646410; 
 Sat, 22 Aug 2020 03:20:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r22sm10664917wmh.45.2020.08.22.03.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 03:20:45 -0700 (PDT)
Subject: Re: [PULL v2 00/24] target/xtensa updates for 5.2
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200821205050.29066-1-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8b20adcd-97e9-0f8f-1854-b9809060d6cd@amsat.org>
Date: Sat, 22 Aug 2020 12:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821205050.29066-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 10:50 PM, Max Filippov wrote:
> Hi Peter,
> 
> please pull the following batch of updates for target/xtensa.
> 
> Changes v1->v2:
> - rebase on top of build system changes, resolve trivial conflicts
>   in the last two patches that add new files.
> 
> The following changes since commit f86d9a093dada588889bde5582c7ec320487c4b8:
> 
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-08-21 17:26:52 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/OSLL/qemu-xtensa.git tags/20200821-xtensa
> 
> for you to fetch changes up to c621b4142bf1ff8c663811c10bd1628481e494a6:
> 
>   target/xtensa: import DSP3400 core (2020-08-21 12:56:45 -0700)
> 
> ----------------------------------------------------------------
> target/xtensa updates for 5.2:
> 
> - add NMI support;
> - add DFPU option implementation;
> - update FPU tests to support both FPU2000 and DFPU;
> - add example cores with FPU2000 and DFPU.
> 
> ----------------------------------------------------------------
> Max Filippov (24):
>       target/xtensa: make opcode properties more dynamic
>       target/xtensa: implement NMI support
>       softfloat: make NO_SIGNALING_NANS runtime property
>       softfloat: pass float_status pointer to pickNaN
>       softfloat: add xtensa specialization for pickNaNMulAdd
>       target/xtensa: add geometry to xtensa_get_regfile_by_name
>       target/xtensa: support copying registers up to 64 bits wide
>       target/xtensa: rename FPU2000 translators and helpers
>       target/xtensa: move FSR/FCR register accessors
>       target/xtensa: don't access BR regfile directly
>       target/xtensa: add DFPU option
>       target/xtensa: add DFPU registers and opcodes
>       target/xtensa: implement FPU division and square root
>       tests/tcg/xtensa: fix test execution on ISS
>       tests/tcg/xtensa: update test_fp0_arith for DFPU
>       tests/tcg/xtensa: expand madd tests
>       tests/tcg/xtensa: update test_fp0_conv for DFPU
>       tests/tcg/xtensa: update test_fp1 for DFPU
>       tests/tcg/xtensa: update test_lsc for DFPU
>       tests/tcg/xtensa: add fp0 div and sqrt tests
>       tests/tcg/xtensa: test double precision load/store
>       tests/tcg/xtensa: add DFP0 arithmetic tests
>       target/xtensa: import de233_fpu core
>       target/xtensa: import DSP3400 core
> 
>  fpu/softfloat-specialize.c.inc                    |    286 +-
>  fpu/softfloat.c                                   |      2 +-
>  hw/xtensa/pic_cpu.c                               |      6 +-
>  include/fpu/softfloat-helpers.h                   |     10 +
>  include/fpu/softfloat-types.h                     |      8 +-
>  target/xtensa/core-de233_fpu.c                    |     58 +
>  target/xtensa/core-de233_fpu/core-isa.h           |    727 +
>  target/xtensa/core-de233_fpu/core-matmap.h        |    717 +
>  target/xtensa/core-de233_fpu/gdb-config.c.inc     |    277 +
>  target/xtensa/core-de233_fpu/xtensa-modules.c.inc |  20758 +++
>  target/xtensa/core-dsp3400.c                      |     58 +
>  target/xtensa/core-dsp3400/core-isa.h             |    452 +
>  target/xtensa/core-dsp3400/core-matmap.h          |    312 +
>  target/xtensa/core-dsp3400/gdb-config.c.inc       |    400 +
>  target/xtensa/core-dsp3400/xtensa-modules.c.inc   | 171906 +++++++++++++++++++

3.12MiB of generated data...

Where does that come from? Some submodule? Can't we regenerate?

This seems very similar to what the decodetree.py script generates.

I'm asking because IIRC we have been reluctant to accept the hexagon
port due to its big generated imported data (beside the licensing
issues).

Thanks,

Phil.

>  target/xtensa/cpu.c                               |      5 +
>  target/xtensa/cpu.h                               |     14 +-
>  target/xtensa/exc_helper.c                        |     23 +-
>  target/xtensa/fpu_helper.c                        |    342 +-
>  target/xtensa/helper.c                            |      4 +-
>  target/xtensa/helper.h                            |     58 +-
>  target/xtensa/meson.build                         |      2 +
>  target/xtensa/overlay_tool.h                      |     30 +-
>  target/xtensa/translate.c                         |   1979 +-
>  tests/tcg/xtensa/fpu.h                            |    142 +
>  tests/tcg/xtensa/macros.inc                       |     10 +-
>  tests/tcg/xtensa/test_dfp0_arith.S                |    162 +
>  tests/tcg/xtensa/test_fp0_arith.S                 |    282 +-
>  tests/tcg/xtensa/test_fp0_conv.S                  |    299 +-
>  tests/tcg/xtensa/test_fp0_div.S                   |     82 +
>  tests/tcg/xtensa/test_fp0_sqrt.S                  |     76 +
>  tests/tcg/xtensa/test_fp1.S                       |     62 +-
>  tests/tcg/xtensa/test_lsc.S                       |    170 +-
>  33 files changed, 198888 insertions(+), 831 deletions(-)
>  create mode 100644 target/xtensa/core-de233_fpu.c
>  create mode 100644 target/xtensa/core-de233_fpu/core-isa.h
>  create mode 100644 target/xtensa/core-de233_fpu/core-matmap.h
>  create mode 100644 target/xtensa/core-de233_fpu/gdb-config.c.inc
>  create mode 100644 target/xtensa/core-de233_fpu/xtensa-modules.c.inc
>  create mode 100644 target/xtensa/core-dsp3400.c
>  create mode 100644 target/xtensa/core-dsp3400/core-isa.h
>  create mode 100644 target/xtensa/core-dsp3400/core-matmap.h
>  create mode 100644 target/xtensa/core-dsp3400/gdb-config.c.inc
>  create mode 100644 target/xtensa/core-dsp3400/xtensa-modules.c.inc
>  create mode 100644 tests/tcg/xtensa/fpu.h
>  create mode 100644 tests/tcg/xtensa/test_dfp0_arith.S
>  create mode 100644 tests/tcg/xtensa/test_fp0_div.S
>  create mode 100644 tests/tcg/xtensa/test_fp0_sqrt.S
> 



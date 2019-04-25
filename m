Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDF6C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 03:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDF3214AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 03:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KAqF7EdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDF3214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJV8H-0004ZK-5v
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 23:33:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJV6p-0003va-6r
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJV6n-0008Rf-Be
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:39 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJV6n-0008Qq-5i
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id f6so10423836pgs.8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=uUzPpclpaSMI7fsm1VBAyEEh86pyGptcQuyv4nm43AI=;
	b=KAqF7EdYFsBJirwLbslKpU2tIwbbX7n+JFYFqpqW+7xIl/Qa24pnK4gHTxPcrRBxPI
	ByFkSs41pV1xx1JB1N7FRJGkINQIb+EQ+d/oZp4W6kdeaeZaqzqi7k5y+EnRs9XoDjfe
	o1yVLANQs7odegVoz0f3LBkV1uqmZ1GfVGvNamoRjszMP33SPiWc0yhH8gz590dlbZk4
	c+CiTOflpq6OyCdXZRYGx1kHzGAqIL+EA5bj6+TcxJ1P0P2edVra5dxDO+krnyBgcc0h
	8EQWFZtTFjx8FFq/8v+7UvtI0J7qZ4Legtv1lebzTH8bnrDQsHDB+z0Yurq+IocqtvVf
	rvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=uUzPpclpaSMI7fsm1VBAyEEh86pyGptcQuyv4nm43AI=;
	b=DEN5FOZyGKgbxsNYPvxIGzJ6PkVl9s/NZb6237jzattcwCudUjUxg8sNLNpfXSZI/V
	tDmXi0i0SvaaiMbd16P6B0ITRfx44gbdVx2oQSk9dDOT7zToNS/R8YPXtbrujIWqphjd
	gw98dq5T1YlVjqqTED77xNG7C1lAFVDQOCNuMKxBpIebJ8dajWW5EtHXn7bIRflJkz4J
	eRBOXPXUAfLf4EXdL/7zMw+bTrxsgB/pIfMA3hq6g5aeusVgoseeQFLIxBKGq5hmmyvS
	7nt197RabvkuzqaaA5QsgZc0gxFaF22T47MJ4UwH65GLPc93r9C/yTTqq/LTLGVpbX/x
	vgHw==
X-Gm-Message-State: APjAAAVix4d3gaLMcTbduR5t0AcrsRH/qIodIfFqo/zKF8iZXbEohag8
	ZBknNiUVIY227p0VDAWFFYv7fumgb0zCbw==
X-Google-Smtp-Source: APXvYqywoH82wXN3iImfWH/690jSk6A11ExwtMAgVL+Ly2AaV7xB5PPhTQ9qa5aw1nNRWud4ITX8Ow==
X-Received: by 2002:a62:595d:: with SMTP id n90mr8991721pfb.112.1556163095279; 
	Wed, 24 Apr 2019 20:31:35 -0700 (PDT)
Received: from localhost ([67.51.191.132]) by smtp.gmail.com with ESMTPSA id
	10sm57749606pft.100.2019.04.24.20.31.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 20:31:34 -0700 (PDT)
Date: Wed, 24 Apr 2019 20:31:34 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Apr 2019 16:40:46 PDT (-0700)
In-Reply-To: <20190401031155.21293-3-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-d8a9c6b1-6c19-45a3-ba27-f8fc88bdc933@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/8] target/riscv: Use
 --static-decode for decodetree
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425033134.PkpQWGU4T3B7BbMpTYNHUOy-hqi1H5Dl1uTS9twZvls@z>

On Sun, 31 Mar 2019 20:11:49 PDT (-0700), richard.henderson@linaro.org wrote:
> The generated functions are only used within translate.c
> and do not need to be global, or declared.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/translate.c   | 2 --
>  target/riscv/Makefile.objs | 8 ++++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index dd763647ea..7ebd590486 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -538,7 +538,6 @@ static int ex_rvc_register(int reg)
>      return 8 + reg;
>  }
>
> -bool decode_insn32(DisasContext *ctx, uint32_t insn);
>  /* Include the auto-generated decoder for 32 bit insn */
>  #include "decode_insn32.inc.c"
>
> @@ -667,7 +666,6 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  #include "insn_trans/trans_rvd.inc.c"
>  #include "insn_trans/trans_privileged.inc.c"
>
> -bool decode_insn16(DisasContext *ctx, uint16_t insn);
>  /* auto-generated decoder*/
>  #include "decode_insn16.inc.c"
>  #include "insn_trans/trans_rvc.inc.c"
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index 9c6c109327..c7a1b063ed 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -7,14 +7,14 @@ decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn32-64.decode
>
>  target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
>  	$(call quiet-command, \
> -	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $(decode32-y), \
> -	  "GEN", $(TARGET_DIR)$@)
> +	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
> +          $(decode32-y), "GEN", $(TARGET_DIR)$@)
>
>  target/riscv/decode_insn16.inc.c: \
>    $(SRC_PATH)/target/riscv/insn16.decode $(DECODETREE)
>  	$(call quiet-command, \
> -	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn16 --insnwidth 16 $<, \
> -	  "GEN", $(TARGET_DIR)$@)
> +	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
> +          --insnwidth 16 $<, "GEN", $(TARGET_DIR)$@)
>
>  target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
>  	target/riscv/decode_insn16.inc.c

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>


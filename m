Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08370C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D292067D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4wltwzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D292067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18bT-0005PI-5G
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18aI-00042q-Qx
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:26:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:34804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18aG-0006RA-4U
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:26:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id o1so14128270plk.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tBsjl6/gQnF1iVF+wRYhQbaM0PKMnO5JfqHNvXOGtYQ=;
 b=z4wltwzg7csOYWXYzHi9YOjka1/s+nI/Cgws5xTuDdYh9c0PZGG2JJ62aCTLSfC+wv
 hrl7VzKkiNGh6/NNL6bhDa1rGPV2kDkB5Agfdz0unKdhsZ/xQcgi9j5+xIeig/xfVwVf
 V913SD6TRRw/KOOTLS6RnCTDsO4cLZtN5OGsEpXRD+D7zTjMu4pw5CD9/rcihdLKmJ2X
 JDaFws8vsyGPl4wVDa3EDWIs6osP7T+PqjiULhG3ZGhT6t6vYim1xplXNrbmrhMkdrHf
 5OQgGUoFqMO4mqiR4J8iibIDgTbWbHZB+4UDCVVgp0DCOq9WB6y7JcqdJrUZtTEXZg1D
 Oj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tBsjl6/gQnF1iVF+wRYhQbaM0PKMnO5JfqHNvXOGtYQ=;
 b=rw/6F8zpRANUKffsAkq2kNTLTRUkEtH7EUzxJnPytkJ8QW+I313aH3FWpcALBntxoh
 xe4lLc2iIbx8qEXFulXSu+IxG1MEN17cAAUR7GffwbU2vCgwHX295KGiRX0LBLMiQXgv
 3LfoiohRiMALv57sjslAff9FuX/g524jo+zFAw8d+qbbR7Md7PRei1h1UjULD1VEdX+7
 7qnsIzTeY5PyUzRLeUXCg1VfUitypDtRY4AcavDQcjeXQ9v3sXxxq/Zoe4jmbu9YPKgD
 P5OtcS3q7584XitTpfiu6AaPOcoVLOY1+FRDlskEkjN1pQmFGeOWCSh5yj6GH+Al9P+B
 ePiQ==
X-Gm-Message-State: AOAM531Pg/gRDYkDETtbVe2A8QseMaw8/IheY6Lw7HZlR18K580FMPPT
 1KLsFA6t6L6wjSyCtagCZGrZvQ==
X-Google-Smtp-Source: ABdhPJzM56fae09YHhVKFyhW9Nwnap9/BH7aTprAyfhfbM7jPGMtp/EC8G7/Nphwb2xEWGk/rX83CQ==
X-Received: by 2002:a17:902:50d:: with SMTP id
 13mr4517722plf.311.1596115614198; 
 Thu, 30 Jul 2020 06:26:54 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y18sm6138485pff.10.2020.07.30.06.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:26:53 -0700 (PDT)
Subject: Re: [RFC v2 34/76] target/riscv: rvv-0.9: set-X-first mask bit
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-35-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01f30ac7-30fa-701d-c824-2395d317f5e6@linaro.org>
Date: Thu, 30 Jul 2020 06:26:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-35-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn32.decode              | 6 +++---
>  target/riscv/insn_trans/trans_rvv.inc.c | 5 ++++-
>  target/riscv/vector_helper.c            | 4 ----
>  3 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


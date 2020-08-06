Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17867221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvQEKXWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17867221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3osh-0000xh-6W
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 19:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3orq-0008Vw-7Q
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 19:00:10 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:44683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3oro-0007vQ-HB
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 19:00:09 -0400
Received: by mail-pg1-x536.google.com with SMTP id m34so1386074pgl.11
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tDvdeLoqAS5o0vI6v0zz99GNsMFN8hc10UgJPe7JNWM=;
 b=BvQEKXWEF1vSYxlCCYQZsiRfBDFlOS1GtfvTdzAfNbkRqvMSfyeGmJF6CInZ0NhiyY
 Q1YOJOiU9q1wSzEAwc0hR9gesDYJ9qqZNqJ4I3NpGLeM/OpbtNumrmKAPDIqQ+mpXTo1
 1rORAMDkARoSEktXJajSouCdMg0x9uHxELEkWHqqKNhqYEKM7pnJ/VCuWtV9w+VO8/nT
 QE0DxcPGLeEPvL09pR/3zvlS205cp7JhQ03mvZQgE2r3HuhW86nD735uot2eRbjAuAN6
 urTKOsz1MxVnMYc6Ux74VfXF+CRYzEH/q67wXTKNRNF91Tp5o+Kz3PBmHlsuEL2QFvZI
 xK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tDvdeLoqAS5o0vI6v0zz99GNsMFN8hc10UgJPe7JNWM=;
 b=Zfaz5gJFKef+UU5mia0iIyQYbrAsZfPiRQtAvmp5rX9G9X4snozMocKUDyhdy8x3uW
 +NRNwCegUacc968JLmWm1YM/opkOUXNJc35qUNAl9LOy7jX37RDpc5PLX65wD3zp2STd
 B2V0zZldJYf/KOSVJ6yTQEYX6FiVcKri5RfbxMynpEVZavLaT7nD7qvxoAmy1W+VZYKr
 0ET8q0bNHeSUCS/bLJyIXv4l30cdoR8Rr8I8aoDlQ88VSL8n9a0iNVtrIjOOhGvT41v7
 b7rDoTyFHfh1RLWFaROKgM4NrL+l2h1JRc5SPpuX9WD3Q3Z8mjiBStVmwkX0GLq7/L5V
 xNaw==
X-Gm-Message-State: AOAM5326iDDRMQQJK3nR7i/RAw2/duGZe5k2RGiVKkxJJ5RnDK4dtrYz
 +bPVkGNHhkkfpq5NEy07d98gIw==
X-Google-Smtp-Source: ABdhPJw6cR4/m5UZ1a6qFPQtdAj1bPwE7bDCziYhmEPMsyEx/jQIOD18PEWwtCYLzgRe5e9c75LmbQ==
X-Received: by 2002:a62:e202:: with SMTP id a2mr10214279pfi.140.1596754807066; 
 Thu, 06 Aug 2020 16:00:07 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t25sm10794494pfl.198.2020.08.06.16.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 16:00:06 -0700 (PDT)
Subject: Re: [RFC v3 18/71] target/riscv: rvv-1.0: apply nanbox helper in
 opfvf_trans
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-19-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe616a74-adb3-0357-dae4-d6f2c7139385@linaro.org>
Date: Thu, 6 Aug 2020 16:00:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104709.13235-19-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

With patches 16 and 17 merged into here,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


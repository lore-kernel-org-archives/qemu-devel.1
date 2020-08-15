Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AC5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF46E22DCC
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tY8QGWDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF46E22DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xiC-0005fn-4c
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xed-0002Gm-VF
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:59:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:45065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xec-0005br-0h
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:59:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id f193so5946388pfa.12
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FI/r/KPM3NamuEvu+F9mW+RliiWbhgVxKmNTvx6BQcc=;
 b=tY8QGWDcFtWOVpQJZV0liCOS04JLlmA+FB8vkBPVaUAkjzJWRbZ+qL2u8k2wtCWGTp
 3YdCfIr+k6HZxtWNVQ1Egi7Mofiq82yxK1dIRNgxayxrq7r3UonSJFfy7YhEcpRkw5pP
 s+lIXKL43zbsR5402wVvQ90q/01MmwnBnMOLGgtAtKaSxq8WWNtfCJDUjNVbX8dknKBr
 sjO+74OkbcioE/8OP1ORS0oKdzw6dw9FxybxOeXfdCE6tJZhU7ZxAeztbln9EkPYcbRG
 bTkf2LP0LntNX0xEnlU5NecLQxpUS1GWU399tE940judQvptUKW+d4lwnpHiqPfLGreb
 IF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FI/r/KPM3NamuEvu+F9mW+RliiWbhgVxKmNTvx6BQcc=;
 b=nDFSRQekty2oLcA8fQjMHZBJlFcz0uZjRN3JyddbsMQuqZC+jXXdTkKVP8gkz/J414
 A5kfGPwOW1Cgcub7KBl1L6uyqDtiiAN7bCuobpE3FTXA7Mv9CrlpJM6WZcP/CxSELw4P
 0rGqJO3KPA6BXNLTj+8LuMqOCwwuTogS7GlF02XhInc2IcidnmMRhOe+VnWFaTTd/bBg
 9ffKhhubLzm1qbN9WhucozVH+aYDJrHGDxUDRAe4XkLwksVg346c3eHTsrgkTe38hjSQ
 1uOrGDp7CFGG4z0gpPsMmrYKxBwUir6uKbuAGJu8NRQPMSSK9qs/H+hI9WQpQJXmUS5F
 x65Q==
X-Gm-Message-State: AOAM531iseNk1FvTVBeeKdil3PsNt7cngGa0A4L/F2tEg2nAx8kGAm9G
 l8MJmC27qulkPk5FYRafozWpQpxdiEAdbA==
X-Google-Smtp-Source: ABdhPJw0LwMD3EbR1FBKH852hmnoFvx+VhSkX3kEnC3/GndsGW0vzotWC3zGi6/oUfpLjWlwj3q9YQ==
X-Received: by 2002:a63:1a66:: with SMTP id a38mr3737132pgm.253.1597469360358; 
 Fri, 14 Aug 2020 22:29:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v78sm11468635pfc.121.2020.08.14.22.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 22:29:19 -0700 (PDT)
Subject: Re: [RFC v3 26/71] target/riscv: rvv-1.0: update vext_max_elems() for
 load/store insns
To: Frank Chang <frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-27-frank.chang@sifive.com>
 <90f01984-54a4-2a56-c52f-d1f4332b39d4@linaro.org>
 <CAE_xrPiJRRV3FYtfve6LMOF6LNEYGfhmi9CiabxqUBEew9igLg@mail.gmail.com>
 <5706a1ca-1dd9-22cd-08ce-c70780111bfc@linaro.org>
 <CAE_xrPgSbzzJqHYTeSND4wQDJUMoMYPmmcH97VE6hRcxh2S54A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de85d715-924a-8156-7424-5c35fd585fb3@linaro.org>
Date: Fri, 14 Aug 2020 22:29:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPgSbzzJqHYTeSND4wQDJUMoMYPmmcH97VE6hRcxh2S54A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 7:52 PM, Frank Chang wrote:
>     probe_pages(env, base + stride * i, nf * esz, ra, access_type);
> and
>     target_ulong addr = base + stride * i + k * esz;
> 
> If we pass ctzl(sizeof(type)) in GEN_VEXT_LD_STRIDE(),
> I would still have to do: (1 << esz) to get the correct element size in the
> above calculations.
> Would it eliminate the performance gain we have in vext_max_elems() instead?

Well, no, it will improve performance, because you'll write

  addr = base + stride * i + (k << esz)

I.e. strength-reduce the multiply to a shift.


r~



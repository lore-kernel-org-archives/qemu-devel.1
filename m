Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73440C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951A8207DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgTDdbk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951A8207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ffL-0004Va-UI
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 14:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2feW-0003jZ-UT
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:57:40 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:35221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2feT-0007iJ-P2
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:57:40 -0400
Received: by mail-pg1-x534.google.com with SMTP id o5so2544206pgb.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9SR8aJxp76dwQjm8gpP0eZpbbdelARJFGvLfkpS1Jpw=;
 b=tgTDdbk1dyspLbdfGfSLyU86onm6Q3pQrMiIto9YSHvtXMpUpzTXe3UKAsiGvgtWpN
 gs0sVV7qAjMOJH3G+RnbsO1PdGwMEkFK9ZuIAyMROnkomTRGL61qRGAGDxs7fpP5t9LM
 SIf8qL/3ToGiXqohTBJIJyYBcXTPQPKOZqmlvgCesQghB3Vm8KQGCCwsQjpYqMirTueF
 x6TBMMBq1AcNBqNT+faK0sK5I8a5cKfYc9op8KMpQSPSBFWFLLTzl4RPxcOt5SilJFXj
 K+YkF4htMjjlKfjGXYI4LNdPiHmxo9pY075Bqj7T2t07htcay2Vggzona1WrR8YVOXD3
 On5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9SR8aJxp76dwQjm8gpP0eZpbbdelARJFGvLfkpS1Jpw=;
 b=Ai+Do4Ym+S/tpn7fx6I0nD+9uCIanaZtn6/V3TypTkIjuhCGILO2ecKHTIEflb8lI7
 uQl0wESQYxWefBt72B1tHNhnslZSj9iyvfFKjTWPP2T8AHwgJCBb4EC9xphxlYv8AhJO
 r/Ig3oItWXaECvlQuqj2XzMgoG0fJHdcjmKcaCfz5QtwWj4ZO26v4/n/GSs6NvqY0neo
 TXxYOmUZCjt7x2i3B+1MOhumtWIcqHyUWvzDC+CBWdWD0IlDGkX+JsSwVbRDSh3hr+nV
 koA6qzHC0Rw61IZCU1/EJGotqMTYDySLGsuFS42twhIkrwo2iYVhyIUTLRx28NT5FgwM
 X3sQ==
X-Gm-Message-State: AOAM532Dh1vlIhN22L8vzPfs2EVh8zn5lYUARpRgzGATCO2ceeHdNz0s
 4bY5Q9EyoO+FjFOohrU5rf4C6w==
X-Google-Smtp-Source: ABdhPJxmROqEDNiLfjtiuOxrHo4KyTxVeVb5Q2nb5sxLjU5Y0SuUpWW86L4cP37GXMNGog7BIZ2ZxQ==
X-Received: by 2002:a63:d951:: with SMTP id e17mr15633737pgj.318.1596481056196; 
 Mon, 03 Aug 2020 11:57:36 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b26sm12012029pff.54.2020.08.03.11.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 11:57:35 -0700 (PDT)
Subject: Re: [RFC v2 59/76] target/riscv: rvv-0.9: floating-point slide
 instructions
To: Frank Chang <frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-60-frank.chang@sifive.com>
 <8ae82210-965a-25cc-46d6-f3d2e05e88a5@linaro.org>
 <CAE_xrPjqNSJBvK3E6c4FW3idxOvHGCf9Sj0x1918rqV35vL77A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e630d88c-4eff-bf2c-5244-128b49c4c9f4@linaro.org>
Date: Mon, 3 Aug 2020 11:57:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPjqNSJBvK3E6c4FW3idxOvHGCf9Sj0x1918rqV35vL77A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 3:35 AM, Frank Chang wrote:
> i.e.
> /DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, *tl*, ptr, env, i32)/ vs.
> /DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, *i64*, ptr, env, i32)/
> 
> As /opfvf_trans()/ and /opivx_trans()/ are shared among other instructions,
> I wouldn't like to make prototype changes to these functions.
> 
> So far what I can come up with is to extract the logic in /vslide1up/'s
> helper function to an individual static function and make /vslide1up/
> and /vfslide1up/'s helper functions to call this static function.
> 
> So that the're no redundant logic to be redefined.
> However, this still require to declare /vfslide1up'/s/ /helper function explicitly
> as its function prototype is different with /vslide1up/.

Well, of course the alternative is to adjust the prototypes to be the same,
avoiding TCGv and tl.  That would require an adjustment in the translator
though, which would require a different form of macro instead of GEN_OPIVX_TRANS.

It could be cleanest to do what you have done; hard to tell.


r~


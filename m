Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094DCC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243EB2226B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReC90+/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243EB2226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRErm-0000Yn-7d
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 09:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kREq9-0007xh-C7
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 09:23:13 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kREq6-0000SQ-Eu
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 09:23:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id f37so11510247otf.12
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kLvZ3Ba9N5ZK4eb+Ofd69hXQfdMvwMbkzGHm6B1jLS0=;
 b=ReC90+/km+k4j/1D1jY1VoluypW3L/fPuQtv0jUsRc8jWcZnhEFY4okjUFOR5Cx4ki
 QxmO+gpG4t1ZS4NXPCFpNWbKoTfm0DNuy2F69WWuw07Mdd+kZGNWcytmG1lcgfBCNKLV
 /jSs6S2L+Og+XIxZv5JRiqa0RLlAYzPpUFSeTM9bQFVh5mxwbka6iOM4MfQoTXqxKd9s
 tb/yJRn3ayItY5o8vL+5j2yNoSvD/z03LSsBH80VoHeRB1uLmy0oA0vFHvE6e0hsLofc
 tLVokRToMgLkNNljBc17R9/hgbB+CXdJRzmRNXdkaS0wbFwIjsMBFP21pQFbTmsuYJjm
 frsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kLvZ3Ba9N5ZK4eb+Ofd69hXQfdMvwMbkzGHm6B1jLS0=;
 b=t1fnZhO0CIWFi6qcYXvVskHk2GLzRY6FQd4z6xDQsyic7RcS8KQ+45MvZHzmACWXDf
 y/oOW7bXjKpiKtp2bqCbjajOYtlsV2iJ8oBItCQ1gC/GOygT6hreA9QMYBWAUgBAuVIf
 i2/XoAcZJ0NzSpIoy3H/sLifCw00tm9Nj6nlOkPsrPHeDg0R6TjGGZKpdzeSj6DyRxxp
 PpguBDPx06IotoudesLI9YWDeccYjrMVL0QL4bp7fU/I9XcRWRJ7WZWe6IqpJMyoLvZV
 in0VUsn2hOuI3D3llxgGwrq5z3dRVwp2NIlDaGJJfIqgo1MgaAK3fawJY5FVmwGs0yqB
 6bow==
X-Gm-Message-State: AOAM533LV2jVZAO3VYheNbqwBgJNT9o6uy/vxCH+KSp8DDbHmdgwos0C
 xeS6fGmLkqZqVFFMSDrvQjya1Q==
X-Google-Smtp-Source: ABdhPJx6cjfGBU4Wo9GMmGQvpNwEvUqUwvPKCYuoDJ7sNFig/l49Wum+aQ3CI7Y0XPKIrgag7gEqMA==
X-Received: by 2002:a9d:6349:: with SMTP id y9mr11521312otk.246.1602336188532; 
 Sat, 10 Oct 2020 06:23:08 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id q8sm7001868otf.7.2020.10.10.06.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 06:23:07 -0700 (PDT)
Subject: Re: [PATCH V2 1/5] target/riscv: Add basic vmstate description of CPU
To: Yifei Jiang <jiangyifei@huawei.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20201010080623.768-1-jiangyifei@huawei.com>
 <20201010080623.768-2-jiangyifei@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0bc022ca-35f6-8579-51f1-65005e89a9a3@linaro.org>
Date: Sat, 10 Oct 2020 08:23:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201010080623.768-2-jiangyifei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.207,
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 Alistair.Francis@wdc.com, yinyipeng1@huawei.com, palmer@dabbelt.com,
 wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 3:06 AM, Yifei Jiang wrote:
> +++ b/target/riscv/cpu.h
> @@ -311,6 +311,10 @@ extern const char * const riscv_fpr_regnames[];
>  extern const char * const riscv_excp_names[];
>  extern const char * const riscv_intr_names[];
>  
> +#ifndef CONFIG_USER_ONLY
> +extern const VMStateDescription vmstate_riscv_cpu;
> +#endif
> +

This is not part of the public interface to RISCVCPU, so it should go in
internals.h.

Not that there aren't other things in cpu.h that don't belong.  No target has
been perfect in differentiating what's interface and what's implementation.

> +
> +#ifdef TARGET_RISCV32
> +        VMSTATE_UINTTL(env.mstatush, RISCVCPU),
> +#endif

Would this be a good time to expand mstatus to uint64_t instead of target_ulong
so that it can be saved as one unit and reduce some ifdefs in the code base?

Similarly with some of the other status registers that are two halved for riscv32.


r~


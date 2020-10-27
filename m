Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4225E207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdvTd+f1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4225E207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXU1a-0002RK-0a
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXTz3-0000gv-MF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:46:16 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXTyu-0006OP-JA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:46:10 -0400
Received: by mail-pg1-x543.google.com with SMTP id n16so1283756pgv.13
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WEGB00gKH/k4VlfeScpKtujT9Ah0HC3vbWmmS+rHb3Y=;
 b=WdvTd+f1xC6USJpBeh6SKrcrBQaHqxtbwhRTwzy9u12UW29UTdNWD1ydPBEIsV4Aep
 HJwym6Bocxvrf7gWkiDiZEUeHE87YJAB/Va5QZGnxNgxIUDGmY2OdE7zN6Q3kkmmX1lf
 QjZS7EFA8Gv6mD9nYjsgfXkbHAkImu1kkT9zO+jDMFn101G2OceveTDQyFlMI9Kq07u2
 yRmLPaxEvFradhVhpA5gwIXRNrLQbAEPatwFkc3RMcPcXyxI8TMWH5/qSnhmt2KtcQHC
 l7Vt8Tx7bPqWJy+G1qZs/IGSdtFwzvyCYSWjguFTtCsbGhSukayj4uF6J484peqFlB7F
 9H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WEGB00gKH/k4VlfeScpKtujT9Ah0HC3vbWmmS+rHb3Y=;
 b=AOVaYZ+ATLwlt5PTHkEYIcPbPwtiSS3z1Fx3Tv9Q87n+TY/hL2SFInaq06JbLqgA7W
 BMTp12n7mwxpEBXGZmrDF0hYuBLj94kH8wug6SIEXC7t60XM7Uf8kU8RJEZh4yT67b9M
 1dbIngDigyxNbB0YNLLQ5SuTbXOjDKsDriHspiTcIzCiEIMhOeIda7GN1zBzMMTywtO1
 03Trj7fWzZK3Y7kHEKrTyj/zwqFs7B4F/fZakO73Waj5jcL/ptcEGdJovIQdWEETpLJ1
 uSMWns9kvqgksz/pleOduNBClluhbLFrsyOr4NonbBRKr7+YnjxvfJSul4B6t4OgFSyI
 s1mw==
X-Gm-Message-State: AOAM533K1WcdgzgFos4jfQpbRwTukKhN35MRy6do90uqSuQieC/qA400
 pvmTHq8j/S2cpq0mR96ootiwmQ==
X-Google-Smtp-Source: ABdhPJx9SwmOCtU6Rl56InsoWfiLo/gfVcN6hp9fy/QuGum3DHU2q1xuda0aGvS7bkgWyyaj7Vk6dQ==
X-Received: by 2002:a62:be04:0:b029:15d:7423:e320 with SMTP id
 l4-20020a62be040000b029015d7423e320mr3523845pff.42.1603824363057; 
 Tue, 27 Oct 2020 11:46:03 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m13sm2684957pjl.45.2020.10.27.11.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 11:46:02 -0700 (PDT)
Subject: Re: [PATCH V4 1/6] target/riscv: Merge m/vsstatus and m/vsstatush
 into one uint64_t unit
To: Yifei Jiang <jiangyifei@huawei.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20201026115530.304-1-jiangyifei@huawei.com>
 <20201026115530.304-2-jiangyifei@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91908cb7-0677-96f1-327d-e69f8094fec3@linaro.org>
Date: Tue, 27 Oct 2020 11:45:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026115530.304-2-jiangyifei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.167,
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

On 10/26/20 4:55 AM, Yifei Jiang wrote:
> -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", (target_ulong)env->mstatus);

This is truncating mstatus to target_ulong, i.e. breaking the output for
riscv32.  You should use PRIx64 and print the whole 64-bit value.


r~


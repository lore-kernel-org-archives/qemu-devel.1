Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6BDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567412074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZVipeAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567412074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGUv-0006SA-Iq
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGTq-0005Q6-L6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:50:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGTp-0006Tx-7u
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:50:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id b16so5290668pfi.13
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zuM3Ss61uV7K9Slj9YXzJ50CwuFDaA4NA1rXaFp4tWA=;
 b=PZVipeApRDnZjANzqPgvyrvd94KlmYlLJJYP1v8mICk6XwbJEEcrks2B1+l2UYKjMW
 odSYrSJcex8v9Hw2xXbQBQOExo6EtAg4pqm1FGUuwJTdCTN0Dm41DVXv6/qyWS9wnUTj
 juxN7+16rZOsrGOfjjNmUGSQ2QIvgtOY6mRT/N96niXKxS0KY7WPxaexIICyBoUq32Bp
 pPebbogORckfqqgeTjf+fXk1J6VpwYROijRh5v9L91tJ32vWR0NOVcrZOzsq15y6D8v+
 ggohIrvr6XZdGe2f98qT6ZrdwiqrrGqITBpC8hD8hydAaFgx36PQKMfdULbGAS9KJGTd
 gh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zuM3Ss61uV7K9Slj9YXzJ50CwuFDaA4NA1rXaFp4tWA=;
 b=JrZinebRNjvwdAe9PUmDIMgc5WhsfXQsQ7/wVpJN9VK0KByiUs77BkcTQY+xIpAE7b
 MuSThJHC30HuSxriAC5Sj8UHEknTCq0fgs78+rIiHSMraGQUt2cwbbkb9aCBjLAF8r1d
 5pIcRyC0/BuWGSOnApLrNxrWJViQDuZ+SxO0Om6ZwK1Pe3OTTFffGio0ln/y1d7Bs8xE
 N5KUkmZ4DcBwFBXLNaJEfTB/6zEJou7k5t0PvGV14Y9OU27mFGUx1ldb9hxwj3U35fZz
 zTnljQVVrCMHumB10oVr3unyThAhSUvMKivy55WHJYG8BdBIm6Hn369xkRB0joKp5WYi
 vvlQ==
X-Gm-Message-State: AOAM531sPaOwHNQ6cNMXUw3VjUoM9PVy0UQ1ahUazaZpRU+StYCgLKtp
 gGUWJ9MQtRM7W3F9RgR0Zb/V5g==
X-Google-Smtp-Source: ABdhPJzxnvV8wm/kwBf8GnHqdmH27lIDLge48DOT92yCDhlrBJZCNNh87knWk1h+BgbWwoSUiOcteQ==
X-Received: by 2002:a65:51c1:: with SMTP id i1mr10384854pgq.272.1591379407696; 
 Fri, 05 Jun 2020 10:50:07 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z24sm228815pfk.29.2020.06.05.10.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 10:50:06 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] target/riscv: Set access as data_load when
 validating stage-2 PTEs
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1591319882.git.alistair@alistair23.me>
 <5556f87b6d71a61f5e9113873d91132e08ac6b2f.1591319882.git.alistair@alistair23.me>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3289584f-74a4-b9fe-0c24-dc711711a5a7@linaro.org>
Date: Fri, 5 Jun 2020 10:49:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5556f87b6d71a61f5e9113873d91132e08ac6b2f.1591319882.git.alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, anup.pate@wdc.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 6:20 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


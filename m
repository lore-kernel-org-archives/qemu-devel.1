Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CDC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 05:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706BE2074B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 05:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oeaaXjsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706BE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCzQK-0000j5-MG
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 01:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCzPi-0000HH-Ov
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 01:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCzPh-0003L2-Fq
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 01:32:46 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCzPh-0003J5-90
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 01:32:45 -0400
Received: by mail-pf1-x444.google.com with SMTP id i13so6570952pfe.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 22:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W7riT3PAPCj4pGbZE9tcdq+XHnkSeh42mDhaZviyPs0=;
 b=oeaaXjsizGMiAT8DDQ0rwz9IWqXiXI8Dj4xjc7XLDPQlCFLHYN8wvX4sAmbVs+10EU
 ihahasP6Mf7lERNh/MEi+zuZs9obeCmvuOGjHHL3c2v/ry25SNjfPVwyYrQDHQimoxZf
 iCLjetLU1HkspBDeCnB+Ns0Dd0GoAY8nPu4uVNN5JbhNqli1ZuybysxBv0DoIWcgkAi1
 KaInZAn33iHLSmD7duEbjWbCeNeNbsyTkpfOFHyLsRmz0WaCeutIq2o3MFRZRhwvSInC
 LIWHUB4DD6qM1GWrUSTCZc4HTFHPjtfn2CXVkviDmq+mVjmtquSjrATTu8p+r8MgIxrY
 /SxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W7riT3PAPCj4pGbZE9tcdq+XHnkSeh42mDhaZviyPs0=;
 b=DWNjMTLICT6eJ+BYlM+m+OzgdtQsyIzozxEjdAm+VCFel71PK/aFsGsrmwk9TOQYcw
 lmBC4VzK172YC0XdzOoMXyfUTlSON4WxvTxKeBPO0R37Tnvo2GTBu8JYhJogOv7Zx8tx
 k6Y/d6LjUxgNcF5ti3SY2p80Nbe84oJIsUVWKG+uJrn2VgnmjfB1kobjoXrgHl8htP03
 sL8lN+DfbFcaOupQch867ysbXdvfBCWz717rr1QhhqidhxvhH9UX1Cb258bXQlJEa2uv
 v8Ew+q9VVl2K3xe4OGn3TArFxYkurBmvB+V0lM0WkvE+rzjfTZ8Ifb8PDLPML56YJzIM
 RxGA==
X-Gm-Message-State: ANhLgQ0G5Aanse6YcqPNwvRS1Q7/qXFpYcPiV4pspUfGumk6gb0ZgaOp
 ECCtH4RTAf/DTTeokfUjs9p22Q==
X-Google-Smtp-Source: ADFU+vtKXIiMDjwnwK0Pewg+Un9fOHhEwucRjvChXof1RmFtIPXiCAn8AQ9V7ZzVijwRHGKZ8Sy7ZA==
X-Received: by 2002:a63:a361:: with SMTP id v33mr16172059pgn.324.1584163964087; 
 Fri, 13 Mar 2020 22:32:44 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 nl3sm14700519pjb.12.2020.03.13.22.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 22:32:43 -0700 (PDT)
Subject: Re: [PATCH v5 10/60] target/riscv: vector widening integer add and
 subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-11-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a441beff-45d1-21fe-2efb-9614e4d64387@linaro.org>
Date: Fri, 13 Mar 2020 22:32:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-11-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  49 ++++++++
>  target/riscv/insn32.decode              |  16 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 154 ++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 112 +++++++++++++++++
>  4 files changed, 331 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB36FC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84278221EB
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDe3o18D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84278221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDGXs-0003GJ-Mg
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 19:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDGX7-0002oU-Ky
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDGX6-0000qs-LP
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:49:33 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDGX6-0000mv-F2
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:49:32 -0400
Received: by mail-pj1-x1042.google.com with SMTP id d8so6277627pje.4
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 16:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vnVePBa1aHYXXk2MUCRDLoPKiQn8rBG94p7anAPutsM=;
 b=EDe3o18DGTYOAwVU6+j7I59m2cw7264zEmL2VuvYN2hZgiAzufrJ2ri4apShP4xfWD
 H58ZRp4Gdg8ROgBBzGJoDU3WPiBm42N9p20DX5EGaGqmrKZM3BUb/oAjB85LMI5UhjTJ
 F1QKoGcs9Ht2UmVx4CqK97xiyifnYDJrjTLoXmahHvYYnel840VmRrhTVKCGb42YtF8U
 p2NLjIcE9Cu955Uq8WPtOf/f7RdTdcObfzTIZJCQ0qAUdBbBMnfliMwb+1yMt99+UFbf
 YGq7PXgtleP7bQLyQBUljbi0x56epIMbqv7CfBLiUv3VVF62Z24FEI4qrmamnt0+E5JJ
 3ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vnVePBa1aHYXXk2MUCRDLoPKiQn8rBG94p7anAPutsM=;
 b=EbfLYOZ0nhT05unzvxBgzq2sX223B/tXLMqkdRg6c6HOZwj6gaI8t29yBSTHYavBiX
 /522KI8r2vjDPhjvfpbhDwzgBHLLIvCS0eAyIKekWqvKe/kUWwSTB+z3W0Hm9pYadGTb
 /pup787g3dF44eyDL6ZBNOaxn2rVwNTRYnneNL514G/p/n6Qcwz6IF9i46Jvo+b8mfE9
 rSZchfFzYe/fRlnP9+94VQ6jTCG/82sy2hagQopW2i45kZ2rAhLNq1H0Xtxmj7ciovn6
 hFNvt4Py62uz/VhYojEP9Wkr7o3KeK7JpMP7FDRLobQa0WD4DxpbL2jtRVUcMQggOQCa
 VNew==
X-Gm-Message-State: ANhLgQ0+Sc0lr0x62BIZGIL6RDnxHS4CChU7KIu/v1Wjm2rjSEpsQc9T
 GWiv7ZmkK0BAjt8vvefjqt3Y5Q==
X-Google-Smtp-Source: ADFU+vuO73eOUfkSqESCtk6hFBLZ+6us9KfEdvIc179/AAKDr/NV5v0mptEvKJvauTUKWRCjL2qKoQ==
X-Received: by 2002:a17:902:b485:: with SMTP id
 y5mr18960158plr.4.1584229771341; 
 Sat, 14 Mar 2020 16:49:31 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e28sm60899937pgn.21.2020.03.14.16.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 16:49:30 -0700 (PDT)
Subject: Re: [PATCH v5 47/60] target/riscv: vector widening floating-point
 reduction instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-48-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <843f39db-21df-37cf-cdbd-ae6b08aa9b0c@linaro.org>
Date: Sat, 14 Mar 2020 16:49:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-48-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
>  target/riscv/helper.h                   |  3 ++
>  target/riscv/insn32.decode              |  2 +
>  target/riscv/insn_trans/trans_rvv.inc.c |  3 ++
>  target/riscv/vector_helper.c            | 50 +++++++++++++++++++++++++
>  4 files changed, 58 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



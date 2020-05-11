Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F7AC54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEEE206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNUouRuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEEE206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCoJ-0006hG-Ka
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCmw-0005BT-L0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:04:26 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCmv-0001Ue-81
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:04:26 -0400
Received: by mail-pg1-x541.google.com with SMTP id f6so4912521pgm.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eCRzVp62mSxMAEEz+I7VSkKo2tvnwi1uu/90viuOvjU=;
 b=GNUouRuUmdIw400Cyo8nV59d1VFXxc+jY7HUSwOp0RIGU1icGcE5EHh8gNT4gPB26g
 2Y4E8vUe3MRCd4nNwQuxgt93f97lzd5r8aR3lSnXTqMuSQJIslpVwxxdokWXBjg2aP9I
 Wm31MFYYhME4awAXcgc299ec8wtZWKKbf7WDft0DT6Tjre6VHkJGu6kGw+Mp5dqsWCR8
 uUKwZIj6a2QSERwTRi8WTL9EBudugBVEcQ1C1AEL5WcOhI8pihWx0LSH9nBJ3JcDcF6Z
 SgyCfuk4S/6SUGPfaxp7XHb/7SHXWcLr8oP84T7jBpnCHdcs4OfyGPbmOLU4geXt9b1X
 +PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eCRzVp62mSxMAEEz+I7VSkKo2tvnwi1uu/90viuOvjU=;
 b=KrAstM6980TjMbxQTGXPEjNAWUCLKnSdn3qO9hdPZdXrSY2Ui1kx9XpUapUwh7m7QD
 YnozS9nBV2fenxTXsD/IxsB7ZiSrec7XoinRQq8YXRe5FCP2S0ql1sYWPvY//94G6jGe
 G5V0WLvXfIXL7V3SH4RTwaouZ9cC5dQToVJPZr49JFDeW/WExuCWnSZbiAsd/0/1PF/H
 cKxxxz4WJgA1yiksjcEoiHRP6eck8Q3Jw0q0iptS3ke1g5pUu2jEMirgEuTlUILglBKD
 mTBUM2otMDAo8XFmGO1gApFWnC94O8McXoquz2q83iqYoRdIN3DGkqgdZMn7fExFoMTn
 /utg==
X-Gm-Message-State: AGi0PuZ4MKafy6dXeM2vf6YW2uSEuraggoO4ezNnz+9nk9r0ZwYJ1L/G
 memhm+nO7ALRQwg9/IbjC5yUag==
X-Google-Smtp-Source: APiQypL/iOjveScXvHS2VX5DaPlZj0P27T7bCGdy8HE3XKMm4d/13yFd5v9O/p+TgLSn1Tco4XWi5A==
X-Received: by 2002:a63:555c:: with SMTP id f28mr16078954pgm.80.1589220263571; 
 Mon, 11 May 2020 11:04:23 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a12sm9733302pfr.28.2020.05.11.11.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 11:04:22 -0700 (PDT)
Subject: Re: [RFC PATCH 5/8] riscv: Add standard test case
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-6-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96bc38d9-02e9-ca10-2db8-a279131366b2@linaro.org>
Date: Mon, 11 May 2020 11:04:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430072139.4602-6-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:21 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  test_riscv64.s | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 test_riscv64.s

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


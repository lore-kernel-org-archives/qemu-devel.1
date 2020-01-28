Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541FEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22033206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdSYwsPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22033206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWm1-0000ju-BP
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwVf8-0000CM-Mo
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwVf7-0000Eg-HU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:32:34 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwVf7-0000CR-9o
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:32:33 -0500
Received: by mail-pl1-x641.google.com with SMTP id t6so5449879plj.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 10:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3FFMCR8sdXEoSiA365oWEWFgYiyrqQdXUFAmRVZXTUw=;
 b=hdSYwsPrGkkncCD4J9tQsacjrzQ13mi6LmEzBkuRoA8MQ1YLREp2945t/WLphzXB/P
 12JXkr2qYeUF7G5CAuckEeabC1rHXYaoC8azN6QkTrcQ4221G5DvJhwxqPXUTUWRZZN0
 FYtXOBBF+JYvzKtq6rHTz5Q4bAN/W0NZq0SN5f8iRE1xcEDoTA69NqV6Gbqo8CKn4BCZ
 T35M1urJgR69+C+lPyFSPbHggQpH6xlbEV+72to5fKx6kSzghfxdeOj8lpDuP7M82ZhR
 lzfHQeSSyI4IwLGIa/Hx3s+eR4FoJgjgqfKVTQsFyMY7DAwnkX+oIZ/EraZs6g0zseb7
 gUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3FFMCR8sdXEoSiA365oWEWFgYiyrqQdXUFAmRVZXTUw=;
 b=EhOGFAq7dMDRuvcNeKEEVldK+jSlN8adtVDuYb3RWU0rTON+OReGGEX432mufiG+M7
 FgpCnEfbVau9KlWIhoURhLV1+YtBl9r+Li93u8H7A6p9DN1XuOvRv7FKdxc0WXur+msc
 wZbSnxI7YFdmpIsSMBqMJA1cJ5VH/aSNw+GwRcKFWirMGX8lahoIHksi7jqsiR3ssQ3H
 fAR4Vf++61Y7sHZ/ZMN6DPwdjV9OQsM3Zl7+57TZ7hhkbJl3y10W4IFd4Vh0qRLfPWr5
 NXFaAga9Kpwo61KmMyDN6lP4wGLBV7kesXtD4ssGkq7RD5CVGb21gd6J0FPmgZK1Pg8P
 C/+Q==
X-Gm-Message-State: APjAAAXBwIgBC9KkMu16Go9ESUXQTr5jnf+TXIEI8uXfuzoqvz2gLkcf
 mtJEAIfW2WcNcZjATMLdHxdwrQ==
X-Google-Smtp-Source: APXvYqyFLSDUuIkAvp4Uc3BBRrFgmW3hn5+6demG/yFr7hjJiR1ZJs7TN7OooI/cgyecvjc780jISA==
X-Received: by 2002:a17:90a:a88f:: with SMTP id
 h15mr6503848pjq.32.1580236351958; 
 Tue, 28 Jan 2020 10:32:31 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 m71sm3440296pje.0.2020.01.28.10.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 10:32:31 -0800 (PST)
Subject: Re: [PATCH v2] riscv: Add helper to make NaN-boxing for FP register
To: Ian Jiang <ianjiang.ict@gmail.com>, qemu-devel@nongnu.org
References: <20200128003707.17028-1-ianjiang.ict@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b14a65dd-b565-77ca-d479-f88e53ca0721@linaro.org>
Date: Tue, 28 Jan 2020 10:32:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128003707.17028-1-ianjiang.ict@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 4:37 PM, Ian Jiang wrote:
> The function that makes NaN-boxing when a 32-bit value is assigned
> to a 64-bit FP register is split out to a helper gen_nanbox_fpr().
> Then it is applied in translating of the FLW instruction.
> 
> Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
> ---
>  target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


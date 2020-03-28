Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FD7C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECE42073B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CnOW+ofl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECE42073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI2cJ-00088P-9V
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 23:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jI2bf-0007g9-40
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jI2be-00058q-2Q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:57:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jI2bd-00058C-PJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:57:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id d37so5123003pgl.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 20:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v63jdjHMa34GweLIYpGjS74osC4ZDLGriEaDp/Ur9aw=;
 b=CnOW+ofl9/VwkAMvx0mdOYgdfbWGjENgg770unos9KwR7xiofYjFVxvy+zmhTK22BU
 Ppc+iGBWfjukMRLCmO7WHiv1YMdkON2uD9Uy52D5SpDRnIq5q1ZhZyDY1B7u6w+PIYha
 OohLEllmqTqDBovt4BW+5vv+bxtXJGuILhDKqbWVgcUE0fQ7/aaIZDdwOB1uHz/ru1ih
 1auAM1ejMuOHcDi1lNVVGnDlrdGag9rS7n7nT07Czwp3OcyciC5a2evxU/hJ8Cm7+riK
 0kRNyYB+gNP2RYetbRg22fBIgyryzbffW+Dfo/wIlvgNMqEnYfytECiTlFAPy1vnozqL
 zfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v63jdjHMa34GweLIYpGjS74osC4ZDLGriEaDp/Ur9aw=;
 b=gQkAizFEu9MljftLLhzSaRSPU+0WBfSdK2sAhqDaqhyumYDOvsJECLKDq7gpPjfWGl
 G3msjDh87Qu9ccnYqmiZZq8/uSfrw2reI2laMHLXEn8n44d5VCwHsJm2gbIjOtH/xshw
 8pUhLOnwBMEYQwPVyYsgOlofJRuyYzKEsmzozJscB3HvH3JoX4XrgvW9AlYWSU2g1RU9
 VqhoPZzhwR0gpzczumktfxFN7oV7MijmVeWs/StBp5P+bzUOTxQuzOn22Z/ML4ARZGXF
 Lp17P2jnjDWICyTAYVGerTtS3xSN7gLeU7Hwfz9SmiInsP1P7o2ElbZDqp5R/p/tjXQ9
 tLlg==
X-Gm-Message-State: ANhLgQ3K4ApDDcnjURfZwfvY3hyPiimUQqlUFeMJrp5HYkzJN8WerJvY
 IGvgOKGCgOHTxgKlWE80yeZtFw==
X-Google-Smtp-Source: ADFU+vuGz8r2wvgnnr1w4ACd1lo9wb56yR0hiM/uwAxUmiYJ6x13KaGaihtrJUmrqsebhXWqeeOAhQ==
X-Received: by 2002:aa7:9e42:: with SMTP id z2mr2493175pfq.109.1585367876286; 
 Fri, 27 Mar 2020 20:57:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id 144sm4938726pgd.29.2020.03.27.20.57.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 20:57:55 -0700 (PDT)
Subject: Re: [PATCH v6 59/61] target/riscv: vector register gather instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-60-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2c3feba-9a54-79c6-cb2d-fbc7d7ca7dac@linaro.org>
Date: Fri, 27 Mar 2020 20:57:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-60-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |   9 ++
>  target/riscv/insn32.decode              |   3 +
>  target/riscv/insn_trans/trans_rvv.inc.c | 127 ++++++++++++++++++++++++
>  target/riscv/vector_helper.c            |  64 ++++++++++++
>  4 files changed, 203 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



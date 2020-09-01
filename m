Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E077AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E9B2083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7kT67c2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E9B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD30E-0004Az-Qj
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2po-0002A6-99; Tue, 01 Sep 2020 05:44:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2pN-0002Be-UV; Tue, 01 Sep 2020 05:44:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id j2so750165wrx.7;
 Tue, 01 Sep 2020 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tMGemdzIY8cXvrI0NskeWxxpDDZ5u3lB6tzZ7zTDUqg=;
 b=B7kT67c2dbVQeksS5sowaTTqUMcMVlrmDTVjQgGARnnw5UWYfzcymPY01YQZWebZzu
 WIyaFTgdtVzG+Wio1BPneh6GHZJ4Lc8CatUtSwzP7u46mPYFfPFCvnBpYunsEyG6krWb
 APbnQJXSLQKVKqDAiGTXLVkz4YsiCgIcg/S+aI7pZRkzo41oyMZ+3OOfi04jKl/UNOqG
 y5PrRJ7IyNNURpZnJ9eIehUZyRxxNJj/hh5wZxWDXnYGSAtrKiL4tK3mzYC4auHMIi+7
 H3DODKhmt5V3b2w5NG2u/pgVy/UbIDwgZId9OrhAGlNDQepIxbBBTPu7Yf545hal7mIP
 uLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tMGemdzIY8cXvrI0NskeWxxpDDZ5u3lB6tzZ7zTDUqg=;
 b=GFNe+iTsN8AkMlvmoZ+IeXXvWmoLZs2ObL/C2d37+3kIR9wQP2ghBjEETbUi0xK3+M
 k87QhFyFBSZtcTu6xtzic5zZJ1/8rHwX8ktlpM8CVzNRLvS4koe9TeuLad9Bh8Zjci+V
 l915eFpsli92/XELo5QdcBiY8rW5bg5u290EFoKFoatwgOIfkSgv5IHNvdEzqu1Ptikk
 Xp4/fMr3tGwL3WiJ9r9NFB5uxoBYGahholXeAnOp1KGMHv8R2t4biHFrFvAuCCiRLYUh
 hv/PReVtYx5RZLfwF5EJq5T4tRMnKvLOZ47Co15riwq0drawUe1jZ6Ea2HGDQW6EiJow
 vqag==
X-Gm-Message-State: AOAM530m4GqkbWGeQzQnYuBvHA9zhPnVT2XJnunQMdi4vrKZHpTM9lZZ
 KKTzLt2vcPtCVlEON61Ne2E=
X-Google-Smtp-Source: ABdhPJyWvN74sgiKjkWxoMYphv9KV0BuPTkcPU7PyawGlE2yo2QPr5xH3DaOX/1Zy3nR5Hw5qCY5Fg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr966447wru.30.1598953423875;
 Tue, 01 Sep 2020 02:43:43 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id g18sm1571775wru.27.2020.09.01.02.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:43:42 -0700 (PDT)
Subject: Re: [PATCH v3 11/16] hw/net: cadence_gem: Add a new 'phy-addr'
 property
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-12-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4caad02-6081-c0c7-ad2d-e10a75e1c816@amsat.org>
Date: Tue, 1 Sep 2020 11:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598924352-89526-12-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:39 AM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> At present the PHY address of the PHY connected to GEM is hard-coded
> to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case for
> all boards. Add a new 'phy-addr' property so that board can specify
> the PHY address for each GEM instance.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - change "phy-addr" default value to BOARD_PHY_ADDRESS
> 
>  include/hw/net/cadence_gem.h | 2 ++
>  hw/net/cadence_gem.c         | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


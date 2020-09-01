Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723C4C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3212083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evlxLmVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3212083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2xL-0007fD-Cl
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2j5-0005ti-AU; Tue, 01 Sep 2020 05:37:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2j3-0001Xh-OD; Tue, 01 Sep 2020 05:37:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id c18so716451wrm.9;
 Tue, 01 Sep 2020 02:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IyzL7jyhMcu6eGehfaT5P8dSwD+lmQVa3PMr1t3AYME=;
 b=evlxLmVbzEGL0nVPm5WzGxZ4WxIDdnYfUSVqfofRSm8zvIKpCG/WJBj3f4l3GFse/3
 U97Q97n/GE9c7ONcXYSiRtFl7WvS2VhnOPy6y5zePmeTMmFoGDCgR45R9TdnWs2qpiJu
 2B4vpMOrxh2l2D0Cr+hRig4TgOEcGRKs5m1DjT7i5JQ3K3HMrhrjZR4AvEFAbs2Ekg1+
 WOx9zYGKmexAYWQe7O8kKtFCldWjlr6+eztKRqH7kPMRE+GiTuiKA7Whi8WPURkG/FdV
 jePA2E2Rz0d03rL0HkwD1GqisQn99sWtKjwNiKZwho6GIU9VHVOSADaHAVr+5yvZSA27
 IZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IyzL7jyhMcu6eGehfaT5P8dSwD+lmQVa3PMr1t3AYME=;
 b=obvfKCUq1FofvuFJM7uXp9fzf42ltKX3rVYPzMGnv2g5FbZ0fuhXHgx4u2WE4vZsPx
 BTGmHI81hzfWH3oahoT3O2QsTef5/K5sAepnIHvESb1q1Gte4SGAQodj/nS37/2ncAMR
 DpQA+lE/cdd/gpMZBFrQAeccYIH+tZYBAVsmPbnQj8P7k1vVoCAl4dKBDk5nya66PVBr
 G688bDfhG1XcGOqa1KftvOSFz4xcspzw1ynWU2caSCJFpLlLp5xkGypbqu9ltZcTn0mv
 BYgFSY1Q1Ju9OU4mauUyTiiagQ2It8hNcWXmxX3pJ4jz8HW4QoccD17YqE1kpaB+F3QZ
 YYAA==
X-Gm-Message-State: AOAM533G0X/EcUMifpizinfvananNY7GmvGLcG/8SD8NDQoxmlpVFPxe
 pgqdr9+YxHxhzx7OBU8bZg0=
X-Google-Smtp-Source: ABdhPJzPpNSOXg61rHeoJI0GkoEL10EpDw1pPZRTKOV6sOuaOz57/5GLehBVW+ne7fHpGfQmNV5Zzg==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr935183wrs.218.1598953032096;
 Tue, 01 Sep 2020 02:37:12 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id h184sm1082283wmh.41.2020.09.01.02.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:37:11 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] hw/riscv: hart: Add a new 'resetvec' property
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-3-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e69feefa-49d4-79a5-8319-738c6da61f28@amsat.org>
Date: Tue, 1 Sep 2020 11:37:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598924352-89526-3-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:38 AM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> RISC-V machines do not instantiate RISC-V CPUs directly, instead
> they do that via the hart array. Add a new property for the reset
> vector address to allow the value to be passed to the CPU, before
> CPU is realized.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> 
> (no changes since v1)
> 
>  include/hw/riscv/riscv_hart.h | 1 +
>  hw/riscv/riscv_hart.c         | 3 +++
>  2 files changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


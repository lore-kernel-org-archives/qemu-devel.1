Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31BFC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EC72083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1fa4nrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EC72083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2yU-0001pF-Li
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2jM-00064v-7m; Tue, 01 Sep 2020 05:37:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2jK-0001Ze-Go; Tue, 01 Sep 2020 05:37:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id b79so479271wmb.4;
 Tue, 01 Sep 2020 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xQJ/1aeREE6BtqE2y9OvWz7GTKgA3waNf32gvJPB1gA=;
 b=e1fa4nrb+T7nyVo1a1L5HjBZ24S7uBozAfV+T29mPvBHw0pjPvuuuAysNxj1HN4z+b
 dntlahUwNNYPQOR/9lBJWMuBM4IaoeQUxvdqKPd+diBLUSrz2ZGkmEADf0yv5xD1CLxB
 lex/O3nQdcHIpPhGr8Xn2iom/ZqRACBvOwR1dCUglfrx4kj1sG5Ujm6xmPkHZb8lxLHF
 2sY4kYT2J0Qwz3ZSjMe9Q1RVVqfIgiV6jwMGHBgqjh86qgiQmp65sLkP7HAG4umnvjq8
 UPsWw3g5jahYG7eQjtQhlndGzcKReiXJnQvHkX3liyzBONsrzhWJVJsd3qqN6CC64Geo
 xwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xQJ/1aeREE6BtqE2y9OvWz7GTKgA3waNf32gvJPB1gA=;
 b=bOynwQp3B3SK6VLo2l3azXcqe2EobGHcRQysACmW9ipFgZ4WxOi4y6SpOziB4io4rN
 0mPScEpiO4I3WssLZPvok0wJH5NPc259nT+lKpyXAfNM649JQcwqZoL9jlKz+iFRNPFS
 gJSxi9UhE9BomraDoH/FjQ+ROpkVB05NF9mBDXsCxBu9/Hf7+R/qWzGiClPMurv/h1T5
 U+wxsvVK3zAdQjxsDrihXJAsk9slSQ0Nr0lbtn5AN+z5G4KiEHHzin7WBKoo/H/Gqm8A
 wRqPuNzNMD6gGUxxOdZyNct6QJhE5k9vIdXjCnDroQa4IJ8s+YWpfw626SXjkL+x1KKn
 fW3g==
X-Gm-Message-State: AOAM530RvvI93peBzjnGvvD2DK9DUqWweMlvOKswTSGBlEiHDzOt/pgE
 WVK7ZUBWPN1/ZvKhaWasLxE=
X-Google-Smtp-Source: ABdhPJwQw+ITF9/jCVKl4WXnR44vXMw1T9lZreN8JLVPQpAgbyQs4ta1LEfSfyUpR13YjYujy18DsQ==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr955113wmh.31.1598953048636;
 Tue, 01 Sep 2020 02:37:28 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id h184sm1083354wmh.41.2020.09.01.02.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:37:28 -0700 (PDT)
Subject: Re: [PATCH v3 03/16] target/riscv: cpu: Set reset vector based on the
 configured property value
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-4-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <897097ce-54cc-e7de-e4a8-83f9ab83269e@amsat.org>
Date: Tue, 1 Sep 2020 11:37:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598924352-89526-4-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
> Now that we have the newly introduced 'resetvec' property in the
> RISC-V CPU and HART, instead of hard-coding the reset vector addr
> in the CPU's instance_init(), move that to riscv_cpu_realize()
> based on the configured property value from the RISC-V machines.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> 
> (no changes since v1)
> 
>  hw/riscv/opentitan.c | 1 +
>  hw/riscv/sifive_e.c  | 1 +
>  hw/riscv/sifive_u.c  | 2 ++
>  target/riscv/cpu.c   | 7 ++-----
>  4 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


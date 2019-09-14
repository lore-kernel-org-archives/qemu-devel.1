Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B1C4CECA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 20:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2F020692
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 20:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2F020692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9Eka-0007qP-DQ
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 16:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i9Eh3-0004Hc-2C
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i9Eh2-0007eD-46
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:30:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i9Eh1-0007dq-VF
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:30:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so20097260pfe.5
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 13:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=lmIE6brnWQtY5H4j71QmKIIANTmcMtcTWXj0yIx25yc=;
 b=f70FW/Zzx3HGlf3qBS7773Gedx+f8bTeY1wobwbO6cbgw9un+Uv/rThV2cYbr/zHsx
 jXlY3eG46LKjPK4Cicg0MQl7AP0VFpZoUgn+8JcznUBzflUNVWtzkSFvPYFLY0x7iS7e
 zHotGlS8wewZ8vDu9Ig4qIzTN3DI/ZBw6mx9hyjQm14voD9BBDy9VqetMMA8xSKNw3TQ
 xbotsjS5DTfIxLACiBGmq7XasHlDcikm3lZgRwdaoIuLlilgJB8xOeVV09m1ZxZUGi9b
 emunHAZ5i7yCx/6xTUo3dm+/UsFqu8Tap7VeLfdGn/zWnqso48ONhsypfXsEYwpBlbeA
 IKlw==
X-Gm-Message-State: APjAAAVs7FDjNSM+bNvsYjvCwRfOHeZqsXp+JVpxE51rloM8P+kFvNxc
 B7YaD3LkTSHf0Z78K/yNPxlxSlJByFSQ1/6I
X-Google-Smtp-Source: APXvYqzVykDWGPVtRdm206gXhojwCpiwp4WNX7JLu4an0m2s4ppqJlDrbf5FHMYBI2Ne+0qdv/Ezzg==
X-Received: by 2002:a62:2c85:: with SMTP id s127mr25398173pfs.55.1568493050583; 
 Sat, 14 Sep 2019 13:30:50 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id h18sm5378122pjt.18.2019.09.14.13.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 13:30:49 -0700 (PDT)
Date: Sat, 14 Sep 2019 13:30:49 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 13:30:13 PDT (-0700)
In-Reply-To: <f3f7e9fdb539df1aa4c5f2b64db5847ad8d2eaee.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-d02a4b9d-36d3-4d6c-9616-8a73edaca517@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
Subject: Re: [Qemu-devel] [PATCH v1 14/28] target/riscv: Generate illegal
 instruction on WFI when V=1
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:26 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/op_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index d150551bc9..beb34e705b 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -130,9 +130,10 @@ void helper_wfi(CPURISCVState *env)
>  {
>      CPUState *cs = env_cpu(env);
>
> -    if (env->priv == PRV_S &&
> +    if ((env->priv == PRV_S &&
>          env->priv_ver >= PRIV_VERSION_1_10_0 &&
> -        get_field(*env->mstatus, MSTATUS_TW)) {
> +        get_field(*env->mstatus, MSTATUS_TW)) ||
> +        riscv_cpu_virt_enabled(env)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      } else {
>          cs->halted = 1;

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>


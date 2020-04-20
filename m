Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9782EC54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A4120782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="q1lay7Fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A4120782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbV0-0003pR-Fc
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45864 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQbMm-0007iO-5f
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:42:00 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQbMl-0007q0-1l
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:41:59 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48792)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jQbMk-0007og-83
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:41:58 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id F27F096F50;
 Mon, 20 Apr 2020 18:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1587408115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxxQFtXWFvomTUJ6RK1vSkvMOv/OhZcdJtvyKF0QXoU=;
 b=q1lay7FqKd5+wLxVG+/0LDjAjMb4UrYysljH5e1vffT2FXYROIYvXScE1d+o44pZDX22ql
 w8pqwJz/vbWOFQBQiezJ4jRNlYMX0vVtCGBugiiYkeLWBtFfv0nZr/BmyG0+SqGWU1SYkI
 4NdMzmnJhu95CD11EbL6rxAj+TPwOD0=
Subject: Re: [PATCH v2 3/6] target/microblaze: Add the div-zero-exception
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200420175250.25777-1-edgar.iglesias@gmail.com>
 <20200420175250.25777-4-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <67e27771-84d2-3857-3eec-5c589947fbcc@greensocs.com>
Date: Mon, 20 Apr 2020 20:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420175250.25777-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1587408115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxxQFtXWFvomTUJ6RK1vSkvMOv/OhZcdJtvyKF0QXoU=;
 b=b4D2g1HrpOnZtRxUzODLw9BOAQWiZIqGb8UbYvcY5I49AQkI2/7HTtXnxUGF4eLdXbwSii
 GZ4dcT4SpOLbEzTU54tUVJQkSNc2yuN14F4ITM8Lr53IbzY9vE5HxIkh/WvJn+RsOMqbYH
 Vt9vkYFxwQUXdZIo0xH+to99I086rj0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1587408115; a=rsa-sha256; cv=none;
 b=jzS12l7KPs9KazCAJ/0ZCVLD8BbSB7IfIb0pi8tvUBHyRtt+Ns0yGa3FDrov0vP3fww+x7
 FuR86u2QykCVkDI+CyEke3h20dN3Xl5EaEgznbyHD7SylcQBfRiZIEHgAqlHTgsv2TWovH
 G5nIXWhFgVME6j6QVzLKbwXZ3PftFeg=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 14:41:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 5.135.226.135
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 7:52 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add the div-zero-exception property to control if the core
> traps divizions by zero.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/microblaze/cpu.c       | 4 ++++
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/op_helper.c | 5 +++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 36c20d9724..53e80f4e5d 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -207,6 +207,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                                                   PVR2_DOPB_BUS_EXC_MASK : 0) |
>                          (cpu->cfg.iopb_bus_exception ?
>                                                   PVR2_IOPB_BUS_EXC_MASK : 0) |
> +                        (cpu->cfg.div_zero_exception ?
> +                                                 PVR2_DIV_ZERO_EXC_MASK : 0) |
>                          (cpu->cfg.illegal_opcode_exception ?
>                                                  PVR2_ILL_OPCODE_EXC_MASK : 0) |
>                          (cpu->cfg.opcode_0_illegal ?
> @@ -280,6 +282,8 @@ static Property mb_properties[] = {
>                       cfg.iopb_bus_exception, false),
>      DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
>                       cfg.illegal_opcode_exception, false),
> +    DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
> +                     cfg.div_zero_exception, false),
>      DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
>                       cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 71d7317a58..3c07f9b3f7 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -305,6 +305,7 @@ struct MicroBlazeCPU {
>          bool iopb_bus_exception;
>          bool illegal_opcode_exception;
>          bool opcode_0_illegal;
> +        bool div_zero_exception;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 18677ddfca..f3b17a95b3 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -132,11 +132,12 @@ uint32_t helper_carry(uint32_t a, uint32_t b, uint32_t cf)
>  
>  static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
>  {
> +    MicroBlazeCPU *cpu = env_archcpu(env);
> +
>      if (b == 0) {
>          env->sregs[SR_MSR] |= MSR_DZ;
>  
> -        if ((env->sregs[SR_MSR] & MSR_EE)
> -            && !(env->pvr.regs[2] & PVR2_DIV_ZERO_EXC_MASK)) {
> +        if ((env->sregs[SR_MSR] & MSR_EE) && cpu->cfg.div_zero_exception) {
>              env->sregs[SR_ESR] = ESR_EC_DIVZERO;
>              helper_raise_exception(env, EXCP_HW_EXCP);
>          }
> 


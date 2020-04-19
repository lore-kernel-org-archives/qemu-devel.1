Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E9BC38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7978121473
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="VruQTXHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7978121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQFP0-0006Gw-H9
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 15:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43740 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFIm-0004QX-Ed
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:08:24 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFIl-0000i7-VB
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:08:24 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:39990)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jQFIl-0000gH-CK
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:08:23 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 6F70B96F50;
 Sun, 19 Apr 2020 19:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1587323302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/x8UsvEaMcHeJVRMPLpRl0/BpSdlR10TkjHIJ+YY21k=;
 b=VruQTXHxKNbunttArdmvDSvfL6xXs65u8IHU22PeG6eBMynuChN5O33QRKhcDxmo3U8JVV
 HAnlLOVtQci5hKHOpfy2QsaLFYaYpltEaj9EsXoxkrk3f3EU7SEs3cuAI+FymnRnz42ZDK
 R0q6m9tTxEnSqlB5dt/qHdb+4v1PjfU=
Subject: Re: [PATCH v1 2/6] target/microblaze: Add the ill-opcode-exception
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-3-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <0af27392-5d3a-8029-870e-3942599ce444@greensocs.com>
Date: Sun, 19 Apr 2020 21:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417191022.5247-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1587323302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/x8UsvEaMcHeJVRMPLpRl0/BpSdlR10TkjHIJ+YY21k=;
 b=NR2e7TrcWGKgt22EVeP2ZPFffhvnb1bjcW8BWISStWca268RKGWy/oJAY8QAEIRxY6TbJj
 yV8jwn51CUDqEhrP7s7CskPiOZqZljcCvG41LK66mFsXrSJE3w4//b+a0sVA3n2ZPlGMBx
 ZA8TeAWScDclUencm4H2/bE4iEFgy2c=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1587323302; a=rsa-sha256; cv=none;
 b=m+OlvKM4iUK5QoZicYPVtuwY89RneL05R8Aohg/v/FglzNYwau3DP4Zx1zojog3Vjtol8i
 XeVBXcpPZg9TguRQqAYy7NFfuMqfbhS31Hlscqn7vf1wEiPfBgtoGaiE0J/eZ8hidguA8b
 QVTugEZhKNhg5A/rp3lM4qxh0Inovq4=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs1p.gnu.org: Linux 3.11 and newer
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

On 4/17/20 9:10 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add the ill-opcode-exception property to control if illegal
> instructions will raise exceptions.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/microblaze/cpu.c       | 4 ++++
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/translate.c | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 1044120702..36c20d9724 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -207,6 +207,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                                                   PVR2_DOPB_BUS_EXC_MASK : 0) |
>                          (cpu->cfg.iopb_bus_exception ?
>                                                   PVR2_IOPB_BUS_EXC_MASK : 0) |
> +                        (cpu->cfg.illegal_opcode_exception ?
> +                                                PVR2_ILL_OPCODE_EXC_MASK : 0) |
>                          (cpu->cfg.opcode_0_illegal ?
>                                                   PVR2_OPCODE_0x0_ILL_MASK : 0);
>  
> @@ -276,6 +278,8 @@ static Property mb_properties[] = {
>      /* Enables bus exceptions on failed instruction fetches.  */
>      DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
>                       cfg.iopb_bus_exception, false),
> +    DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
> +                     cfg.illegal_opcode_exception, false),
>      DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
>                       cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index d51587b342..71d7317a58 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -303,6 +303,7 @@ struct MicroBlazeCPU {
>          bool endi;
>          bool dopb_bus_exception;
>          bool iopb_bus_exception;
> +        bool illegal_opcode_exception;
>          bool opcode_0_illegal;
>          char *version;
>          uint8_t pvr;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 222632b670..b4a78551ef 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -185,7 +185,7 @@ static void write_carryi(DisasContext *dc, bool carry)
>  static bool trap_illegal(DisasContext *dc, bool cond)
>  {
>      if (cond && (dc->tb_flags & MSR_EE_FLAG)
> -        && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
> +        && dc->cpu->cfg.illegal_opcode_exception) {
>          tcg_gen_movi_i64(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
>          t_gen_raise_exception(dc, EXCP_HW_EXCP);
>      }
> 


Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161EFC38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23812145D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="C+zTJkZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23812145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQFKx-0004tG-S7
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 15:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43578 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFI7-00041P-IP
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:07:43 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFI6-0007m2-Sm
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:07:43 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:39952)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jQFI6-0007fh-7q
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:07:42 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id CF88096F50;
 Sun, 19 Apr 2020 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1587323259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ia9Cj39fJuGe/2vw+NZF8Ud9P80vygbaY4/dTMvswQg=;
 b=C+zTJkZzIDBU6nad+d4c8CIgPbmNFJPi6GLG2FBgsJ5+7p9Ji87JjDfKcKKLMp0EU7ZPxS
 DRPwfTKayBjx2IxP2K3JtFM3ixR8Jh0RNybn5jrPMjGM/S2pcBlYqKgMmG6K5mg+7PX3c4
 e+6Cl2Pc2arkyMFhwvnG1myuaQI8TiQ=
Subject: Re: [PATCH v1 1/6] target/microblaze: Add the opcode-0x0-illegal CPU
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-2-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <74343844-d356-67a1-ea75-63af3079fe23@greensocs.com>
Date: Sun, 19 Apr 2020 21:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417191022.5247-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1587323259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ia9Cj39fJuGe/2vw+NZF8Ud9P80vygbaY4/dTMvswQg=;
 b=LrrTf5YPK3eJnCZYRAAguyeDQLE0ET8fWlSxvLicAQ+qh43tnEl+W/TdD87A8CPBdKa7be
 Gzoiu5ucLDmr7MSvHd716boCqJksOn4s4wZtTSLJmuKD1bFu0HASRJBb6TYFF48MKc6m8q
 79LRPyLfoMiNH+qO8BoNgmEppEkj8YY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1587323259; a=rsa-sha256; cv=none;
 b=MmIIYFe/BvZIeKu+kGwdBckQnaDdVN5s0iUndy+s6BmCgbkHlBMlMJr97DsSBMZCmiQKbz
 X9xafPDFwjWHrmvNUCFsIcfcmWMVTPgM8s/LehpYogdILm/pIiVEHSdBJq9biJFhBrz2dX
 9v9QSRl2CzgQ+FnegBGtyLeqrzq2lTE=
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
> Add the opcode-0x0-illegal CPU property to control if the core
> should trap opcode zero as illegal.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/microblaze/cpu.c       | 6 +++++-
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/translate.c | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index a2c2f271df..1044120702 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -206,7 +206,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          (cpu->cfg.dopb_bus_exception ?
>                                                   PVR2_DOPB_BUS_EXC_MASK : 0) |
>                          (cpu->cfg.iopb_bus_exception ?
> -                                                 PVR2_IOPB_BUS_EXC_MASK : 0);
> +                                                 PVR2_IOPB_BUS_EXC_MASK : 0) |
> +                        (cpu->cfg.opcode_0_illegal ?
> +                                                 PVR2_OPCODE_0x0_ILL_MASK : 0);
>  
>      env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
>                                          PVR5_DCACHE_WRITEBACK_MASK : 0;
> @@ -274,6 +276,8 @@ static Property mb_properties[] = {
>      /* Enables bus exceptions on failed instruction fetches.  */
>      DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
>                       cfg.iopb_bus_exception, false),
> +    DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
> +                     cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
>      DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 1a700a880c..d51587b342 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -303,6 +303,7 @@ struct MicroBlazeCPU {
>          bool endi;
>          bool dopb_bus_exception;
>          bool iopb_bus_exception;
> +        bool opcode_0_illegal;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 37a844db99..222632b670 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1573,7 +1573,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
>      LOG_DIS("%8.8x\t", dc->ir);
>  
>      if (ir == 0) {
> -        trap_illegal(dc, dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK);
> +        trap_illegal(dc, dc->cpu->cfg.opcode_0_illegal);
>          /* Don't decode nop/zero instructions any further.  */
>          return;
>      }
> 


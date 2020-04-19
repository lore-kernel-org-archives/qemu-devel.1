Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D04C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D89E2075E
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ETS2hm5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D89E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQFfo-0004Kq-9q
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 15:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52552 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFcj-00030q-8k
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:29:01 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFci-0005n5-Nv
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:29:00 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40612)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jQFci-0005hm-5S
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:29:00 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 09A7296EF0;
 Sun, 19 Apr 2020 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1587324538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yh96zn6e/klinW00APl2588h1b1oEyRTajRMVCJg284=;
 b=ETS2hm5Mt9lQG9x5a+3zBLDL540PUczCNBSSec7Noa1zO3YMXaWe9Vni42DKu/ChDVCrf5
 AFxh+LOz/q8I0OaGgfIeccohqMeDkCga3Ky98M6hR6zfjZggfeOqiEBgCXBdlscVnB+0Ef
 u5KP10C4orWlSGbGvv7gt5lg3Ms042o=
Subject: Re: [PATCH v1 5/6] target/microblaze: Add the pvr-user1 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-6-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <8b63e507-67b6-a097-c61b-5d485a7ed447@greensocs.com>
Date: Sun, 19 Apr 2020 21:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417191022.5247-6-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1587324538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yh96zn6e/klinW00APl2588h1b1oEyRTajRMVCJg284=;
 b=aClGBIb/84SQj7Ei8L0kDywsiKXBI0JgtyJKi2eYKbcg4Vd0IYk3wOCI4lwI4/Qf+O1YzN
 VzhKxfEznRD8hI0NOWa0RgzW/geiAvEf7gewx4yZAZn/ANxQYPumRz4vWMkDzYgCYzNAR4
 GLINWRxLAjV9tRCWXyAFE4TQzPFkPiE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1587324538; a=rsa-sha256; cv=none;
 b=MjA3e2yLuEBfd7Y9o+JOMRvXnend799xLzJNYbBstvvaHm9AnX19UVoVPZPXnlIe5QYKtI
 b7QLjY8M17u4I+vcR5jmo7LQw1OaBVz56N2Ly0uJq3pFR1gPmsBxeQDqfNiZ8yHQoau8bP
 UCQPS534FbFN4aC05r7zb4lV3fXi6b0=
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
> Add the pvr-user1 property to control the user-defined
> PVR0 User1 field.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/microblaze/cpu.c | 4 +++-
>  target/microblaze/cpu.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index a850c7b23c..0759b23a83 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -193,7 +193,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
>                          (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
>                          (version_code << PVR0_VERSION_SHIFT) |
> -                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0);
> +                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
> +                        cpu->cfg.pvr_user1;
>  
>      env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
>                          (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
> @@ -290,6 +291,7 @@ static Property mb_properties[] = {
>                       cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
>      DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
> +    DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index ef9081db40..7bb5a3d6c6 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -307,6 +307,7 @@ struct MicroBlazeCPU {
>          bool opcode_0_illegal;
>          bool div_zero_exception;
>          bool unaligned_exceptions;
> +        uint8_t pvr_user1;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> 


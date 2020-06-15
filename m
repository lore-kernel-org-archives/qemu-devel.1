Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9535EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F83620663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obq9J9OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F83620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jksKV-0000hv-Lr
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jksJq-0000Db-2Y; Mon, 15 Jun 2020 12:50:47 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jksJn-0003RC-OF; Mon, 15 Jun 2020 12:50:45 -0400
Received: by mail-il1-x143.google.com with SMTP id x18so15983713ilp.1;
 Mon, 15 Jun 2020 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=09cH+KrtXqLM7fQNz+W8DeIct8hAan40sX43VBh3y6o=;
 b=obq9J9OM6rEpc/fSbxryZ2XPu3FXTkkUT+vh5JAgdENTngGI+ipkMP7EMZrukyz/QO
 IcesIs/HlC54Cj4WEwbA3vrjRHgIDdgq9pDTFNMsVLBYDrdrga7R7puX7HjhkaS8AyK+
 0s+3xqzdM4Nv+oBwNHIw043F8LeXKf/f514EwvDS9lI+fwaRsHT41D+UARHtQmroVqSJ
 sU/7mQWCVfVo8VWyjZHJTE0Hfqs4dTWS5ZcaccZI+QhyqB8qQiwKNta4YmgbY1QKGiYS
 c2jN8MZEZcTw5JsfxCTTI9oT+YCl8u633yzFYTz5Nc1EA+odirwxsiWU6/ZuKwVEGNaT
 kc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=09cH+KrtXqLM7fQNz+W8DeIct8hAan40sX43VBh3y6o=;
 b=IUnkbqHKqXWI5Sg/9REzeT9rRx9StgakEhNWSf6nfeaTj+Oar6WEeLShzMYaQGiNij
 iISama+pHOoL3NT/Uvuuynsn64GiOe86D+ygXSLeOZWlXyQI5hfEJikxlH4WcWwi2Ddn
 zbbBugDZgXtZfDdoD8xpDmD4QKQVi60vDNFwBTFBXWGMxxi7UlPnKZCswCqEzsUnb1kC
 CCSGlxEBsuMdRtjVuSkauIeIMUDegtrLejD89awY1DWjCZuwL7kZsBrfa9+lEUj8ySjg
 iZ3tUxNirlIw47S0yZBgE/Fy/YdH4Yk8oHz1Vy/bVX9rYFvfeyXWiBd7HRPqnMtJCKQb
 lwnw==
X-Gm-Message-State: AOAM533dtzURq4X5AQUgSDvpcMQkv3Ko4eLOmI2PP1Q2SQr4T+MLZE1O
 Hdb6Dxnpv5Pq1qlCU1Tdme3xkq809cR86h0DToE=
X-Google-Smtp-Source: ABdhPJy4JJDhW2UyFHfnllSrwAMDhjTgouDagK1InPCxfyFn0MgSO2cLPviI9EUpYQaiYAeTFbWQN0RTJGK5/2v/01c=
X-Received: by 2002:a92:bb45:: with SMTP id w66mr28021106ili.131.1592239842379; 
 Mon, 15 Jun 2020 09:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-12-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-12-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 09:41:19 -0700
Message-ID: <CAKmqyKMGq_zNZBwbAFbtVVp0P_YvSD98ZqHg3=TvzOS5a6Qfag@mail.gmail.com>
Subject: Re: [PATCH 11/15] hw/riscv: sifive_u: Add a new property msel for
 MSEL pin state
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 7:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> On SiFive FU540 SoC, the value stored at physical address 0x1000
> stores the MSEL pin state that is used to control the next boot
> location that ROM codes jump to.
>
> Add a new property msel to sifive_u machine for this.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c         | 7 +++++++
>  include/hw/riscv/sifive_u.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 07e2ba0..aaa5adb 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -507,6 +507,13 @@ static void sifive_u_machine_instance_init(Object *obj)
>                                      "Set on to tell QEMU's ROM to jump to "
>                                      "flash. Otherwise QEMU will jump to DRAM");
>
> +    s->msel = 0;
> +    object_property_add(obj, "msel", "uint32",
> +                        sifive_u_machine_get_uint32_prop,
> +                        sifive_u_machine_set_uint32_prop, NULL, &s->msel);
> +    object_property_set_description(obj, "msel",
> +                                    "Mode Select (MSEL[3:0]) pin state");
> +
>      s->serial = OTP_SERIAL;
>      object_property_add(obj, "serial", "uint32",
>                          sifive_u_machine_get_uint32_prop,
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index dcf7f3b..d82cfe0 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -63,6 +63,7 @@ typedef struct SiFiveUState {
>      int fdt_size;
>
>      bool start_in_flash;
> +    uint32_t msel;
>      uint32_t serial;
>  } SiFiveUState;
>
> --
> 2.7.4
>
>


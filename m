Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDBBC388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438D72225E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4WmYLAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438D72225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7Au-0005Ej-7h
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7AF-0004aO-JR; Fri, 23 Oct 2020 20:12:07 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7AD-0007LU-Oj; Fri, 23 Oct 2020 20:12:07 -0400
Received: by mail-io1-xd41.google.com with SMTP id h21so4001298iob.10;
 Fri, 23 Oct 2020 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eQmfCjC1F5tttQFCp7SKRHZLFtd4BMEf2ojLiWS3Gso=;
 b=K4WmYLAAa/K1UMatNZHI8uYtSxFFCq9R2jd0NiXYHHwbdIpt23gtc0tNGMijxrA9sT
 CZadiYTKft6wIUMEsu75aHBYI5sNxiCTZhHHi83+be8g9efYhSnsCwoGEY9Qq1IB4uVx
 qBgEJW0AFBe2tMOpzXZu2EyVw0Z5x/+Nl17hPWqUI6fcGk81R8gPQOPbYjlzS+sv+4/c
 P/EpZXOnwGEpeWyA8k+eAzIHBXQKx6hQ84wnOAW+/xqyozkaTqA0AwD5TxVN3vZg5TlC
 aDbKv1z8EOmYpEh9vPq8uWk57IJYsm6YrU/8MtpJELee9TGEhEXgqqeoE1YZ/bb5aZ4P
 w9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eQmfCjC1F5tttQFCp7SKRHZLFtd4BMEf2ojLiWS3Gso=;
 b=HQPiA7H2QNVwd7B1Q57/YRCqv95Tq1NRrPPJUTmxGPD5YcCDVkXBncAAVtew4YpJxL
 8HmtIBeaJqXvRUy5Da1cnKbDMs8t1CM16piy/oBlbr6tKIIC+iIgKA5DQbqErF99xIy2
 SJ84EkMVQ+juftPh8Qdfqd9aQNuGJaQhOmZghhu+dQpsQ5F96BBGOrdIPZ5V2sPu5vS/
 PMHKYcywny3gcNVLUjj55FQHIVdC3D7JXqJBleRebv30CxpHXuO+Yv7Vd1UYpuu6idtW
 OYkYTlUXGYKEwCPWdT5tKw7QVhqqHteXPJKztrh+iyStcgMsFhAHar7yoox6NnOcGA+7
 BKyw==
X-Gm-Message-State: AOAM530o7V/6GPcNa0w7eanMSQN2MhDyoB9zcj5YzXEaQyJ6rA4CTFK9
 /9FEQ2zRoYRJXl3ofh40KwZZSle/RB37l5AjBg8=
X-Google-Smtp-Source: ABdhPJwHoM2GEKzrLDKkWyymoi2r4P1gI/LzFldR+rI/TcCegonrswfqIRWoS5/sKZf4gVeRHjCpGWNbtrYACtUB0OM=
X-Received: by 2002:a05:6602:2ac3:: with SMTP id
 m3mr3734194iov.105.1603498324631; 
 Fri, 23 Oct 2020 17:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201023091225.224-1-jiangyifei@huawei.com>
 <20201023091225.224-5-jiangyifei@huawei.com>
In-Reply-To: <20201023091225.224-5-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 17:00:17 -0700
Message-ID: <CAKmqyKP8mMV6_Qb-twgheB6rbW2e_vv9tBYFi3tX8qGPMjnxXQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/6] target/riscv: Add H extension state description
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 2:16 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> In the case of supporting H extension, add H extension description
> to vmstate_riscv_cpu.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/machine.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index fc1461d88e..ae60050898 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -68,6 +68,52 @@ static const VMStateDescription vmstate_pmp = {
>      }
>  };
>
> +static bool hyper_needed(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +    CPURISCVState *env = &cpu->env;
> +
> +    return riscv_has_ext(env, RVH);
> +}
> +
> +static const VMStateDescription vmstate_hyper = {
> +    .name = "cpu/hyper",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = hyper_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINTTL(env.hstatus, RISCVCPU),
> +        VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
> +        VMSTATE_UINTTL(env.hideleg, RISCVCPU),
> +        VMSTATE_UINTTL(env.hcounteren, RISCVCPU),
> +        VMSTATE_UINTTL(env.htval, RISCVCPU),
> +        VMSTATE_UINTTL(env.htinst, RISCVCPU),
> +        VMSTATE_UINTTL(env.hgatp, RISCVCPU),
> +        VMSTATE_UINT64(env.htimedelta, RISCVCPU),
> +
> +        VMSTATE_UINT64(env.vsstatus, RISCVCPU),
> +        VMSTATE_UINTTL(env.vstvec, RISCVCPU),
> +        VMSTATE_UINTTL(env.vsscratch, RISCVCPU),
> +        VMSTATE_UINTTL(env.vsepc, RISCVCPU),
> +        VMSTATE_UINTTL(env.vscause, RISCVCPU),
> +        VMSTATE_UINTTL(env.vstval, RISCVCPU),
> +        VMSTATE_UINTTL(env.vsatp, RISCVCPU),
> +
> +        VMSTATE_UINTTL(env.mtval2, RISCVCPU),
> +        VMSTATE_UINTTL(env.mtinst, RISCVCPU),
> +
> +        VMSTATE_UINTTL(env.stvec_hs, RISCVCPU),
> +        VMSTATE_UINTTL(env.sscratch_hs, RISCVCPU),
> +        VMSTATE_UINTTL(env.sepc_hs, RISCVCPU),
> +        VMSTATE_UINTTL(env.scause_hs, RISCVCPU),
> +        VMSTATE_UINTTL(env.stval_hs, RISCVCPU),
> +        VMSTATE_UINTTL(env.satp_hs, RISCVCPU),
> +        VMSTATE_UINT64(env.mstatus_hs, RISCVCPU),
> +
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_riscv_cpu = {
>      .name = "cpu",
>      .version_id = 1,
> @@ -119,6 +165,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>      },
>      .subsections = (const VMStateDescription * []) {
>          &vmstate_pmp,
> +        &vmstate_hyper,
>          NULL
>      }
>  };
> --
> 2.19.1
>
>


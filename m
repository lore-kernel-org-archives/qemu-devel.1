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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BF1C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A5B2225E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blDTPZNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A5B2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7C4-0006K8-1o
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7B1-0005Vn-9S; Fri, 23 Oct 2020 20:12:55 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7Az-0007QJ-MW; Fri, 23 Oct 2020 20:12:55 -0400
Received: by mail-io1-xd42.google.com with SMTP id p15so4040197ioh.0;
 Fri, 23 Oct 2020 17:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=edgpS6+sgF561zwWxeafZwlFVHauf7ntI4dMRrRr5jU=;
 b=blDTPZNit4SKExtAexyCh4N6uH5YWcy4J9uQw/kxrZH4xgcbcceFOtnrcVpGaV3TrB
 aK2I5mnbSnjT+F1gb3vuJ1mwtECiT9iGGnZKy+OpjsIGBWW5+BpRSvtZzXDHblpbri+O
 yLI5RqDg1PqxhxgYqkDkOllE4pT9qrkJ7qaRScG5bhCiLqGcpxtHitSGuOgv+c1KOKGZ
 nueM2WOhIiwsHRjRagb1dbbNFGZFHzJYyiinv5O7kRV9ytOprYQ333uFtbD0v6Hv03X/
 +dtl6hp16/9kqcd+vkPb6KrJBHNusQa7aSb70Gu/yE8aCGWhwpTSPrjrJ51egXizbBSS
 kHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=edgpS6+sgF561zwWxeafZwlFVHauf7ntI4dMRrRr5jU=;
 b=CXXrd7ut7DtufTMawAFspxJwtlY7X/eG/E0xKh3oLZRMmFCK7747vyDQF1ehw8hsck
 TRB0bWVCM5Et1ZwqYCxRL5WQuvuppsCA2ALMWiqISx+tEEniXk+bfPSlTZg2CyTxAGvO
 OoMx77ob5wtvAg6pbIK1tmjsooG7l2nOoENvugT9tpFM4MSecMoEkZsNhkrC8c4FTUSj
 7lFzmpQEmAMm+XmwIZTI8gEFKlq+HXfywsfFVRZoH16klr1M/JgYpgA4F7iRtVcXQwfq
 cVoH6vAbGmR3SS/0NfsGHAz61kS1cbTpYLy+q8dx7Ta+/MncN0iclP1alN16C2QHLbIc
 sZkQ==
X-Gm-Message-State: AOAM530iMlEZBqthDEmGVEIsjMD5AKaFfWBAGkSsrP1l9DXkwcW33Hh+
 szJN+cvay8QmSLfvxaf6PPB9XVT3tbVdD0Ew+fZdmldhjA0=
X-Google-Smtp-Source: ABdhPJyuHu7kXeR4cXLsSyWCt+FnFJd4isq+qKPVI4QhJjW3SvpNNg5ZMHwgk1jYU3/cBWm8/0ZGrOZfG7jXKxJksQw=
X-Received: by 2002:a6b:8ec7:: with SMTP id q190mr3789049iod.42.1603498371980; 
 Fri, 23 Oct 2020 17:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201023091225.224-1-jiangyifei@huawei.com>
 <20201023091225.224-6-jiangyifei@huawei.com>
In-Reply-To: <20201023091225.224-6-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 17:01:05 -0700
Message-ID: <CAKmqyKNN9F_iz2DuYDNisSRiTW7Oe0x22ZTnOgaKL1A99hPMdQ@mail.gmail.com>
Subject: Re: [PATCH V3 5/6] target/riscv: Add V extension state description
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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

On Fri, Oct 23, 2020 at 2:18 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> In the case of supporting V extension, add V extension description
> to vmstate_riscv_cpu.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/machine.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index ae60050898..44d4015bd6 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -76,6 +76,30 @@ static bool hyper_needed(void *opaque)
>      return riscv_has_ext(env, RVH);
>  }
>
> +static bool vector_needed(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +    CPURISCVState *env = &cpu->env;
> +
> +    return riscv_has_ext(env, RVV);
> +}
> +
> +static const VMStateDescription vmstate_vector = {
> +    .name = "cpu/vector",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vector_needed,
> +    .fields = (VMStateField[]) {
> +            VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
> +            VMSTATE_UINTTL(env.vxrm, RISCVCPU),
> +            VMSTATE_UINTTL(env.vxsat, RISCVCPU),
> +            VMSTATE_UINTTL(env.vl, RISCVCPU),
> +            VMSTATE_UINTTL(env.vstart, RISCVCPU),
> +            VMSTATE_UINTTL(env.vtype, RISCVCPU),
> +            VMSTATE_END_OF_LIST()
> +        }
> +};
> +
>  static const VMStateDescription vmstate_hyper = {
>      .name = "cpu/hyper",
>      .version_id = 1,
> @@ -166,6 +190,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>      .subsections = (const VMStateDescription * []) {
>          &vmstate_pmp,
>          &vmstate_hyper,
> +        &vmstate_vector,
>          NULL
>      }
>  };
> --
> 2.19.1
>
>


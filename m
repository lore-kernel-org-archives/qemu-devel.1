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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE361C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EDA214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keJSdjy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EDA214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7A5-0004GP-Vz
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW79T-0003n3-QG; Fri, 23 Oct 2020 20:11:19 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW79R-0007I5-69; Fri, 23 Oct 2020 20:11:19 -0400
Received: by mail-io1-xd44.google.com with SMTP id h21so3999463iob.10;
 Fri, 23 Oct 2020 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WS/OIwDTHBKjGe1WUtr5aHEiiwLOLl7DRDpvMhBrGTg=;
 b=keJSdjy6GwyYfCx+pqJlgGpNcD7o0jBRhxodNJfiZSoDuLy+o8B1kCKTJjQ8CczWGq
 iQSQd7T/rcqAE7OCJsulHdo2n55CKT5TJ3XWs61ccbaEBWfh9bCNgtr/S5hL4RUaVK2o
 XgJ25K08tHfsmghrrjbiwogSoMOpj/V/f5/Famdxsp40qVGSqt91Fg3XFK5Eos/aCL+e
 YLttL3ZKXsvs18FXkHUuNkTo/798Amqq+q8yjGOl47ETA4lzeVDrZLFFOjmv84+c6+Ge
 fH88wfBh4Awewgnr2DoSXFEJC6/1sCML+y2KSm2Tdlbtx4UlgNDkd7t5dPtLuwPZjgcM
 QkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WS/OIwDTHBKjGe1WUtr5aHEiiwLOLl7DRDpvMhBrGTg=;
 b=FoHl5Kul9/XPKpGtJIOSouKsGoVtCeo8kBt46vbs0uzDSnIkm4BzK6Eng6TPgX8REG
 /I2jnOX4qXIO6bT7nE6fz/X2XyPe1j4xA5PfnYhEY9KX84QMkuIINm7jEmVq8M/JehTY
 G345xZrFj4xJSsBlNazk1ZBXb4hNyIrqBK8y/A7A52CtoAwceyv/vNXaLTQi0VIxGP8D
 fCRqjRZHHY9MqInRflgn9dO7j5lgoIKOhePNd84EG6CzNO8rziTAa/w+TgzubhKb2+9M
 LSCta9NJReJ3PsNpvl5iLWP2dMiyduRUksq0Y6C1Gx+tDw4DMvzNdqQSBlhp+/QBliWU
 kxzg==
X-Gm-Message-State: AOAM532nkfORLNOASv+8RwGFBzixzgxMWHAU5C46aV20VyQpQ7Nu2z20
 yk0dP0/hmtHbmLBpPLHYpwlV0O0d1yDBdezjubI=
X-Google-Smtp-Source: ABdhPJwfns4POEh5z0PqsKpkE0NeEtim9h3Ko+Lch3uGuP/C4kIvMehpECfAzzoz9WQt4sHVKTWkFxOQMKCrPpbX+z8=
X-Received: by 2002:a5d:9a8d:: with SMTP id c13mr3616393iom.176.1603498275057; 
 Fri, 23 Oct 2020 17:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201023091225.224-1-jiangyifei@huawei.com>
 <20201023091225.224-4-jiangyifei@huawei.com>
In-Reply-To: <20201023091225.224-4-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 16:59:28 -0700
Message-ID: <CAKmqyKP5MwkzabG3KVmYCKJ=wOLjVPjo5sAkNu_wZkkM53xUrA@mail.gmail.com>
Subject: Re: [PATCH V3 3/6] target/riscv: Add PMP state description
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
> In the case of supporting PMP feature, add PMP state description
> to vmstate_riscv_cpu.
>
> 'vmstate_pmp_addr' and 'num_rules' could be regenerated by
> pmp_update_rule(). But there exists the problem of updating
> num_rules repeatedly in pmp_update_rule(). So here extracts
> pmp_update_rule_addr() and pmp_update_rule_nums() to update
> 'vmstate_pmp_addr' and 'num_rules' respectively.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/machine.c | 50 ++++++++++++++++++++++++++++++++++++++++++
>  target/riscv/pmp.c     | 29 ++++++++++++++----------
>  target/riscv/pmp.h     |  2 ++
>  3 files changed, 70 insertions(+), 11 deletions(-)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 32edbcba7c..fc1461d88e 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -22,6 +22,52 @@
>  #include "sysemu/kvm.h"
>  #include "migration/cpu.h"
>
> +static bool pmp_needed(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +    CPURISCVState *env = &cpu->env;
> +
> +    return riscv_feature(env, RISCV_FEATURE_PMP);
> +}
> +
> +static int pmp_post_load(void *opaque, int version_id)
> +{
> +    RISCVCPU *cpu = opaque;
> +    CPURISCVState *env = &cpu->env;
> +    int i;
> +
> +    for (i = 0; i < MAX_RISCV_PMPS; i++) {
> +        pmp_update_rule_addr(env, i);
> +    }
> +    pmp_update_rule_nums(env);
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_pmp_entry = {
> +    .name = "cpu/pmp/entry",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINTTL(addr_reg, pmp_entry_t),
> +        VMSTATE_UINT8(cfg_reg, pmp_entry_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_pmp = {
> +    .name = "cpu/pmp",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = pmp_needed,
> +    .post_load = pmp_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT_ARRAY(env.pmp_state.pmp, RISCVCPU, MAX_RISCV_PMPS,
> +                             0, vmstate_pmp_entry, pmp_entry_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_riscv_cpu = {
>      .name = "cpu",
>      .version_id = 1,
> @@ -70,5 +116,9 @@ const VMStateDescription vmstate_riscv_cpu = {
>          VMSTATE_UINT64(env.timecmp, RISCVCPU),
>
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_pmp,
> +        NULL
>      }
>  };
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index c394e867f8..2eda8e1e2f 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -136,18 +136,8 @@ static void pmp_decode_napot(target_ulong a, target_ulong *sa, target_ulong *ea)
>      }
>  }
>
> -
> -/* Convert cfg/addr reg values here into simple 'sa' --> start address and 'ea'
> - *   end address values.
> - *   This function is called relatively infrequently whereas the check that
> - *   an address is within a pmp rule is called often, so optimise that one
> - */
> -static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
> +void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>  {
> -    int i;
> -
> -    env->pmp_state.num_rules = 0;
> -
>      uint8_t this_cfg = env->pmp_state.pmp[pmp_index].cfg_reg;
>      target_ulong this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
>      target_ulong prev_addr = 0u;
> @@ -186,7 +176,13 @@ static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
>
>      env->pmp_state.addr[pmp_index].sa = sa;
>      env->pmp_state.addr[pmp_index].ea = ea;
> +}
>
> +void pmp_update_rule_nums(CPURISCVState *env)
> +{
> +    int i;
> +
> +    env->pmp_state.num_rules = 0;
>      for (i = 0; i < MAX_RISCV_PMPS; i++) {
>          const uint8_t a_field =
>              pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
> @@ -196,6 +192,17 @@ static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
>      }
>  }
>
> +/* Convert cfg/addr reg values here into simple 'sa' --> start address and 'ea'
> + *   end address values.
> + *   This function is called relatively infrequently whereas the check that
> + *   an address is within a pmp rule is called often, so optimise that one
> + */
> +static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
> +{
> +    pmp_update_rule_addr(env, pmp_index);
> +    pmp_update_rule_nums(env);
> +}
> +
>  static int pmp_is_in_range(CPURISCVState *env, int pmp_index, target_ulong addr)
>  {
>      int result = 0;
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 6a8f072871..6c6b4c9bef 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -62,5 +62,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
>      target_ulong size, pmp_priv_t priv, target_ulong mode);
>  bool pmp_is_range_in_tlb(CPURISCVState *env, hwaddr tlb_sa,
>                           target_ulong *tlb_size);
> +void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
> +void pmp_update_rule_nums(CPURISCVState *env);
>
>  #endif
> --
> 2.19.1
>
>


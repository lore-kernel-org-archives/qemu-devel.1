Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049EFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08E7207FB
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHFzbB4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08E7207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajKL-00053i-VN
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jajJa-0004bP-6m; Mon, 18 May 2020 13:12:34 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jajJY-0006Mc-TA; Mon, 18 May 2020 13:12:33 -0400
Received: by mail-il1-x142.google.com with SMTP id o67so5952472ila.0;
 Mon, 18 May 2020 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rsKtgwwVLavRmGAhjPjBx9qgFbdHnf/krAIZv1IDcSU=;
 b=NHFzbB4aOCB6dbCyrURod39KCriS0H5R/tNoJTZ8CiLO7QMFT0gEiprIToau8LvsAK
 RrxWZEeYLibtUi+3V6M4mY9VtDkGdKD2t0WKWEqQWnnufwCe3xnNNLttQK5Y8jV8TlFq
 rbdnM4MWCYFb4FXE2B4DklKqibeEd8QFVzzOugv1mH8SfBSfjJ8RMuTT0E7cMLXnDrCb
 nraIE02L1SOvzK/F9mjMp4F/etVuoR/G2qCEcF4H7Mwv1Q9VP74Ucrr4waSrGuex9TUl
 T9aZNa8I50OdkgKBqZLH0Ra53MRz3/+btwUgwg8pd/1hzln5ehD8/bIN+6Arcc+8cGeo
 sBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rsKtgwwVLavRmGAhjPjBx9qgFbdHnf/krAIZv1IDcSU=;
 b=iC0O9nZgtJpY3ps3DhV7f+ruGrEjMupBhhMHoDoUzuoKaiB3oAqG72yUGZuulrz0QK
 JKM7YMm24RUHQcW8hx2B3sMbnx3ISwtKxIdmqz9/oH6zwjdkoljxADnz2LB6SXLx68eM
 zol9Kl9DHxTJT41sdBOtjnkYYvG616AkQgwPycb5AXNuzrsdBp9wBpGq6EAFONRHCvPJ
 Ahz+oJDBoM3husE3RcPVR4IOZKUoxPAI+lgEhJlkAe54d+7ikdEAttgrGV1hf9L+dUEu
 WpMKqyY3xtzE5BOlJ+0raHEliO5hC8yMahNL9dsgSWAkcgqpuwz54xzdsiKkLkMLCXLd
 qEWA==
X-Gm-Message-State: AOAM5321jhub16RhWDmbgQ/zZEJN7R7qxhic+6zLw2FiKFzYz0pmdYWE
 IsFIFQN+f2HbbnUIUiTMcwS6gfcRsyRMu4jouis=
X-Google-Smtp-Source: ABdhPJx7RpmUwl9g5kaDes4ka3sfyhZrqQYPoYwGrR0Cw3hWV9291eP/gxVmJ5fBIFcplbAzkMNIB1No7YZ0Tvzbrfc=
X-Received: by 2002:a92:48d1:: with SMTP id j78mr17960291ilg.131.1589821951497; 
 Mon, 18 May 2020 10:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-20-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-20-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2020 10:03:36 -0700
Message-ID: <CAKmqyKPSF+rZCzXFeQCJZZ-w5AAUjwnv1aBPcRb2k5tR6fTkZw@mail.gmail.com>
Subject: Re: [PATCH 19/24] riscv: Fix to put "riscv.hart_array" devices on
 sysbus
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 17, 2020 at 10:16 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> riscv_sifive_e_soc_init(), riscv_sifive_u_soc_init(),
> spike_board_init(), spike_v1_10_0_board_init(),
> spike_v1_09_1_board_init(), and riscv_virt_board_init() create
> "riscv-hart_array" sysbus devices in a way that leaves them unplugged.
>
> Create them the common way that puts them into the main system bus.
> Affects machines sifive_e, sifive_u, spike, spike_v1.10, spike_v1.9.1,
> and virt.  Visible in "info qtree", here's the change for sifive_e:
>
>      bus: main-system-bus
>        type System
>     +  dev: riscv.hart_array, id ""
>     +    num-harts = 1 (0x1)
>     +    hartid-base = 0 (0x0)
>     +    cpu-type = "sifive-e31-riscv-cpu"
>        dev: sifive_soc.gpio, id ""
>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: qemu-riscv@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_e.c |  5 ++---
>  hw/riscv/sifive_u.c | 14 ++++++--------
>  hw/riscv/spike.c    | 12 ++++++------
>  hw/riscv/virt.c     |  4 ++--
>  4 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index b53109521e..8831e6728e 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -120,9 +120,8 @@ static void riscv_sifive_e_soc_init(Object *obj)
>      MachineState *ms = MACHINE(qdev_get_machine());
>      SiFiveESoCState *s = RISCV_E_SOC(obj);
>
> -    object_initialize_child(obj, "cpus", &s->cpus,
> -                            sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
> -                            &error_abort, NULL);
> +    sysbus_init_child_obj(obj, "cpus", &s->cpus,
> +                          sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
>      object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
>                              &error_abort);
>      sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 4299bdf480..bb69fd8e48 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -491,10 +491,9 @@ static void riscv_sifive_u_soc_init(Object *obj)
>                              &error_abort, NULL);
>      qdev_prop_set_uint32(DEVICE(&s->e_cluster), "cluster-id", 0);
>
> -    object_initialize_child(OBJECT(&s->e_cluster), "e-cpus",
> -                            &s->e_cpus, sizeof(s->e_cpus),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort,
> -                            NULL);
> +    sysbus_init_child_obj(OBJECT(&s->e_cluster), "e-cpus",
> +                          &s->e_cpus, sizeof(s->e_cpus),
> +                          TYPE_RISCV_HART_ARRAY);
>      qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
>      qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
>      qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
> @@ -504,10 +503,9 @@ static void riscv_sifive_u_soc_init(Object *obj)
>                              &error_abort, NULL);
>      qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
>
> -    object_initialize_child(OBJECT(&s->u_cluster), "u-cpus",
> -                            &s->u_cpus, sizeof(s->u_cpus),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort,
> -                            NULL);
> +    sysbus_init_child_obj(OBJECT(&s->u_cluster), "u-cpus",
> +                          &s->u_cpus, sizeof(s->u_cpus),
> +                          TYPE_RISCV_HART_ARRAY);
>      qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
>      qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
>      qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index d0c4843712..01d52e758e 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -169,8 +169,8 @@ static void spike_board_init(MachineState *machine)
>      unsigned int smp_cpus = machine->smp.cpus;
>
>      /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> +    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> +                          TYPE_RISCV_HART_ARRAY);
>      object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> @@ -275,8 +275,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>      }
>
>      /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> +    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> +                          TYPE_RISCV_HART_ARRAY);
>      object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> @@ -365,8 +365,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>      }
>
>      /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> +    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> +                          TYPE_RISCV_HART_ARRAY);
>      object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c695a44979..0f93e0d9c8 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -485,8 +485,8 @@ static void riscv_virt_board_init(MachineState *machine)
>      unsigned int smp_cpus = machine->smp.cpus;
>
>      /* Initialize SOC */
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> -                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> +    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> +                          TYPE_RISCV_HART_ARRAY);
>      object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> --
> 2.21.1
>
>


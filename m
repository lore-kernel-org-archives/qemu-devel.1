Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFDEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987122072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akcGOczX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987122072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9ir-00052O-Is
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9hu-0004Ud-UZ
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:23:26 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9ht-0005af-Rx
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:23:26 -0400
Received: by mail-il1-x143.google.com with SMTP id j3so899777ilk.11
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aAAl8bEWOUhhTxxVcNnLxWC56G7b9D3wm4pcfCNY9vI=;
 b=akcGOczXAH54ARoDTp8LhhDXVfrKrXQDK0RJzj2KiUtgdvv8q1+rsb2Xjh4YpIGv1Y
 ccUmYUJaAkAWVh6DfZPZhVLEEx07JhWjzkZKNhSlUHVV49riRQ6xqQ8dEepugWK93OXy
 wh+VguoywhCS/mQY+WqI9QLL3oYT/o6os99/aPQRe7N3qmNmL8DghKxZEmAcz9qaeF7I
 nfvId+c1In/2t5DOfdHFprU4FnjWSguCvDtGt6rXm/aSxepBoI2eyE2/0mhG6BUIV06l
 ANAABiOaVQctDoJm7EfvNZMR6ArNQeDNpvdrin8JQfZTJaZljFdZ97F9qrvcsVVFNrFD
 rFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aAAl8bEWOUhhTxxVcNnLxWC56G7b9D3wm4pcfCNY9vI=;
 b=h5P3KGLgN3ALnLu9Vzw0E5WwuuZy/LF5oYo+D43FgkHluN98/2FGeo68563bDJ0Zcj
 oMy5RLTdIefD5z27IpiUL02suxj+83HZQKiIgmrLN+WK2jRa0PpW7AsqxD/UZF8/wyGp
 xsLpJFheeFYik4fOnAmFwXToqJcIzCEXcS3rfZ/ivLD6raDdgedGm4b1GnKmoLEAMsaL
 ARLHURxTv5zD1OeiEpPLo236KmPPAI7Lbc0GrhNFa07KeV+ytRkqw+wV9POL1suNqXe2
 8FVW2c2dK2oSwwnMZ7LxnGTdkoieH5hFZT1FdN3vck8PthRILMvz+ZdPv7fl07UWbo4+
 /KyQ==
X-Gm-Message-State: AOAM533agUvPSt0+BjJgO6+CxkPSffNt7Pg2U9vvXxmhnI0oy13JiTNZ
 7OaigMxyL6BlR9nHkY+gr7pF3tmKnzX0cP1dW6s=
X-Google-Smtp-Source: ABdhPJz7pKWz/lX3BGCxs8TaS8CLrtyj+2W5uWmyNtnpl6VequE5Tb49gWS3qK6hpXTub/l2+BnRtwLSpzmdI5ZkuNA=
X-Received: by 2002:a92:de02:: with SMTP id x2mr1047462ilm.267.1589923404726; 
 Tue, 19 May 2020 14:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-34-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-34-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2020 14:14:31 -0700
Message-ID: <CAKmqyKO0Lymxmm5RvhhjFmqALmb6NAmtTR88O4yKM6C0L=77_g@mail.gmail.com>
Subject: Re: [PATCH 33/55] qom: Tidy up a few object_initialize_child() calls
To: Markus Armbruster <armbru@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 8:04 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> The callers of object_initialize_child() commonly  pass either
> &child, sizeof(child), or pchild, sizeof(*pchild).  Tidy up the few
> that don't, mostly to keep the next commit simpler.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/aspeed.c                 | 2 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c | 3 +--
>  hw/pci-host/pnv_phb4.c          | 2 +-
>  hw/riscv/riscv_hart.c           | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index adbfbbd6b4..eaf50da8df 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -267,7 +267,7 @@ static void aspeed_machine_init(MachineState *machine)
>      memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
>
>      object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
> -                            (sizeof(bmc->soc)), amc->soc_name, &error_abort,
> +                            sizeof(bmc->soc), amc->soc_name, &error_abort,
>                              NULL);
>
>      sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 028f31894d..aa90b9d1be 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -174,8 +174,7 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>                                  pmu_ram);
>
>      /* Create the PMU device */
> -    object_initialize_child(OBJECT(machine), "pmu", pmu,
> -                            sizeof(XlnxZynqMPPMUSoCState),
> +    object_initialize_child(OBJECT(machine), "pmu", pmu, sizeof(*pmu),
>                              TYPE_XLNX_ZYNQMP_PMU_SOC, &error_abort, NULL);
>      object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
>
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index e30ae9ad5b..aba710fd1f 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1155,7 +1155,7 @@ static void pnv_phb4_instance_init(Object *obj)
>      QLIST_INIT(&phb->dma_spaces);
>
>      /* XIVE interrupt source object */
> -    object_initialize_child(obj, "source", &phb->xsrc, sizeof(XiveSource),
> +    object_initialize_child(obj, "source", &phb->xsrc, sizeof(phb->xsrc),
>                              TYPE_XIVE_SOURCE, &error_abort, NULL);
>
>      /* Root Port */
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 276a9baca0..61e88e2e37 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -46,7 +46,7 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
>      Error *err = NULL;
>
>      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
> -                            sizeof(RISCVCPU), cpu_type,
> +                            sizeof(s->harts[idx]), cpu_type,
>                              &error_abort, NULL);
>      s->harts[idx].env.mhartid = s->hartid_base + idx;
>      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
> --
> 2.21.1
>
>


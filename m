Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83802C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 00:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AAE2073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 00:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUhfKv62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AAE2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqQoM-0005fW-LR
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 20:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqQne-00055s-Uv; Tue, 30 Jun 2020 20:40:31 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:45195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqQnc-0007Kh-G6; Tue, 30 Jun 2020 20:40:30 -0400
Received: by mail-io1-xd44.google.com with SMTP id e64so18190779iof.12;
 Tue, 30 Jun 2020 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KQAbQd7JpNZe0P+Q3d5SVfyZKpCRYlA8XNfnJ4Va4GQ=;
 b=SUhfKv62Pt7M+pJLB1TE+0PiprzKVNrr4xYa/cuSMUGiOgMCnZP2rCFWl2mDdKFS/k
 kz044h31kyB3Gwz3cq5YDpIeQEPtXq46FY78lDruRv1P1nIyLtO8fTBcKsG7z+3rAAJh
 xPQYJTVde3NPppny9706GrD9v0XJIqI74FCp5oNPjXrntp2S1A7KJAT/VLGclpHjOkt6
 iT5nM9GCKLdKuLhA5L02ggky7pmFzpOCuEMwYS+oQ2+g7LpwsPopC67RMdkzp2A8isUf
 kiMniDtj5o+lMRmjC9eMSgj4BknkBwmQD+vTUDK/uPyyt/5aAvZ0cimI9BBROvB3jQEN
 07Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KQAbQd7JpNZe0P+Q3d5SVfyZKpCRYlA8XNfnJ4Va4GQ=;
 b=eAvOuvP6kp6s5MVihZ0gRJpPNlXl8YYL5yOHUbk4K/ue7aagmuHkIxMwpddui0TcTj
 H8dALFuMpLFZrpEG9Yr7QrIGEirmUO8HzpuvJvJKKrseAPj+DoD7Cb+b11thf3FQp7yv
 zmE6sTIAExzfjo7vnBTOEt5zAQKpuDtQgAJ0JAb06Bs84jcGPeL2c68rKL6NKweGus4J
 vTRDTS9ADpUl/33E+QGS3+Mrt/avJst/k6YUNfOxenttPSJKnXkbLLwMn5Q5W622zYr0
 JnB8WJfho06PdUAqcw7ebJ7GqBhoZBq+sDXtHf1u6/tFFhawrM4ogfuHKs5z1sWbQqm7
 a6ew==
X-Gm-Message-State: AOAM533rh00j6INpk5LuZEwi6bu62xCQja2PEkthUPO/mKZNFXEJgf6U
 CJ4bZeaZww6AIJHFlCmuM8aTBCF33Cm0+KBcBTc=
X-Google-Smtp-Source: ABdhPJy/VWZ/ha1YXPTJLglqkJ93VInAYkYiUp+Kv5+gm1zPOC2HiFsT8VS+xtpNxpx+Y4aqiOfELtbfZD4L3XA1hFg=
X-Received: by 2002:a02:10c1:: with SMTP id 184mr25171681jay.135.1593564027034; 
 Tue, 30 Jun 2020 17:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-13-dmitry.fomichev@wdc.com>
In-Reply-To: <20200617213415.22417-13-dmitry.fomichev@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jun 2020 17:30:43 -0700
Message-ID: <CAKmqyKPm+AUMJZVEkc6qW+V14o+9t1Grb9hugZGoaVA9v4r5OQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] hw/block/nvme: Simulate Zone Active excursions
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 2:52 PM Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
>
> Added a Boolean flag to turn on simulation of Zone Active Excursions.
> If the flag, "active_excursions", is set to true, the driver will try
> to finish one of the currently open zone if max active zones limit is
> going to get exceeded.
>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/nvme.c | 24 +++++++++++++++++++++++-
>  hw/block/nvme.h |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 05a7cbcfcc..a29cbfcc96 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -540,6 +540,26 @@ static void nvme_auto_transition_zone(NvmeCtrl *n, NvmeNamespace *ns,
>  {
>      NvmeZone *zone;
>
> +    if (n->params.active_excursions && adding_active &&
> +        n->params.max_active_zones &&
> +        ns->nr_active_zones == n->params.max_active_zones) {
> +        zone = nvme_peek_zone_head(ns, ns->closed_zones);
> +        if (zone) {
> +            /*
> +             * The namespace is at the limit of active zones.
> +             * Try to finish one of the currently active zones
> +             * to make the needed active zone resource available.
> +             */
> +            nvme_aor_dec_active(n, ns);
> +            nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_FULL);
> +            zone->d.za &= ~(NVME_ZA_FINISH_RECOMMENDED |
> +                            NVME_ZA_RESET_RECOMMENDED);
> +            zone->d.za |= NVME_ZA_FINISHED_BY_CTLR;
> +            zone->tstamp = 0;
> +            trace_pci_nvme_zone_finished_by_controller(zone->d.zslba);
> +        }
> +    }
> +
>      if (implicit && n->params.max_open_zones &&
>          ns->nr_open_zones == n->params.max_open_zones) {
>          zone = nvme_remove_zone_head(n, ns, ns->imp_open_zones);
> @@ -2631,7 +2651,7 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
>      /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
>      ns->id_ns_zoned->mar = cpu_to_le32(n->params.max_active_zones - 1);
>      ns->id_ns_zoned->mor = cpu_to_le32(n->params.max_open_zones - 1);
> -    ns->id_ns_zoned->zoc = 0;
> +    ns->id_ns_zoned->zoc = cpu_to_le16(n->params.active_excursions ? 0x2 : 0);
>      ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
>
>      ns->id_ns_zoned->lbafe[lba_index].zsze = cpu_to_le64(n->params.zone_size);
> @@ -2993,6 +3013,8 @@ static Property nvme_props[] = {
>      DEFINE_PROP_INT32("max_active", NvmeCtrl, params.max_active_zones, 0),
>      DEFINE_PROP_INT32("max_open", NvmeCtrl, params.max_open_zones, 0),
>      DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
> +    DEFINE_PROP_BOOL("active_excursions", NvmeCtrl, params.active_excursions,
> +                     false),
>      DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index f5a4679702..8a0aaeb09a 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -15,6 +15,7 @@ typedef struct NvmeParams {
>
>      bool        zoned;
>      bool        cross_zone_read;
> +    bool        active_excursions;
>      uint8_t     fill_pattern;
>      uint32_t    zamds_bs;
>      uint64_t    zone_size;
> --
> 2.21.0
>
>


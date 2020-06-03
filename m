Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00487C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 18:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37AA2053B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 18:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1q9f/3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37AA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgYDP-0007pS-1c
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 14:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jgYCa-0007OE-Es; Wed, 03 Jun 2020 14:33:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jgYCZ-0004n3-DZ; Wed, 03 Jun 2020 14:33:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so3477290wru.0;
 Wed, 03 Jun 2020 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z7ZSaQV8FCkoSIZW6VtjaYv7rq0pKKOrkPApUTO6y6A=;
 b=u1q9f/3e2+8xzbph2+6x6xAGEoU5SNI8kcvSzImcFXvfS5ZPQEkyOoqVKKPdqyXWLX
 hf81nvAXNR0Fm36WEVrpVKw+zPAVkjm0bbM7okM4T0vnbdmKGT/trXVWLk9DJ2kyKCmr
 Dlbd/TlUeaLb7v3quOIrFzFJdpAFavEsTsi0WAbeyd1ToGCDhdrYesXJlFohTdQwGCUc
 X6cWisoo7ihVNjEZJnk51V7pgVXKBjUzK9jVcrQUg7pNMQQiqb1Qpp669zvQkPWf1+hG
 XGXU766JtrIFEcZRjXIBERzHUYmAd/F5OhfIZRRZyxrnvIfQrPNEvGEo701dXcWil5vw
 MJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z7ZSaQV8FCkoSIZW6VtjaYv7rq0pKKOrkPApUTO6y6A=;
 b=UocKjnwCXUrgppqEuIsk4iy1wBWf9QLfaAz4eXc9TfKR9Hc7KRZaEtRN1Q9DzGmuRe
 G7R4Kg82b0XsMuaMfaG33gk8RtAwJiRLz7T7QsljdoNUGU/v9Kmu1eAx4XwL5Frc0GkK
 y+ym8CjNZ86OhZRWfnjCkkJRPtdWw6CvJabFP1tNqPoXhJCN1kbJleI+IcN5Eu1fktXE
 Mao+uhloNkg/EYHeSxmU7cXLZsXUgGwECrJuw34MokJ5jnSS1ZNyTSRM+Y6R69ilhFFd
 2u/NFaSrlDlUmiYgvCmJqDz+D/jt+6XcZad66MUdUFR0SNUparFaNEMIENppUDL0wx6V
 zr+Q==
X-Gm-Message-State: AOAM5303sbIn4LUDJskIQqB3GGtk7Y8en2C/mPZwXdcJQMtHUv6lCfHw
 bL4s2WiDK5plNX4tQgbBaoGhTi2TnKIDSW/WxRE=
X-Google-Smtp-Source: ABdhPJxhzl6xqHC2YqnpHtDWSfzfVs9/1wD5cdtokxBPSWg3b0KGSbnnHwoX/bQ6MSBau//Kj4kMcYG+NPySKwS71TM=
X-Received: by 2002:a5d:4282:: with SMTP id k2mr720391wrq.196.1591209200829;
 Wed, 03 Jun 2020 11:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200603144914.41645-1-david@redhat.com>
 <20200603144914.41645-15-david@redhat.com>
In-Reply-To: <20200603144914.41645-15-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 3 Jun 2020 20:33:09 +0200
Message-ID: <CAM9Jb+jQRteSthE3rWMBEybLcMyXO+C+Q1FiH1h63tLmWBL-wA@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] numa: Handle virtio-mem in NUMA stats
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Account the memory to the configured nid.
>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/core/numa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 316bc50d75..06960918e7 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -812,6 +812,7 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>      MemoryDeviceInfoList *info;
>      PCDIMMDeviceInfo     *pcdimm_info;
>      VirtioPMEMDeviceInfo *vpi;
> +    VirtioMEMDeviceInfo *vmi;
>
>      for (info = info_list; info; info = info->next) {
>          MemoryDeviceInfo *value = info->value;
> @@ -832,6 +833,11 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>                  node_mem[0].node_mem += vpi->size;
>                  node_mem[0].node_plugged_mem += vpi->size;
>                  break;
> +            case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
> +                vmi = value->u.virtio_mem.data;
> +                node_mem[vmi->node].node_mem += vmi->size;
> +                node_mem[vmi->node].node_plugged_mem += vmi->size;
> +                break;
>              default:
>                  g_assert_not_reached();
>              }

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>


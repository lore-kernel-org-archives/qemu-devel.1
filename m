Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AB1C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C57921527
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbBaVUt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C57921527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHQp-00016j-88
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kMHPr-0000GX-Kw
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 17:07:35 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kMHPp-0005Px-Px
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 17:07:35 -0400
Received: by mail-il1-x144.google.com with SMTP id s88so5969933ilb.6
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fal3Y0sJuouvHzHkG2K7+TUsT6cl7+z/fzD4B0ut1hI=;
 b=vbBaVUt42q6Wi6jl6wo9lwfg0WV6FQysa9qWFfFvicHIpuwbPuHN6sU5Xmgzd25FVV
 m4d7NMa7S0lqv43W24lN3BA6aj2kEK2atK+Zjpi4QvQZKvdeIo0pgCW9cS9mCx0rbvE6
 CUx9fJI8mepGUPdg2Ex+YfA4CqsTnbY1O+KsVBumGSNo0F1a3MsiC/Z1CeklkPUrxPCj
 XsCM5wjny3xl4zp78CWiANYISLxCvf4G80GuCCYJTYeat5QjMoNcWi0b/9Sd2zDofGqx
 mHcCjgS2cgXuDQAKLIfAwC2oxlMtyo0ivYthTzoYo/WgfWlyoZTJscNJ+0PXBHLygAdx
 RDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fal3Y0sJuouvHzHkG2K7+TUsT6cl7+z/fzD4B0ut1hI=;
 b=ZxvVMuuya9T2FZBtiX2cUJrkWVNRMgxPoYQnkP8gachT4JMJJPjq6zam+tjCOEiVYb
 R1G5tIGzr9WSSY/ofoGNe/1O6uXgYUskEh6gnjDVm2scc0yQFKDNhx1sP7ZlSb++r3nv
 V9ubil9qWIY2QRax7xZSMBiyJ+fqUAv/ltiAG+uxLqRhLLqh4aFdH+n10KcbHYIjAdyr
 b9kw0XKScHVw8WZpqsmEgZeo2v5fnfSmdDZRXsAUYmNG3ZAOn/k20j3K2uACVT7/J1CP
 aHIxv+bOszYCbDY4NDr0+T9cuzGH/suDVWKP/TO9mOOIEnRU4h/kZRjRJ3hTyVAnSDzT
 XKsQ==
X-Gm-Message-State: AOAM533dW+Wri14P3eREvu4lwyE2AG8vYAKq4Ay0Uoj3yvRPQtUCBxk6
 YafPMLEo4kOfvZacQxFx7HjuGWUH4yIl85uDvnxsw9TTcLK1RQ==
X-Google-Smtp-Source: ABdhPJzRl8i66g/O/Qq45VzGpvpeZM1keJbY73ymZj1b9oppzKOVC77zaT/K7NVW0NIEoxm/sU9FCJdMgFu8WTRzE1E=
X-Received: by 2002:a92:d645:: with SMTP id x5mr5125711ilp.79.1601154452006;
 Sat, 26 Sep 2020 14:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200923113900.72718-1-david@redhat.com>
 <20200923113900.72718-5-david@redhat.com>
In-Reply-To: <20200923113900.72718-5-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Sat, 26 Sep 2020 23:07:20 +0200
Message-ID: <CAM9Jb+g8RKb3eqKtqzwYU7_PU_Go+XLbrvC57AUF6EmCo8mDuQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] memory-device: Add get_min_alignment() callback
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Will be used by virtio-mem to express special alignment requirements due
> to manually configured, big block sizes. This avoids failing later when
> realizing, because auto-detection wasn't able to assign a properly
> aligned address.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/memory-device.c         | 11 +++++++++--
>  include/hw/mem/memory-device.h | 11 +++++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 8a736f1a26..cf0627fd01 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -259,7 +259,7 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
>  {
>      const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
>      Error *local_err = NULL;
> -    uint64_t addr, align;
> +    uint64_t addr, align = 0;
>      MemoryRegion *mr;
>
>      mr = mdc->get_memory_region(md, &local_err);
> @@ -267,7 +267,14 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
>          goto out;
>      }
>
> -    align = legacy_align ? *legacy_align : memory_region_get_alignment(mr);
> +    if (legacy_align) {
> +        align = *legacy_align;
> +    } else {
> +        if (mdc->get_min_alignment) {
> +            align = mdc->get_min_alignment(md);
> +        }
> +        align = MAX(align, memory_region_get_alignment(mr));
> +    }
>      addr = mdc->get_addr(md);
>      addr = memory_device_get_free_addr(ms, !addr ? NULL : &addr, align,
>                                         memory_region_size(mr), &local_err);
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> index cde52e83c9..563893854a 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -88,6 +88,17 @@ struct MemoryDeviceClass {
>       */
>      MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
>
> +    /*
> +     * Optional: Return the desired minimum alignment of the device in guest
> +     * physical address space, ignoring the alignment requirements of the
> +     * memory region (e.g., based on the page size). The final alignment is
> +     * computed by selecting the maximum of both alignments.
> +     *
> +     * Called when plugging the memory device to detect the required alignment
> +     * during address assignment.
> +     */
> +    uint64_t (*get_min_alignment)(const MemoryDeviceState *md);
> +
>      /*
>       * Translate the memory device into #MemoryDeviceInfo.
>       */
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>


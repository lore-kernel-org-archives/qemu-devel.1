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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8F9C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422ED21531
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfUF+Mu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422ED21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHgR-0005Ip-9f
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kMHfk-0004sF-Ph
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 17:24:00 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:46328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kMHfi-0006sT-2J
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 17:24:00 -0400
Received: by mail-il1-x143.google.com with SMTP id l16so5982490ilt.13
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HIgQHfdDH+jZriGr+pY/rhbupGSKj8HFyxcXJlNP/WY=;
 b=vfUF+Mu2XGMNrSv8L1yVHYysH/TkyD4/fIvrZS5rvBDhdeNdZi2V6nsSgmk513Ne09
 jIDQ5jChzO7W3+i7p69qTkM3BFjKZSpjgaCauGQYoT+zq2HtugVLcSeMzpB2ARQ1aw19
 gzrdCEF/H03qzOJQ18G6js30wLzXQLDFuUyTktpEWLeqXpGoDWlkmhHOCUtBcIXQoorn
 ynWSHK0+lYQUhhJKvhoofe3jiye0OqcuYnlOdtgWcOdB3WV3M00iMaTO9kVtmjRJbnQH
 PN3soUSsu/yX779Y0h+WZnSuVKnd9CW1Y59DIQeqeT8peHMxOXvcSi7WOgqcW9yAoYpB
 d46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HIgQHfdDH+jZriGr+pY/rhbupGSKj8HFyxcXJlNP/WY=;
 b=Hxvb0fb/p0UUkc8aGarO1bWn+PGJ3mJQAvEnBPEg4B+oEIpP+nsAHoqZDp/WuTRJuL
 +2APTpA2uG8gq+Y+9WgWvQWqgY1HJ21M34Q0OoIlKY7sgFETvS19E6Dx371SsMCrR9kh
 x136zx+sbLvtO/cYuc3qe4z0YsPvY/q0bt+F2WtRn8z2weMj7Wy4235/HcLh8wcqd8Y2
 cFUE7D54bi2Spb6u75sgzE1LZsVdFn2EenY6t/kAASzOa0fD11IgQRRy7Rb4XxF3PlcO
 SDiswrSkpiS0eRcdbzDfB3qhoK4PgJRXN1Zh86kuA8SB2QP6SHmyzQQfVU5cIJ2PgiAk
 ZV+w==
X-Gm-Message-State: AOAM533nsWjPba0wZxfBPpa1RReTsZnaJDo0vsxN2uARwWAWcPd2wvWU
 M9RzwDPRhrA6pmucwZRWLS3kf5ZjoPjmddDieZI=
X-Google-Smtp-Source: ABdhPJyyIqGteU1AF4um/fCQhgqWVL9xfLG4dLrhTX8su4ZD+k3eRKhF0uN8/WuMGSbGf3oygHtax+cubb++z+xImbE=
X-Received: by 2002:a92:d68d:: with SMTP id p13mr4698484iln.32.1601155437031; 
 Sat, 26 Sep 2020 14:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200923113900.72718-1-david@redhat.com>
 <20200923113900.72718-6-david@redhat.com>
In-Reply-To: <20200923113900.72718-6-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Sat, 26 Sep 2020 23:23:46 +0200
Message-ID: <CAM9Jb+iRz2+8QeF8LtEmP+rDy3Tf_oWo9Wy7V8gWgyftCm4+Fw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] virito-mem: Implement get_min_alignment()
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-il1-x143.google.com
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

> This allows auto-assignment of a properly aligned address in guest
> physical address space. For example, when specifying a 2GB block size
> for a virtio-mem device with 10GB with a memory setup "-m 4G, 20G",
> we'll no longer fail when realizing.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-mem-pci.c | 14 ++++++++++++++
>  hw/virtio/virtio-mem.c     |  8 ++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
> index 590cec041b..2bfa2474fb 100644
> --- a/hw/virtio/virtio-mem-pci.c
> +++ b/hw/virtio/virtio-mem-pci.c
> @@ -75,6 +75,19 @@ static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
>      info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
>  }
>
> +static uint64_t virtio_mem_pci_get_min_alignment(const MemoryDeviceState *md)
> +{
> +    /*
> +     * If no block size was configured, returns the default block size.
> +     * Before the device was realized, this might be smaller than the
> +     * final block size (because it ignores the page size of the memory region).
> +     * However, the alignment of the memory region properly considers the
> +     * page size of the memory region.
> +     */
> +    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_BLOCK_SIZE_PROP,
> +                                    &error_abort);
> +}
> +
>  static void virtio_mem_pci_size_change_notify(Notifier *notifier, void *data)
>  {
>      VirtIOMEMPCI *pci_mem = container_of(notifier, VirtIOMEMPCI,
> @@ -109,6 +122,7 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
>      mdc->get_plugged_size = virtio_mem_pci_get_plugged_size;
>      mdc->get_memory_region = virtio_mem_pci_get_memory_region;
>      mdc->fill_device_info = virtio_mem_pci_fill_device_info;
> +    mdc->get_min_alignment = virtio_mem_pci_get_min_alignment;
>  }
>
>  static void virtio_mem_pci_instance_init(Object *obj)
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 716eddd792..d8222153cf 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -805,6 +805,14 @@ static void virtio_mem_get_block_size(Object *obj, Visitor *v, const char *name,
>      const VirtIOMEM *vmem = VIRTIO_MEM(obj);
>      uint64_t value = vmem->block_size;
>
> +    /*
> +     * If not configured by the user (and we're not realized yet), use the
> +     * default block size.
> +     */
> +    if (!value) {
> +        value = virtio_mem_default_block_size();
> +    }
> +
>      visit_type_size(v, name, &value, errp);
>  }
>

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>


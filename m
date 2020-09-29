Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD75C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1017A20739
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1SNF821"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1017A20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGZh-00012b-FR
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kNGYS-0000Np-5G
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:24:32 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:34695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kNGYP-0007wZ-T0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:24:31 -0400
Received: by mail-il1-x144.google.com with SMTP id q5so5064897ilj.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ghbpn7PKO8ktden4QTLfrNlyxdykkhqcQmWsxGfZ4dA=;
 b=h1SNF821m0NNhLo7ie3ZwpF7ZJn7KlFad3KIyu+1760nRSywrDAFulsfAtSEth/kiA
 /WgqnUfgEJxpgw3s+022IneSL9SoM1lxkTywWYTFSHNJeitLytg8RUxAmP7nnxeK6xX7
 kMxwJ+iTvgMj0V+amDsa46gZkVk7w4DFpyo5xPwrre72nj6drejI616vr0dM7hajaDGn
 QRQ/szeP7Vx/uJlTYuR/lAzolEVfFH70po+VWsBBHNwWTMoqhmKUBHlDRWr7iO0bdMDF
 nz1Ify+z9thiLH1N254NFFdS8V6HnKsa0wUiAXbJGVSHDO8uShKk59CWa3BXdm4hU8HX
 tiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ghbpn7PKO8ktden4QTLfrNlyxdykkhqcQmWsxGfZ4dA=;
 b=FUf8AzCEBNaKwWSzDG4CenvAKvm94BNybqiKCP7VDCpTXogibWmvWnC2e+TbnlZ0HT
 BlPTraNIkpv/BExTk3eYFknsSBoMLQ/mTsZ0cJnZ1D0JfRNZnBg60TbTc/BxtJvn9O5t
 TFlaQg6ZsCSfQVCdsSgI8YmcUa13BxmuhwCNTDb18MZct6HWqj7XzOhPLLbS/eT2E2RI
 Wc1n4K+gBz1Rnhtv+78t0Kc8BHR3hhOVC6smKngyP+F+mYC+UMiKCbI/CJ3Iy+TOjJ18
 NIo0v585O6ECN1qNWS4s3EnSqL0si+cc+jLBI0SmjqV4gdpdb34DTCZJrjJ1BbygjwJF
 uCow==
X-Gm-Message-State: AOAM5332wVdOLS8lwCOJxRJ0E/vPfyZ8vqADIp0Em40Gar3a2OKuYO2u
 fVEHIj9xxrlEYozv99NaPdqEPAfeKD4FY0CtGHI=
X-Google-Smtp-Source: ABdhPJwKH+5cfaylbaiAt4tporlUi8YLdJmr5jhd8y5zTSRGYviaMOK2tern1ClzGFxIwHaJtJElBAVBL0r5f4qEfN8=
X-Received: by 2002:a92:ccc5:: with SMTP id u5mr3369854ilq.178.1601389468631; 
 Tue, 29 Sep 2020 07:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200928114909.20791-1-david@redhat.com>
 <20200928114909.20791-2-david@redhat.com>
 <CAM9Jb+gdf+n+Poa_kZRRTchcB8D33FDuuTyn4tB4TjWyAah9Hw@mail.gmail.com>
 <e14670b7-417b-17be-3275-82f7ef0861d7@redhat.com>
In-Reply-To: <e14670b7-417b-17be-3275-82f7ef0861d7@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 29 Sep 2020 16:24:17 +0200
Message-ID: <CAM9Jb+j3pMLOUhm=x+Wr+t1sHDxyT6aNC=keK7G1p7yaU5p-kQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] virtio-mem: Probe THP size to determine default
 block size
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

> >> Let's allow a minimum block size of 1 MiB in all configurations. Select
> >> the default block size based on
> >> - The page size of the memory backend.
> >> - The THP size if the memory backend size corresponds to the real hsot
> >
> > s/hsot/host
>
> thanks!
>
> >>   page size.
> >> - The global minimum of 1 MiB.
> >> and warn if something smaller is configured by the user.
> >>
> >> VIRTIO_MEM only supports Linux (depends on LINUX), so we can probe the
> >> THP size unconditionally.
> >>
> >> For now we only support virtio-mem on x86-64 - there isn't a user-visiable
> >
> > s/visiable/visible
>
> thanks!
>
> >> change (x86-64 only supports 2 MiB THP on the PMD level) - the default
> >> was, and will be 2 MiB.
> >>
> >> If we ever have THP on the PUD level (e.g., 1 GiB THP on x86-64), we
> >> expect to have a trigger to explicitly opt-in for the new THP granularity.
> >>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Wei Yang <richardw.yang@linux.intel.com>
> >> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/virtio/virtio-mem.c | 105 +++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 101 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> >> index 8fbec77ccc..9b1461cf9d 100644
> >> --- a/hw/virtio/virtio-mem.c
> >> +++ b/hw/virtio/virtio-mem.c
> >> @@ -33,10 +33,83 @@
> >>  #include "trace.h"
> >>
> >>  /*
> >> - * Use QEMU_VMALLOC_ALIGN, so no THP will have to be split when unplugging
> >> - * memory (e.g., 2MB on x86_64).
> >> + * Let's not allow blocks smaller than 1 MiB, for example, to keep the tracking
> >> + * bitmap small.
> >>   */
> >> -#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)QEMU_VMALLOC_ALIGN)
> >> +#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)(1 * MiB))
> >> +
> >> +#if defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) || \
> >> +    defined(__powerpc64__)
> >> +#define VIRTIO_MEM_DEFAULT_THP_SIZE ((uint32_t)(2 * MiB))
> >> +#else
> >> +        /* fallback to 1 MiB (e.g., the THP size on s390x) */
> >> +#define VIRTIO_MEM_DEFAULT_THP_SIZE VIRTIO_MEM_MIN_BLOCK_SIZE
> >> +#endif
> >> +
> >> +/*
> >> + * We want to have a reasonable default block size such that
> >> + * 1. We avoid splitting THPs when unplugging memory, which degrades
> >> + *    performance.
> >> + * 2. We avoid placing THPs for plugged blocks that also cover unplugged
> >> + *    blocks.
> >> + *
> >> + * The actual THP size might differ between Linux kernels, so we try to probe
> >> + * it. In the future (if we ever run into issues regarding 2.), we might want
> >> + * to disable THP in case we fail to properly probe the THP size, or if the
> >> + * block size is configured smaller than the THP size.
> >> + */
> >> +static uint32_t thp_size;
> >> +
> >> +#define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
> >> +static uint32_t virtio_mem_thp_size(void)
> >> +{
> >> +    gchar *content = NULL;
> >> +    const char *endptr;
> >> +    uint64_t tmp;
> >> +
> >> +    if (thp_size) {
> >> +        return thp_size;
> >> +    }
> >> +
> >> +    /*
> >> +     * Try to probe the actual THP size, fallback to (sane but eventually
> >> +     * incorrect) default sizes.
> >> +     */
> >> +    if (g_file_get_contents(HPAGE_PMD_SIZE_PATH, &content, NULL, NULL) &&
> >> +        !qemu_strtou64(content, &endptr, 0, &tmp) &&
> >> +        (!endptr || *endptr == '\n')) {
> >> +        /*
> >> +         * Sanity-check the value, if it's too big (e.g., aarch64 with 64k base
> >> +         * pages) or weird, fallback to something smaller.
> >> +         */
> >> +        if (!tmp || !is_power_of_2(tmp) || tmp > 16 * MiB) {
> >> +            warn_report("Read unsupported THP size: %" PRIx64, tmp);
> >> +        } else {
> >> +            thp_size = tmp;
> >> +        }
> >> +    }
> >> +
> >> +    if (!thp_size) {
> >> +        thp_size = VIRTIO_MEM_DEFAULT_THP_SIZE;
> >> +        warn_report("Could not detect THP size, falling back to %" PRIx64
> >> +                    "  MiB.", thp_size / MiB);
> >> +    }
> >> +
> >> +    g_free(content);
> >> +    return thp_size;
> >> +}
> >> +
> >> +static uint64_t virtio_mem_default_block_size(RAMBlock *rb)
> >> +{
> >> +    const uint64_t page_size = qemu_ram_pagesize(rb);
> >> +
> >> +    /* We can have hugetlbfs with a page size smaller than the THP size. */
> >> +    if (page_size == qemu_real_host_page_size) {
> >> +        return MAX(page_size, virtio_mem_thp_size());
> >> +    }
> >
> > This condition is special, can think of hugetlbfs smaller in size than THP size
> > configured.
>
> Yeah, there are weird architectures, most prominently arm64:
>
> https://www.kernel.org/doc/html/latest/arm64/hugetlbpage.html
>
> Assume you're on 64K base pages with a probed 512MB THP size
> (currently). You could have hugetlbfs with 2MB page size via "CONT PTE"
> bits.

Ok. I understand now. Thanks for explaining!
>
> >> +    return MAX(page_size, VIRTIO_MEM_MIN_BLOCK_SIZE);
> >
> > Do we still need this? Or we can have only one return for both the cases?
> > Probably, I am missing something here.
>
> We still need it. Assume somebody would have 64K hugetlbfs on arm64
> (with 4k base pages), we want to make sure we use at least 1MB blocks.
ok. got it.

Looks good to me.
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>


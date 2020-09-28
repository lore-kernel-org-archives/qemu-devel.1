Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27316C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E205221E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXWWcaim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E205221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpXP-0002sY-Ia
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kMpVW-0001ax-A5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:31:42 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kMpVT-0004Tw-Nh
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:31:41 -0400
Received: by mail-io1-xd43.google.com with SMTP id y13so424970iow.4
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m3ukiYrDWk4x2oC/NjhUqCrEPN24kl8Py9Zb2Jq6Dz0=;
 b=VXWWcaimyPj/8CSKB1zP/fNqLSNlI6Hxi/dXng9hdP21imVmrFRir7KAzhpCoLVlj1
 uU5B5xriaBT+75luknCVDzYacc2AKnvPwxaU2G17XUKysLiI2poFzASEirmqmdfos3Yq
 sqhXneMvLjQjsejxRW14EVNnJ5WPt4iQl6g0LBetx/eQbC/9I4rKejzyF2SgAbCa5ECt
 veurWaRQhylECjULRraQ1dIkjWYM/NpdvI/k1cSfPadHDJ5eYRRSmNy/pmPFPqCMnJKj
 IEJf7Dcvk/8yM6xdqN3wWg8UPcW/HwQW5NeiYHiohn9gK5FvzF1MxjzhRWPt+hUAAgxa
 Pmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m3ukiYrDWk4x2oC/NjhUqCrEPN24kl8Py9Zb2Jq6Dz0=;
 b=ZOqkdbZvalwn3AiEjB/P3OIiYXvOEN6b7HOzRBazCjzMIJwCbfWh3nHtS6P71V52bO
 vBe6MwdKVdocMqkN6TEDQv0VNjkt7ZnqKE3aDD9ABCFGoS9onPDimPaIXzbCf+DL5a8c
 L4RgYw3OK+1QPOQrDThpeMKK+mQWbUsDBF20HnuWDQ8LW6zJj6s+tEk3BVkCLUuId7zn
 bShPwsx37A6Mfwh3UAvIqqcOFE/ll0Fh5IQTNVpbQ6al+JOih8vjvchcOciV/PwR0LuL
 u1C8dxREVg0Y2f9L4rfmPfb0C6/JzEIESVr1zmMbZZT91C87EgfIyMCAYf9ISSu3TeKm
 QKxg==
X-Gm-Message-State: AOAM5301uC1dJe4BjDOAy8hGlgWhOIDW1ZcCoID/4IYkZAz+1z155wnr
 CfA2OytlyZdo2IwO7Pz9uRjoL3ZVFWHUiMnqh3I=
X-Google-Smtp-Source: ABdhPJzrBCKqXdCKtl8DO3cf+Kyeby+5gKfypnewxRtyrPW3Saxr3i0D8XNNGfNCJA4rkOJVmuO/12W5upWaOtz28ao=
X-Received: by 2002:a6b:d603:: with SMTP id w3mr6429017ioa.29.1601285498303;
 Mon, 28 Sep 2020 02:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200923113900.72718-1-david@redhat.com>
 <20200923113900.72718-2-david@redhat.com>
 <CAM9Jb+gJkzW3_d-JxG+o6eYttSXHPGxCGDhzLgpyb_okOG+xXA@mail.gmail.com>
 <21b7facd-0801-f90e-8806-ccfa3d1730fa@redhat.com>
In-Reply-To: <21b7facd-0801-f90e-8806-ccfa3d1730fa@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Mon, 28 Sep 2020 11:31:27 +0200
Message-ID: <CAM9Jb+jG9hhWZ_QAG_LddannRh1zQzTB9nYf7GOVHZo44pKL9Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] virtio-mem: Probe THP size to determine default
 block size
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd43.google.com
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

> >> Let's allow a minimum block size of 1 MiB in all configurations. Use
> >> a default block size based on the THP size, and warn if something
> >> smaller is configured by the user.
> >>
> >> VIRTIO_MEM only supports Linux (depends on LINUX), so we can probe the
> >> THP size unconditionally.
> >>
> >> For now we only support virtio-mem on x86-64 - there isn't a user-visiable
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
> >>  hw/virtio/virtio-mem.c | 82 +++++++++++++++++++++++++++++++++++++++---
> >>  1 file changed, 78 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> >> index 8fbec77ccc..58098686ee 100644
> >> --- a/hw/virtio/virtio-mem.c
> >> +++ b/hw/virtio/virtio-mem.c
> >> @@ -33,10 +33,70 @@
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
> >> +static uint32_t default_block_size;
> >> +
> >> +#define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
> >> +static uint32_t virtio_mem_default_block_size(void)
> >> +{
> >> +    gchar *content = NULL;
> >> +    const char *endptr;
> >> +    uint64_t tmp;
> >> +
> >> +    if (default_block_size) {
> >> +        return default_block_size;
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
> >> +            warn_report("Detected a THP size of %" PRIx64
> >> +                        " MiB, falling back to 1 MiB.", tmp / MiB);
> >> +            default_block_size = 1 * MiB;
> >
> > Probably use macro "VIRTIO_MEM_MIN_BLOCK_SIZE"
>
> Indeed.
>
> >> +        } else {
> >> +            default_block_size = tmp;
> >> +        }
> >> +    } else {
> >> +#if defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) || \
> >> +    defined(__powerpc64__)
> >> +        default_block_size = 2 * MiB;
> >> +#else
> >> +        /* fallback to 1 MiB (e.g., the THP size on s390x) */
> >> +        default_block_size = 1 * MiB;
> >> +#endif
> >
> > Maybe we can declare this macro near to "VIRTIO_MEM_MIN_BLOCK_SIZE
> > ((uint32_t)(1 * MiB))"
> > or club into one, just a thought.
>
> I decided to not use VIRTIO_MEM_MIN_BLOCK_SIZE here to not accidentally
> mess up the s390x THP size when ever wanting to decrease
> VIRTIO_MEM_MIN_BLOCK_SIZE. But as we have a comment here, people should
> know whats happening when ever changing VIRTIO_MEM_MIN_BLOCK_SIZE.

Thanks for answering. Makes sense.

Overall the patch looks good to me.
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>


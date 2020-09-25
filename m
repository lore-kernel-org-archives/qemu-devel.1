Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B58C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0B320BED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8N5388Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0B320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoa2-0000ce-22
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLoYv-00089c-LQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:19:01 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLoYu-0004dD-2w
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:19:01 -0400
Received: by mail-io1-xd43.google.com with SMTP id g128so2849727iof.11
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X4ErAsL2TKf8BKb9ojU+VmE8k0NsVev5lTaCWEWnl0s=;
 b=t8N5388ZeBA/arnI0hnCs/er1HWfUCfY8xQs0kF0weIaletTM6F1Cw/Jk7jN93za6L
 3m+N5ronY/YDPMQhQAVkcS27UU5u0V8ju52ftVaQucQO2tK/0sZXR6RC/5Tqloc3i9Mk
 XS96sng6IESEd1afOzi/oxnF0j53B0nXOmdLBYqN+EZlXM45HLm+Mjlu11B/hrP+0jQ5
 xYMFGvoJBvb8LHatiwSZjrg9kThYeF/smpzuNZ4p4LCi5U954y+Q4ZVJe9GG7Pser+Ln
 IgpFA+q9nlmuBslbtwiWhbcqPULNhnJTu3bvzUgpkhVz46Zs16qOYOpcdb+9y8U9Gqi1
 S4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X4ErAsL2TKf8BKb9ojU+VmE8k0NsVev5lTaCWEWnl0s=;
 b=jSx+rdClEKG6vi2m4cq8iV11juumZsjMlgYMVjFfIkVR6ki/F5zcnZUOfBl3hnVkFi
 ZxNzu/21xPxrGQ9hg3/JRRYwkvR9cKBMF8YGtQmWxqOn2mDp3yb6O3sucgO/TbJ+nGxw
 pcC+92eMlxwP11hlRAm/ThGKSLZHPvX0vLMsHsVy/Zg/YrabT8niW++HjmZDCsvu7paP
 KgVOt1BN3CNGGxscQYrgciAZYFeItizUdiHag/8L6y1rFHpfcP2uIPIwniln10imMH+R
 WiBfLXSjMiTWBTtG+oFSkvD2FEHlsCrcTmSwWX4owzWyT6gYja4iBdwYCtQsRo0th2rH
 nO7A==
X-Gm-Message-State: AOAM531RRMJQeAGF0uqFqOAmS9w/0A8SHG4Qicb9axGaKwPZWhnWQMNN
 NRAmwE8U/zd4TNrDNLwUQc3iIQmsdKHfFY0pAx0=
X-Google-Smtp-Source: ABdhPJxyCHZ+rJPusxQxCo4IP2ciqngcpaMD1HI6GBEwchvPkXdJzhq7yr2B72cK84/Qt28HiLeOCNYHd9IYpE+8HyQ=
X-Received: by 2002:a6b:2b45:: with SMTP id r66mr372338ior.159.1601043539039; 
 Fri, 25 Sep 2020 07:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200923113900.72718-1-david@redhat.com>
 <20200923113900.72718-4-david@redhat.com>
In-Reply-To: <20200923113900.72718-4-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Fri, 25 Sep 2020 16:18:48 +0200
Message-ID: <CAM9Jb+i4PWgp7oK6PEse-ja8a51O9L5G7un-FCJ3SfpgB62H6Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] memory-device: Support big alignment requirements
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

> Let's warn instead of bailing out - the worst thing that can happen is
> that we'll fail hot/coldplug later. The user got warned, and this should
> be rare.
>
> This will be necessary for memory devices with rather big (user-defined)
> alignment requirements - say a virtio-mem device with a 2G block size -
> which will become important, for example, when supporting vfio in the
> future.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/memory-device.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 4bc9cf0917..8a736f1a26 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -119,9 +119,10 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
>
>      /* start of address space indicates the maximum alignment we expect */
>      if (!QEMU_IS_ALIGNED(range_lob(&as), align)) {
> -        error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported",
> -                   align);
> -        return 0;
> +        warn_report("the alignment (0x%" PRIx64 ") exceeds the expected"
> +                    " maximum alignment, memory will get fragmented and not"
> +                    " all 'maxmem' might be usable for memory devices.",
> +                    align);
>      }
>
>      memory_device_check_addable(ms, size, &err);
> @@ -151,7 +152,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
>              return 0;
>          }
>      } else {
> -        if (range_init(&new, range_lob(&as), size)) {
> +        if (range_init(&new, QEMU_ALIGN_UP(range_lob(&as), align), size)) {
>              error_setg(errp, "can't add memory device, device too big");
>              return 0;
>          }

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>


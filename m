Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B98CC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D9B20717
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzvvMuln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D9B20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyGAc-0005qG-CS
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 10:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jyG9y-00059O-Vh
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:55:55 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jyG9x-0005Mb-Ao
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:55:54 -0400
Received: by mail-io1-xd42.google.com with SMTP id p205so2837811iod.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T45sfvFI/eWT+YZ3ZpJnJaZ1EqjMcmpotYaXMQooQF8=;
 b=EzvvMulnzDXysLufOBYQ06qxUIR6llZbY90BOMQgcW565HZ0Pme1I0xgC96VGnjURT
 2ZFnR0h3omArzI6BjkQgE6riWwcacJ158Z/Zfk3nl4CrD0fBWCJ5rFOy3eSmVm05fr3A
 kBDilNy+9065sTG20yRCjV9wdk79188cXunlrbLOOZDe51+bZ8UfXz4IAfHsRpJsP96Z
 3JdjtJSqXkkH4Y3Fw1HflI/1aon5q7p2FIbGXPKZsfqvarTyMsfyD+IGCGCq/hCuDoem
 8g0ZaUWqRBj806GzPsEhRLsu81VEkvF0sdS6uw0FhQrv1l1WuxXTbkbqaGnG+TCju18X
 75yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T45sfvFI/eWT+YZ3ZpJnJaZ1EqjMcmpotYaXMQooQF8=;
 b=dq0V5wrN2WDw9Fqpstt6kIrbx7IWA3ocLTpwwohOAYjMza1Jb6rhHnMcNuLJ9WVfUi
 EjOIppvjJe3/5PJyzvK2dhUKZ7AtO81EAuHbokZhLNjEGEQFGmHK0RBJgQmutB378DSU
 2AiU5W3gEOYQYflw04IiePWOV7XNFLb2tWdwtWcDbecB7c7PPCArbIbBYGgk3NUAqkDQ
 c/cOIZD9Z4RP49q+YxCSG/ddYHzLpoc58/eBU5yCk2iYjr0h2jxAB1rfrd+NeNNrk4Dd
 uLoynRIo+P6Ec5LSWAPOK+ePJjTKRjhpVIqXOV7F2DHRzKcjCIPZ7adloR0LX5RV86Vb
 YJFQ==
X-Gm-Message-State: AOAM532cFLH/FQeI8iCLG92HFhe7Q0Sibdlt/WwcqaejDvi7qkgoA+l0
 f4WoiA3ReCqC9ZLfJkqfq9dAtiOTqsrW7e/UCYE=
X-Google-Smtp-Source: ABdhPJxPSvkGfSjVEJe4+6Jycuw3kaL3m8KLaVvkCabm2x+D8VtTq9WVwt1UvTaUg1JhprC2nXekocvfr9+atW10hhs=
X-Received: by 2002:a02:ce9a:: with SMTP id y26mr38811730jaq.121.1595429751582; 
 Wed, 22 Jul 2020 07:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200629080615.26022-1-david@redhat.com>
 <20200722080356-mutt-send-email-mst@kernel.org>
 <d52e7c61-a458-141c-5b7c-515173724fe8@redhat.com>
 <77a59dfa-9560-209b-f85e-4e0b3df51bab@redhat.com>
In-Reply-To: <77a59dfa-9560-209b-f85e-4e0b3df51bab@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Jul 2020 07:55:40 -0700
Message-ID: <CAKgT0UeXgDkyNxrM-7XuJ8KdtY2qT9CpSfcMx9RFUm_wppivbg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-balloon: always indicate S_DONE when migration
 fails
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alexander.duyck@gmail.com; helo=mail-io1-xd42.google.com
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
Cc: virtio-dev@lists.oasis-open.org,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 5:12 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.07.20 14:05, David Hildenbrand wrote:
> > On 22.07.20 14:04, Michael S. Tsirkin wrote:
> >> On Mon, Jun 29, 2020 at 10:06:15AM +0200, David Hildenbrand wrote:
> >>> If something goes wrong during precopy, before stopping the VM, we will
> >>> never send a S_DONE indication to the VM, resulting in the hinted pages
> >>> not getting released to be used by the guest OS (e.g., Linux).
> >>>
> >>> Easy to reproduce:
> >>> 1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
> >>> 2. Cancel migration (e.g., HMP "migrate_cancel")
> >>> 3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
> >>>    no free memory left.
> >>>
> >>> While at it, add similar locking to virtio_balloon_free_page_done() as
> >>> done in virtio_balloon_free_page_stop. Locking is still weird, but that
> >>> has to be sorted out separately.
> >>>
> >>> There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
> >>> comments regarding S_DONE handling.
> >>>
> >>> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> >>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>> Cc: Wei Wang <wei.w.wang@intel.com>
> >>> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>
> >> IIUC this is superceded by Alexander's patches right?
> >
> > Not that I know ... @Alex?
> >
>
> Okay, I'm confused, that patch is already upstream (via your tree)?
>
> dd8eeb9671fc ("virtio-balloon: always indicate S_DONE when migration fails")
>
> Did you stumble over this mail by mistake again?

I agree. David's patches should be upstream, and if they aren't they
should be applied before mine. Mine are meant to be a follow-on as I
end the set with the "report"->"hint" rename for several fields. The
idea is the fixes go first and the rename comes last.

Thanks.

- Alex


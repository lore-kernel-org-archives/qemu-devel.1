Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C440C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A05206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5FfqsaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A05206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJrE-0002uH-A9
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jiJqH-0002Qb-7R
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:37:41 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jiJqF-0002rl-IJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:37:40 -0400
Received: by mail-io1-xd42.google.com with SMTP id k8so6817202iol.13
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l4EsAyStnfwQd97D0FoDk5Cnv2VWe6gNeyj8fzyQn5M=;
 b=q5FfqsaYTWIm1DTWWR2H03ao6G/kR12B2YohxOaYi42GSa/2YsOuAB+DLuNBnXMmQ7
 v0ORl/FcL2bmlPxtG8qo/+KOv3Qhgi0uvw+ODJyP8Umlv4hQ4eNSoUU0zi5CJp7okDQO
 wAIPkLz9fmG52sWzmGgjJzrNiehYo4xj9JMrUvQG+XKltrGzmzDL0lZd/HRKv6OQki+a
 iafAofvxvyHLxolSOn3wrOAOjJcJJycBxoYqGoFMWOeNA4lzwVv2lit5nTyzmp3J7oYc
 IfPIo0t7J55ZFbLfToZUrQwbYoE+jcz/ztCsJJ7HJMA6SbNrFnqitZchaQh4104KFxR9
 IMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l4EsAyStnfwQd97D0FoDk5Cnv2VWe6gNeyj8fzyQn5M=;
 b=JZ5s2Dg0+Db30b7bnu7XK6HFc3wDYnfHlkffWmItS9EQEB3OYU/ZOf4uVITY17WDV5
 fUFvIMexdalhB+6Fhm5XlaBxbgIViCEx3GCEsGw1NNEcHPFKavV5+H9xe+TcTjxFRlkz
 zA1Tpbn98cphIoVaCpKXZrsnegKD14dsVCwJvUlPxH5GRJFY5A+yb/3Ru5I+mMg1ddDI
 w8/MCns3ochYAqZRThSk4EYFGZikzw4XQI8NWvNfMwywEGRWyDGLEWzjuT+7FVEwlktA
 H/mCNdSdk+/tM1MG2xSyX7CkZkN0fZjFjRZcYZBlni+/V2V50wzwQxRt/Hc7FUa+BsdG
 VMAw==
X-Gm-Message-State: AOAM531VDcJ32dS5SGlkOX2OwWd6k7HCbYppYQUZ/foRwl2Swv8c8KUF
 7is7AYoBsVoEorh7gsvNVR7m96mzxYRY2moO+24=
X-Google-Smtp-Source: ABdhPJwjpcfnuhv3ck9sFKNhcCcaRiXjJI2GUt6xwI3w4VWKXEhi+WIuqLT6EA6BF4Ngn5jXIwurXtx0jJ6sDQLqQi8=
X-Received: by 2002:a02:7127:: with SMTP id n39mr22345192jac.96.1591630657495; 
 Mon, 08 Jun 2020 08:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
In-Reply-To: <20200527041212.12700.60627.stgit@localhost.localdomain>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Jun 2020 08:37:26 -0700
Message-ID: <CAKgT0Ue4DU9cP7BLCBHEU+kLzZjyZTFj-MqMDranezZVZ0W4pg@mail.gmail.com>
Subject: Re: [PATCH v25 QEMU 0/3] virtio-balloon: add support for page poison
 and free page reporting
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's been almost 2 weeks since I submitted this. Just thought I would
follow up and see if there is any ETA on when this might be applied,
or if I missed the need to fix something and resubmit.

Thanks.

- Alex


On Tue, May 26, 2020 at 9:13 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> This series provides an asynchronous means of reporting free guest pages
> to QEMU through virtio-balloon so that the memory associated with those
> pages can be dropped and reused by other processes and/or guests on the
> host. Using this it is possible to avoid unnecessary I/O to disk and
> greatly improve performance in the case of memory overcommit on the host.
>
> I originally submitted this patch series back on February 11th 2020[1],
> but at that time I was focused primarily on the kernel portion of this
> patch set. However as of April 7th those patches are now included in
> Linus's kernel tree[2] and so I am submitting the QEMU pieces for
> inclusion.
>
> [1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc
>
> Changes from v17:
> Fixed typo in patch 1 title
> Addressed white-space issues reported via checkpatch
> Added braces {} for two if statements to match expected coding style
>
> Changes from v18:
> Updated patches 2 and 3 based on input from dhildenb
> Added comment to patch 2 describing what keeps us from reporting a bad page
> Added patch to address issue with ROM devices being directly writable
>
> Changes from v19:
> Added std-headers change to match changes pushed for linux kernel headers
> Added patch to remove "report" from page hinting code paths
> Updated comment to better explain why we disable hints w/ page poisoning
> Removed code that was modifying config size for poison vs hinting
> Dropped x-page-poison property
> Added code to bounds check the reported region vs the RAM block
> Dropped patch for ROM devices as that was already pulled in by Paolo
>
> Changes from v20:
> Rearranged patches to push Linux header sync patches to front
> Removed association between free page hinting and VIRTIO_BALLOON_F_PAGE_POISON
> Added code to enable VIRTIO_BALLOON_F_PAGE_POISON if page reporting is enabled
> Fixed possible resource leak if poison or qemu_balloon_is_inhibited return true
>
> Changes from v21:
> Added ack for patch 3
> Rewrote patch description for page poison reporting feature
> Made page-poison independent property and set to enabled by default
> Added logic to migrate poison_val
> Added several comments in code to better explain features
> Switched free-page-reporting property to disabled by default
>
> Changes from v22:
> Added ack for patches 4 & 5
> Added additional comment fixes in patch 3 to remove "reporting" reference
> Renamed rvq in patch 5 to reporting_vq to better match linux kernel
> Moved call adding reporting_vq to after free_page_vq
>
> Changes from v23:
> Rebased on latest QEMU
> Dropped patches 1 & 2 as Linux kernel headers were synced
> Added compat machine code for page-poison feature
>
> Changes from v24:
> Moved free page hinting rename to end of set as feature may be removed entirely
> Added code to cleanup reporting_vq
>
> ---
>
> Alexander Duyck (3):
>       virtio-balloon: Implement support for page poison reporting feature
>       virtio-balloon: Provide an interface for free page reporting
>       virtio-balloon: Replace free page hinting references to 'report' with 'hint'
>
>
>  hw/core/machine.c                  |    4 +
>  hw/virtio/virtio-balloon.c         |  179 ++++++++++++++++++++++++++++--------
>  include/hw/virtio/virtio-balloon.h |   23 ++---
>  3 files changed, 155 insertions(+), 51 deletions(-)
>
> --


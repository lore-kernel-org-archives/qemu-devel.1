Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E79C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 17:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5F32184D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 17:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDu7Q0r6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5F32184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX6r6-00008F-DH
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 13:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jX6q4-0007kU-II
 for qemu-devel@nongnu.org; Fri, 08 May 2020 13:31:08 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jX6q3-0006Ft-JK
 for qemu-devel@nongnu.org; Fri, 08 May 2020 13:31:08 -0400
Received: by mail-io1-xd42.google.com with SMTP id u11so2591920iow.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kdk0kUyMhofrKL8cT/0ym4KC3p3RaAaMrBjo/oA0SvU=;
 b=RDu7Q0r6qt0jccGwYFbjiMXZM16ugIgBkM631HVnTXf56yntVd5qqZMJnqSHLjinDw
 mwUGuIbMWRjhgcON8kaf+EDWIaC+P2ZePWEOFlWtIw9JuIXkQ6ERArH5qri4An4/pJXk
 CkoQFMJx0jAFOH7x6blmgbUD5lM4a9N2lRTi12cGeB6fMEsZDEgI+VaVxlyVFTZ6ZFfw
 eCgegTpnGwdMNqtXzlxdm+eJDiUqRzu/jlrUr0m6H9plXL30OXFkAThfnH9OO2MFE6Aq
 nJpCn4Ps9Xr+FOJXWKMgsqZHoMfOCyyEGbXbMcHp0dqFqX1EVZdwpkZKtl5QIXFx+SEE
 Garw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kdk0kUyMhofrKL8cT/0ym4KC3p3RaAaMrBjo/oA0SvU=;
 b=QD088X3kYd9KN4YcNOgXdZfpPfY1cZE9FqyVrSQ4/Y8MBVgxfPQF7Wn1SxiGu3hbD5
 At5xaZ2Tt9wRc7+IRjeJzv0Ipcb/wOQv6xgTmys3BY6Iex/jPWcDSXycGO2lSBHWG+y4
 ai3+6+jqQYCQ7BMkHbZd6414p2hK9fXm4lEdUV7dtOYF/RRbrl+f/TjR3VpH9ufsggEG
 FgI08izVzmfM59LOlOvpGZszuRb71xTpEL7SXvXtqZKpb4a2DbZ2LxjEgcAKKeZPsbAj
 he0QvSSnY9OuurJJ3UM/2lvW/GiqPBQ7HLYbHltEBULzDhyrOzWQnUQmmjl3YDIc79/a
 8R3A==
X-Gm-Message-State: AGi0PuYSCoUPGKIXC/SG9PM5psyTQTYjYom/A81oa4IhBRg1J/5jvZ5X
 1Jklks+pX+XZdhoPYIBvhreyDFT7ZfziAhQKxBk=
X-Google-Smtp-Source: APiQypKIWh1mwJjO4DyFfe4PobimhzMBcWNw18a6QrZWEK23lYvaqiX310FuZE2mj34AsTS0xWFQU7xUlpnRzNLCZ5U=
X-Received: by 2002:a6b:d90f:: with SMTP id r15mr3689145ioc.5.1588959065176;
 Fri, 08 May 2020 10:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200428005134.6158.88521.stgit@localhost.localdomain>
In-Reply-To: <20200428005134.6158.88521.stgit@localhost.localdomain>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 8 May 2020 10:30:54 -0700
Message-ID: <CAKgT0UcygsdURGivgTb08i2Ot0TQAzahLKhkkzXvhsoEU-7p3Q@mail.gmail.com>
Subject: Re: [PATCH v23 QEMU 0/5] virtio-balloon: add support for page poison
 reporting and free page reporting
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

I just wanted to follow up since it has been a little over a week
since I submitted this and I haven't heard anything back. It looks
like the linux-headers patches can be dropped since the headers appear
to have been synced. I was wondering if I should resubmit with just
the 3 patches that are adding the functionality, or if this patch-set
is good as-is?

Thanks.

- Alex

On Mon, Apr 27, 2020 at 5:53 PM Alexander Duyck
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
> Renamed rvq in patch 5 to reporting_vq to improve readability
> Moved call adding reporting_vq to after free_page_vq to fix VQ ordering
>
> ---
>
> Alexander Duyck (5):
>       linux-headers: Update to allow renaming of free_page_report_cmd_id
>       linux-headers: update to contain virito-balloon free page reporting
>       virtio-balloon: Replace free page hinting references to 'report' with 'hint'
>       virtio-balloon: Implement support for page poison reporting feature
>       virtio-balloon: Provide an interface for free page reporting
>
>
>  hw/virtio/virtio-balloon.c                      |  176 ++++++++++++++++++-----
>  include/hw/virtio/virtio-balloon.h              |   23 ++-
>  include/standard-headers/linux/virtio_balloon.h |   12 +-
>  3 files changed, 159 insertions(+), 52 deletions(-)
>
> --


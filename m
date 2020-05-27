Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38174C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0074E2078C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqAY+Dwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0074E2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdnSe-0000eN-2R
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 00:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jdnS1-0008RB-S2
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:13:57 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jdnS0-00058Y-Rx
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:13:57 -0400
Received: by mail-qk1-x743.google.com with SMTP id v79so13099699qkb.10
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 21:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:user-agent:mime-version
 :content-transfer-encoding;
 bh=k1sBlWU96wZFac1PTd0z/8CMJSoS7d6e0GdXSOB9crU=;
 b=gqAY+Dwp5X/ARwk5vewKYLlNcHvPUNkF7Z+4YSO206hUGQeU5RdrO8sZT8+xmzRUuQ
 RaIp9BmeiZiXw/4LIM2AhLGA21heQgm/GEFT/DaacJvvdilmEmhGQ8hT8BkzydxiO1Xw
 YS9hacJc6Sl+U+OxAElNIR0ynYwe9Ay0cg2KFcsSsyDD3xqe+mZ0Oz9PhHEg7hsCmPpC
 A405JTXjLjLTbKFBADTC8PIdfVZ1gjTddnaOFR2rG8fYaVBDyLXA/Gs6Fc72u5MoYhJO
 wJItElkzb0+fJuxed1lRO4aoXGC4Xc1a+9S99kqgwHpHhA6nw8om0s8irnzRIc87OoiY
 3LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
 :mime-version:content-transfer-encoding;
 bh=k1sBlWU96wZFac1PTd0z/8CMJSoS7d6e0GdXSOB9crU=;
 b=aSarRd8I5HAZnwhmAktm7d69BCelG1S+iMOs3WjoteU5ahIEQsoYuZ5jmTKhNTzNdu
 w9i3G4tVPTRMzHoyLXZcsIOZnS80TdUxV+jCWQEoY4A318O9N0MnTmHNVeDYzsB0TEB3
 XGp7f3jtDZuXebX54U3hUP/KKGIPCzp7vlV5d56/dpTU6kNh25oTYnKNh4fU0p8maVAh
 XZ/SgDDKioFQULjR7xP9uiq8uhe2LvJE8A8rWTPAo+xj+4pGYczyBQOccahirWzFsmPm
 TZ6aeB8CvQ4W9g+WN2GmP7UnahpLqcZ7WvQqmNkeUKM9oYVAgyJ4bGmtr7XS99bNYYT3
 3+Gg==
X-Gm-Message-State: AOAM530BcUlkvpdQdbhMbpJ027EX41EeHg5TNh84E5+12DUpe3DeSTjz
 a9u4AmiNoU+ZhK0vmqqL0t8=
X-Google-Smtp-Source: ABdhPJwCizjm7/VmHvQzbSjtbmoSEOMFabQ58WmIUwiqdqTfsdDxT3UFCTzY3Vd7BGnoGtZEqULhNg==
X-Received: by 2002:a05:620a:54b:: with SMTP id
 o11mr2376279qko.222.1590552835536; 
 Tue, 26 May 2020 21:13:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id m21sm1294082qkh.50.2020.05.26.21.13.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 May 2020 21:13:55 -0700 (PDT)
Subject: [PATCH v25 QEMU 0/3] virtio-balloon: add support for page poison
 and free page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Tue, 26 May 2020 21:13:53 -0700
Message-ID: <20200527041212.12700.60627.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=alexander.duyck@gmail.com; helo=mail-qk1-x743.google.com
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

This series provides an asynchronous means of reporting free guest pages
to QEMU through virtio-balloon so that the memory associated with those
pages can be dropped and reused by other processes and/or guests on the
host. Using this it is possible to avoid unnecessary I/O to disk and
greatly improve performance in the case of memory overcommit on the host.

I originally submitted this patch series back on February 11th 2020[1],
but at that time I was focused primarily on the kernel portion of this
patch set. However as of April 7th those patches are now included in
Linus's kernel tree[2] and so I am submitting the QEMU pieces for
inclusion.

[1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc

Changes from v17:
Fixed typo in patch 1 title
Addressed white-space issues reported via checkpatch
Added braces {} for two if statements to match expected coding style

Changes from v18:
Updated patches 2 and 3 based on input from dhildenb
Added comment to patch 2 describing what keeps us from reporting a bad page
Added patch to address issue with ROM devices being directly writable

Changes from v19:
Added std-headers change to match changes pushed for linux kernel headers
Added patch to remove "report" from page hinting code paths
Updated comment to better explain why we disable hints w/ page poisoning
Removed code that was modifying config size for poison vs hinting
Dropped x-page-poison property
Added code to bounds check the reported region vs the RAM block
Dropped patch for ROM devices as that was already pulled in by Paolo

Changes from v20:
Rearranged patches to push Linux header sync patches to front
Removed association between free page hinting and VIRTIO_BALLOON_F_PAGE_POISON
Added code to enable VIRTIO_BALLOON_F_PAGE_POISON if page reporting is enabled
Fixed possible resource leak if poison or qemu_balloon_is_inhibited return true

Changes from v21:
Added ack for patch 3
Rewrote patch description for page poison reporting feature
Made page-poison independent property and set to enabled by default
Added logic to migrate poison_val
Added several comments in code to better explain features
Switched free-page-reporting property to disabled by default

Changes from v22:
Added ack for patches 4 & 5
Added additional comment fixes in patch 3 to remove "reporting" reference
Renamed rvq in patch 5 to reporting_vq to better match linux kernel
Moved call adding reporting_vq to after free_page_vq

Changes from v23:
Rebased on latest QEMU
Dropped patches 1 & 2 as Linux kernel headers were synced
Added compat machine code for page-poison feature

Changes from v24:
Moved free page hinting rename to end of set as feature may be removed entirely
Added code to cleanup reporting_vq

---

Alexander Duyck (3):
      virtio-balloon: Implement support for page poison reporting feature
      virtio-balloon: Provide an interface for free page reporting
      virtio-balloon: Replace free page hinting references to 'report' with 'hint'


 hw/core/machine.c                  |    4 +
 hw/virtio/virtio-balloon.c         |  179 ++++++++++++++++++++++++++++--------
 include/hw/virtio/virtio-balloon.h |   23 ++---
 3 files changed, 155 insertions(+), 51 deletions(-)

--


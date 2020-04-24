Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1409C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B687C20774
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWYGDliP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B687C20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS1Xo-0000il-O2
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 12:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS1Wh-0007zz-4j
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS1Wg-0000XF-By
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:50:06 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jS1Wf-0000UU-T9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:50:06 -0400
Received: by mail-pf1-x441.google.com with SMTP id w65so5038059pfc.12
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:user-agent:mime-version
 :content-transfer-encoding;
 bh=VUeft5IQYRxFqptZ+xVlTPfBFnWafBYgrDZIQN6clNg=;
 b=QWYGDliPhabCeVk39D87ZlSaX0H8h3c7ij1C5Rg0Y/DOFVRhxhYHDuuj9vTlE1IHI/
 tfT4gMRm0fctrVMqhbjff10uyIfrOsa61zujG7Q6CBjZXp7A+XmoOa4r5EKyfdLlTFbq
 OYm9+IbWPP1DDlqN/i3TAZ1rOegbo6j6ggVn8GNsGpk5HB7jqed7OYF5QzVHlLu0jIVZ
 /iitRlUgfMK32au59+BrW99iMnafLGEoonvVFiNAjnEPbc7efCz/baCG6m3FEFAciMC5
 RsDWadAqzAxlr3lteBHuGno6Uu8CfEq1eY1jh/jVriRGkh1fDS9nSykTX2ANwaT8Hoah
 8LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
 :mime-version:content-transfer-encoding;
 bh=VUeft5IQYRxFqptZ+xVlTPfBFnWafBYgrDZIQN6clNg=;
 b=OxXl1yHtwDyN4DAEMoV1sBivV6/5bM+Fc5LTbay9IDwPBxae56s/4yuQpGS96bOtnT
 0DxgCInHqCof+wpWPj2FpUXlOI76qdP6cDUcfZuoBA7jfofjmBqXui076wvli9q3g70l
 u3QXIANGN/NrFxvykEgXOmiUEjtdGPFOad0n3zmxLhkF5uQILdDfLW7zB+AvZ/kjVv2P
 kF3FGbBO7gAwvLn0hrtaz26Z5J1HodBYk9zo9vUVMaF6pFJPPx6S18ZjUEw3GuPc2nGB
 1yYFOAsk79T6N9u1b7Q8wZFv+yHisncs64KQsQLncutdjAlwy2QuVs2O5SDo+Vswat83
 KpnQ==
X-Gm-Message-State: AGi0PubInXkTTnutZ5HAboTAYGf1rvbo/FJaToDrSp/tL+tOeuwYM+7U
 ASbfbU8KZ/g4w13ah3vvnlw=
X-Google-Smtp-Source: APiQypKKkkulPs6Fc4xBUMRy+72jNevaLK/OK/bi+JIzg5m//C1Nt9yt8uvFqFUi0nMGXa2U175XcA==
X-Received: by 2002:a63:5a12:: with SMTP id o18mr2804701pgb.204.1587747004206; 
 Fri, 24 Apr 2020 09:50:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id d36sm5268948pgb.93.2020.04.24.09.50.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2020 09:50:03 -0700 (PDT)
Subject: [PATCH v22 QEMU 0/5] virtio-balloon: add support for page poison
 reporting and free page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Fri, 24 Apr 2020 09:50:03 -0700
Message-ID: <20200424164239.10723.58352.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::441
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
pages can be discarded and reused by other processes and/or guests on the
host. Using this it is possible to avoid unnecessary I/O to disk and
greatly improve performance in the case of memory overcommit on the host.

As a part of enabling this feature it was necessary to implement the page
poison reporting feature which had been added to the kernel, but was not
available in QEMU. This patch set adds it as a new device property
"page-poison" which is enabled by default, and adds support for migrating
the reported value.

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

---

Alexander Duyck (5):
      linux-headers: Update to allow renaming of free_page_report_cmd_id
      linux-headers: update to contain virito-balloon free page reporting
      virtio-balloon: Replace free page hinting references to 'report' with 'hint'
      virtio-balloon: Implement support for page poison reporting feature
      virtio-balloon: Provide an interface for free page reporting


 hw/virtio/virtio-balloon.c                      |  170 ++++++++++++++++++-----
 include/hw/virtio/virtio-balloon.h              |   23 ++-
 include/standard-headers/linux/virtio_balloon.h |   12 +-
 3 files changed, 155 insertions(+), 50 deletions(-)

--


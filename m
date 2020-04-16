Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94872C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEC521744
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+o2CtzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEC521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPAhX-0005b5-8P
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAgU-0004Yp-N9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAgT-0000Ja-Hq
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jPAgT-0000J7-BA
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:25 -0400
Received: by mail-pf1-x444.google.com with SMTP id r20so2147749pfh.9
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 13:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:user-agent:mime-version
 :content-transfer-encoding;
 bh=0QoMSSkoO1WtiMmWyqMxCuih2EheX/gZF6FbL8pMGKQ=;
 b=s+o2CtzGme5TyZlLDsHTGJBBWcmOHvuOBsnb8ois9dU81FrnsB4Uxnav9f42O+KuBw
 cpv/K1Iyb5aDiDw1dXc8VckQnQ5mHkKP/RjSiloDhBsuCJWmfK81V/d+SmmPL8KeorEh
 3FoOe7FdWh20s1p+OcpEUNsG53eJTwcU0mB/Hj3hUdoiEqreh+PdKsg1rr/8M3oUxIrG
 TLn2Po6Fgkl3zJziG6Zr/VepusjsROUhoaquLqlOvF5ybpXGB1AN02cB1m1gMbuqV9sb
 +l5nRClZMCH7uu+AYLzU87kZwKB4Ss4KZSY3e0W41Nd31/qEAuWsk59rw/tgPNr/dULX
 HZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
 :mime-version:content-transfer-encoding;
 bh=0QoMSSkoO1WtiMmWyqMxCuih2EheX/gZF6FbL8pMGKQ=;
 b=hx4t102T3sGenVkgjXq0E8jH5ZglZnwglfNryIFLfMQO6Iy5Vd288goSpzdqQp72NY
 UOOoPkqEIQBq4xJw8pFLRce5rDoyRBVqIJAWGXOaQVxvLXAQXODDZbgLRZwbYtVLzOIU
 zmkbX13qUkfrVWKhbybqEEW9228FpPLR8LFBBHeksgSuvjSkKn0yppm1L+sStX9AbHvC
 BL52Z9pmkD6MEg+P4K0JYXWhx0Wd+EkpimwfD7a63OJY9BQrltZZHFEko6KMODBZkQdI
 MZlOnKiJBLJwcnvNPI5Z2cEiPPT1zP11M3rdiNMCNa5uVMIDxnUMnts621PLDOlXS7/7
 92ow==
X-Gm-Message-State: AGi0Pua2Wqi6maJaBNxcMRt0BdnmqdwA77kbVdgVEZP9ljEaJicF68S0
 tZ6QDBsIqqEla7iqhpPaokM=
X-Google-Smtp-Source: APiQypIGM8nWqVcYlJI2KzmAaKJHJEwlHW2GgCuvd/+KCSSV0Cd9Lvafs1hilOM7efP3pHYjOTpRKQ==
X-Received: by 2002:aa7:9502:: with SMTP id b2mr5585181pfp.277.1587067223959; 
 Thu, 16 Apr 2020 13:00:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id z7sm12708203pfz.216.2020.04.16.13.00.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 13:00:22 -0700 (PDT)
Subject: [PATCH v20 QEMU 0/5] virtio-balloon: add support for free page
 reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Thu, 16 Apr 2020 13:00:21 -0700
Message-ID: <20200416195641.13144.16955.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

---

Alexander Duyck (5):
      linux-headers: Update to allow renaming of free_page_report_cmd_id
      virtio-balloon: Replace free page hinting references to 'report' with 'hint'
      virtio-balloon: Implement support for page poison tracking feature
      linux-headers: update to contain virito-balloon free page reporting
      virtio-balloon: Provide an interface for free page reporting


 hw/virtio/virtio-balloon.c                      |  161 ++++++++++++++++++-----
 include/hw/virtio/virtio-balloon.h              |   23 ++-
 include/standard-headers/linux/virtio_balloon.h |   12 +-
 3 files changed, 146 insertions(+), 50 deletions(-)

--


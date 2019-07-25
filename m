Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87BCC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B126D21951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B126D21951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfib-0002nB-CY
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48928)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfiM-0002D2-4L
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfiL-0001nU-3V
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfiL-0001nE-0J
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so36707276qkl.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=6upyMRWCI0QzgYSVTMkWu1ozaMI3bNy8E6N0+tk0Nsk=;
 b=MmYqCa+MBiqceuUsxLPHv9vZWJdEpXQh/TerEPZOIgTetCKaCAnbZy78Rs82z2krH0
 MraXl/OoZZptuwfceUnFkImBrvP20PUDVuOMV6PsA5BfQFY/lAvAVFLh5fGqiYocHwrX
 BYo+AUXxkOaAsWg4r+nhD00FIpo15R0rKe5XdZiR0FqZUQ4v9r5/i9nRTjTqbJSlGM+c
 6VdpIvL5WI0YzQpijDF+o5ojYpMsD68QtmDupC+iJ5w8PxPobjDLmZrIEOawcoCztIWo
 R/sYesqoRIc2zZTB8RysOEhDXocPeFsQU+y8eKKqHQbMBHqxMvRnENVibul0RV/XK7Qi
 Sr4Q==
X-Gm-Message-State: APjAAAX7jQXYXcSbeJCVt8+XGGDPR/8ttxZk7Il6fWbVb7DqTD55LHxQ
 8z68+0EP6lCivQR374rumNtxg6LtqWG5LQ==
X-Google-Smtp-Source: APXvYqzVEQI6485Md32bBBZyKcIhXj2Nx6woPtpoGh4dDn625+WkBhQSSXZjAHnnUmyhWQTUpXMGqQ==
X-Received: by 2002:a37:a603:: with SMTP id p3mr60883811qke.297.1564068688002; 
 Thu, 25 Jul 2019 08:31:28 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 b202sm22413250qkg.83.2019.07.25.08.31.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:31:27 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:31:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.193
Subject: [Qemu-devel] [PULL 00/12] virtio, pc: fixes, cleanups
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit bf8b024372bf8abf5a9f40bfa65eeefad23ff988:

  Update version for v4.1.0-rc2 release (2019-07-23 18:28:08 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 1b47b37c33ec01ae1efc527f4c97f97f93723bc4:

  virtio-balloon: free pbp more aggressively (2019-07-25 11:19:25 -0400)

----------------------------------------------------------------
virtio, pc: fixes, cleanups

A bunch of fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (7):
      virtio-balloon: Fix wrong sign extension of PFNs
      virtio-balloon: Fix QEMU crashes on pagesize > BALLOON_PAGE_SIZE
      virtio-balloon: Simplify deflate with pbp
      virtio-balloon: Better names for offset variables in inflate/deflate code
      virtio-balloon: Rework pbp tracking data
      virtio-balloon: Use temporary PBP only
      virtio-balloon: don't track subpages for the PBP

Evgeny Yakovlev (2):
      i386/acpi: fix gint overflow in crs_range_compare
      i386/acpi: show PCI Express bus on pxb-pcie expanders

Jan Kiszka (1):
      ioapic: kvm: Skip route updates for masked pins

Michael S. Tsirkin (1):
      virtio-balloon: free pbp more aggressively

Stefan Hajnoczi (1):
      docs: clarify multiqueue vs multiple virtqueues

 include/hw/virtio/virtio-balloon.h |   3 -
 hw/i386/acpi-build.c               |  17 ++++--
 hw/intc/ioapic.c                   |   8 ++-
 hw/virtio/virtio-balloon.c         | 115 ++++++++++++++++++-------------------
 docs/interop/vhost-user.rst        |  17 ++++++
 5 files changed, 90 insertions(+), 70 deletions(-)



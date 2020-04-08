Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC81C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 22:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F411320730
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 22:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0J+Kfqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F411320730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMJcG-0001Yy-2u
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 18:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMJbG-0000ON-Ti
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 18:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMJbF-0001Dl-Or
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 18:55:14 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jMJbF-0001DQ-Ip
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 18:55:13 -0400
Received: by mail-pl1-x643.google.com with SMTP id c12so3102200plz.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 15:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:user-agent:mime-version
 :content-transfer-encoding;
 bh=p/2SdRygVSQ/9ezRp65t6CYbS0JxaUYrxPx+xlaGG+0=;
 b=t0J+Kfqkr9kuTUEKX8QgdtKLzYJWQLi38f4OQ8plMt+QD1nwMvfPC0lDaORjPKr7B7
 dhAQMLKAVXnba8XGHeb+648S5sGbBUFZH4yg3uuendHvGOemRLq8aUYw39NwJZvl2IRO
 4uGc+HaqGcpxYK43yAna6cbJCvC1PPX9QxAm7DMDTYprFz5mul5tOw9tNuTmChdAwITu
 BM7V0i7NwNH0bDH1woAQnvPtR7Nl9WSEM1Wl5f0nEz7AUGaAjX7KL0F05I8HGt6FgXDB
 Z5AkkFhVGowFL7xzMQOm1l3hgFQ1Z8358sd0NN5Ruz3uUSi9e6/5mSehKqDSJr6BMXHZ
 qmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
 :mime-version:content-transfer-encoding;
 bh=p/2SdRygVSQ/9ezRp65t6CYbS0JxaUYrxPx+xlaGG+0=;
 b=lQPfDjw/fVTp975RBFZFqTLRzj+8KcT5aUcma0SNAHHAR3iRFPKdQW4A8xji8QtyBU
 WvWsLWhDID4li22y0DpK41emsgu+3d5ev1XuGiGAQK4vdXMwe7nvhh8tnhHhBjXFQn3j
 OucK0jDGmZFE+3+2vrp4Z09I9h5fBOJGxpRv3f3psIliVG7xELBPYOg9wY/rj0LrlPpi
 HCGtV2ITJvJiWh+rhsDucz/m10uYIHIUiMgsXRhjQCkXV6IMBxKcyc01QtwkZlC8r5Zm
 sXOnPji3VkDtdZykQ1FQExcjYLIQOrNpu5JE/0Sz543DDoSo3OGE0j+6RPZPjb8NmW8V
 YFfA==
X-Gm-Message-State: AGi0PuZF90XM3qmhFUtO1xG/SjjtuhKrCX6Mu43nrp3VPsP4v3L67bM+
 EiydSMXAkD2rdTyrjthl1OA=
X-Google-Smtp-Source: APiQypLcfuzfwhjU+TTwIQz3+dWfdko/EUQMY8QUzOVjVA3mW236RYx15gT51jLPZVMTdi1dqeBDiA==
X-Received: by 2002:a17:902:8641:: with SMTP id
 y1mr9710654plt.14.1586386512203; 
 Wed, 08 Apr 2020 15:55:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id h13sm3955373pfr.1.2020.04.08.15.55.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Apr 2020 15:55:11 -0700 (PDT)
Subject: [PATCH v18 QEMU 0/3] virtio-balloon: add support for providing free
 page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Wed, 08 Apr 2020 15:55:10 -0700
Message-ID: <20200408225302.18764.209.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

I originally submitted this patch series[1] back on February 11th 2020,
but at that time I was focused primarily on the kernel portion of this
patch set. However as of April 7th those patches are now included in
Linus's kernel tree[2] and so I thought I should resubmit the QEMU side of
this for inclusion so that the feature will be available in QEMU hopefully
by the time the 5.7 kernel tree is released.

[1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc

Changes from v17:
Fixed typo in patch 1 title
Addressed white-space issues reported via checkpatch
Added braces {} for two if statements to match expected coding style

---

Alexander Duyck (3):
      virtio-balloon: Implement support for page poison tracking feature
      virtio-balloon: Add support for providing free page reports to host
      virtio-balloon: Provide a interface for free page reporting


 hw/virtio/virtio-balloon.c                      |   70 ++++++++++++++++++++++-
 include/hw/virtio/virtio-balloon.h              |    3 +
 include/standard-headers/linux/virtio_balloon.h |    1 
 3 files changed, 69 insertions(+), 5 deletions(-)

--


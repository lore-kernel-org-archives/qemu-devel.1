Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C139C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA28206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA28206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEB3O-0007NT-O0
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEB2B-00066U-Qk
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:41:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEB28-0006X6-LF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:41:39 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-SBJRj_K6PCKn7WTeC8eMJA-1; Fri, 04 Sep 2020 08:41:34 -0400
X-MC-Unique: SBJRj_K6PCKn7WTeC8eMJA-1
Received: by mail-wm1-f69.google.com with SMTP id w3so2164287wmg.4
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 05:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q7Ub8cUrsMo9vrkyfM6hqS+Uvb9OzT09v79uzbAF8ig=;
 b=Xa2WwM6aqnYRLKSu2g/G9nWzV1BX21Cu6jkpr8Jw3iS0bv6o2+e8GMjhNSfU3BMolJ
 pCo3c0x9rfJfvrIiCpr6aIpr8YYySgyeV+XaPmGIM+0T6nfxXI5SZfZojNh5pxVc+yfq
 +DQB+R4KIMMxoe9M0lyeM6mXg+wYOMPSF8LmRUdtw23w5On4Zm9m4sBNZA8/LR/mC0UY
 BfB6XFGfcUqK8X6lzeAltYR4M+0toW1aYMh/ZzQgaENk9e/OsE8Ivb2jAtAYSlnESA7G
 FVHxYbnzTn92OHSlnZgWJQUdUXlxeaUZhqdpYa4GkABO1b9SXlAu6EQ5HTdNTy2lGNIi
 iXZA==
X-Gm-Message-State: AOAM533FQ/ZZXWtqJIDsek5Ms7nVY6gj684ZYqm7+QEp/aq66ZflA3nu
 KWVT5yHFjbY3a3yeOuOA9PzbViqjgq8eeHgpbBe3ObEh6YTzpDjkDFezVHv2Q3ClVbZjHIGZAOG
 X76xKzkvcHpIlC1I=
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr7310751wrt.267.1599223293058; 
 Fri, 04 Sep 2020 05:41:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE1JxMCvZpNDh/5MDkf2YH0VrXEM2fWkrgnspnM7j1NoU54kEDo0RnGD0r/Fzh99JP5MPyUw==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr7310735wrt.267.1599223292874; 
 Fri, 04 Sep 2020 05:41:32 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o4sm10901731wrv.86.2020.09.04.05.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 05:41:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] block/nvme: Use NvmeBar structure from "block/nvme.h"
Date: Fri,  4 Sep 2020 14:41:27 +0200
Message-Id: <20200904124130.583838-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanups in the NVMeRegs structure:
- Use the already existing NvmeBar structure from "block/nvme.h"
- Pair doorbell registers

Based-on: <20200903122803.405265-1-philmd@redhat.com>

Philippe Mathieu-Daudé (3):
  block/nvme: Group controller registers in NVMeRegs structure
  block/nvme: Use generic NvmeBar structure
  block/nvme: Pair doorbell registers

 block/nvme.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

-- 
2.26.2



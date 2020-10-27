Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0191C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8DD218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeUUxsm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8DD218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPVj-0005cm-C5
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPS7-0002Y7-NA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPS5-00047f-RI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qUP/FH3AYfwBu2eZdS5d24y5xEAu4cbHD+ei+bCLpTk=;
 b=SeUUxsm0p0DiJb1cpPqOcgLngAEA07xN/C0EA2qefg2fY5ALlM67EoFXaY3e/eJ82w/Exa
 1AgDaP026+gU8+B+JyFye8jFCdZYDdLdnJmzq4Uf/iizdnNCMk+q5GEBwsMP5dkd1WU67f
 VMU2zb8ViqrbmRoVYN2fAhtD6O0cRVU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-LJIIHBJYNmuRmCrdMY_gFQ-1; Tue, 27 Oct 2020 09:55:51 -0400
X-MC-Unique: LJIIHBJYNmuRmCrdMY_gFQ-1
Received: by mail-ed1-f71.google.com with SMTP id y8so729648edj.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z6fA7K31DYXhm9iAdSijMcXKOeSGEDkOUxF90mLy2q8=;
 b=CLmz9RSjla8VWKzfHmvzjN2foLO674QEperBlOu8/HHdUjV2fVmQpto/6voNS3Ragp
 kJyiXCkaRXJwM8dUXo6FVfKGdDneDpB0ElUQ/C2jiT75MsbPTIHGsOYxz9gqKVPkf0ba
 N3EmYpLZVbAddBetzre11T9cbJNGVo+RRThd0ldNJCbS7ZnxZLbR18fpMuVScQCMBnXq
 ejwtkeYzUhb+KwoZturDqSzY4jWBoe+CdjjZZ75KvpYxlKw525O6FZXRGVHyrbC/43sb
 tnCqRCaVgvG8nUJKdQQQ3CB5o07aqqrI5WnTHFCAZw1n8pvCPCA5AaR0RyPZi6aXiej/
 F8Qw==
X-Gm-Message-State: AOAM530r5Rv7q8ND/vq6t+p3bE9QYX/kWnHs/X03sqFCHprostMw+7I0
 KLLWMrvUFLOLQCgPdq5ZokDjf6NU6g2ZnUXZnEXY379Aa8DcUKTgoIGr7ntzmWr9Bm+/VXYk5E8
 cPZq9TcrDJ5NSkUA=
X-Received: by 2002:a50:8c24:: with SMTP id p33mr2378930edp.330.1603806949734; 
 Tue, 27 Oct 2020 06:55:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2Uy7YdbeaVDbmkubSreyccH6j6Fb7Jij9DP38BSY6VET0xtZaw3jJUlTqBk9algRXW9fX7Q==
X-Received: by 2002:a50:8c24:: with SMTP id p33mr2378899edp.330.1603806949384; 
 Tue, 27 Oct 2020 06:55:49 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id nu20sm1108370ejb.109.2020.10.27.06.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:55:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/25] block/nvme: Fix Aarch64 host
Date: Tue, 27 Oct 2020 14:55:22 +0100
Message-Id: <20201027135547.374946-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a bit of tracing, clean around to finally fix few bugs.=0D
In particular, restore NVMe on Aarch64 host.=0D
=0D
Eric Auger (4):=0D
  block/nvme: Change size and alignment of IDENTIFY response buffer=0D
  block/nvme: Change size and alignment of queue=0D
  block/nvme: Change size and alignment of prp_list_pages=0D
  block/nvme: Align iov's va and size on host page size=0D
=0D
Philippe Mathieu-Daud=C3=A9 (21):=0D
  MAINTAINERS: Cover 'block/nvme.h' file=0D
  block/nvme: Use hex format to display offset in trace events=0D
  block/nvme: Report warning with warn_report()=0D
  block/nvme: Trace controller capabilities=0D
  block/nvme: Trace nvme_poll_queue() per queue=0D
  block/nvme: Improve nvme_free_req_queue_wait() trace information=0D
  block/nvme: Trace queue pair creation/deletion=0D
  block/nvme: Simplify device reset=0D
  block/nvme: Move definitions before structure declarations=0D
  block/nvme: Use unsigned integer for queue counter/size=0D
  block/nvme: Make nvme_identify() return boolean indicating error=0D
  block/nvme: Make nvme_init_queue() return boolean indicating error=0D
  block/nvme: Introduce Completion Queue definitions=0D
  block/nvme: Use definitions instead of magic values in add_io_queue()=0D
  block/nvme: Correctly initialize Admin Queue Attributes=0D
  block/nvme: Simplify ADMIN queue access=0D
  block/nvme: Simplify nvme_cmd_sync()=0D
  block/nvme: Pass AioContext argument to nvme_add_io_queue()=0D
  block/nvme: Set request_alignment at initialization=0D
  block/nvme: Correct minimum device page size=0D
  block/nvme: Fix use of write-only doorbells page on Aarch64 arch=0D
=0D
 include/block/nvme.h |  17 ++--=0D
 block/nvme.c         | 208 ++++++++++++++++++++++++-------------------=0D
 MAINTAINERS          |   2 +=0D
 block/trace-events   |  30 ++++---=0D
 4 files changed, 148 insertions(+), 109 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D



Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB43C3F2D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C474A246AA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C474A246AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42649 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Zwh-0004Xc-RJ
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 02:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Zvm-0002Zd-0F
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Zvl-00061I-08
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:19:29 -0500
Received: from relay.sw.ru ([185.231.240.75]:51942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Zvk-00060c-OT; Fri, 28 Feb 2020 02:19:28 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Zve-0002hc-5A; Fri, 28 Feb 2020 10:19:22 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] benchmark util
Date: Fri, 28 Feb 2020 10:19:10 +0300
Message-Id: <20200228071914.11746-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, stefanha@gmail.com, mreitz@redhat.com, crosa@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

v3:
  move all to scripts/simplebench
  add myself as a maintainer of this thing

Here is simple benchmarking utility, to generate performance
comparison tables, like the following:

----------  -------------  -------------  -------------
            backup-1       backup-2       mirror
ssd -> ssd  0.43 +- 0.00   4.48 +- 0.06   4.38 +- 0.02
ssd -> hdd  10.60 +- 0.08  10.69 +- 0.18  10.57 +- 0.05
ssd -> nbd  33.81 +- 0.37  10.67 +- 0.17  10.07 +- 0.07
----------  -------------  -------------  -------------

I'll use this benchmark in other series, hope someone
will like it.

Vladimir Sementsov-Ogievskiy (4):
  scripts/simplebench: add simplebench.py
  scripts/simplebench: add qemu/bench_block_job.py
  scripts/simplebench: add example usage of simplebench
  MAINTAINERS: add simplebench

 MAINTAINERS                            |   5 +
 scripts/simplebench/bench-example.py   |  80 ++++++++++++++++
 scripts/simplebench/bench_block_job.py | 119 +++++++++++++++++++++++
 scripts/simplebench/simplebench.py     | 128 +++++++++++++++++++++++++
 4 files changed, 332 insertions(+)
 create mode 100644 scripts/simplebench/bench-example.py
 create mode 100755 scripts/simplebench/bench_block_job.py
 create mode 100644 scripts/simplebench/simplebench.py

-- 
2.21.0



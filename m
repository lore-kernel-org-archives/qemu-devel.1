Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D3C433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AD321920
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="l9GMpsJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AD321920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7HH7-00080U-AY
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 06:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i7HFa-0006VF-MB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i7HFX-00075N-Lo
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:50:24 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:40184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i7HFX-0006yp-3p
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:50:23 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5C1572E1429;
 Mon,  9 Sep 2019 13:50:19 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
 [2a02:6b8:0:1472:2741:0:8b6:10])
 by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 3crOw56ucZ-oIW4R6P8; Mon, 09 Sep 2019 13:50:19 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1568026219; bh=I9Otm40/SXZRGB83vtneLojZbFBJFQ/cvt5qNHvBiD4=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=l9GMpsJGOwfQbsHmkStL6AUhBYtktlkQcFbAYMN2BC+l8fdmejyTqu8lIJfq1TEdB
 HIGT6MknlfBAuPYcrvT74lm2S9JFMtRC0cFFrXMclGf9lffjiIdPHgNuijs4eRm0aW
 MmbfSWvT8ETbR+bQgtIo55lhbbkdqK6mo9o3VHvU=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:c41:6db7:e9d4:e9e0])
 by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 Skp3BT4RoZ-oID0rYkn; Mon, 09 Sep 2019 13:50:18 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>,
 Thomas Huth <thuth@redhat.com>
Date: Mon,  9 Sep 2019 13:49:45 +0300
Message-Id: <20190909104948.30253-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [PATCH v6 0/3] High downtime with 95+ throttle pct
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

V6:
* Fix "Add qemu_cond_timedwait" patch:
  - Changed return type for qemu_cond_timedwait (void -> bool)
  - Added details in commit message

V5:
* Updated sleep loop in throttle_thread at the suggestion of Paolo Bonzin=
i
* Fixed hanging of test

V4:
* The test was simplified to prevent false fails.

V3:
* Rebase fixes (migrate_set_parameter -> migrate_set_parameter_int)

V2:
* Added a test
* Fixed qemu_cond_timedwait for qsp

I wrote a test for migration auto converge and found out a strange thing:
1. Enable auto converge
2. Set max-bandwidth 1Gb/s
3. Set downtime-limit 1ms
4. Run standard test (just writes a byte per page)
5. Wait for converge
6. It's converged with 99% throttle percentage
7. The result downtime was about 300-600ms   <<<<

It's much higher than expected 1ms. I figured out that cpu_throttle_threa=
d()
function sleeps for 100ms+ for high throttle percentage (>=3D95%) in VCPU=
 thread.
And it sleeps even after a cpu kick.

Fixed it by using timedwait for ms part of sleep.
E.g timedwait(halt_cond, 1ms) + usleep(500).

Regards,
Yury

Yury Kotov (3):
  qemu-thread: Add qemu_cond_timedwait
  cpus: Fix throttling during vm_stop
  tests/migration: Add a test for auto converge

 cpus.c                   |  25 +++++---
 include/qemu/thread.h    |  19 +++++++
 tests/migration-test.c   | 120 +++++++++++++++++++++++++++++++++++----
 util/qemu-thread-posix.c |  41 +++++++++----
 util/qemu-thread-win32.c |  17 ++++++
 util/qsp.c               |  20 +++++++
 6 files changed, 211 insertions(+), 31 deletions(-)

--=20
2.23.0



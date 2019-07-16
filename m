Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B648C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0802220693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="tnK9X8gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0802220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49783 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOsI-0003Xd-Qe
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hnOrB-0007ac-Ug
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hnOrA-0001L7-Ca
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:55:05 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:48168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hnOr9-0001Jp-Ps
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:55:04 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id DB5EF2E0A2C;
 Tue, 16 Jul 2019 17:54:56 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 aPqPlABj9T-stUSOoaf; Tue, 16 Jul 2019 17:54:56 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563288896; bh=KFO5oG2Nm1dwR2QfkRer46qbSk588/2/p2CI7n5RCj0=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=tnK9X8gTaPF4vFQvPGzPi/gRbScCY14JEdO5CO/8lD50tCoxDeP6sYQIaTMvAPZ9s
 ODGp/TsnMmq7bn4MYYlj1wxaSXVCZSN72kWcepYmUqUQHTnslPVGMnaI3oy5/sD2ZJ
 GAiTe1pFF1KNbifI/YdZiLdf/tX6fDOYEK6LeBuI=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:68fa:19fe:5639:24b5])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 RzIFhwRP0o-stQiIRJr; Tue, 16 Jul 2019 17:54:55 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Date: Tue, 16 Jul 2019 17:54:18 +0300
Message-Id: <20190716145421.17645-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
Subject: [Qemu-devel] [PATCH v2 0/3] High downtime with 95+ throttle pct
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

I tried to fix it by using timedwait for ms part of sleep.
E.g timedwait(halt_cond, 1ms) + usleep(500).

Regards,
Yury

Yury Kotov (3):
  qemu-thread: Add qemu_cond_timedwait
  cpus: Fix throttling during vm_stop
  tests/migration: Add a test for auto converge

 cpus.c                   |  27 ++++++---
 include/qemu/thread.h    |  18 ++++++
 tests/migration-test.c   | 119 +++++++++++++++++++++++++++++++++++----
 util/qemu-thread-posix.c |  40 +++++++++----
 util/qemu-thread-win32.c |  16 ++++++
 util/qsp.c               |  18 ++++++
 6 files changed, 207 insertions(+), 31 deletions(-)

--=20
2.22.0



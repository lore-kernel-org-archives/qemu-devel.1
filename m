Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6020C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85714227B7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="pFvFEQ0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85714227B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpv4E-0000dm-HW
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hpv3y-0008Lr-Hm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hpv3x-0003vR-Kj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:42:42 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:56032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hpv3x-0003ur-12
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:42:41 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 5D1F42E14BE;
 Tue, 23 Jul 2019 16:42:38 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 uUKKBTHJPz-gbNSvIrn; Tue, 23 Jul 2019 16:42:38 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563889358; bh=fhxOvU+fKFPyYtrmD4WYuVEm4ToPLKSH4TSxFFwacrk=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=pFvFEQ0h2J1elTUHwhqoE54XPfiNEAVXbKsD2PpGRXU984UUbDrLNNS0O4jFIgnXu
 D/eDoQ6wXotcdJHT1jmH7uQKaS606BlwhlHHsbFSxSgdZrIpNzNOBsCTjLXrjWPgAc
 IbXxm2g+yx9nbFMi/VGTNjKtoLx0l3V+3vud27AI=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8808::1:1a])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 cJSCJL4WEY-gbAm4nSr; Tue, 23 Jul 2019 16:42:37 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Date: Tue, 23 Jul 2019 16:42:11 +0300
Message-Id: <20190723134215.25095-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: [Qemu-devel] [PATCH v4 0/3] High downtime with 95+ throttle pct
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
Cc: "open list:Overall" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

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

 cpus.c                   |  27 +++++++---
 include/qemu/thread.h    |  18 +++++++
 tests/migration-test.c   | 103 ++++++++++++++++++++++++++++++++++-----
 util/qemu-thread-posix.c |  40 ++++++++++-----
 util/qemu-thread-win32.c |  16 ++++++
 util/qsp.c               |  18 +++++++
 6 files changed, 191 insertions(+), 31 deletions(-)

--=20
2.22.0



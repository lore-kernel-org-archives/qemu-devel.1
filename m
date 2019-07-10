Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4F6C004EF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3842620838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="RT6YlxW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3842620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl8qy-000175-Ic
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47439)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hl8pe-0008Aj-8A
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hl8pc-0007sl-MS
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:24:10 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:54432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hl8pc-0007kO-5X
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:24:08 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 551882E0A03;
 Wed, 10 Jul 2019 12:24:01 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
 [2a02:6b8:0:1472:2741:0:8b6:10])
 by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 cOQwEUnMaj-O0imMNSi; Wed, 10 Jul 2019 12:24:01 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1562750641; bh=ikfGEsCCjo83Cs34/TDb++y7x/1OZ2QOYoPo+b2xQKk=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=RT6YlxW6O0rmuy9ewjS8k0LirG0LVQ0eQi3xtmtEJHu17+arg/DnwHL2+fGryJOu/
 plTakFNqMn5+1vJhuBWaQth2nBUsk4Tp41zSZjtRR04sWmXaamL/0430z6zX+CjJxY
 zg6uwWq/xhZx97tIsJKLQJZ1jQ55H+XSFlPJTlv4=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:649c:ccd6:daab:d003])
 by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 c6HGiW8rtf-O0waYlpv; Wed, 10 Jul 2019 12:24:00 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefan Weil <sw@weilnetz.de>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Wed, 10 Jul 2019 12:23:36 +0300
Message-Id: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [RFC PATCH 0/2] High downtime with 95+ throttle pct
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

But I'm not sure about using timedwait function here with qemu_global_mut=
ex.
The original function uses qemu_mutex_unlock_iothread + qemu_mutex_lock_i=
othread
It differs from locking/unlocking (inside timedwait) qemu_global_mutex
because of using qemu_bql_mutex_lock_func function which could be anythin=
g.
This is why the series is RFC.

What do you think?
Thanks!

Yury Kotov (2):
  qemu-thread: Add qemu_cond_timedwait
  cpus: Fix throttling during vm_stop

 cpus.c                   | 27 +++++++++++++++++++--------
 include/qemu/thread.h    | 12 ++++++++++++
 util/qemu-thread-posix.c | 40 ++++++++++++++++++++++++++++------------
 util/qemu-thread-win32.c | 16 ++++++++++++++++
 4 files changed, 75 insertions(+), 20 deletions(-)

--=20
2.22.0



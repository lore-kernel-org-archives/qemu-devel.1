Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56EEC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BAD217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="XSwOVZOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BAD217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGaw-0008N0-VE
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35856)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hvGaL-0007x9-3n
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hvGaK-0006cL-52
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:42:13 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:60176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hvGaJ-0006bj-My
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:42:12 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 4C8702E1492;
 Wed,  7 Aug 2019 10:42:08 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 UpDtakiB3V-g6e8RBnx; Wed, 07 Aug 2019 10:42:08 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1565163728; bh=Bb5pjB8aRRbz6D9blwMSN2I/Qw5Su7a/PoUTlsC66NM=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=XSwOVZOV4l+Oa/Rf9iL//7h4t1oUBGXciBIuuuvSQxxf3eKeN4O+sbMju6nLI0+ED
 p8rzfiAWYC4UjnvdcuOOIp4rZJO1ELgeYigkxjnHtcWokBAz3cjMgLEqi9oRP1fjWi
 dpYvGIrFioO9A5lLv1TUxIkK6ERwg5zMjhmaCe5s=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net (localhost [::1])
 by mxbackcorp1o.mail.yandex.net with LMTP id D7xrwO7OIi-SdnnbfeL
 for <yury-kotov@yandex-team.ru>; Wed, 07 Aug 2019 10:41:56 +0300
Received: by vla1-1374b6242101.qloud-c.yandex.net with HTTP;
 Wed, 07 Aug 2019 10:41:56 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>,
 Dr. David Alan Gilbert <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>
In-Reply-To: <20190723134215.25095-1-yury-kotov@yandex-team.ru>
References: <20190723134215.25095-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 07 Aug 2019 10:42:06 +0300
Message-Id: <2013231565163716@vla1-1374b6242101.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: Re: [Qemu-devel] [PATCH v4 0/3] High downtime with 95+ throttle pct
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
Cc: "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

23.07.2019, 16:42, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> Hi,
>
> V4:
> * The test was simplified to prevent false fails.
>
> V3:
> * Rebase fixes (migrate_set_parameter -> migrate_set_parameter_int)
>
> V2:
> * Added a test
> * Fixed qemu_cond_timedwait for qsp
>
> I wrote a test for migration auto converge and found out a strange thin=
g:
> 1. Enable auto converge
> 2. Set max-bandwidth 1Gb/s
> 3. Set downtime-limit 1ms
> 4. Run standard test (just writes a byte per page)
> 5. Wait for converge
> 6. It's converged with 99% throttle percentage
> 7. The result downtime was about 300-600ms <<<<
>
> It's much higher than expected 1ms. I figured out that cpu_throttle_thr=
ead()
> function sleeps for 100ms+ for high throttle percentage (>=3D95%) in VC=
PU thread.
> And it sleeps even after a cpu kick.
>
> Fixed it by using timedwait for ms part of sleep.
> E.g timedwait(halt_cond, 1ms) + usleep(500).
>
> Regards,
> Yury
>
> Yury Kotov (3):
> =C2=A0=C2=A0qemu-thread: Add qemu_cond_timedwait
> =C2=A0=C2=A0cpus: Fix throttling during vm_stop
> =C2=A0=C2=A0tests/migration: Add a test for auto converge
>
> =C2=A0cpus.c | 27 +++++++---
> =C2=A0include/qemu/thread.h | 18 +++++++
> =C2=A0tests/migration-test.c | 103 ++++++++++++++++++++++++++++++++++--=
---
> =C2=A0util/qemu-thread-posix.c | 40 ++++++++++-----
> =C2=A0util/qemu-thread-win32.c | 16 ++++++
> =C2=A0util/qsp.c | 18 +++++++
> =C2=A06 files changed, 191 insertions(+), 31 deletions(-)
>
> --
> 2.22.0


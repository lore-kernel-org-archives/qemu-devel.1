Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05FDC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D7920665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="VspC16UG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D7920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9pD-0001x2-5K
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hl9mS-0000uT-8S
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hl9mQ-0007QA-Cf
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:24:56 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:60068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hl9mP-0007MM-D6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:24:54 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 375DD2E14BF;
 Wed, 10 Jul 2019 13:24:42 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 6ta6vEdiYk-Ofi4QCkN; Wed, 10 Jul 2019 13:24:42 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1562754282; bh=3zY26uYfqU7/mErlLlEHloCw5Q5TIXc0AncgaJjEnzI=;
 h=Cc:Subject:Date:References:To:From:Message-Id;
 b=VspC16UGw/V97jfJMlQycugw1GtWbP6nWDNvkF1zPfyVr7VKzrV2rLntBfzOp11Lh
 OC0aZdbXe7m5Y73drvJN2Ro9NDEYbkfNvYrY5793BxqSGLjO5aGef0Fbe3SD3SB2GC
 S53kE3E0y01F1gPqzr0a01mQrfLkE+ldzWk54WyQ=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (localhost [::1])
 by mxbackcorp1j.mail.yandex.net with LMTP id 2vpzUjb29T-HNTkFYWV
 for <yury-kotov@yandex-team.ru>; Wed, 10 Jul 2019 13:24:31 +0300
Received: by myt4-a988562a11ab.qloud-c.yandex.net with HTTP;
 Wed, 10 Jul 2019 13:24:30 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
References: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
 <20190710095657.GB2682@work-vm>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 10 Jul 2019 13:24:40 +0300
Message-Id: <287391562754270@myt4-a988562a11ab.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] High downtime with 95+ throttle pct
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
Cc: Juan Quintela <quintela@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.07.2019, 12:57, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0Hi,
>>
>> =C2=A0I wrote a test for migration auto converge and found out a stran=
ge thing:
>> =C2=A01. Enable auto converge
>> =C2=A02. Set max-bandwidth 1Gb/s
>> =C2=A03. Set downtime-limit 1ms
>> =C2=A04. Run standard test (just writes a byte per page)
>> =C2=A05. Wait for converge
>> =C2=A06. It's converged with 99% throttle percentage
>> =C2=A07. The result downtime was about 300-600ms <<<<
>>
>> =C2=A0It's much higher than expected 1ms. I figured out that cpu_throt=
tle_thread()
>> =C2=A0function sleeps for 100ms+ for high throttle percentage (>=3D95%=
) in VCPU thread.
>> =C2=A0And it sleeps even after a cpu kick.
>>
>> =C2=A0I tried to fix it by using timedwait for ms part of sleep.
>> =C2=A0E.g timedwait(halt_cond, 1ms) + usleep(500).
>>
>> =C2=A0But I'm not sure about using timedwait function here with qemu_g=
lobal_mutex.
>> =C2=A0The original function uses qemu_mutex_unlock_iothread + qemu_mut=
ex_lock_iothread
>> =C2=A0It differs from locking/unlocking (inside timedwait) qemu_global=
_mutex
>> =C2=A0because of using qemu_bql_mutex_lock_func function which could b=
e anything.
>> =C2=A0This is why the series is RFC.
>>
>> =C2=A0What do you think?
>
> Would qemu_sem_timedwait work for your use? I use it in
> migration_thread for the bandwidth limiting and allowing that to be
> woken up.

It's a good idea and it should work. But it's more complicated than reusi=
ng
halt_cond. I see that it's ok to use qemu_cond_wait in cpus.c so I hope i=
t's
ok to use qemu_cond_timedwait too. But if it isn't then using qemu_sem_ti=
medwait
is a good fallback I think.

Regards,
Yury

>
> Dave
>
>> =C2=A0Thanks!
>>
>> =C2=A0Yury Kotov (2):
>> =C2=A0=C2=A0=C2=A0qemu-thread: Add qemu_cond_timedwait
>> =C2=A0=C2=A0=C2=A0cpus: Fix throttling during vm_stop
>>
>> =C2=A0=C2=A0cpus.c | 27 +++++++++++++++++++--------
>> =C2=A0=C2=A0include/qemu/thread.h | 12 ++++++++++++
>> =C2=A0=C2=A0util/qemu-thread-posix.c | 40 ++++++++++++++++++++++++++++=
------------
>> =C2=A0=C2=A0util/qemu-thread-win32.c | 16 ++++++++++++++++
>> =C2=A0=C2=A04 files changed, 75 insertions(+), 20 deletions(-)
>>
>> =C2=A0--
>> =C2=A02.22.0
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FFEC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5D12054F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5D12054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9M8-00071d-IQ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60471)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hl9LV-0006aD-T3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hl9LU-0005UC-LD
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:57:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hl9LU-0005Ti-Ex
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:57:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5388E81120;
 Wed, 10 Jul 2019 09:57:03 +0000 (UTC)
Received: from work-vm (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AF5B1001B19;
 Wed, 10 Jul 2019 09:57:01 +0000 (UTC)
Date: Wed, 10 Jul 2019 10:56:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190710095657.GB2682@work-vm>
References: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 10 Jul 2019 09:57:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] High downtime with 95+ throttle pct
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
Cc: Juan Quintela <quintela@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "open list:Overall" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Hi,
> 
> I wrote a test for migration auto converge and found out a strange thing:
> 1. Enable auto converge
> 2. Set max-bandwidth 1Gb/s
> 3. Set downtime-limit 1ms
> 4. Run standard test (just writes a byte per page)
> 5. Wait for converge
> 6. It's converged with 99% throttle percentage
> 7. The result downtime was about 300-600ms   <<<<
> 
> It's much higher than expected 1ms. I figured out that cpu_throttle_thread()
> function sleeps for 100ms+ for high throttle percentage (>=95%) in VCPU thread.
> And it sleeps even after a cpu kick.
> 
> I tried to fix it by using timedwait for ms part of sleep.
> E.g timedwait(halt_cond, 1ms) + usleep(500).
> 
> But I'm not sure about using timedwait function here with qemu_global_mutex.
> The original function uses qemu_mutex_unlock_iothread + qemu_mutex_lock_iothread
> It differs from locking/unlocking (inside timedwait) qemu_global_mutex
> because of using qemu_bql_mutex_lock_func function which could be anything.
> This is why the series is RFC.
> 
> What do you think?

Would qemu_sem_timedwait work for your use?  I use it in
migration_thread for the bandwidth limiting and allowing that to be
woken up.

Dave

> Thanks!
> 
> Yury Kotov (2):
>   qemu-thread: Add qemu_cond_timedwait
>   cpus: Fix throttling during vm_stop
> 
>  cpus.c                   | 27 +++++++++++++++++++--------
>  include/qemu/thread.h    | 12 ++++++++++++
>  util/qemu-thread-posix.c | 40 ++++++++++++++++++++++++++++------------
>  util/qemu-thread-win32.c | 16 ++++++++++++++++
>  4 files changed, 75 insertions(+), 20 deletions(-)
> 
> -- 
> 2.22.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


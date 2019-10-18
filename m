Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A22CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D38421925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D38421925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLQzK-0001WS-56
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iLQyH-0000eD-Co
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iLQyG-0006vX-3S
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:03:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iLQy9-0006pt-Ef; Fri, 18 Oct 2019 08:02:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0156F4FCCE;
 Fri, 18 Oct 2019 12:02:56 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 853E9196B2;
 Fri, 18 Oct 2019 12:02:54 +0000 (UTC)
Date: Fri, 18 Oct 2019 14:02:52 +0200
From: Andrew Jones <drjones@redhat.com>
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
Message-ID: <20191018120252.sdpi4t7jlectnspu@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <20191017211758.ownflk2c7mzv3poh@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017211758.ownflk2c7mzv3poh@gabell>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 18 Oct 2019 12:02:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 05:17:59PM -0400, Masayoshi Mizuma wrote:
> Hi Drew,
> 
> Thank you for posting the patches, they seems to work well
> because the softlockup is gone and the timestamp jump of
> dmesg and ftrace record also disappeared after the guest
> is virsh resume'ed.
> 
> Let me add comments.
> I think the kvm-adjvtime behavior should be the default.
> How about introducing 'kvm-noadjvtime' parameter instead?
> kvm-noadjvtime is to provide the old behavior.
> 
> That is because the time jump occurs timeout for timers even though
> the timer doesn't reach the timeout in the guest time.
> 
> For example, below flow shows that user and/or kernel sets timer A
> for +10 sec and B for +20 sec in Guest, then Guest is suspended and
> it passes 60 sec, then Guest is resumed. Timer A and B go off because
> the Guest timestamp (TS) is jumped to 63. That is unexpected timer
> behavior for Guest.
> 
>  Host TS(sec) Guest TS(sec) Event
>  ============ ============= =============================
>  00           00            Guest: Set timer A for +10 sec
>  01           01            Guest: Set timer B for +20 sec
>  03           03            Host: virsh suspend Guest
>  63           63            Host: virsh resume Guest
>                             Guest: Timer A and B go off
> 
> I believe kvm-adjvtime behavior is as following. So Time A
> and B go off as expected time. So, kvm-adjvtime behavior should
> be the default.
> 
>  Host TS(sec) Guest TS(sec) Event
>  ============ ============= =============================
>  00           00            Guest: Set timer A for +10 sec
>  01           01            Guest: Set timer B for +20 sec
>  03           03            Host: virsh suspend guest
>  63           03            Host: virsh resume guest
>  70           10            Guest: Timer A goes off
>  81           21            Guest: Timer B goes off
> 

Thanks for the testing Masa. Your timer test is another good example of
what can happen when a guest is paused. I'm sure there are many other ways
a pause could be problematic as well, especially if the guest has devices
passed through to it that it's actively using. I also don't expect
kvm-adjvtime to solve all those problems (like, for example, potential
problems with passthrough devices, networks, etc.)  This means that guest
pausing should only be done by host admins that are intimately familiar
with the guest OS, workload, and network connections. They should be sure
that it can tolerate and recover from the pauses. Since the admins need to
make the decision to pause at all, then I think it's fair for them to also
decide if they want to try and mitigate some of the issues with
kvm-adjvtime, i.e. require them to enable it, rather than have it on by
default. Also, if we choose to enable it by default, then we'll need to
deal with the compatibility issues that come with changing a behavior.
That's not impossible, as this feature could be disabled for older
machine types, but it's messy.

All that said, I won't argue too hard against kvm-adjvtime being on by
default, but let's see if others like Peter or Marc want to chime in on
it too.

Thanks,
drew


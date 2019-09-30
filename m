Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B238C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFED20679
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFED20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEx5c-0007dZ-3n
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 10:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iEx4l-0006o7-9n
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iEx4k-0006dq-2z
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:54:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62923)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iEx4j-0006dI-Te
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:54:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6334620F4
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 14:54:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-86.ams2.redhat.com [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF33F10013D9;
 Mon, 30 Sep 2019 14:54:55 +0000 (UTC)
Date: Mon, 30 Sep 2019 16:54:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Tony Asleson <tasleson@redhat.com>
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
Message-ID: <20190930145454.GA12777@linux.fritz.box>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920083630.GA5458@localhost.localdomain>
 <566d0d07-35fc-2d66-a47c-00526546b31e@redhat.com>
 <20190920181119.GF5458@localhost.localdomain>
 <4d1d6516-fc4a-6258-e993-452f92cdfa28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d1d6516-fc4a-6258-e993-452f92cdfa28@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 30 Sep 2019 14:54:56 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.09.2019 um 20:55 hat Tony Asleson geschrieben:
> On 9/20/19 1:11 PM, Kevin Wolf wrote:
> > Emitting a QMP event when blkdebug injects an error makes sense to me.
> > 
> > I wouldn't use it for this case, though, because this would become racy.
> > It could happen that the guest writes to the image, which sends a QMP
> > event, and then reads before the external program has removed the error.
> 
> My POC had a single lock protecting it's shared state.  I'm kind of
> surprised no one jumped on that because it's a big point of lock
> contention.

I think people didn't review the code in detail because we're still
discussing very high-level design questions.

Anyway, I did mention that I'd like to get your code out of the way for
the fast path when the feature isn't used. If the user explicitly
enabled the feature and we're basically in a debugging setup, the lock
contention should be acceptable. In fact, the mutex might not even be
necessary because the code should be covered by the AioContext lock.

However, I don't see how this locking could fix the race I mention. It's
not a race between two QEMU components, but between the guest and a QMP
client. A mutex in QEMU certainly feels like the wrong way to address
it.

If you really wanted an external process to control this, you would have
to fully stop the VM whenever an error is injected and only continue it
via QMP after the QMP client has decided whether or not to disable the
error. Because you'd need a custom QMP client then, you wouldn't be able
to use things like libvirt for such QEMU instances.

Kevin


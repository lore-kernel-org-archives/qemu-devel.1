Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0210C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933C320811
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933C320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIu2T-0004xe-J9
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:56:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIu1j-0004gN-10
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIu1h-0002V7-S4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:55:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hIu1h-0002UX-MO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:55:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C01733082B5A
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:55:52 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE8015D71F;
	Tue, 23 Apr 2019 11:55:49 +0000 (UTC)
Date: Tue, 23 Apr 2019 12:55:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190423115546.GJ6022@redhat.com>
References: <20190423113028.GD30014@wheatley>
	<20190423113602.GJ3926@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423113602.GJ3926@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 23 Apr 2019 11:55:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Martin Kletzander <mkletzan@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423115546.mQul65jksFvELrIOMV1e7elRSa_68ZdEWVVONuuN0zA@z>

On Tue, Apr 23, 2019 at 12:36:02PM +0100, Richard W.M. Jones wrote:
> On Tue, Apr 23, 2019 at 01:30:28PM +0200, Martin Kletzander wrote:
> > I am using qemu-img with nbdkit to transfer a disk image and the
> > update it with extra data from newer snapshots.  The end image
> > cannot be transferred because the snapshots will be created later
> > than the first transfer and we want to save some time up front.  You
> > might think of it as a continuous synchronisation.
> 
> It's important to note here that Martin is reading the data from a
> VMware server, so this is not something that can be solved with qemu's
> own snapshots.
> 
> [...]
> 
> I think the following is an even simpler demo which gets to the nub of
> the problem as I understand it:
> 
> $ rm -f disk.img snap.img
> $ dd if=/dev/urandom of=disk.img bs=2M count=1
> $ dd if=/dev/zero of=snap.img bs=2M count=1
> $ qemu-img convert -n -p snap.img disk.img
> $ hexdump -C disk.img | head
> 00000000  18 30 e8 1f 09 f0 bb 2c  2f c7 b3 97 8f 12 fe 4b  |.0.....,/......K|
> 00000010  66 f7 28 cb 8e 72 2a 37  6b fa 98 2e a0 e6 d9 cf  |f.(..r*7k.......|
> [etc] <- ie. not zeroes
> 
> Should we expect disk.img to contain zeroes at the end?

I'd expect disk.img and snap.img to be identical when read.
snap.img doesn't have to contain zeros (it could be full of
holes instead), but a read should return all zeros.

That doesn't seem to be the case here though. It looks like
QEMU is seeing that disk.img is all zeros and then neither
writing any zeros to snap.img, not punching sparse holes in
it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


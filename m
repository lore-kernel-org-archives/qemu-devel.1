Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63F322B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUt/1Ril"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63F322B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGBM-0004py-6E
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBGAp-0004Lg-2o
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBGAm-00053F-8m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598528066;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dS7iFNAcFz+RbafFbUeYFU1F4bQuu83rvyBYWY6Vpvc=;
 b=FUt/1Ril7fGOoJt+vsO4Nd71MsSdgMNTqR/xi312y8nEzXQ3vO0JU1tRwsbiXmAeN6ZMZr
 6Es1KnqPyxXN1+H+y0glXmf0FVsXs0+8Ba8PzB36cS4C2+/HgzpH/MmnBnoPrB4iSNc6q6
 LsiaLNcCxXGLrMgVV8jJa/vMU1lrYok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-gaJJY7-ZMBihFJvWLxOD8A-1; Thu, 27 Aug 2020 07:34:18 -0400
X-MC-Unique: gaJJY7-ZMBihFJvWLxOD8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E66DD185FD7E;
 Thu, 27 Aug 2020 11:34:16 +0000 (UTC)
Received: from redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F3401944D;
 Thu, 27 Aug 2020 11:34:14 +0000 (UTC)
Date: Thu, 27 Aug 2020 12:34:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 (BROKEN) 0/6] migration: bring improved
 savevm/loadvm/delvm to QMP
Message-ID: <20200827113411.GP192458@redhat.com>
References: <20200727150843.3419256-1-berrange@redhat.com>
 <877dtls8ux.fsf@dusky.pond.sub.org>
 <20200826182824.GA190807@redhat.com>
 <874koonyd0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <874koonyd0.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 01:04:43PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Aug 26, 2020 at 05:52:06PM +0200, Markus Armbruster wrote:
> > From the POV of practicality, making a design that unifies internal
> > and external snapshots is something I'm considering out of scope.
> > It increases the design time burden, as well as implementation burden.
> > On my side, improving internal snapshots is a "spare time" project,
> > not something I can justify spending weeks or months on.
> 
> I'm not demanding a solution that unifies internal and external
> snapshots.  I'm asking for a bit of serious thought on an interface that
> could compatibly evolve there.  Hours, not weeks or months.
> 
> > My goal is to implement something that is achievable in a short
> > amount of time that gets us out of the hole we've been in for 10
> > years. Minimal refactoring of the internal snapshot code aside
> > from fixing the critical limitations we have today around choice
> > of disks to snapshot.
> >
> > If someone later wants to come up with a grand unified design
> > for everything that's fine, we can deprecate the new QMP commands
> > I'm proposing now.
> 
> Failing at coming up with an interface that has a reasonable chance to
> be future-proof is okay.
> 
> Not even trying is not okay.

This was raised in my v1 posting:

  https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01346.html

but the conclusion was that it was a non-trivial amount of extra
implementation work


> Specifically, I'd like you to think about monolothic snapshot command
> (internal snapshots only by design) vs. transaction of individual
> snapshot commands (design is not restricted to internal snapshots, but
> we may want to accept implementation restrictions).
> 
> We already have transactionable individual storage snapshot commands.
> What's missing is a transactionable machine state snapshot command.

At a high level I consider what I've proposed as being higher level
syntax sugar vs a more generic future impl based on multiple commands
for snapshotting disk & state. I don't think I'd claim that it will
evolve to become the design you're suggesting here, as they are designs
from different levels in the stack. IOW, I think the would ultimately
just exist in parallel. I don't think that's a real problem from a
maint POV, as the large burden from the monolithic snapshot code is
not the HMP/QMP interface, but rather the guts of the internal
impl in the migration/savevm.c and block/snapshot.c files. That code
will exist for as long as the HMP commands exist, and adding a QMP
interface doesn't make that situation worse unless we were intending
to drop the existing HMP commands. If we did change our minds though,
we can just deprecate the QMP command at any time we like.


> One restriction I'd readily accept at this time is "the machine state
> snapshot must write to a QCOW2 that is also internally snapshot in the
> same transaction".
> 
> Now explain to me why this is impractical.

The issues were described by Kevin here:

  https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg02057.html

Assuming the migration impl is actually possible to solve, there is
still the question of actually writing it. That's a non-trivial
amount of work someone has to find time for.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



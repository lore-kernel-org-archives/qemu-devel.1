Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96557C3A5A7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 12:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6028521881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 12:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6028521881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4l55-0005EE-ET
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 08:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i4l4L-0004jA-7r
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 08:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i4l4J-0001kF-Up
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 08:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i4l4G-0001g7-Nb; Mon, 02 Sep 2019 08:04:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F85C3082129;
 Mon,  2 Sep 2019 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-189.ams2.redhat.com
 [10.36.116.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C6FF60166;
 Mon,  2 Sep 2019 12:04:16 +0000 (UTC)
Date: Mon, 2 Sep 2019 14:04:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190902120415.GB13140@localhost.localdomain>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <20190815114553.GQ300@andariel.pipo.sk>
 <87d0h6zfrt.fsf@dusky.pond.sub.org> <m1lfvbex92.fsf@redhat.com>
 <eba518d8-0104-fb41-8ed5-d59ebdb211c9@redhat.com>
 <m1k1avdkzu.fsf@redhat.com>
 <1b7887f1-41e9-8de3-8e92-fc6d6815f20f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7887f1-41e9-8de3-8e92-fc6d6815f20f@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 02 Sep 2019 12:04:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/2] qapi: deprecate implicit
 filters
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, Christophe de Dinechin <dinechin@redhat.com>,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.08.2019 um 20:11 hat John Snow geschrieben:
> 
> 
> On 8/30/19 6:07 AM, Christophe de Dinechin wrote:
> > Without having looked at the code much, I think I would
> > 
> > 1. extend the existing QAPI error to support warnings, deprecations and
> >    info messages. The first problem I see is that there is no error, so
> >    we may sometimes need to create one when there was none before. And
> >    of course make sure that this does not ultimately show as an error,
> >    but as a success with additional annotations.
> > 
> 
> I assume this might be a chance to consolidate all of the methodologies
> we use for actually checking if there was an error or not. There have
> been many and I am sure Markus can give us a history lesson if it's
> warranted.
> 
> Generally, there's a few paradigms I see a lot:
> 
> 1. Rely on an error return code being produced by the called function.
> The caller trusts that errp was set. This is one of my favorite methods,
> because it has the least scaffolding.

This one is convenient to use, but the problem is that nobody enforces
that errp is always set if ret < 0, and that it's not set for ret == 0.
So in a way it is error-prone because it allows inconsistencies.

> 2. Pass errp directly to the called function, and check for null after
> return. I don't like this method very much, because of confusion with:

I mainly don't like this very much because it's simply wrong.

Callers can pass errp = NULL if they aren't interested in error
information. If you directly pass errp, you can't check *errp because
errp could be NULL.

So directly passing errp makes the code simpler, but only use it in
functions where you don't intend to check whether an error is set.

> 3. Create a local error object; check THAT for null, and propagate the
> error to the common error object. I think Markus has explained why we
> have this code 50 times, and I forget again minutes later.

local_err exists for those cases where you need to check the error
object before passing it to the caller. (And obviously for those cases
where you don't want to pass it to the caller, but do something like
error_report_err().)

> If we want to expand the concept of the error object into something that
> encompasses hints, warnings and deprecations*, checking for null is no
> longer appropriate. It might be a good chance to make our error
> propagation story more consistent, too.
> 
> We could unify with a helper like this, I think, if I'm not forgetting
> some crucial usage detail:
> 
> subroutine(foo, bar, errp);
> if (failure(errp)) {
>     error_append_hint(errp, "Lorem ipsum, ...");
>     cleanup();
>     return;
> }
> 
> We would then always use this pattern that operates directly on the
> caller's errp instead of creating local error objects to allow hints and
> warnings to accumulate.

There are two parts to the change that you imply:

1. Forbid passing errp = NULL to any function so that *errp can always
   be checked. This gets rid of local_err in the intermediate function,
   but may require the introduction of new local_err variables in
   top-level callers which ignore the error information.

2. Introduce failure(errp) to replace errp != NULL because we want Error
   to contain warnings and notes, too. Currently, it can contain only
   exactly one error, so this would be a major change.

   Note that the change wouldn't make the existing 'if (errp)' checks
   build failures, so getting confident that we found and replaced all
   of them is going to be hard.

Essentially, you'd probably want to replace Error with a new type so
that the compiler will at least be able to tell which places have been
converted and which haven't.

And then, you'd have to touch every single function that does something
with errors. This is a huge change across the whole source tree.

I doubt it's worth the effort.

> > Second, why not report the use of deprecated features? I don't fully buy
> > the rationale that libvirt engages the features, because it does not do
> > it on its own, it does it because the user made some specific request.
> 
> Because the user didn't request those specific QMP features, they asked
> for the VM to start, or to stop, or they asked for a backup, or a snapshot.
> 
> On my desktop, I am not really too interested in knowing if XFCE is
> using deprecated features of xorg or wayland. I didn't tell it to use
> them and I have no real power or control over that. It's nice if I'm a
> developer, but as a user, it's noise.
> 
> So a development log seems right for these, but not user-visible
> interruptions.

I agree, it's not the high-level operation the user requested that is
deprecated, but just the specific implementation libvirt uses to perform
the operation on a QEMU VM.

The expected response to a deprecation notice is that a libvirt update
makes it go away by using more modern interfaces, not that the user
changes their workflow.

Kevin


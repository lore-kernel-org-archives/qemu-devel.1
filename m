Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B848C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016E12053B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016E12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33597 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOIaj-0001lH-4r
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 05:10:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOIUV-0005WJ-OK
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOIUU-0007ls-Kf
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hOIUR-0007jB-CC; Wed, 08 May 2019 05:03:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B600F5277B;
	Wed,  8 May 2019 09:03:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DE9D60C6A;
	Wed,  8 May 2019 09:03:48 +0000 (UTC)
Date: Wed, 8 May 2019 10:03:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190508090345.GB32552@redhat.com>
References: <20190507183610.9848-1-mreitz@redhat.com>
	<20190507183610.9848-2-mreitz@redhat.com>
	<81dd6702-1d51-ca2e-1445-e8cdcfb14711@redhat.com>
	<f34fb38c-22dd-1ed3-821d-7c8a9ea8943a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f34fb38c-22dd-1ed3-821d-7c8a9ea8943a@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 08 May 2019 09:03:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/5] qemu-nbd: Add --pid-file option
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 09:39:01PM +0200, Max Reitz wrote:
> On 07.05.19 21:30, Eric Blake wrote:
> > On 5/7/19 1:36 PM, Max Reitz wrote:
> >> --fork is a bit boring if there is no way to get the child's PID.  This
> >> option helps.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  qemu-nbd.c    | 29 +++++++++++++++++++++++++++++
> >>  qemu-nbd.texi |  2 ++
> >>  2 files changed, 31 insertions(+)
> >>
> > 
> >> @@ -111,6 +112,7 @@ static void usage(const char *name)
> >>  "                            specify tracing options\n"
> >>  "  --fork                    fork off the server process and exit the parent\n"
> >>  "                            once the server is running\n"
> >> +"  --pid-file=PATH           store the server's process ID in the given file\n"
> > 
> > Should --pid-file imply --fork, or be an error if --fork was not
> > supplied? As coded, it writes a pid file regardless of --fork, even
> > though it is less obvious that it is useful in that case. I don't have a
> > strong preference (there doesn't seem to be a useful consensus on what
> > forking daemons should do), but it would at least be worth documenting
> > the intended action (even if that implies a tweak to the patch to match
> > the intent).
> 
> I think the documentation is pretty clear.  It stores the server's PID,
> whether it has been forked or not.
> 
> I don't think we would gain anything from forbidding --pid-file without
> --fork, would we?

Indeed, use of --pid-file should be independant of --fork, as a mgmt app
may have already forked it into the background, and merely want to get
the pidfile

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


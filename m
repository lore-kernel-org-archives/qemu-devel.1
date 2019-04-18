Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E6C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC552183E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC552183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39967 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH5RC-0002dJ-5Z
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 07:42:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hH5Hu-000466-6A
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hH5Ht-0006Zi-2W
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:33:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hH5Hq-0006Vq-H4; Thu, 18 Apr 2019 07:33:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79726306C9FF;
	Thu, 18 Apr 2019 11:32:56 +0000 (UTC)
Received: from redhat.com (ovpn-112-59.ams2.redhat.com [10.36.112.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9602B1001DC8;
	Thu, 18 Apr 2019 11:32:52 +0000 (UTC)
Date: Thu, 18 Apr 2019 12:32:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190418113249.GP13773@redhat.com>
References: <20190417115343.30527-1-pbonzini@redhat.com>
	<CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
	<cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
	<20190418104737.GC5242@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418104737.GC5242@linux.fritz.box>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 18 Apr 2019 11:32:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
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
Cc: qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-stable <qemu-stable@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418113249.-BswL_NFyWSul-7qg92jmMQ61tcbP9xBfC3-qsUBo5g@z>

On Thu, Apr 18, 2019 at 12:47:37PM +0200, Kevin Wolf wrote:
> Am 18.04.2019 um 11:48 hat Paolo Bonzini geschrieben:
> > On 17/04/19 14:30, Stefan Hajnoczi wrote:
> > > On Wed, Apr 17, 2019 at 12:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >> Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limit
> > >> is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
> > >> from exceeding these limits, by capping the maximum transfer length to
> > >> that value in the block limits VPD page.
> > >>
> > >> [1] Oh well, at least it was easier to follow the kernel source knowing
> > >>     it had to end as ENOMEM...
> > >>
> > >> Cc: qemu-stable@nongnu.org
> > >> Cc: qemu-block@nongnu.org
> > >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > >> ---
> > >>  hw/scsi/scsi-generic.c | 17 +++++++++++++----
> > >>  1 file changed, 13 insertions(+), 4 deletions(-)
> > > 
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > 
> > 
> > This is acually only an issue with kernels prior to 4.5, so it should be
> > fixed downstream instead.
> 
> I don't think that upstream QEMU has kernels > 4.5 as an official
> requirement, though? We try to be compatible with quite old libs, so we
> should stay compatible with old kernels, too.

We've not explicitly stated or checked a min kernel version, but our
min kernel is defined implicitly by our targetted build platforms:

  https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

The oldest Linux distro under those rules is RHEL-7 (3.10.0), since
Debian Jessie actually updates its kernel version so is already on
version 4.5


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


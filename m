Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF191C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937D022CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937D022CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5QVo-0003KP-0p
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 04:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i5QUi-0002Pu-IL
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i5QUg-0006w2-Ol
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:18:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i5QUd-0006ue-Lz; Wed, 04 Sep 2019 04:18:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06EF3308FED5;
 Wed,  4 Sep 2019 08:18:19 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3F4F5DA60;
 Wed,  4 Sep 2019 08:18:12 +0000 (UTC)
Date: Wed, 4 Sep 2019 09:18:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190904081809.GB19582@redhat.com>
References: <20190903145634.20237-1-eblake@redhat.com>
 <9bde61cf-b4a7-fb11-7b8d-12cf8a2dc558@redhat.com>
 <a49c5a8d-b77a-a2fe-fb02-673971ccd70b@redhat.com>
 <e7d1f571-9e0b-9fd0-5921-e182a2bc92ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7d1f571-9e0b-9fd0-5921-e182a2bc92ca@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 04 Sep 2019 08:18:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] docs: Update preferred NBD
 device syntax
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 libvirt-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 03:06:24PM -0400, John Snow wrote:
> 
> 
> On 9/3/19 3:02 PM, Eric Blake wrote:
> > [adding libvirt list]
> > 
> > On 9/3/19 1:50 PM, John Snow wrote:
> >>
> >>
> >> On 9/3/19 10:56 AM, Eric Blake wrote:
> >>> Mention the preferred URI form, especially since NBD is trying to
> >>> standardize that form: https://lists.debian.org/nbd/2019/06/msg00012.html
> >>>
> >>> Signed-off-by: Eric Blake <eblake@redhat.com>
> >>> ---
> >>>  qemu-doc.texi | 16 +++++++++++-----
> >>>  1 file changed, 11 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/qemu-doc.texi b/qemu-doc.texi
> >>> index 577d1e837640..c83fb347d77e 100644
> >>> --- a/qemu-doc.texi
> >>> +++ b/qemu-doc.texi
> >>> @@ -297,7 +297,14 @@ qemu-system-i386 -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
> >>>
> >>>  @item NBD
> >>>  QEMU supports NBD (Network Block Devices) both using TCP protocol as well
> >>> -as Unix Domain Sockets.
> >>> +as Unix Domain Sockets.  With TCP, the default port is 10809.
> >>>
> >>> -Syntax for specifying a NBD device using TCP
> >>> +Syntax for specifying a NBD device using TCP, in preferred URI form:
> >>> +``nbd://<server-ip>[:<port>]/[<export>]''
> >>> +
> >>> +Syntax for specifying a NBD device using Unix Domain Sockets; remember
> >>> +that '?' is a shell glob character and may need quoting:
> >>> +``nbd+unix:///[<export>]?socket=<domain-socket>''
> >>> +
> >>> +Older syntax that is also recognized:
> >>
> >> Deprecated officially, or no?
> >>
> >>>  ``nbd:<server-ip>:<port>[:exportname=<export>]''
> >>>
> >>> -Syntax for specifying a NBD device using Unix Domain Sockets
> >>>  ``nbd:unix:<domain-socket>[:exportname=<export>]''
> > 
> > I didn't feel like starting a deprecation clock, in part because libvirt
> > is still using nbd:host:port:exportname during migration, similarly code
> > in virstoragefile.c is using only the old form.  Do we want to start a
> > deprecation (as a separate patch), to prod faster changes in libvirt in
> > switching to the newer form where sensible?
> > 
> 
> Yeah, understood -- I was merely curious for wording purposes. Some
> people might wonder what "Older syntax" means and perhaps why they
> shouldn't use it. It sounds like we do want to wander away from it
> eventually but aren't prepared to do that yet.
> 
> I think largely such a deprecation clock is up to the workload of
> whoever would have to update the libvirt workflow (You, Peter?) and how
> much benefit we'd gain by dropping it in QEMU (little?)

In general libvirt should never use the psuedo-URI/URI syntax for
anything. We're moving towards use of blockdev, so will have the
dot separated key syntax on the cli and equiv in QMP.

I hope this means we'll stop using the URIs in migration, but will
defer to peter for specifics.

I always think it is a shame that QEMU has done so much work on
blockdev, but all QEMU's docs still largely use the many legacy
syntaxes. IOW, we should make these NBD examples use the modern
non-URI syntax too.

> If you don't have motivation for doing it unprompted I have little
> reason to coerce you into it.
> 
> >>>
> >>>  Example for TCP
> >>>  @example
> >>> -qemu-system-i386 --drive file=nbd:192.0.2.1:30000
> >>> +qemu-system-i386 --drive file=nbd://192.0.2.1:30000
> >>>  @end example
> >>>
> >>>  Example for Unix Domain Sockets
> >>>  @example
> >>> -qemu-system-i386 --drive file=nbd:unix:/tmp/nbd-socket
> >>> +qemu-system-i386 --drive "file=nbd+unix:///?socket=/tmp/nbd-socket"
> >>>  @end example
> >>>
> >>>  @item SSH
> >>>
> >>
> >> Reviewed-by: John Snow <jsnow@redhat.com>
> > 
> > Thanks; will queue through my NBD tree (regardless of whether we decide
> > I should add more patches to start a deprecation cycle).
> > 
> 
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


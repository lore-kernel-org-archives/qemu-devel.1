Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EC9C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B983E218D4
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B983E218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2G3-00070t-JV
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43225)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rjones@redhat.com>) id 1hr2Fs-0006XG-7l
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1hr2Fq-0004gd-VF
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>)
 id 1hr2Fo-0004VZ-Dw; Fri, 26 Jul 2019 11:35:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3BAC783F3C;
 Fri, 26 Jul 2019 15:35:29 +0000 (UTC)
Received: from localhost (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC5EC6092D;
 Fri, 26 Jul 2019 15:35:28 +0000 (UTC)
Date: Fri, 26 Jul 2019 16:35:27 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190726153527.GD3888@redhat.com>
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726142710.GY3888@redhat.com>
 <4422965.dTeGc4fl6G@lindworm.usersys.redhat.com>
 <94a702f6-10a3-4705-4ec4-496a1b5b0515@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94a702f6-10a3-4705-4ec4-496a1b5b0515@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 26 Jul 2019 15:35:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] ssh: add password and privkey auth
 methods
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, Pino Toscano <ptoscano@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 10:06:43AM -0500, Eric Blake wrote:
> On 7/26/19 9:45 AM, Pino Toscano wrote:
> > On Friday, 26 July 2019 16:27:11 CEST Richard W.M. Jones wrote:
> >> On Fri, Jul 26, 2019 at 04:09:52PM +0200, Pino Toscano wrote:
> >>> These two patches add the password and private key authentication
> >>> methods to the ssh block driver, using secure objects for
> >>> passwords/passphrases.
> >>
> >> I was attempting to test this but couldn't work out the full command
> >> line to use it (with qemu-img).  I got as far as:
> >>
> >> $ ./qemu-img convert -p 'json:{ "file.driver": "ssh", "file.host": "devr7", "file.path": "/var/tmp/root", "file.password-secret": "..." }' /var/tmp/root
> >>
> >> I guess the secret should be specified using --object, but at that
> >> point I gave up.
> > 
> > Almost there :) add e.g.
> >   --object 'secret,id=sec0,file=passwd'
> > as parameter for the convert command (so after it, not before), and then
> > set 'sec0' as value for file.password-secret.  Of course 'sec0' is
> > arbitrary, any other QEMU id will do.
> > 
> > A long helpful comment in include/crypto/secret.h explains the basics
> > of the crypto objects.
> 
> That is useful information, but even more useful if you amend the commit
> message to include a working example command line rather than making
> readers chase down the docs :)
> 
> Untested, but piecing together what I know from my work on qemu-nbd
> encryption, it seems like this should be a starting point for such a
> command:
> 
> qemu-img convert -p --imageopts --object secret,id=sec0,file=passwd \
>   driver=ssh,host=devr7,path=/var/tmp/root,password-secret=sec0 \
>   /var/tmp/copy

--imageopts isn't necessary.  This was the command that worked for me:

unset SSH_AUTH_SOCK; ./qemu-img convert -p --object 'secret,id=sec0,file=/tmp/passwd' 'json:{ "file.driver": "ssh", "file.host": "devr7", "file.path": "/var/tmp/root", "file.password-secret": "sec0" }' /var/tmp/root

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top


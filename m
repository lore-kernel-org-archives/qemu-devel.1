Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DD9C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC442083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC442083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqej-0002DZ-FT
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hgqIG-0001Nw-Nm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hgqIE-0002sG-IW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:47:56 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:60977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hgqIC-0002oh-UJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:47:54 -0400
Received: from player714.ha.ovh.net (unknown [10.109.160.217])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id A8B1F10DF41
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 14:47:50 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id B8B6474B654B;
 Fri, 28 Jun 2019 12:47:46 +0000 (UTC)
Date: Fri, 28 Jun 2019 14:47:45 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190628144745.083023c9@bahia.lan>
In-Reply-To: <11832960.ASyAv1XfID@silver>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <26b626706b5fa0c492413a3279512c17952be5de.1561575449.git.qemu_oss@crudebyte.com>
 <20190627192622.6f49dc0a@bahia.lan> <11832960.ASyAv1XfID@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 897905176902474048
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddtgdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.93
Subject: Re: [Qemu-devel] [PATCH v4 2/5] 9p: Treat multiple devices on one
 export as an error
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Jun 2019 14:36:41 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 27. Juni 2019 19:26:22 CEST Greg Kurz wrote:
> > On Wed, 26 Jun 2019 20:30:41 +0200
> > 
> > Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:
> > > The QID path should uniquely identify a file. However, the
> > > inode of a file is currently used as the QID path, which
> > > on its own only uniquely identifies wiles within a device.
> > 
> > s/wile/files
> 
> Ah right. :)
> 
> > > Here we track the device hosting the 9pfs share, in order
> > > to prevent security issues with QID path collisions from
> > > other devices.
> > > 
> > > Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
> > 
> > You should mention here the changes you made to the original patch.
> 
> Got it. Will do for the other cases as well of course.
> 

Cool.

> > > -static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
> > > +static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID
> > > *qidp)> 
> > >  {
> > >  
> > >      size_t size;
> > > 
> > > +    if (pdu->s->dev_id == 0) {
> > > +        pdu->s->dev_id = stbuf->st_dev;
> > 
> > st_dev should be captured in v9fs_device_realize_common() since we
> > lstat() the root there, instead of every request doing the check.
> 
> Ok.
> 
> > > +    } else if (pdu->s->dev_id != stbuf->st_dev) {
> > > +        error_report_once(
> > > +            "9p: Multiple devices detected in same VirtFS export. "
> > > +            "You must use a separate export for each device."
> > > +        );
> > > +        return -ENOSYS;
> > 
> > This error is likely to end up as the return value of a
> > syscall in the guest and -ENOSYS usually means the syscall
> > isn't implemented, which is obviously not the case. Maybe
> > return -EPERM instead ?
> 
> I would rather suggest -ENODEV. The entire device of the requested file/dir is 
> not available on guest.
> 
> -EPERM IMO rather motivates users looking for file system permission settings 
> on individual files intead, and probably not checking the host's logs for the 
> detailled error message.
> 

-ENODEV is ok with me then.

> > > @@ -3633,6 +3674,8 @@ int v9fs_device_realize_common(V9fsState *s, const
> > > V9fsTransport *t,> 
> > >          goto out;
> > >      
> > >      }
> > > 
> > > +    s->dev_id = 0;
> > > +
> > 
> > Set it to stat->st_dev after lstat() was called later in this function.
> 
> I guesst you mean "earlier" not "later". The lstat() call is just before that 
> dev_id initalization line. But in general your suggestion makes sense of 
> course.
> 

Oops... "earlier" indeed :)

> Best regards,
> Christian Schoenebeck



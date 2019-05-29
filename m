Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6181C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 22:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFB62426E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 22:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFB62426E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW6p4-0007V0-Ok
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 18:13:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hW6mP-0005Tn-50
	for qemu-devel@nongnu.org; Wed, 29 May 2019 18:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hW6mO-0000vJ-8H
	for qemu-devel@nongnu.org; Wed, 29 May 2019 18:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hW6mO-0000v4-2k
	for qemu-devel@nongnu.org; Wed, 29 May 2019 18:10:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F92F307D849;
	Wed, 29 May 2019 22:10:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 246185D9E1;
	Wed, 29 May 2019 22:10:31 +0000 (UTC)
Date: Thu, 30 May 2019 00:10:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190529221030.GD3471@localhost.localdomain>
References: <20190524183638.20745-1-stefanha@redhat.com>
	<24b93cc5-edb1-a197-14be-e63ac356325d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b93cc5-edb1-a197-14be-e63ac356325d@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 29 May 2019 22:10:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v3 0/3] scsi: restart dma after vm change
 state handlers
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.05.2019 um 20:47 hat Paolo Bonzini geschrieben:
> On 24/05/19 20:36, Stefan Hajnoczi wrote:
> > v3:
> >  * Fix s/k->vmstate_change/vdc->vmstate_change/
> >  * Still RFC, waiting for customer to confirm this fixes the issue
> > v2:
> >  * Do it properly with a clean API instead of deferring to a BH!
> >    Thanks for encouraging me to do this, Kevin.
> > 
> > These patches solve a deadlock when the 'cont' command is used and there are
> > failed requests on a virtio-scsi device with iothreads.  The deadlock itself is
> > actually not the thing we need to fix because we should never reach that case
> > anyway.  Instead we need to make sure DMA restart is only performed after the
> > virtio-scsi iothread is re-initialized.
> 
> custom_dma_restart is a bit ugly...  Do you think it would make sense to
> order the VMStateChange handlers using some kind of enum (with the order
> unspecified within the category)?
> 
> We could start with
> 
> 	VMSTATECHANGE_PRIO_UNKNOWN  = 0  (if needed?)
> 	VMSTATECHANGE_PRIO_IOTHREAD = 100
>         VMSTATECHANGE_PRIO_DEVICE   = 200
> 
> where higher priorities run first on stop and last on resume.

I don't think this is as nice because stopping or resuming a device
could involve some async operation (e.g. be delegated to a BH). In this
case, a device on a child bus must still wait for the BH (or other async
part) to be completed before it can resume its own operation.

Basically, a single flat list of global VM state handlers wasn't a good
design, because what we actually need in such cases is something
hierarchical.

Kevin


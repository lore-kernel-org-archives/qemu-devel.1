Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594D8C31E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374C6208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374C6208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50770 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcw3y-00080P-HU
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52518)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hcvu8-0006at-An
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hcvu7-0004KE-AL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:58:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hcvu5-0004FK-9Z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:58:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B078B80B49;
 Mon, 17 Jun 2019 17:58:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-99.ams2.redhat.com [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE54458C95;
 Mon, 17 Jun 2019 17:58:41 +0000 (UTC)
Date: Mon, 17 Jun 2019 19:58:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190617175840.GO7397@linux.fritz.box>
References: <20190612120421.20336-1-stefanha@redhat.com>
 <20190617122922.GG7397@linux.fritz.box>
 <25ad60d8-8860-b535-a42b-03d4d63d0802@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ad60d8-8860-b535-a42b-03d4d63d0802@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 17 Jun 2019 17:58:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] virtio-scsi: restart DMA after iothread
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.06.2019 um 19:23 hat Paolo Bonzini geschrieben:
> On 17/06/19 14:29, Kevin Wolf wrote:
> > But in the end, if Paolo feels strongly that for whatever reason
> > propagating events through the real device tree isn't good, let's get
> > the bug fixed with whatever hack it takes.
> 
> It is actually good, but the implementation in hw/scsi is ugly because
> it singles out virtio-scsi - whereas the rule should simply be that the
> HBA is stopped after the disks and started before.  Having the HBA do
> something special if it cares about the order is the part that I didn't
> like.

The alternative would be to add a VM state change handler to all other
HBAs, too, so that scsi-bus never has to register its own handler. I
don't think we have that many HBAs, so maybe it's actually workable.

Of course, this makes me think that maybe for the actual proper
solution, VM state change handlers should really be a feature that qdev
provides for devices. Then if a HBA doesn't have anything else to do,
the qdev core would just recurse into the children right away; if it has
something to do, it would disable the device after its children, and
re-enable it before the children.

However, I'm afraid we're talking about a major feature then and not
about a simple fix any more. :-(

Kevin


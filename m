Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6554CC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2D6216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2D6216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51721 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT30B-0002zE-5R
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:32:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hT2zJ-0002iJ-HC
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hT2zI-0001jR-Lm
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:31:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hT2zI-0001dv-Ga
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:31:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A50AF30842A8;
	Tue, 21 May 2019 11:31:09 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-63.ams2.redhat.com [10.36.117.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 69A79600CC;
	Tue, 21 May 2019 11:31:06 +0000 (UTC)
Date: Tue, 21 May 2019 13:30:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190521113059.GB4971@linux.fritz.box>
References: <20190521103650.18479-1-stefanha@redhat.com>
	<0630a607-9216-6b75-54fa-0a1308f2eff0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0630a607-9216-6b75-54fa-0a1308f2eff0@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 21 May 2019 11:31:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] scsi: restart dma after vm change state
 handlers
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
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.05.2019 um 13:04 hat Paolo Bonzini geschrieben:
> On 21/05/19 12:36, Stefan Hajnoczi wrote:
> > This is RFC because I am waiting for a test result on the system where
> > the bug was originally discovered.  I'm also open to nicer solutions!
> 
> I don't think it's too ugly; IDE is also using a bottom half for this.

I think the IDE case is different, see commit 213189ab65d. The case
we're protecting against there is stopping the VM from inside a VM state
handler, which can confuse other VM state callbacks that come later. The
actual order of the IDE callback vs. the other callback doesn't matter,
it's just important that all start callbacks are completed before stop
callbacks are called.

In our current case, the problem is not that we're confusing other
handlers, but that we rely on another handler to have completed resuming
something. If that other handler changes e.g. to use a BH itself, we get
an undefined order again.

The clean solution would probably be not to use a VM state handler in
scsi-bus, but a callback from the HBA that tells the bus that the HBA is
ready to receive requests again.

If we go with the not so clean solution, maybe at least a comment in
virtio-scsi would be in order.

Kevin


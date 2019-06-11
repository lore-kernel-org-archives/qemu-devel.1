Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E11FC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7026320657
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7026320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52966 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hacXP-0004LO-K8
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 04:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hacUp-0002oM-88
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hacUm-0005Mw-NE
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:51:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hacUY-0004vp-6J; Tue, 11 Jun 2019 04:50:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9CF98553B;
 Tue, 11 Jun 2019 08:50:24 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A76A1972C;
 Tue, 11 Jun 2019 08:50:22 +0000 (UTC)
Message-ID: <70eecc1c95485798c6fe1dfdbd1d091254de885b.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org
Date: Tue, 11 Jun 2019 11:50:21 +0300
In-Reply-To: <449e8bb0-8936-bcdc-9142-c2730ac24f4e@redhat.com>
References: <20190417195355.16123-1-mlevitsk@redhat.com>
 <20190417195355.16123-2-mlevitsk@redhat.com>
 <d1ab2f6e-a5b1-466b-7ad9-df47b8739579@redhat.com>
 <7b9baac9a0b652105cebb681e9759cb4e9d3877b.camel@redhat.com>
 <601a2a78-0ddb-ccc9-f3c2-46aa16e18629@redhat.com>
 <dfd777d8-1241-7361-193d-02442a0d79ab@redhat.com>
 <449e8bb0-8936-bcdc-9142-c2730ac24f4e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 11 Jun 2019 08:50:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/5] block/nvme: don't flip
 CQ phase bits
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-06-07 at 15:28 -0400, John Snow wrote:
> 
> On 6/7/19 7:08 AM, Paolo Bonzini wrote:
> > On 06/06/19 23:23, John Snow wrote:
> > > So: This looks right; does this fix a bug that can be observed? Do we
> > > have any regression tests for block/NVMe?
> > 
> > I don't think it fixes a bug; by the time the CQ entry is picked up by
> > QEMU, the device is not supposed to touch it anymore.
> > 
> > However, the idea behind the phase bits is that you can decide whether
> > the driver has placed a completion in the queue.  When we get here, we have
> > 
> > 	le16_to_cpu(c->status) & 0x1) == !q->cq_phase
> > 
> > On the next pass through the ring buffer q->cq_phase will be flipped,
> > and thus when we see this element we'll get
> > 
> > 	le16_to_cpu(c->status) & 0x1) == q->cq_phase
> > 
> > and not process it.  Since block/nvme.c flips the bit, this mechanism
> > does not work and the loop termination relies on the other part of the
> > condition, "if (!c->cid) break;".
> > 
> > So the patch is correct, but it would also be nice to also either remove
> > phase handling altogether, or check that the phase handling works
> > properly and drop the !c->cid test.
> > 
> > Paolo


I agree with that and I'll send an updated patch soon.

The driver should not touch the completion entries at all, but rather just scan for the entries whose
phase bit was flipped by the hardware.

in fact I don't even think that the 'c->cid' became the exit condition, but rather since the device is not allowed 
to fully fill the compleiton queue (it must alway keep at least one free entry there), the end condition would still
be the check on the flipped phase bit.


I'll fix that to be up to the spec,

Best regards,
	Maxim Levitskky



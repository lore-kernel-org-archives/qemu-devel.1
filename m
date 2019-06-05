Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB65C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1571A206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1571A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYQfl-00078c-1M
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 03:49:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hYQeJ-0006U6-Bt
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hYQeI-00050F-Dn
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
	id 1hYQeF-0004co-F3; Wed, 05 Jun 2019 03:47:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E108308FEE2;
	Wed,  5 Jun 2019 07:47:28 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB4F65C224;
	Wed,  5 Jun 2019 07:47:24 +0000 (UTC)
Message-ID: <7b9baac9a0b652105cebb681e9759cb4e9d3877b.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Date: Wed, 05 Jun 2019 10:47:23 +0300
In-Reply-To: <d1ab2f6e-a5b1-466b-7ad9-df47b8739579@redhat.com>
References: <20190417195355.16123-1-mlevitsk@redhat.com>
	<20190417195355.16123-2-mlevitsk@redhat.com>
	<d1ab2f6e-a5b1-466b-7ad9-df47b8739579@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 05 Jun 2019 07:47:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/5] block/nvme: don't flip
 CQ phase bits
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-06-03 at 18:25 -0400, John Snow wrote:
> 
> On 4/17/19 3:53 PM, Maxim Levitsky wrote:
> > Phase bits are only set by the hardware to indicate new completions
> > and not by the device driver.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/nvme.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/block/nvme.c b/block/nvme.c
> > index 0684bbd077..2d208000df 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -340,8 +340,6 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
> >          qemu_mutex_lock(&q->lock);
> >          c->cid = cpu_to_le16(0);
> >          q->inflight--;
> > -        /* Flip Phase Tag bit. */
> > -        c->status = cpu_to_le16(le16_to_cpu(c->status) ^ 0x1);
> >          progress = true;
> >      }
> >      if (progress) {
> > 
> 
> Since you've not got much traction on this and you've pinged a v2, can
> you point me to a spec or a reproducer that illustrates the problem?
> 
> (Or wait for more NVME knowledgeable people to give you a review...!)

"A Completion Queue entry is posted to the Completion Queue when the controller write of that Completion
Queue entry to the next free Completion Queue slot inverts the Phase Tag (P) bit from its previous value
in memory. The controller may generate an interrupt to the host to indicate that one or more Completion
Queue entries have been posted."



Best regards,
	Maxim Levitsky



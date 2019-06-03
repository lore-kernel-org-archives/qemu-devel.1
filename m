Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1642CC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 11:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD60328136
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 11:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD60328136
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33349 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXl6S-0005Wa-2T
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 07:26:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXl2v-0002jQ-9T
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXkux-0002CJ-F1
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:14:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXkut-00023F-Mt; Mon, 03 Jun 2019 07:14:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47060307D86F;
	Mon,  3 Jun 2019 11:14:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-129.ams2.redhat.com [10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B0D771018A0D;
	Mon,  3 Jun 2019 11:14:10 +0000 (UTC)
Date: Mon, 3 Jun 2019 13:14:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Kenneth Heitke <kenneth.heitke@intel.com>, mreitz@redhat.com,
	keith.busch@intel.com, qemu-block@nongnu.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Message-ID: <20190603111409.GD6523@linux.fritz.box>
References: <20190520174030.1647-1-kenneth.heitke@intel.com>
	<20190528061836.GB32236@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528061836.GB32236@apples.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 03 Jun 2019 11:14:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] nvme: add Get/Set Feature Timestamp
 support
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.05.2019 um 08:18 hat Klaus Birkelund geschrieben:
> On Mon, May 20, 2019 at 11:40:30AM -0600, Kenneth Heitke wrote:
> > Signed-off-by: Kenneth Heitke <kenneth.heitke@intel.com>

> > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > index 56c9d4b4b1..d7277e72b7 100644
> > --- a/hw/block/nvme.h
> > +++ b/hw/block/nvme.h
> > @@ -69,6 +69,7 @@ typedef struct NvmeCtrl {
> >      uint16_t    max_prp_ents;
> >      uint16_t    cqe_size;
> >      uint16_t    sqe_size;
> > +    uint16_t    oncs;
> 
> Looks like this unused member snuck its way into the patch. But I see no
> harm in it being there.

Good catch. I'll just remove it again from my branch.

> > +static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
> > +{
> > +    trace_nvme_setfeat_timestamp(ts);
> > +
> > +    n->host_timestamp = le64_to_cpu(ts);
> > +    n->timestamp_set_qemu_clock_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > +}
> > +
> > +static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
> > +{
> > +    uint64_t current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);

Here I wonder why we use QEMU_CLOCK_REALTIME in a device emulation.
Wouldn't QEMU_CLOCK_VIRTUAL make more sense?

Kevin


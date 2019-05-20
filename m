Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3176C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC9020675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC9020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60917 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSewc-0005Oe-TQ
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 05:50:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSevU-0004iz-Pj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSevT-0008FQ-On
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:49:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSevR-0008DW-95; Mon, 20 May 2019 05:49:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 892373091761;
	Mon, 20 May 2019 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 44F7B608E4;
	Mon, 20 May 2019 09:49:42 +0000 (UTC)
Date: Mon, 20 May 2019 11:49:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <20190520094941.GB5699@localhost.localdomain>
References: <20190405214117.1850-1-kenneth.heitke@intel.com>
	<20190514060225.GA1350@apples.localdomain>
	<1f607df5-b523-e517-c439-392725fd441b@intel.com>
	<20190517053504.GA17341@apples.localdomain>
	<20190517062442.GB17341@apples.localdomain>
	<78248b8b-2684-409a-1e33-77b4c0907cd6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78248b8b-2684-409a-1e33-77b4c0907cd6@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 20 May 2019 09:49:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nvme: add Get/Set Feature
 Timestamp support
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
Cc: keith.busch@intel.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.05.2019 um 03:49 hat Heitke, Kenneth geschrieben:
> 
> 
> On 5/17/2019 12:24 AM, Klaus Birkelund wrote:
> > On Fri, May 17, 2019 at 07:35:04AM +0200, Klaus Birkelund wrote:
> > > Hi Kenneth,
> > > 
> > > On Thu, May 16, 2019 at 05:24:47PM -0600, Heitke, Kenneth wrote:
> > > > Hi Klaus, thank you for you review. I have one comment inline
> > > > 
> > > > On 5/14/2019 12:02 AM, Klaus Birkelund wrote:
> > > > > On Fri, Apr 05, 2019 at 03:41:17PM -0600, Kenneth Heitke wrote:
> > > > > > Signed-off-by: Kenneth Heitke <kenneth.heitke@intel.com>
> > > > > > ---
> > > > > >    hw/block/nvme.c       | 120 +++++++++++++++++++++++++++++++++++++++++-
> > > > > >    hw/block/nvme.h       |   3 ++
> > > > > >    hw/block/trace-events |   2 +
> > > > > >    include/block/nvme.h  |   2 +
> > > > > >    4 files changed, 125 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > > > > index 7caf92532a..e775e89299 100644
> > > > > > --- a/hw/block/nvme.c
> > > > > > +++ b/hw/block/nvme.c
> > > > > > @@ -219,6 +219,30 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
> > > > > >        return NVME_INVALID_FIELD | NVME_DNR;
> > > > > >    }
> > > > > > +static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > > > > > +                                   uint64_t prp1, uint64_t prp2)
> > > > > > +{
> > > > > > +    QEMUSGList qsg;
> > > > > > +    QEMUIOVector iov;
> > > > > > +    uint16_t status = NVME_SUCCESS;
> > > > > > +
> > > > > > +    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> > > > > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > > > > +    }
> > > > > > +    if (qsg.nsg > 0) {
> > > > > > +        if (dma_buf_write(ptr, len, &qsg)) {
> > > > > > +            status = NVME_INVALID_FIELD | NVME_DNR;
> > > > > > +        }
> > > > > > +        qemu_sglist_destroy(&qsg);
> > > > > > +    } else {
> > > > > > +        if (qemu_iovec_from_buf(&iov, 0, ptr, len) != len) {
> > > > > 
> > > > > This should be `qemu_iovec_to_buf`.
> > > > > 
> > > > 
> > > > This function is transferring data from the "host" to the device so I
> > > > believe I am using the correct function.
> > > > 
> > > 
> > > Exactly, but this means that you need to populate `ptr` with data
> > > described by the prps, hence dma_buf_*write* and qemu_iovec_*to*_buf. In
> > > this case `ptr` is set to the address of the uint64_t timestamp, and
> > > that is what we need to write to.
> > > 
> > 
> > I was going to argue with the fact that nvme_dma_read_prp uses
> > qemu_iovec_from_buf. But it uses _to_buf which as far as I can tell is
> > also wrong.
> > 
> 
> Okay, I'm onboard. You're correct. I'll update my patch and re-submit. I can
> also submit a patch to fix nvme_dma_read_prp() unless you or someone else
> wants to.

Maybe it would be time to extend tests/nvme-test.c a bit? So far it only
tests an error case, but it would be good to have tests for successful
use of the basic operations.

Kevin


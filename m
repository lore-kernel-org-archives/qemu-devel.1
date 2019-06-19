Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610F1C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2484D2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2484D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdYF3-000762-AC
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33500)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hdYCY-0006LN-1o
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hdYCV-0005zl-SW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:52:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hdY7b-0000gV-Ex; Wed, 19 Jun 2019 06:47:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72A5D30860A9;
 Wed, 19 Jun 2019 10:47:12 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9B0060A9A;
 Wed, 19 Jun 2019 10:47:03 +0000 (UTC)
Message-ID: <f24926a73f00be2f1d7de2c8b09680a98c595fd5.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 19 Jun 2019 13:47:01 +0300
In-Reply-To: <20190619101414.GA13569@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-5-mehta.aaru20@gmail.com>
 <81e4ab9b07d5678a3a28e1314c07ee0224e4d9ed.camel@redhat.com>
 <20190619101414.GA13569@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 19 Jun 2019 10:47:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 04/12] block/io_uring: implements
 interfaces for io_uring
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
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-06-19 at 11:14 +0100, Stefan Hajnoczi wrote:
> On Mon, Jun 17, 2019 at 03:26:50PM +0300, Maxim Levitsky wrote:
> > On Mon, 2019-06-10 at 19:18 +0530, Aarushi Mehta wrote:
> > > +        if (!cqes) {
> > > +            break;
> > > +        }
> > > +        LuringAIOCB *luringcb = io_uring_cqe_get_data(cqes);
> > > +        ret = cqes->res;
> > > +
> > > +        if (ret == luringcb->qiov->size) {
> > > +            ret = 0;
> > > +        } else if (ret >= 0) {
> > 
> > 
> > You should very carefully check the allowed return values here.
> > 
> > It looks like you can get '-EINTR' here, which would ask you to rerun the read operation, and otherwise
> > you will get the number of bytes read, which might be less that what was asked for, which implies that you
> > need to retry the read operation with the remainder of the buffer rather that zero the end of the buffer IMHO 
> > 
> > (0 is returned on EOF according to 'read' semantics, which I think are used here, thus a short read might not be an EOF)
> > 
> > 
> > Looking at linux-aio.c though I do see that it just passes through the returned value with no special treatments. 
> > including lack of check for -EINTR.
> > 
> > I assume that since aio is linux specific, and it only supports direct IO, it happens
> > to have assumption of no short reads/-EINTR (but since libaio has very sparse documentation I can't verify this)
> > 
> > On the other hand the aio=threads implementation actually does everything as specified on the 'write' manpage,
> > retrying the reads on -EINTR, and doing additional reads if less that required number of bytes were read.
> > 
> > Looking at io_uring implementation in the kernel I see that it does support synchronous (non O_DIRECT mode), 
> > and in this case, it goes through the same ->read_iter which is pretty much the same path that 
> > regular read() takes and so it might return short reads and or -EINTR.
> 
> Interesting point.  Investigating EINTR should at least be a TODO
> comment and needs to be resolved before io_uring lands in a QEMU
> release.
> 
> > > +static int ioq_submit(LuringState *s)
> > > +{
> > > +    int ret = 0;
> > > +    LuringAIOCB *luringcb, *luringcb_next;
> > > +
> > > +    while (s->io_q.in_queue > 0) {
> > > +        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.sq_overflow, next,
> > > +                              luringcb_next) {
> > 
> > I am torn about the 'sq_overflow' name. it seems to me that its not immediately clear that these
> > are the requests that are waiting because the io uring got full, but I can't now think of a better name.
> > 
> > Maybe add a comment here to explain what is going on here?
> 
> Hmm...I suggested this name because I thought it was clear.  But the
> fact that it puzzled you proves it wasn't clear :-).
> 
> Can anyone think of a better name?  It's the queue we keep in QEMU to
> hold requests while the io_uring sq ring is full.
> 
> > Also maybe we could somehow utilize the plug/unplug facility to avoid reaching that state in first place?
> > Maybe the block layer has some kind of 'max outstanding requests' limit that could be used?
> > 
> > In my nvme-mdev I opted to not process the input queues when such a condition is detected, but here you can't as the block layer
> > pretty much calls you to process the requests.
> 
> Block layer callers are allowed to submit as many I/O requests as they
> like and there is no feedback mechanism.  It's up to linux-aio.c and
> io_uring.c to handle the case where host kernel I/O submission resources
> are exhausted.
> 
> Plug/unplug is a batching performance optimization to reduce the number
> of io_uring_enter() calls but it does not stop the callers from
> submitting more I/O requests.  So plug/unplug isn't directly applicable
> here.

Thanks for the explanation! I guess we can leave that name as is, but add some comment or so
in the place where the queue is accessed.



> 
> > > +static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
> > > +                            uint64_t offset, int type)
> > > +{
> > > +    struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
> > > +    if (!sqes) {
> > > +        sqes = &luringcb->sqeq;
> > > +        QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
> > > +    }
> > > +
> > > +    switch (type) {
> > > +    case QEMU_AIO_WRITE:
> > > +        io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
> > > +                             luringcb->qiov->niov, offset);
> > > +        break;
> > > +    case QEMU_AIO_READ:
> > > +        io_uring_prep_readv(sqes, fd, luringcb->qiov->iov,
> > > +                            luringcb->qiov->niov, offset);
> > > +        break;
> > > +    case QEMU_AIO_FLUSH:
> > > +        io_uring_prep_fsync(sqes, fd, 0);
> > > +        break;
> > > +    default:
> > > +        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
> > > +                        __func__, type);
> > 
> > Nitpick: Don't we use some king of error printing functions like 'error_setg' rather that fprintf?
> 
> Here we're not in a context where an Error object can be returned (e.g.
> printed by the QMP monitor).  We only have an errno return value that
> the emulated storage controller may squash down further to a single
> EIO-type error code.
> 
> 'type' is a QEMU-internal value so the default case is basically
> assert(false); /* we should never get here */
> 
> For these reasons the fprintf() seems okay here.
All right then.

> 
> > I plan on this or next week to do some benchmarks of the code and I will share the results as soon
> > as I do them.
> 
> Excellent, Aarushi has been benchmarking too.  Perhaps you can share the
> QEMU command-line and fio configuration so that the results can be
> compared.

I'll do that soon. I already did some initial benchmarks (didn't save the results yet), and in the current state the io_uring is a bit, tiny bit slower
that libaio, which is nothing wrong because io_uring has lot of benefits in addition to performance, plus the current code can be optimized futher.

I'll post all the benchmarks I am doing once again now, as soon as I have them.

Best regards,
	Maxim Levitsky



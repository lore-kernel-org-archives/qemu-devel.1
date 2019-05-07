Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F355C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 07:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A9C21019
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 07:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A9C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNud2-0001Nq-6H
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 03:35:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNuc4-00013c-V6
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNuc3-0004Sr-Nv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:34:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hNuc2-0004Ry-TM; Tue, 07 May 2019 03:34:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2556A356CF;
	Tue,  7 May 2019 07:34:05 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE2CC4C47E;
	Tue,  7 May 2019 07:34:03 +0000 (UTC)
Date: Tue, 7 May 2019 09:34:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Message-ID: <20190507093401.56205f1d.cohuck@redhat.com>
In-Reply-To: <0688a42a-4a7d-8aa4-7993-994c8f46193b@linux.ibm.com>
References: <20190506171730.17556-1-cohuck@redhat.com>
	<0688a42a-4a7d-8aa4-7993-994c8f46193b@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 07 May 2019 07:34:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC] s390/css: handle CCW_FLAG_SKIP
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 May 2019 16:58:03 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/6/19 1:17 PM, Cornelia Huck wrote:
> > If a ccw has CCW_FLAG_SKIP set, and the command is of type
> > read, read backwards, or sense, no data should be written
> > to the guest for that command.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > Only extremely lightly tested (i.e., can boot a guest.)
> > 
> > ---
> >   hw/s390x/css.c         | 22 ++++++++++++++++++----
> >   include/hw/s390x/css.h |  1 +
> >   2 files changed, 19 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index 8fc9e35ba5d3..6ee31cc2e08f 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -830,8 +830,12 @@ static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
> >       if (op == CDS_OP_A) {
> >           goto incr;
> >       }
> > -    ret = address_space_rw(&address_space_memory, cds->cda,
> > -                           MEMTXATTRS_UNSPECIFIED, buff, len, op);
> > +    if (!cds->do_skip) {
> > +        ret = address_space_rw(&address_space_memory, cds->cda,
> > +                               MEMTXATTRS_UNSPECIFIED, buff, len, op);
> > +    } else {
> > +        ret = 0;
> > +    }
> >       if (ret != MEMTX_OK) {
> >           cds->flags |= CDS_F_STREAM_BROKEN;
> >           return -EINVAL;
> > @@ -928,8 +932,13 @@ static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,
> >       do {
> >           iter_len = MIN(len, cont_left);
> >           if (op != CDS_OP_A) {
> > -            ret = address_space_rw(&address_space_memory, cds->cda,
> > -                                   MEMTXATTRS_UNSPECIFIED, buff, iter_len, op);
> > +            if (!cds->do_skip) {
> > +                ret = address_space_rw(&address_space_memory, cds->cda,
> > +                                       MEMTXATTRS_UNSPECIFIED, buff, iter_len,
> > +                                       op);
> > +            } else {
> > +                ret = 0;
> > +            }
> >               if (ret != MEMTX_OK) {
> >                   /* assume inaccessible address */
> >                   ret = -EINVAL; /* channel program check */
> > @@ -968,6 +977,11 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
> >   
> >       cds->count = ccw->count;
> >       cds->cda_orig = ccw->cda;
> > +    /* skip is only effective for read, read backwards, or sense commands */
> > +    cds->do_skip = (ccw->flags & CCW_FLAG_SKIP) &&
> > +        (ccw->cmd_code & CCW_CMD_BASIC_SENSE ||
> > +         ccw->cmd_code & 0x02 /* read */ ||
> > +         ccw->cmd_code & 0x0c /* read backwards */);  
> 
> I wish so badly that these checks work, since it'd simplify the vfio-ccw 
> code, but I don't think this lets you tell the difference between a READ 
> (x02) and a NOP (x03) or any other control-type CCW.  Ditto 
> read-backward versus TIC.  :-(

Drat, why is that never easy... I'll rework this check.

> 
> >       ccw_dstream_rewind(cds);
> >       if (!(cds->flags & CDS_F_IDA)) {
> >           cds->op_handler = ccw_dstream_rw_noflags;
> > diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> > index aae19c427229..7cc183ef4366 100644
> > --- a/include/hw/s390x/css.h
> > +++ b/include/hw/s390x/css.h
> > @@ -97,6 +97,7 @@ typedef struct CcwDataStream {
> >       int (*op_handler)(struct CcwDataStream *cds, void *buff, int len,
> >                         CcwDataStreamOp op);
> >       hwaddr cda;
> > +    bool do_skip;
> >   } CcwDataStream;
> >   
> >   /*
> >   
> 



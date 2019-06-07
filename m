Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDDDC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AA2208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AA2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHQU-00082t-F0
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44831)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZGUT-0001sX-MX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZGUS-0004n3-Bm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZGUS-0004lZ-2y; Fri, 07 Jun 2019 11:09:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 143BC31628F7;
 Fri,  7 Jun 2019 15:09:11 +0000 (UTC)
Received: from gondolin (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 026CC842B8;
 Fri,  7 Jun 2019 15:09:09 +0000 (UTC)
Date: Fri, 7 Jun 2019 17:09:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Message-ID: <20190607170907.1d682513.cohuck@redhat.com>
In-Reply-To: <77395432-9619-1fee-4aeb-5685b8aa9be3@linux.ibm.com>
References: <20190607145353.2052-1-cohuck@redhat.com>
 <77395432-9619-1fee-4aeb-5685b8aa9be3@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 07 Jun 2019 15:09:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5] vfio-ccw: support async command
 subregion
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 11:02:36 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 06/07/2019 10:53 AM, Cornelia Huck wrote:
> > A vfio-ccw device may provide an async command subregion for
> > issuing halt/clear subchannel requests. If it is present, use
> > it for sending halt/clear request to the device; if not, fall
> > back to emulation (as done today).
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > v4->v5:
> > - It seems we need to take the indirection via the class for the
> >    callbacks after all :(
> > - Dropped Eric's R-b: for that reason
> > 
> > ---
> >   hw/s390x/css.c              |  27 +++++++--
> >   hw/s390x/s390-ccw.c         |  20 +++++++
> >   hw/vfio/ccw.c               | 112 +++++++++++++++++++++++++++++++++++-
> >   include/hw/s390x/css.h      |   3 +
> >   include/hw/s390x/s390-ccw.h |   2 +
> >   5 files changed, 158 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index ad310b9f94bc..b92395f165e6 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -22,6 +22,7 @@
> >   #include "trace.h"
> >   #include "hw/s390x/s390_flic.h"
> >   #include "hw/s390x/s390-virtio-ccw.h"
> > +#include "hw/s390x/s390-ccw.h"
> >   
> >   typedef struct CrwContainer {
> >       CRW crw;
> > @@ -1205,6 +1206,26 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
> >   
> >   }
> >   
> > +static void sch_handle_halt_func_passthrough(SubchDev *sch)
> > +{
> > +    int ret;
> > +
> > +    ret = s390_ccw_halt(sch);
> > +    if (ret == -ENOSYS) {
> > +        sch_handle_halt_func(sch);
> > +    }
> > +}
> > +
> > +static void sch_handle_clear_func_passthrough(SubchDev *sch)
> > +{
> > +    int ret;
> > +
> > +    ret = s390_ccw_clear(sch);
> > +    if (ret == -ENOSYS) {
> > +        sch_handle_clear_func(sch);
> > +    }
> > +}
> > +  
> 
> do we need an extra s390_ccw_clear/halt functions? can't we just call 
> cdc->clear/halt in the passthrough functions?

I mostly added them for symmetry reasons... we still need to check for
presence of the callback in any case, though.

(vfio is not always built, e.g. on windows or os x.)

> 
> >   static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
> >   {
> >       SCHIB *schib = &sch->curr_status;
> > @@ -1244,11 +1265,9 @@ IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
> >       SCHIB *schib = &sch->curr_status;
> >   
> >       if (schib->scsw.ctrl & SCSW_FCTL_CLEAR_FUNC) {
> > -        /* TODO: Clear handling */
> > -        sch_handle_clear_func(sch);
> > +        sch_handle_clear_func_passthrough(sch);
> >       } else if (schib->scsw.ctrl & SCSW_FCTL_HALT_FUNC) {
> > -        /* TODO: Halt handling */
> > -        sch_handle_halt_func(sch);
> > +        sch_handle_halt_func_passthrough(sch);
> >       } else if (schib->scsw.ctrl & SCSW_FCTL_START_FUNC) {
> >           return sch_handle_start_func_passthrough(sch);
> >       }
> > diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> > index f5f025d1b6ca..951be5ab0245 100644
> > --- a/hw/s390x/s390-ccw.c
> > +++ b/hw/s390x/s390-ccw.c
> > @@ -29,6 +29,26 @@ IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
> >       return cdc->handle_request(sch);
> >   }
> >   
> > +int s390_ccw_halt(SubchDev *sch)
> > +{
> > +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
> > +
> > +    if (!cdc->handle_halt) {
> > +        return -ENOSYS;
> > +    }
> > +    return cdc->handle_halt(sch);
> > +}
> > +
> > +int s390_ccw_clear(SubchDev *sch)
> > +{
> > +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
> > +
> > +    if (!cdc->handle_clear) {
> > +        return -ENOSYS;
> > +    }
> > +    return cdc->handle_clear(sch);
> > +}
> > +  
> 



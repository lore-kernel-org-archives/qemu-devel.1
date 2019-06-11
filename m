Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85549C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5278F20896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5278F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hag2E-0002th-FD
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hafAu-0006yr-GG
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1haf5k-0007xG-Sg
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:37:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1haf5k-0007pr-JN; Tue, 11 Jun 2019 07:37:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 630247FDFE;
 Tue, 11 Jun 2019 11:37:21 +0000 (UTC)
Received: from gondolin (ovpn-204-147.brq.redhat.com [10.40.204.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E67CE5DD63;
 Tue, 11 Jun 2019 11:37:19 +0000 (UTC)
Date: Tue, 11 Jun 2019 13:37:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Message-ID: <20190611133716.427269b5.cohuck@redhat.com>
In-Reply-To: <e8d6deb4-2e9a-188a-7171-ff9b85d625b3@linux.ibm.com>
References: <20190607145353.2052-1-cohuck@redhat.com>
 <77395432-9619-1fee-4aeb-5685b8aa9be3@linux.ibm.com>
 <20190607170907.1d682513.cohuck@redhat.com>
 <e8d6deb4-2e9a-188a-7171-ff9b85d625b3@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 11 Jun 2019 11:37:21 +0000 (UTC)
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

On Fri, 7 Jun 2019 11:19:09 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 06/07/2019 11:09 AM, Cornelia Huck wrote:
> > On Fri, 7 Jun 2019 11:02:36 -0400
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >   
> >> On 06/07/2019 10:53 AM, Cornelia Huck wrote:  

> >>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >>> index ad310b9f94bc..b92395f165e6 100644
> >>> --- a/hw/s390x/css.c
> >>> +++ b/hw/s390x/css.c
> >>> @@ -22,6 +22,7 @@
> >>>    #include "trace.h"
> >>>    #include "hw/s390x/s390_flic.h"
> >>>    #include "hw/s390x/s390-virtio-ccw.h"
> >>> +#include "hw/s390x/s390-ccw.h"
> >>>    
> >>>    typedef struct CrwContainer {
> >>>        CRW crw;
> >>> @@ -1205,6 +1206,26 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
> >>>    
> >>>    }
> >>>    
> >>> +static void sch_handle_halt_func_passthrough(SubchDev *sch)
> >>> +{
> >>> +    int ret;
> >>> +
> >>> +    ret = s390_ccw_halt(sch);
> >>> +    if (ret == -ENOSYS) {
> >>> +        sch_handle_halt_func(sch);
> >>> +    }
> >>> +}
> >>> +
> >>> +static void sch_handle_clear_func_passthrough(SubchDev *sch)
> >>> +{
> >>> +    int ret;
> >>> +
> >>> +    ret = s390_ccw_clear(sch);
> >>> +    if (ret == -ENOSYS) {
> >>> +        sch_handle_clear_func(sch);
> >>> +    }
> >>> +}
> >>> +  
> >>
> >> do we need an extra s390_ccw_clear/halt functions? can't we just call
> >> cdc->clear/halt in the passthrough functions?  
> > 
> > I mostly added them for symmetry reasons... we still need to check for
> > presence of the callback in any case, though.
> > 
> > (vfio is not always built, e.g. on windows or os x.)  
> 
> 
> right, but if we are calling do_subchannel_work_passthrough, then we 
> know for sure we are building the S390CCWDevice which is the vfio 
> device, no?
> 
> So we could just add checks for callbacks in 
> sch_handle_clear/halt_func_passthrough, no?
> 
> I would even like to get rid of the s390_ccw_cmd_request if we can, but 
> that is out of scope for this patch. :)

Ok, I just walked through various source files (some of which are a bit
confusingly named) again and now I understand again why it was done
that way in the first place.

- hw/s390x/s390-ccw.c provides some interfaces for pass-through ccw
  devices. It is built unconditionally, and its interfaces are called
  unconditionally from the css code.
  It also provides a device class where code can hook up callbacks.
- hw/vfio/ccw.c (which is not built for !KVM) actually hooks up
  callbacks in that device class.

So, s390-ccw.c (not to be confused with ccw-device.c...) provides a
layer that makes it possible to call things unconditionally, regardless
whether we have vfio-ccw available or not. Not that the code ends up
being called without vfio-ccw support; but the class indirection
enables the code to be built.

There's possibly a way to make this work without the class indirection
as well, but I think we'd end up doing code juggling before ending up
with something that's not really nicer than the code we have now.
Therefore, I'd prefer to keep the class handling and hook up the
halt/clear callbacks there as well.


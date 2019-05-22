Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1AFC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145F720868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145F720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOKG-0007Yw-DO
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:18:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hTOJR-0007Ew-T6
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hTOJR-0004mr-0Q
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hTOJQ-0004mH-Q7; Wed, 22 May 2019 06:17:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 393B97FDF0;
	Wed, 22 May 2019 10:17:21 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A3C8F17519;
	Wed, 22 May 2019 10:17:16 +0000 (UTC)
Date: Wed, 22 May 2019 12:17:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Message-ID: <20190522121714.34f1740b.cohuck@redhat.com>
In-Reply-To: <ee44aca2-708b-9ced-b658-731cf6528129@linux.ibm.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
	<20190507154733.28604-3-cohuck@redhat.com>
	<ee44aca2-708b-9ced-b658-731cf6528129@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 22 May 2019 10:17:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 2/2] vfio-ccw: support async command
 subregion
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
Cc: Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
	Halil Pasic <pasic@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 16:50:47 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 05/07/2019 11:47 AM, Cornelia Huck wrote:
> > A vfio-ccw device may provide an async command subregion for
> > issuing halt/clear subchannel requests. If it is present, use
> > it for sending halt/clear request to the device; if not, fall
> > back to emulation (as done today).
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   hw/s390x/css.c              |  27 +++++++--
> >   hw/vfio/ccw.c               | 110 +++++++++++++++++++++++++++++++++++-
> >   include/hw/s390x/s390-ccw.h |   3 +
> >   3 files changed, 134 insertions(+), 6 deletions(-)

> > diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
> > index 901d805d79a3..e9c7e1db5761 100644
> > --- a/include/hw/s390x/s390-ccw.h
> > +++ b/include/hw/s390x/s390-ccw.h
> > @@ -37,4 +37,7 @@ typedef struct S390CCWDeviceClass {
> >       IOInstEnding (*handle_request) (SubchDev *sch);
> >   } S390CCWDeviceClass;
> >   
> > +int vfio_ccw_handle_clear(SubchDev *sch);
> > +int vfio_ccw_handle_halt(SubchDev *sch);
> > +  
> 
> We are not making clear and halt functions part of the 
> S390CCWDeviceClass, is there are reason for doing this?
> Currently we handle ssch through the handle_request function, it just 
> looks a little inconsistent.

I don't quite remember why I did it this way; not sure if there is a
good reason for that (that patch has been around for too long...)

We can change such internal details later on, though. (And I think your
comment has merit.)


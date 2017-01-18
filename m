Received: from eggs.gnu.org ([2001:4830:134:3::10]:41628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTpYu-0000u9-6x
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTpYq-0003Zw-WF
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:42:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53718
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTpYq-0003Zc-Q7
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:41:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0ICchqx074200
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 07:41:54 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28272k3xp3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 07:41:54 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 18 Jan 2017 12:41:52 -0000
Date: Wed, 18 Jan 2017 13:41:47 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170118025117.GN30301@bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112072513.98411-3-bjsdjshi@linux.vnet.ibm.com>
	<20170117145142.4954666f@t450s.home>
	<20170118025117.GN30301@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170118134147.5cf6beb0.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 02/12] vfio: linux-headers update
 for vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

On Wed, 18 Jan 2017 10:51:17 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Alex Williamson <alex.williamson@redhat.com> [2017-01-17 14:51:42 -0700]:
> 
> > On Thu, 12 Jan 2017 08:25:03 +0100
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > 
> > > From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > 
> > > This is a placeholder for a linux-headers update.
> > > 
> > > Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > ---
> > >  include/standard-headers/asm-s390/vfio_ccw.h | 28 ++++++++++++++++++++++++++++
> > >  linux-headers/linux/vfio.h                   | 17 +++++++++++++++++
> > >  2 files changed, 45 insertions(+)
> > >  create mode 100644 include/standard-headers/asm-s390/vfio_ccw.h
> > > 
> > > diff --git a/include/standard-headers/asm-s390/vfio_ccw.h b/include/standard-headers/asm-s390/vfio_ccw.h
> > > new file mode 100644
> > > index 0000000..cddc09b
> > > --- /dev/null
> > > +++ b/include/standard-headers/asm-s390/vfio_ccw.h
> > > @@ -0,0 +1,28 @@
> > > +/*
> > > + * Interfaces for vfio-ccw
> > > + *
> > > + * Copyright IBM Corp. 2017
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License (version 2 only)
> > > + * as published by the Free Software Foundation.
> > > + *
> > > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > + */
> > > +
> > > +#ifndef _VFIO_CCW_H_
> > > +#define _VFIO_CCW_H_
> > > +
> > > +#include "standard-headers/linux/types.h"
> > > +
> > > +struct ccw_io_region {
> > > +#define ORB_AREA_SIZE 12
> > > +	uint8_t  orb_area[ORB_AREA_SIZE];
> > > +#define SCSW_AREA_SIZE 12
> > > +	uint8_t  scsw_area[SCSW_AREA_SIZE];
> > > +#define IRB_AREA_SIZE 96
> > > +	uint8_t  irb_area[IRB_AREA_SIZE];
> > > +	uint32_t ret_code;
> > > +} QEMU_PACKED;
> > > +
> > > +#endif
> > 
> > This is really part of the uapi for the vfio-ccw mdev device, isn't it?
> Yes, it is.
> 
> > Should it really be buried in asm-s390 in the kernel?
> > 
> We had an internal discussion on this question before, since we think
> this interface is strongly s390 dependent, we put it here. What do you
> suggest? Thanks,

As there are already architecture-specific definitions in the common
file, having everything in the same file is probably better. I'm
certainly not against moving it out from asm-s390.

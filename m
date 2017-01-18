Received: from eggs.gnu.org ([2001:4830:134:3::10]:33854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cTgLV-0000KD-2A
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cTgLQ-0004vj-5C
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:51:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cTgLP-0004uU-Re
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:51:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0I2nbTJ114971
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:51:26 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 281ubb0rtg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:51:25 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 17 Jan 2017 21:51:24 -0500
Date: Wed, 18 Jan 2017 10:51:17 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112072513.98411-3-bjsdjshi@linux.vnet.ibm.com>
	<20170117145142.4954666f@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170117145142.4954666f@t450s.home>
Message-Id: <20170118025117.GN30301@bjsdjshi@linux.vnet.ibm.com>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

* Alex Williamson <alex.williamson@redhat.com> [2017-01-17 14:51:42 -0700]:

> On Thu, 12 Jan 2017 08:25:03 +0100
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > 
> > This is a placeholder for a linux-headers update.
> > 
> > Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > ---
> >  include/standard-headers/asm-s390/vfio_ccw.h | 28 ++++++++++++++++++++++++++++
> >  linux-headers/linux/vfio.h                   | 17 +++++++++++++++++
> >  2 files changed, 45 insertions(+)
> >  create mode 100644 include/standard-headers/asm-s390/vfio_ccw.h
> > 
> > diff --git a/include/standard-headers/asm-s390/vfio_ccw.h b/include/standard-headers/asm-s390/vfio_ccw.h
> > new file mode 100644
> > index 0000000..cddc09b
> > --- /dev/null
> > +++ b/include/standard-headers/asm-s390/vfio_ccw.h
> > @@ -0,0 +1,28 @@
> > +/*
> > + * Interfaces for vfio-ccw
> > + *
> > + * Copyright IBM Corp. 2017
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License (version 2 only)
> > + * as published by the Free Software Foundation.
> > + *
> > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > + */
> > +
> > +#ifndef _VFIO_CCW_H_
> > +#define _VFIO_CCW_H_
> > +
> > +#include "standard-headers/linux/types.h"
> > +
> > +struct ccw_io_region {
> > +#define ORB_AREA_SIZE 12
> > +	uint8_t  orb_area[ORB_AREA_SIZE];
> > +#define SCSW_AREA_SIZE 12
> > +	uint8_t  scsw_area[SCSW_AREA_SIZE];
> > +#define IRB_AREA_SIZE 96
> > +	uint8_t  irb_area[IRB_AREA_SIZE];
> > +	uint32_t ret_code;
> > +} QEMU_PACKED;
> > +
> > +#endif
> 
> This is really part of the uapi for the vfio-ccw mdev device, isn't it?
Yes, it is.

> Should it really be buried in asm-s390 in the kernel?
> 
We had an internal discussion on this question before, since we think
this interface is strongly s390 dependent, we put it here. What do you
suggest? Thanks,

[...]

-- 
Dong Jia

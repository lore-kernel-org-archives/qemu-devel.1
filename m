Received: from eggs.gnu.org ([209.51.188.92]:37043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hAsfh-0002Ci-BV
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 04:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hAsfg-0006Ff-D3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 04:52:01 -0400
Date: Mon, 1 Apr 2019 10:51:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190401105153.0eef4fb9.cohuck@redhat.com>
In-Reply-To: <5961e42d-8574-48de-3057-6cd7680645cc@redhat.com>
References: <1552494682-16788-1-git-send-email-jjherne@linux.ibm.com>
	<1552494682-16788-2-git-send-email-jjherne@linux.ibm.com>
	<5961e42d-8574-48de-3057-6cd7680645cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 01/15] s390 vfio-ccw: Add
 bootindex property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 26 Mar 2019 13:49:41 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 13/03/2019 17.31, Jason J. Herne wrote:
> > Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> > forward boot information into the bios for vfio-ccw devices.
> > 
> > Refactor s390_get_ccw_device() to return device type. This prevents us from
> > having to use messy casting logic in several places.
> > 
> > Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> > Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > ---  

> [...]
> > diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
> > new file mode 100644
> > index 0000000..2fceaa2
> > --- /dev/null
> > +++ b/include/hw/s390x/vfio-ccw.h
> > @@ -0,0 +1,28 @@
> > +/*
> > + * vfio based subchannel assignment support
> > + *
> > + * Copyright 2017 IBM Corp.  
> 
> Maybe bump the year to 2019 ?

Not sure, the code is simply extracted and not changed, isn't it?

(If bumped, it probably should be 2017,2019.)

> 
> > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> > + * your option) any later version. See the COPYING file in the top-level
> > + * directory.
> > + */
> > +
> > +#ifndef HW_VFIO_CCW_H
> > +#define HW_VFIO_CCW_H
> > +
> > +#include "hw/vfio/vfio-common.h"
> > +#include "hw/s390x/s390-ccw.h"
> > +#include "hw/s390x/ccw-device.h"
> > +
> > +#define TYPE_VFIO_CCW "vfio-ccw"
> > +#define VFIO_CCW(obj) \
> > +        OBJECT_CHECK(VFIOCCWDevice, (obj), TYPE_VFIO_CCW)
> > +
> > +#define TYPE_VFIO_CCW "vfio-ccw"
> > +typedef struct VFIOCCWDevice VFIOCCWDevice;
> > +
> > +#endif  
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

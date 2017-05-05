Received: from eggs.gnu.org ([2001:4830:134:3::10]:46314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6cG0-0007B7-5A
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6cFw-0007Xw-Rg
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:22:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6cFw-0007Xi-IY
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:22:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45CJFAs137573
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 08:22:43 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8k76rm3a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:22:42 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 5 May 2017 13:22:40 +0100
Date: Fri, 5 May 2017 14:22:34 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170505142234.487dfda9.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 00/13] basic channel IO passthrough
 infrastructure based on vfio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

On Fri,  5 May 2017 04:03:39 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> The patch series introduce a basic channel I/O passthrough
> infrastructure based on vfio.
> - Focus on supporting dasd-eckd(cu_type/dev_type = 0x3990/0x3390) as
>   the target device. 
> - Support new qemu parameters in the style of:
>     -machine s390-ccw-virtio(,s390-squash-mcss=on|off) \
>     -device vfio-ccw,sysfsdev=$MDEV_PATH
>   We want to support real (i.e. not virtual) channel devices even for
>   guests that do not support MCSS-E (where guests may see devices from
>   any channel subsystem image at once). As all virtio-ccw devices are in
>   css 0xfe (and show up in the default css 0 for guests not activating
>   MCSS-E), we need an option to squash e.g. passed-through channel devices
>   from their real css (0-3, or 0 for hosts not activating MCSS-E) into
>   the default css, that is what the new machine option s390-squash-css is
>   added.

Basically looks good, some small nitpicking and the virtual vs. virtio
issue I noticed.

Let's wait if others have more comments. Hopefully, the 3270 changes
will by then be in master and you can rebase on top of them :)

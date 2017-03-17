Received: from eggs.gnu.org ([2001:4830:134:3::10]:33582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1coqTa-0002AE-AW
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1coqTW-00058d-Dp
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:55:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54808
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1coqTW-00058O-7M
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:55:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2HBmiI4104138
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 07:55:16 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 297seuy68r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 07:55:16 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 17 Mar 2017 11:55:14 -0000
Date: Fri, 17 Mar 2017 12:55:10 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170317113353.26297-1-famz@redhat.com>
References: <20170317113353.26297-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170317125510.75b4c92c.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] virtio: Fix error handling in
 virtio_bus_device_plugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, drjones@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 17 Mar 2017 19:33:53 +0800
Fam Zheng <famz@redhat.com> wrote:

> For one thing we shouldn't continue if an error happened, for the other
> two steps failing can cause an abort() in error_setg because we reuse
> the same errp blindly.
> 
> Add error handling checks to fix both issues.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/virtio/virtio-bus.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

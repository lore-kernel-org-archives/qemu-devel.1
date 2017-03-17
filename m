Received: from eggs.gnu.org ([2001:4830:134:3::10]:44879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1corAu-0004iD-JG
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1corAp-0004cC-Ns
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:40:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1corAp-0004c1-Ct
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:40:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2HCYJUL007079
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 08:40:01 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 297yywvupr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 08:40:00 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 17 Mar 2017 12:39:58 -0000
Date: Fri, 17 Mar 2017 13:39:52 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170317123242.32579-1-famz@redhat.com>
References: <20170317123242.32579-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170317133952.1d5bfcce.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio: Fix error handling in
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

On Fri, 17 Mar 2017 20:32:42 +0800
Fam Zheng <famz@redhat.com> wrote:

> For one thing we shouldn't continue if an error happened, for the other
> two steps failing can cause an abort() in error_setg because we reuse
> the same errp blindly.
> 
> Add error handling checks to fix both issues.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> ---
> 
> v2: Don't forget the last errp -> &local_err. [Drew]
> ---
>  hw/virtio/virtio-bus.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

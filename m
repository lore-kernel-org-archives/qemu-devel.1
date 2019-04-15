Received: from eggs.gnu.org ([209.51.188.92]:40005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hG3WD-000464-Pa
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hG3W8-0006Mw-RQ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:27:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59118
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hG3W6-0006Kn-UZ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:27:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FFRPnW117197
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 11:27:29 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rvt3c7qsu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 11:27:26 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 15 Apr 2019 16:24:45 +0100
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-5-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 15 Apr 2019 11:24:41 -0400
MIME-Version: 1.0
In-Reply-To: <20190301093902.27799-5-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <75256da4-2e3a-b3f1-d29b-1986b4bcdf79@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/6] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 03/01/2019 04:39 AM, Cornelia Huck wrote:
> Allow to extend the regions used by vfio-ccw. The first user will be
> handling of halt and clear subchannel.
> 
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   drivers/s390/cio/vfio_ccw_ops.c     | 186 ++++++++++++++++++++++++----
>   drivers/s390/cio/vfio_ccw_private.h |  38 ++++++
>   include/uapi/linux/vfio.h           |   2 +
>   3 files changed, 200 insertions(+), 26 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

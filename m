Received: from eggs.gnu.org ([2001:4830:134:3::10]:60545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duYnA-0006T1-4T
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duYn5-0002cQ-4m
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:47:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1duYn4-0002bT-M6
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:47:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K6kPDA123538
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:47:21 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3bt1yx4h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:47:20 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 00:47:20 -0600
Date: Wed, 20 Sep 2017 14:47:15 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170919182745.90280-4-pasic@linux.vnet.ibm.com>
Message-Id: <20170920064715.GG11080@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-19 20:27:43 +0200]:

> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 157 +++++++++++++++-----------------------------------
>  1 file changed, 46 insertions(+), 111 deletions(-)
> 

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

[...]

-- 
Dong Jia Shi

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSIsZ-0003Me-Hy
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSIsW-0007xP-A7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:08:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49444
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSIsW-0007wp-4V
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:08:12 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64848hV119066
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 04:08:11 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bfqth9uyw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:08:08 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 04:08:07 -0400
References: <20170703213414.94298-1-pasic@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 4 Jul 2017 10:08:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170703213414.94298-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <7804fd7b-b4a6-7551-31dd-741b12f05cc7@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390x: vmstatify config migration
 for virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Cornelia Huck <cohuck@kernel.org>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 07/03/2017 11:34 PM, Halil Pasic wrote:
> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
> flexibility (extending using subsections) and for fun.
> 
> To achieve this we need to hack the config_vector, which is VirtIODevice
> (that is common virtio) state, in the middle of the VirtioCcwDevice state
> representation.  This is somewhat ugly, but we have no choice because the
> stream format needs to be preserved.
> 
> Almost no changes in behavior. Exception is everything that comes with
> vmstate like extra bookkeeping about what's in the stream, and maybe some
> extra checks and better error reporting.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

thanks applied to s390-next.

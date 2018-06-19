Received: from eggs.gnu.org ([2001:4830:134:3::10]:50142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fVGeY-0004Ms-VR
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fVGeT-0007CP-Ae
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:26:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fVGeS-0007Bm-W7
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:26:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5JDNsE9130693
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:26:26 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jq1sjjwdw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:26:25 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 19 Jun 2018 07:26:24 -0600
References: <cover.1528921468.git.alifm@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 19 Jun 2018 09:26:18 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1528921468.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Detect & register virtio-crypto
 algos only if it can be supported by backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com, borntraeger@de.ibm.com

A polite ping :)

If no one has any more comments/feedback then I would like to how to 
merge these patches to the mainline kernel tree.

Thanks
Farhan

On 06/13/2018 04:38 PM, Farhan Ali wrote:
> Hi,
> 
> Currently the Linux virtio-crypto driver registers the crypto
> algorithm without verifying if the backend actually supports the
> algorithm.
> 
> This kernel patch series adds support for registering algorithm
> with Linux crypto layer, only if the algorithm is supported by
> the backend device. This also makes the driver more compliant with
> the virtio-crypto spec [1].
> 
> I would appreciate any feedback or comments on this.
> 
> Thank you
> Farhan
> 
> Reference
> ---------
> [1] Virtio crypto spec proposal https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00816.html
> 
> ChangeLog
> ---------
> v1 -> v2
>     - Modify comment as suggested by Arei (patch 1)
>     - Modify error message as suggested by Arei (patch 2)
> 
> 
> Farhan Ali (2):
>    crypto/virtio-crypto: Read crypto services and algorithm masks
>    crypto/virtio-crypto: Register an algo only if it's supported
> 
>   drivers/crypto/virtio/virtio_crypto_algs.c   | 112 ++++++++++++++++++---------
>   drivers/crypto/virtio/virtio_crypto_common.h |  25 +++++-
>   drivers/crypto/virtio/virtio_crypto_core.c   |  29 +++++++
>   drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 +++++++++++++++++--
>   4 files changed, 202 insertions(+), 45 deletions(-)
> 

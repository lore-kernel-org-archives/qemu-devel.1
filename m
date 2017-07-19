Received: from eggs.gnu.org ([2001:4830:134:3::10]:49311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXjuS-0004JN-JQ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXjuP-00078m-1c
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXjuO-00078U-RG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:00:36 -0400
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-6-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fdcf6619-2c87-3d47-eb60-f414fe9f2488@redhat.com>
Date: Wed, 19 Jul 2017 10:00:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170718142455.32676-6-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 5/9] s390x/ccw: create s390 phb
 conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 18.07.2017 16:24, Cornelia Huck wrote:
> Don't create the s390 pci host bridge if we do not provide the zpci
> facility.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

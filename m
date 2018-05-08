Received: from eggs.gnu.org ([2001:4830:134:3::10]:56461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG2iy-0002BB-2o
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG2is-0001TD-7c
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:32:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fG2ir-0001S0-U1
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:32:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w48DVF9b097960
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 09:32:04 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hubhrv7wn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 09:32:01 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 8 May 2018 14:31:51 +0100
References: <20180507155130.21085-1-cohuck@redhat.com>
	<20180507155130.21085-2-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 8 May 2018 15:31:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180507155130.21085-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b03932e1-2e02-1d1c-cb2d-0d01ef123740@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/2] virtio-ccw: common reset
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>



On 05/07/2018 05:51 PM, Cornelia Huck wrote:
> All the different virtio ccw devices use the same reset handler,
> so let's move setting it into the base virtio ccw device class.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>


> ---
>   hw/s390x/virtio-ccw.c | 13 +------------

[..]

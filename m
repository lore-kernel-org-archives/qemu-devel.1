Received: from eggs.gnu.org ([2001:4830:134:3::10]:41833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ds9yg-0001xH-0u
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ds9yc-0006eH-0c
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:53:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44180
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1ds9yb-0006dg-RC
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:53:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DFo0Cu111860
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:53:20 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cy5y3wmy4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:53:20 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 09:53:19 -0600
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
	<0a156f413f67b1bf55c5516d8263a15db3ec42c3.1505225353.git.alifm@linux.vnet.ibm.com>
	<1505290435.22749.3.camel@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 11:53:15 -0400
MIME-Version: 1.0
In-Reply-To: <1505290435.22749.3.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <5678da9e-ddea-1d31-77ff-8ea52ee30ca9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/2] virtio_gpu: Handle endian conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com



On 09/13/2017 04:13 AM, Gerd Hoffmann wrote:
> Please move this to a helper function, maybe by updating the
> VIRTIO_GPU_FILL_CMD macro.
>
> The header fields should be byteswapped too.  As most structs have
> 32bit fields only (with the exception of hdr.fence_id) you should be
> able to create a generic byteswap function which only needs the struct
> size as argument and handles all structs without addresses/offsets
> (which are 64bit fields).

I am not sure if I understand what you mean here. Since struct 
virtio_gpu_ctrl_hdr is part of every struct, so any such function
would also need to handle the case of hdr.fence_id, right?

>
> The conversion looks incomplete, at least virtio_gpu_ctrl_response will
> need adaptions too.  It probably works by luck because the guest driver
> uses fences only in virgl (3d) mode.
>

Oh right, I need to handle the conversion there as well. Thanks for 
catching that.

Also I believe this conversion patch isn't comprehensive, it's mostly 
the changes I made to get a display working on S390. So I appreciate
you reviewing the changes.

> cheers,
>   Gerd

Thanks
Farhan

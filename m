Received: from eggs.gnu.org ([2001:4830:134:3::10]:60748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dtvLG-0001Fy-VQ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dtvLB-0002F8-UV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:40:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dtvLB-0002Dz-L8
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:39:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8ICd8sj117207
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 08:39:51 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2afwedg5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 08:39:50 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Mon, 18 Sep 2017 08:39:49 -0400
References: <cover.1505485574.git.alifm@linux.vnet.ibm.com>
	<dc748e15f36db808f90b4f2393bc29ba7556a9f6.1505485574.git.alifm@linux.vnet.ibm.com>
	<1505730751.10119.8.camel@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Mon, 18 Sep 2017 08:39:46 -0400
MIME-Version: 1.0
In-Reply-To: <1505730751.10119.8.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <f9f0993c-3486-17b8-6112-b65c880a6f01@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio-gpu: Handle endian conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com



On 09/18/2017 06:32 AM, Gerd Hoffmann wrote:
> On Fri, 2017-09-15 at 10:40 -0400, Farhan Ali wrote:
>> Virtio GPU code currently only supports litte endian format,
>> and so using the Virtio GPU device on a big endian machine
>> does not work.
>>
>> Let's fix it by supporting the correct host cpu byte order.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>
> cheers,
>   Gerd
>
>

Thanks for reviewing it :)

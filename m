Received: from eggs.gnu.org ([2001:4830:134:3::10]:33627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dtvOh-0003tz-GO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dtvOc-0003bo-Hd
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:43:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34634
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dtvOc-0003ba-CA
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:43:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8ICcp3b081835
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 08:43:29 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d2e1215p4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 08:43:29 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Mon, 18 Sep 2017 06:43:28 -0600
References: <cover.1505485574.git.alifm@linux.vnet.ibm.com>
	<20170918142902.1aa7fa4d.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Mon, 18 Sep 2017 08:43:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170918142902.1aa7fa4d.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <34d07f47-a089-345b-273d-c864baf2b461@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Virtio GPU for S390
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, kraxel@redhat.com



On 09/18/2017 08:29 AM, Cornelia Huck wrote:
> On Fri, 15 Sep 2017 10:40:30 -0400
> Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>
>> These patches wire up the virtio-gpu device for CCW bus for
>> S390.
>>
>> For the S390 architecture which does not natively support any graphics
>> device, virtio gpu in 2D mode could be used to emulate a simple graphics
>> card and use VNC as the display.
>>
>> eg: qemu-system-s390x ... -device virtio-gpu-ccw,devno=fe.0.0101
>>     -vnc host_ip_addr:5900
>>
>> Note, to actually see any display content the
>> guest kernel needs to support DRM layer, Virtio GPU driver,
>> the Virtual Terminal layer etc.
>>
>> I would appreciate any feedback on these patches, specially the
>> first patch.
>>
>> ChangeLog
>> --------
>> v1 -> v2
>>     - remove error_propagate (patch 2)
>>     - Add byteswap functions (patch 1)
>>     - Handle endian conversion for virtio_gpu_ctrl_response (patch 1)
>>
>> v2 -> v3
>>     - updated patch 1 based on Gerd's feedback
>>     - rename bswap functions (patch 1)
>>     - use in-place swapping functions (patch 1)
>>     - Handle endian conversion for cursor update (patch 1)
>>
>> Thank you
>> Farhan
>>
>>
>> Farhan Ali (2):
>>   virtio-gpu: Handle endian conversion
>>   virtio-gpu-ccw: Create a virtio gpu device for the ccw bus
>>
>>  hw/display/virtio-gpu.c | 70 +++++++++++++++++++++++++++++++++++++++++++------
>>  hw/s390x/virtio-ccw.c   | 49 ++++++++++++++++++++++++++++++++++
>>  hw/s390x/virtio-ccw.h   | 10 +++++++
>>  3 files changed, 121 insertions(+), 8 deletions(-)
>>
>
> Thanks, applied.
>

Thanks

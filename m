Received: from eggs.gnu.org ([2001:4830:134:3::10]:55382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsD4A-0006eF-FH
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsD45-0008MS-Gj
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:11:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52156
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dsD45-0008Lj-Ad
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:11:13 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DJ92FN054644
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 15:11:12 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cy7p01udc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 15:11:12 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 13:11:11 -0600
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
	<edda99a2-37b3-7428-027c-18f27a315056@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 15:11:06 -0400
MIME-Version: 1.0
In-Reply-To: <edda99a2-37b3-7428-027c-18f27a315056@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <f321fb90-cd47-0b63-dbd5-87d825bc3288@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Virtio GPU for S390
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, kraxel@redhat.com



On 09/13/2017 03:00 PM, Thomas Huth wrote:
> On 12.09.2017 16:26, Farhan Ali wrote:
>> These patches wire up the virtio-gpu device for CCW bus for S390.
>>
>> For the S390 architecture which does not natively support any
>> graphics device, virtio gpu in 2D mode could be used to emulate a
>> simple graphics card and use VNC as the display.
>>
>> eg: qemu-system-s390x ... -device virtio-gpu-ccw,devno=fe.0.0101
>> -vnc host_ip_addr:5900
>>
>> Note, to actually see any display content the guest kernel needs to
>> support DRM layer, Virtio GPU driver, the Virtual Terminal layer
>> etc.
>
> Do you have a list of CONFIG options that need to be enabled there?
> Are there also any patches to the guest kernel driver required? Or
> did that work out of the box once you've enabled the right CONFIG
> options?
>
It required some kernel hacking. You need to enable the VT layer for
S390 to get any kind of graphics displayed.

I experimented on the guest side to enable the VT layer and run a
framebuffer console and also the Xfce desktop :)

Anyway the CONFIG options I used are:

The DRM configs to enable the DRM layer and virtio-gpu. I went with the 
default options for DRM layer.

CONFIG_DRM

CONFIG_DRM_VIRTIO_GPU

We also need to enable configs for the VT layer

CONFIG_VT

CONFIG_DUMMY_CONSOLE

And to display a framebuffer console for the guest

CONFIG_FRAMEBUFFER_CONSOLE



>> I would appreciate any feedback on these patches, specially the
>> first patch.
>
> Patches look good to me, but I'm not at all familiar with the
> virtio-gpu code, so that likely does not count...
>
> Anyway, thanks a lot for tackling this! It's pretty cool to finally
> have a graphics card on s390x, too :-)
>
> Thomas
>

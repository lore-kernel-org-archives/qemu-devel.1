Received: from eggs.gnu.org ([2001:4830:134:3::10]:45247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f8rYQ-0008Hg-Cr
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 14:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f8rYM-00075D-EA
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 14:11:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44512
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1f8rYM-00073O-6h
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 14:11:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3II7Hfn062356
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 14:11:33 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2he98vd9a6-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 14:11:32 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 18 Apr 2018 12:11:32 -0600
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-2-git-send-email-thuth@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 18 Apr 2018 14:11:27 -0400
MIME-Version: 1.0
In-Reply-To: <1524054707-20663-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1170d2d8-a77e-1839-ae64-81f791b3d4e1@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.13 1/4] pc-bios/s390-ccw/net:
 Split up net_load() into init, load and uninit parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org



On 04/18/2018 08:31 AM, Thomas Huth wrote:
> When we want to support pxelinux-style network booting later, we've got
> to do several TFTP transfers - and we do not want to apply for a new IP
> address via DHCP each time. So split up net_load into three parts:
> 
> 1. net_init(), which initializes virtio-net, gets an IP address via DHCP
>     and prints out the related information.
> 
> 2. The tftp_load call is now moved directly into the main() function
> 
> 3. A new net_uninit() function which should tear down the network stack
>     before we are done in the firmware.
> 
> This will make it easier to extend the code in the next patches.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>


Just a minor nit, if we could rename *_uninit functions to 
destroy/release? I think it's just easier to read

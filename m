Received: from eggs.gnu.org ([2001:4830:134:3::10]:58229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fBMiI-0005BB-AI
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fBMiE-0006Cs-7B
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:52:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fBMiD-0006CH-TA
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:52:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3PFl171101796
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:52:03 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hjut3jx2k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:52:02 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 25 Apr 2018 09:52:01 -0600
References: <1524647323-6449-1-git-send-email-thuth@redhat.com>
	<1524647323-6449-2-git-send-email-thuth@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 25 Apr 2018 11:51:57 -0400
MIME-Version: 1.0
In-Reply-To: <1524647323-6449-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <119edcae-745d-f31e-c0a3-62ae1fe75c24@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] pc-bios/s390-ccw/net: Split up
 net_load() into init, load and uninit parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>



On 04/25/2018 05:08 AM, Thomas Huth wrote:
> When we want to support pxelinux-style network booting later, we've got
> to do several TFTP transfers - and we do not want to apply for a new IP
> address via DHCP each time. So split up net_load into three parts:
> 
> 1. net_init(), which initializes virtio-net, gets an IP address via DHCP
>     and prints out the related information.
> 
> 2. The tftp_load call is now moved directly into the main() function
> 
> 3. A new net_release() function which should tear down the network stack
>     before we are done in the firmware.
> 
> This will make it easier to extend the code in the next patches.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>

You might want to change the commit header "uninit parts" to "release 
parts" :)

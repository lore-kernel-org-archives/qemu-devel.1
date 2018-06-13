Received: from eggs.gnu.org ([2001:4830:134:3::10]:54403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fT3S1-0003sr-ON
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fT3Ro-0002dL-Rc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:56:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fT3Ro-0002cP-J9
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:56:16 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5DAsNTa027175
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 06:56:15 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jk1avhm06-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 06:56:14 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Wed, 13 Jun 2018 11:56:12 +0100
References: <1528374154-14680-1-git-send-email-thuth@redhat.com>
	<6e3c0582-86e0-383b-d6d3-7ba127198fd6@linux.vnet.ibm.com>
	<66156118-02da-7bf4-3a7d-6261dee27180@redhat.com>
	<2d029b4f-c14c-cdd3-37ca-2e93e6690e2e@linux.vnet.ibm.com>
	<1a67bc9e-b36c-3c88-701f-f47bf5e819f6@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Wed, 13 Jun 2018 12:56:08 +0200
MIME-Version: 1.0
In-Reply-To: <1a67bc9e-b36c-3c88-701f-f47bf5e819f6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <fa6e041f-93a5-905b-dd62-ec525a90b18a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 0/4] pc-bios/s390-ccw:
 Allow network booting via pxelinux.cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>

On 12.06.2018 08:17, Thomas Huth wrote:
> On 11.06.2018 14:03, Viktor VM Mihajlovski wrote:
[...]
> 
> If you have the time to look at the traffic, could you please also check
> the TFTP block size option that is negotiated at the beginning of the
> TFTP transfer? If this other client is negotiating a transfer block size
> that is bigger than the one from the s390-ccw firmware, this could
> explain the differences in the downloading time, too.
> 
> libnet from SLOF currently uses a block size of 1428. This is the size
> where all TFTP data should still fit nicely into one ethernet packet -
> and this is also the size which is still supported by all TFTP servers
> that support the blksize option. But theoretically it's also possible to
> use a bigger block sizes if both, the server and the client support
> fragmented UDP packets. Unfortunately, as far as I can see, SLOF's
> libnet does not support fragmented UDP packets, so we can't increase the
> block size here anymore so easily.
You will be pleased to hear that the SLOF TFTP client outperforms the
busybox version (which uses 544-byte packets) by 30%. There's some
randomness introduced by the differences in DHCP response times which is
clearly not the client's fault. All is good...
[...]
-- 
Regards,
  Viktor Mihajlovski

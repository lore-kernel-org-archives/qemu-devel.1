Received: from eggs.gnu.org ([2001:4830:134:3::10]:57113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fWM7q-0004bw-Hc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fWM7l-0007Ia-L8
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:29:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fWM7l-0007IJ-CF
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:29:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5MDSewO119476
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:29:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2js1r4gpac-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:29:11 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Jun 2018 14:29:09 +0100
References: <152967373830.876.17089841294743780259@d39dc562802a>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 22 Jun 2018 15:29:04 +0200
MIME-Version: 1.0
In-Reply-To: <152967373830.876.17089841294743780259@d39dc562802a>
Content-Language: en-US
Message-Id: <5df62baa-268b-2624-e9d7-42c521546d04@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, cohuck@redhat.com, frankja@linux.vnet.ibm.com, thuth@redhat.com, david@redhat.com, agraf@suse.de, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net



On 06/22/2018 03:22 PM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 

[...]

>   CC      os-win32.o
>   CC      bt-host.o
>   CC      bt-vhci.o
>   CC      dma-helpers.o
>   CC      vl.o
>   CC      tpm.o
>   CC      device_tree.o
> /tmp/qemu-test/src/nbd/server.c: In function 'nbd_trip':
> /tmp/qemu-test/src/nbd/server.c:1980:19: error: 'end' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      *length = end - offset;
>                ~~~~^~~~~~~~
> /tmp/qemu-test/src/nbd/server.c:1940:30: note: 'end' was declared here
>      uint64_t begin = offset, end;
>                               ^~~
> cc1: all warnings being treated as errors

This seems unrelated to the patch?

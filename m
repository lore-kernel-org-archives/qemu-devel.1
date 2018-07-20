Received: from eggs.gnu.org ([2001:4830:134:3::10]:47031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fgbIP-00065r-Lh
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fgbIL-0003zM-UG
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:42:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42420
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fgbIL-0003yx-Oz
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:42:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6KJcaIS133904
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 15:42:28 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kbhhh3gnr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 15:42:28 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 20 Jul 2018 13:42:27 -0600
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
	<a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
	<20180720193257.GB23996@breakout>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 20 Jul 2018 15:42:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180720193257.GB23996@breakout>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20dc1e6f-df6c-9c59-f8ac-ec1f78b9473a@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org



On 07/20/2018 03:32 PM, Nishanth Aravamudan wrote:
> On 20.07.2018 [15:11:14 -0400], Farhan Ali wrote:
>> I am seeing another issue pop up, in a different test. Even though it's a
>> different assertion, it might be related based on the call trace.
> 
> Just to be clear, this does not happen if you revert the original patch
> (i.e., the one you bisected to before)?
> 
> I'm digging into the code now.
> 
> -Nish
> 
> 
I had not seen this issue before. I just ran my regression tests with 
your fix and saw the failure in one of my test. The patch in itself 
fixes the original issue I reported. I am going to try and debug some more.

Thanks
Farhan

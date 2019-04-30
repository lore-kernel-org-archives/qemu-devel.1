Received: from eggs.gnu.org ([209.51.188.92]:53715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oberpar@linux.ibm.com>) id 1hLP0C-0000LK-Uv
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oberpar@linux.ibm.com>) id 1hLP0B-00021N-TI
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:24:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <oberpar@linux.ibm.com>)
	id 1hLP0B-00020J-Hi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:24:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3U9MFUw083277
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:24:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s6hj3druw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:24:34 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <oberpar@linux.ibm.com>;
	Tue, 30 Apr 2019 10:24:32 +0100
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
	<20190429154003.7f8fc423.cohuck@redhat.com>
	<ef10a003-3eb8-df60-bfb1-bc99bfd6b7af@de.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Date: Tue, 30 Apr 2019 11:24:27 +0200
MIME-Version: 1.0
In-Reply-To: <ef10a003-3eb8-df60-bfb1-bc99bfd6b7af@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <099881e7-b0a9-055a-ba3e-2ebb66b4e15c@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-bios: Skip bootmap signature entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, alifm@linux.ibm.com, Stefan Haberland <sth@linux.vnet.ibm.com>

On 29.04.2019 15:45, Christian Borntraeger wrote:
> 
> 
> On 29.04.19 15:40, Cornelia Huck wrote:
>> On Mon, 29 Apr 2019 09:09:41 -0400
>> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
>>
>>> Newer versions of zipl have the ability to write signature entries to the boot
>>> script for secure boot. We don't yet support secure boot, but we need to skip
>>> over signature entries while reading the boot script in order to maintain our
>>> ability to boot guest operating systems that have a secure bootloader.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>  pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
>>>  pc-bios/s390-ccw/bootmap.h | 10 ++++++----
>>>  2 files changed, 23 insertions(+), 6 deletions(-)
>>
>> Skipping something that we don't have support for yet, but that doesn't
>> hinder normal operation sounds reasonable; but can you point me to the
>> relevant commit implementing this in zipl or some documentation? I
>> haven't been able to find something like that in the s390-tools git
>> tree.
> 
> the s390-tools update is currently in preparation, adding Stefan and Peter.

Here's the link to the s390-tools commit that introduces the new
signature component to zipl:

https://github.com/ibm-s390-tools/s390-tools/commit/7c7e10ed8fb048efc4e0cd91b0f6fa704fba128e


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

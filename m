Received: from eggs.gnu.org ([2001:4830:134:3::10]:33008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dxabl-0004EL-UR
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 11:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dxabi-0000dp-AD
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 11:20:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52692
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dxabi-0000cQ-3A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 11:20:10 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8SFHTGe048478
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 11:20:06 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d90t64fdf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 11:20:06 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 28 Sep 2017 16:20:04 +0100
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
	<20170928171919.0a71784c.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 28 Sep 2017 17:20:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170928171919.0a71784c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c88e4612-28cb-ae0b-101c-11b67af91f6e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] 3270 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/28/2017 05:19 PM, Cornelia Huck wrote:
> On Wed, 20 Sep 2017 19:23:12 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Jason found some problems with 3270 which he traced down to insufficient
>> output buffer size. I've looked into the underlying issue (and the
>> relevant code) and I saw strange things. Among others an unreasonable
>> assert requiring the payload of a ccw being less than some more or
>> less arbitrary limit (dictated by the size of the output buffer).
>>
>> Because we were already considering converting 3270 to CcwDataStream I've
>> decided to try do get rid of this strange limitation on the length of the
>> writes too. 
>>
>> This series depends on my IDA work, which can be found here:
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg03434.html.
>>
>> Halil Pasic (2):
>>   s390x/3270: IDA support for 3270 via CcwDataStream
>>   s390x/3270: handle writes of arbitrary length
>>
>>  hw/char/terminal3270.c      | 46 +++++++++++++++++++++++++++------------------
>>  hw/s390x/3270-ccw.c         |  4 ++--
>>  include/hw/s390x/3270-ccw.h |  5 ++---
>>  3 files changed, 32 insertions(+), 23 deletions(-)
>>
> 
> Thanks, applied.
> 

Thx

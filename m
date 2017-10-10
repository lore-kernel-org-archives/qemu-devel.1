Received: from eggs.gnu.org ([2001:4830:134:3::10]:54642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1vgz-0003QD-1D
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1vgv-0000OG-Pp
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:39:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37919
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e1vgv-0000Nw-Ib
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:39:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AEbLrH124495
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:39:29 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgwesb29m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:39:28 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 15:39:27 +0100
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-2-pasic@linux.vnet.ibm.com>
	<20171010152551.33ab63f3.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:39:23 +0200
MIME-Version: 1.0
In-Reply-To: <20171010152551.33ab63f3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <67b57f9c-2dcd-f2bd-88ae-f4ba8e0ccdef@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] s390x/css: be more consistent if
 broken beyond repair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On 10/10/2017 03:25 PM, Cornelia Huck wrote:
> On Wed,  4 Oct 2017 17:41:37 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Calling do_subchannel_work with no function control flags set in SCSW is
>> a programming error. Currently the handle this differently in
>> do_subchannel_work_virtual and do_subchannel_work_passthrough. Let's be
>> consistent and guard with a common assert against this programming error.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/css.c | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> Thanks, applied.
> 

Thank you!

Halil

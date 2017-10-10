Received: from eggs.gnu.org ([2001:4830:134:3::10]:54162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1vfH-0002c6-Dg
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1vfE-00086P-5G
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:37:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57907
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e1vfD-00086D-VW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:37:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AEbL7E124530
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:37:40 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgwesay9b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:37:40 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 15:37:38 +0100
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-9-pasic@linux.vnet.ibm.com>
	<20171010151005.15dc7907.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:37:35 +0200
MIME-Version: 1.0
In-Reply-To: <20171010151005.15dc7907.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bf19ed51-a281-9bd8-d27c-1f3cd8522149@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 8/8] s390x: factor out common ioinst
 handler logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/10/2017 03:10 PM, Cornelia Huck wrote:
> On Wed,  4 Oct 2017 17:41:44 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Some of ioinst the handlers look very much the same: they basically
>> delegate the work to the appropriate css function (doing some always the
>> same stuff before and after the call to the appropriate css function).
>> Let us create a template and get rid of some code.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Suggested-by: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>
>> ---
>>  target/s390x/ioinst.c | 59 ++++++++++++---------------------------------------
>>  1 file changed, 14 insertions(+), 45 deletions(-)
> 
> Staring at this patch, I'm not sure I like it, although I can't quite
> put a finger on *what* I don't like... maybe the whole 'template'
> approach.
> 

Well that's why I was careful to make it a separate patch.
I'm also a bit ambivalent, and did not want to include it in
this series along the lines can be done later if somebody wants,
but Marc convinced me -- kind of. We can just forget about it.

Halil

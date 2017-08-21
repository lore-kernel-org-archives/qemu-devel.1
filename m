Received: from eggs.gnu.org ([2001:4830:134:3::10]:42351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djmom-0006JM-7B
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djmog-0004n1-Me
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:32:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43581
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1djmog-0004mO-GV
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:32:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7LDT9Ux029467
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 09:32:29 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cg0610ys0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 09:32:29 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 14:32:27 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
	<700d1722-baf1-163e-6764-179f1340cc22@linux.vnet.ibm.com>
	<20170821151650.35050b3e.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 15:32:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170821151650.35050b3e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e21f5781-38c9-5909-b0e1-f47de1cb524d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 07/10] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com



On 08/21/2017 03:16 PM, Cornelia Huck wrote:
> On Mon, 21 Aug 2017 13:41:53 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 08/21/2017 11:16 AM, Cornelia Huck wrote:
>>> If we do not provide zpci, pci reconfiguration via sclp is not available
>>> either. Don't indicate it in the sclp facilities and return an invalid
>>> command if the guest tries to issue pci configure/deconfigure.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  hw/s390x/sclp.c | 19 +++++++++++++++----
>>>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> (...)
> 
>> LGTM
> 
> Is that an Acked-by:? Or a Reviewed-by:? :)
> 

r-b

(Not sure what Acked-by from a role other that affected
maintainer means.)

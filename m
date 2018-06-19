Received: from eggs.gnu.org ([2001:4830:134:3::10]:49754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fVI5A-0000da-15
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fVI55-0007jr-2c
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:58:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57232
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fVI54-0007iN-RA
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:58:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5JEsHVU036600
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 10:58:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jq34eaurs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 10:58:01 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 19 Jun 2018 08:58:01 -0600
References: <cover.1528921468.git.alifm@linux.ibm.com>
	<44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
	<0c5d7e42-e6c5-6aa2-8c1b-487c8cc9eb21@de.ibm.com>
	<20180619143230.zjemmhhz7embs2li@gondor.apana.org.au>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 19 Jun 2018 10:57:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180619143230.zjemmhhz7embs2li@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4301ac2e-a8f5-7432-cdd9-f39d30a9fb5e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Detect & register virtio-crypto
 algos only if it can be supported by backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com, Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org



On 06/19/2018 10:32 AM, Herbert Xu wrote:
> On Tue, Jun 19, 2018 at 04:08:05PM +0200, Christian Borntraeger wrote:
>> On 06/19/2018 03:26 PM, Farhan Ali wrote:
>>> A polite ping :)
>>>
>>> If no one has any more comments/feedback then I would like to how to merge these patches to the mainline kernel tree.
>>
>> I think it should go via Michael Tsirkin or Jason Wang (Adding Jason).
>> Also adding Herbert Xu as FYI.
>>
>>
>> I have not looked into the details of the patch, but I like the idea.
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Please post crypto patches to linux-crypto.
> 
> Thanks,
> 

I have cc'ed linux-crypto folks. Sorry I missed them

Thanks
Farhan

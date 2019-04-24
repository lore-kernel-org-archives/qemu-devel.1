Received: from eggs.gnu.org ([209.51.188.92]:34656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hJ9xg-0006mX-4M
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hJ9t0-0004DO-DE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:51:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46898
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hJ9t0-0004Cr-7R
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:51:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3O4heTT016074
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 00:51:57 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s2ghj9m7g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 00:51:57 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 24 Apr 2019 05:51:56 +0100
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
	<875zr43hxj.fsf@linux.ibm.com>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2019 10:21:50 +0530
MIME-Version: 1.0
In-Reply-To: <875zr43hxj.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a1e59aa3-f596-abbd-8365-3a12293d85e8@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 4/6] target/ppc: Build rtas
 error log upon an MCE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: aik@au1.ibm.com, mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au



On Tuesday 23 April 2019 08:08 PM, Fabiano Rosas wrote:
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:
> 
>> +    /*
>> +     * Properly set bits in MSR before we invoke the handler.
>> +     * SRR0/1, DAR and DSISR are properly set by KVM
>> +     */
>> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
>> +        msr |= (1ULL << MSR_LE);
>> +    }
>> +
>> +    if (env->msr && (1ULL << MSR_SF)) {
> 
> Don't you mean & instead of &&?

Ah.. yes.. Thanks for pointing out.

> 
>> +        msr |= (1ULL << MSR_SF);
>> +    }
> 
> 

-- 
Regards,
Aravinda

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ewlkI-0000Ex-Tn
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ewlkF-0008RW-PA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:33:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ewlkF-0008Qb-E0
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:33:51 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2G9XS2n135238
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 05:33:49 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gr7y4fkhe-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 05:33:42 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 09:33:40 -0000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <941d7e1b-b6c2-59bd-90dc-4b19903d2a84@linaro.org>
References: <871sgwmcc3.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<b8642b07-307a-6109-6350-e7830a1b7842@linaro.org>
	<87bmfor7bl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<941d7e1b-b6c2-59bd-90dc-4b19903d2a84@linaro.org>
Date: Fri, 16 Mar 2018 15:03:33 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efkk8ivm.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] Using new TCG Vector infrastructure in PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Richard Henderson <richard.henderson@linaro.org> writes:

> On 03/16/2018 12:08 PM, Nikunj A Dadhania wrote:
>> @@ -1078,8 +1079,8 @@ struct CPUPPCState {
>>      /* Altivec registers */
>>      ppc_avr_t avr[32];
>>      uint32_t vscr;
>> -    /* VSX registers */
>> -    uint64_t vsr[32];
>> +    /* 32 (128bit)- VSX registers */
>> +    ppc_avr_t vsr[32];
>
> Another thing that needs to happen is to make ppc_avr_t to be 16-byte aligned
> (this is documented in tcg-gvec-op.h, I believe).
>
> This is easily accomplished by adding QEMU_ALIGNED(16) to the first union
> member.  And then you'd like to put vsr adjacent to avr so that you're not
> adding another alignment hole.

Sure, will do that.

Regards
Nikunj

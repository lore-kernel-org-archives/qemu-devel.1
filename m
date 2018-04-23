Received: from eggs.gnu.org ([2001:4830:134:3::10]:38701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1fAWQz-0007XN-EJ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1fAWQt-0006AT-GC
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:02:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42506
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1fAWQt-0006A5-Ak
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:02:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3N7xOTc094382
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 04:02:42 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hh9vscp2r-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 04:02:42 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 23 Apr 2018 09:02:40 +0100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20180423065245.GH19804@umbus.fritz.box>
References: <20180423061302.24201-1-nikunj@linux.vnet.ibm.com>
	<20180423065245.GH19804@umbus.fritz.box>
Date: Mon, 23 Apr 2018 13:32:28 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r2n6mju3.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] target/ppc/kvm: set vcpu as online/offline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@samba.org

David Gibson <david@gibson.dropbear.id.au> writes:

> On Mon, Apr 23, 2018 at 11:43:02AM +0530, Nikunj A Dadhania wrote:
>> Set the newly added register(KVM_REG_PPC_ONLINE) to indicate if the vcpu is
>> online(1) or offline(0)
>> 
>> KVM will use this information to set the RWMR register, which controls the PURR
>> and SPURR accumulation.
>> 
>> CC: paulus@samba.org
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> 
>> ---
>> 
>> http://patchwork.ozlabs.org/patch/901897/
>> ---
>>  hw/ppc/spapr.c                  | 1 +
>>  hw/ppc/spapr_rtas.c             | 4 ++++
>>  linux-headers/asm-powerpc/kvm.h | 1 +
>
> The usual convention is to send updates to the imported headers, as a
> general update to a specific kernel SHA, rather than folding just the
> necessary parts into the patches that use them.

Sure, we need to wait until Paul's patch is pulled in.

> This will need to wait for 2.13.

Yes, that is fine.

Regards
Nikunj

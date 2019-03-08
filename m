Received: from eggs.gnu.org ([209.51.188.92]:59425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1h2Ksh-0005ss-3S
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1h2Ksg-000168-9R
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:10:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1h2Ksf-000131-Sd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:10:06 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x28J96QA026739
	for <qemu-devel@nongnu.org>; Fri, 8 Mar 2019 14:10:03 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r3wwj17jb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 14:10:03 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 8 Mar 2019 19:10:02 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <20190304055018.GM7792@umbus.fritz.box>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
	<20190228225759.21328-3-farosas@linux.ibm.com>
	<20190304055018.GM7792@umbus.fritz.box>
Date: Fri, 08 Mar 2019 16:09:56 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o96luqrf.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 2/5] kvm-all: Introduce
 kvm_set_singlestep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

David Gibson <david@gibson.dropbear.id.au> writes:

>> +/* Whether the KVM_SET_GUEST_DEBUG ioctl supports single stepping */
>> +int kvm_has_guestdbg_singlestep(void)
>> +{
>> +    /* return kvm_check_extension(kvm_state, KVM_CAP_GUEST_DEBUG_SSTEP); */
>
> I don't see a KVM_CAP_GUEST_DEBUG_SSTEP in either the qemu or kernel
> trees.  Where does that come from?
>

I realized that this will cause a regression for the other architectures
(and even PPC-PR) that already have the feature when we run QEMU on
older kernels without this capability.

I am becoming inclined to rely on kvmppc_is_pr. Do you see another way
around this?

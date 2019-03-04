Received: from eggs.gnu.org ([209.51.188.92]:60681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1h0nLT-0004sC-2p
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1h0nBA-00037K-Dy
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:58:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1h0nB8-0002zd-EL
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:58:48 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x24Cp5Q7128787
	for <qemu-devel@nongnu.org>; Mon, 4 Mar 2019 07:58:38 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r121bxmj2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 07:58:37 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Mon, 4 Mar 2019 12:58:36 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <20190304055018.GM7792@umbus.fritz.box>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
	<20190228225759.21328-3-farosas@linux.ibm.com>
	<20190304055018.GM7792@umbus.fritz.box>
Date: Mon, 04 Mar 2019 09:58:28 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d0n623uz.fsf@linux.ibm.com>
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

I'll submit that to the kernel this week. I was waiting to make sure this
wouldn't change too much on QEMU side first.

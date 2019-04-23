Received: from eggs.gnu.org ([209.51.188.92]:47957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hIwZY-0005j0-99
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hIwZX-0006jl-70
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:39:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51710
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1hIwZX-0006iv-2U
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:38:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3NEcilr137706
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:38:56 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s221nyxww-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:38:56 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Tue, 23 Apr 2019 15:38:55 +0100
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <155591660602.20338.9804738040071843715.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
Date: Tue, 23 Apr 2019 11:38:48 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <875zr43hxj.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 4/6] target/ppc: Build rtas error log
 upon an MCE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: paulus@ozlabs.org, mahesh@linux.vnet.ibm.com, aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:

> +    /*
> +     * Properly set bits in MSR before we invoke the handler.
> +     * SRR0/1, DAR and DSISR are properly set by KVM
> +     */
> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
> +        msr |= (1ULL << MSR_LE);
> +    }
> +
> +    if (env->msr && (1ULL << MSR_SF)) {

Don't you mean & instead of &&?

> +        msr |= (1ULL << MSR_SF);
> +    }

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fcQRi-0006ny-3j
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fcQRe-00088O-RH
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:18:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fcQRe-00087o-IX
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:18:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w697EB1c081534
	for <qemu-devel@nongnu.org>; Mon, 9 Jul 2018 03:18:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k40b08p24-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 03:18:48 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 9 Jul 2018 08:18:46 +0100
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 9 Jul 2018 09:18:41 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
Content-Language: en-US
Message-Id: <0eaa934e-10bd-5b63-6a87-9cbbc06913df@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 10/15] s390-bios: Support for running
 format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com



On 07/05/2018 07:25 PM, Jason J. Herne wrote:
> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

> +void await_io_int(uint16_t sch_no)
> +{
> +    /*
> +     * wait_psw and ctl6 must be static to avoid stack allocation as gcc cannot
> +     * align stack variables. The stctg, lctlg and lpswe instructions require
> +     * that their operands be aligned on an 8-byte boundary.
> +    */

In fact, the ABI guarantees that the stack is always 8 byte aligned and gcc should 
align any uint64_t to 8 byte as well on the stack.

> +    static uint64_t ctl6 __attribute__((__aligned__(8)));
> +    static PSW wait_psw;
> +

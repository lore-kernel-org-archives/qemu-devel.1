Received: from eggs.gnu.org ([2001:4830:134:3::10]:41542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dZo5O-0004R7-Cz
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 20:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dZo5K-0001ds-6V
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 20:52:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dZo5J-0001co-SW
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 20:52:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6P0nkmx130555
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 20:52:22 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bwqxngmmd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 20:52:22 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 24 Jul 2017 20:52:21 -0400
Date: Tue, 25 Jul 2017 08:52:15 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170724143452.55534-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724143452.55534-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170725005215.GA23015@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/css: fix ilen in IO instruction
 handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-07-24 16:34:52 +0200]:

> When initiating a program check interruption by calling program_interrupt
> the instruction length (ilen) of the current instruction is supplied as
> the third parameter.
> 
> On s390x all the IO instructions are of instruction format S and their
> ilen is 4.  The calls to program_interrupt (introduced by commits
> 7b18aad543 ("s390: Add channel I/O instructions.", 2013-01-24) and
> 61bf0dcb2e ("s390x/ioinst: Add missing alignment checks for IO
> instructions", 2013-06-21)) however use ilen == 2.
> 
> This is probably due to a confusion between ilen which specifies the
> instruction length in bytes and ILC which does the same but in halfwords.
> If kvm_enabled() this does not actually matter, because the ilen
> parameter of program_interrupt is effectively unused.
> 
> Let's provide the correct ilen to program_interrupt.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Fixes:  7b18aad543 ("s390: Add channel I/O instructions.")
> Fixes: 61bf0dcb2e ("s390x/ioinst: Add missing alignment checks for IO instructions")
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/ioinst.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
If I didn't misunderstandd, David will take care of the non-I/O cases.
So:

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

[...]

-- 
Dong Jia Shi

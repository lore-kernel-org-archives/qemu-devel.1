Received: from eggs.gnu.org ([2001:4830:134:3::10]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cECiq-0006dZ-Gk
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cECil-0001ZP-Io
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:11:40 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:51710
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cECil-0001Z2-AU
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:11:35 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6AA5BP001365
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 05:11:34 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275ns2m3sj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 05:11:34 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 20:11:31 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <37c840a9-b9c1-4308-fbff-2e22c8f57d09@twiddle.net>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<37c840a9-b9c1-4308-fbff-2e22c8f57d09@twiddle.net>
Date: Tue, 06 Dec 2016 15:41:24 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3ztgyer.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 03/13] target-ppc: implement lxvl
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:
>> +void helper_lxvl(CPUPPCState *env, target_ulong addr,
>> +                 target_ulong xt_num, target_ulong rb)
>> +{
>> +    ppc_vsr_t xt;
>> +
>> +    getVSR(xt_num, &xt, env);
>> +    if (unlikely((rb & 0xFF) == 0)) {
>> +        xt.s128 = int128_make128(0, 0);
>> +    } else {
>> +        target_ulong end = ((rb & 0xFF) * 8) - 1;

Found the above wrong it the code, ISA is extracting bit 0:7
from GPR[RB]

Regards
Nikunj

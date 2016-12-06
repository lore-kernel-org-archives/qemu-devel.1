Received: from eggs.gnu.org ([2001:4830:134:3::10]:39742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8aT-0004qt-CZ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8aQ-00060F-98
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:46:45 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:38131
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cE8aP-000606-Vy
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:46:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB65ixqT005136
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 00:46:40 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275q0jhr9b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 00:46:40 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 15:46:38 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <f0f4c7ff-ac27-ffc2-10b4-c212b33bbadc@twiddle.net>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<f0f4c7ff-ac27-ffc2-10b4-c212b33bbadc@twiddle.net>
Date: Tue, 06 Dec 2016 11:16:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877f7dip8q.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 05/13] target-ppc: implement stxvl
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

> On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
>> +    for (i = 15; i > 15 - end; i--) {
>> +        cpu_stb_data_ra(env, addr, xt.u8[i], GETPC());
>> +        addr = addr_add(env, addr, 1);
>> +    }
>
> (1) you need to handle nb > 16.

Sure will handle that.

> (2) don't you need different byte indexing for little-endian?

AFAIU, no, I am going by the example of the ISA.

Regards
Nikunj

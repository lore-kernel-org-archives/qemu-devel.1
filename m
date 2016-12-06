Received: from eggs.gnu.org ([2001:4830:134:3::10]:44294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEBO4-0007jm-Ax
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEBO1-0006YM-AJ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:46:08 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:44237
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cEBO1-0006Xq-01
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:46:05 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB68hjNo063658
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 03:46:03 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275ns2guxt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 03:46:03 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 18:46:01 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <8e4a0e60-c44a-5591-9b91-b77bd1e1b2c1@twiddle.net>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-12-git-send-email-nikunj@linux.vnet.ibm.com>
	<8e4a0e60-c44a-5591-9b91-b77bd1e1b2c1@twiddle.net>
Date: Tue, 06 Dec 2016 14:15:54 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871sxligxp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 11/13] target-ppc: implement xsnegqp
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
>> +    case OP_NEG:                                                  \
>> +        tcg_gen_xor_i64(xbh, xbh, sgm);                           \
>> +        tcg_gen_xori_i64(xbl, xbl, 0);                            \
>> +        break;                                                    \
>
> No point in the xori.

Yeah, right.

Regards
Nikunj

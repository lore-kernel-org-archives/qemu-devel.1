Received: from eggs.gnu.org ([2001:4830:134:3::10]:56792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQToe-0001nQ-SC
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 01:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQTob-0002Ti-S2
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 01:52:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34359
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cQTob-0002TJ-NN
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 01:52:21 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v096mUTb060186
	for <qemu-devel@nongnu.org>; Mon, 9 Jan 2017 01:52:20 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27v55y12tb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 01:52:19 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 9 Jan 2017 12:22:16 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170109024909.GE12515@umbus.fritz.box>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170109024909.GE12515@umbus.fritz.box>
Date: Mon, 09 Jan 2017 12:21:58 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874m18rai9.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 00/14] POWER9 TCG enablements - part10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Fri, Jan 06, 2017 at 11:44:42AM +0530, Nikunj A Dadhania wrote:
>> This series contains 11 new instructions for POWER9 ISA3.0
>>      VSX Vector Insert/Extract Word
>>      VSX Scalar Extract Exponent/Significand
>>      VSX Scalar Convert
>>      VSX Scalar Add QP
>>      Various float related improvements
>
> Applied to ppc-for-2.9, thanks.

Found issue in register numbering in 3 instructions.
xsaddqp
xscvdpqp
xscvqpdp

Please drop following:

  target-ppc: Add xsaddqp instructions
  target-ppc: Add xscvdpqp instruction
  target-ppc: Add xscvqpdp instruction

I will resend them.

Regards
Nikunj

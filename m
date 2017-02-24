Received: from eggs.gnu.org ([2001:4830:134:3::10]:36410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch8pQ-0004NK-NP
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch8pN-0007Zj-Le
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:54:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ch8pN-0007ZW-Cd
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:54:01 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1O5rdLA111578
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 00:54:00 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28t61rknrq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 00:53:59 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 11:23:56 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170224050242.GA17615@umbus.fritz.box>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170224050242.GA17615@umbus.fritz.box>
Date: Fri, 24 Feb 2017 11:23:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87poi88780.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v4 00/15] POWER9 TCG enablements - part15
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
> On Fri, Feb 24, 2017 at 01:26:25AM +0530, Nikunj A Dadhania wrote:
>> Patches:
>> 01-06  Cleans up the XER split out variables and now the 
>>        flag bits are stored in XER at their respective places 
>> 
>> 07-14  Contains implentation of CA32 and OV32 bits added to the 
>>        ISA 3.0. Various fixed-point arithmetic instructions are 
>>        updated to take care of the newer flags.
>>  
>> 15     Finally the last patch adds new instruction mcrxrx, that helps
>>        reading the carry (CA and CA32) and the overflow (OV and OV32) flags
>
> I've applied 1/15, I've rest the left pending correction of 2/15 and
> discussions on the rest.

I thought of changing back to previous implementation, and posted v5 :-)

/me needs to slow down !

Regards,
Nikunj

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1diI1O-0007Ku-UG
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1diI1K-00072l-VW
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:27:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46613
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1diI1K-000721-QW
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:27:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7HANx9f042037
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 06:27:21 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cd4qc8sre-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 06:27:21 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 17 Aug 2017 20:27:18 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170817013426.GB5509@umbus.fritz.box>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287473305.9760.9007559736340136424.stgit@aravinda>
	<20170817013426.GB5509@umbus.fritz.box>
Date: Thu, 17 Aug 2017 15:57:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fucqjxq8.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] ppc: spapr: Register and handle
 HCALL to receive updated RTAS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@samba.org, sam.bobroff@au1.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:

> On Wed, Aug 16, 2017 at 02:42:13PM +0530, Aravinda Prasad wrote:
>> Receive updates from SLOF about the updated rtas-base.
>> A separate patch for SLOF [1] adds functionality to invoke
>> a private HCALL whenever OS issues instantiate-rtas with
>> a new rtas-base.
>> 
>> This is required as QEMU needs to know the updated rtas-base
>> as it allocates error reporting structure in RTAS space upon
>> a machine check exception.
>> 
>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120386.html
>> 
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> Actually, I take back this R-b, see below.
>
> In any case I'm not willing to apply the patches which depend on this
> until the corresponding SLOF update is merged as well.

We already have this sitting around in SLOF for a while

https://git.qemu.org/gitweb.cgi?p=SLOF.git;a=commit;f=lib/libhvcall/libhvcall.h;h=f9a60de30492863811c2cdf6f28988c9e8a2c3d9

Regards
Nikunj

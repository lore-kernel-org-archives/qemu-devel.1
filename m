Received: from eggs.gnu.org ([2001:4830:134:3::10]:43987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dT7ow-0005gU-J3
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dT7os-0002pb-5i
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:31:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dT7or-0002p7-S8
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:31:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v66ESXXG147191
	for <qemu-devel@nongnu.org>; Thu, 6 Jul 2017 10:31:48 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bhm2r8k7h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 10:31:47 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 6 Jul 2017 11:31:45 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
	<f89c6897-9555-100a-7252-a705fcbc8ee6@linux.vnet.ibm.com>
	<20170705110414.GN2180@umbus.fritz.box>
	<0e4deabe-58e9-6c15-5910-cda9f8e63f9b@linux.vnet.ibm.com>
Date: Thu, 6 Jul 2017 11:31:35 -0300
MIME-Version: 1.0
In-Reply-To: <0e4deabe-58e9-6c15-5910-cda9f8e63f9b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <89240dbb-56b7-e540-8981-b6af20eb0d8c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/5] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, sursingh@redhat.com, groug@kaod.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com



On 07/05/2017 06:53 PM, Daniel Henrique Barboza wrote:
> Worth a try. I'll see if I can make a POC of this DRC reset at incoming
> migration time. 


Just played a little with the idea of manual reset during migration. 
I've created a
POC that resets the CPU DRCs in a pre_load hook. Then I've done the same
experiment - device_add on both source and target before the migration,
hot unplug the device after migration is completed. The hot unplug worked as
expected in both QEMU and guest.

To minimize the impact I am resetting only the DRCs of the CPUs that 
were hotplugged
in the target instead of resetting everybody.

I'll see if this solution works for LMBs and PCI devices. In case 
affirmative, and
if we are fine with this solution of resetting the DRCs in pre_load (not 
sure if pre_load is
the right place for doing it - suggestions welcome), I can send a patch 
to be applied on top
of this series.



Thanks,

Daniel

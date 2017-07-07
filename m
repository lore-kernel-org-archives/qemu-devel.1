Received: from eggs.gnu.org ([2001:4830:134:3::10]:41042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dTakQ-00054W-5N
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dTakN-0004qL-0j
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:25:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dTakM-0004pB-MO
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:25:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v67LOsDV131615
	for <qemu-devel@nongnu.org>; Fri, 7 Jul 2017 17:25:05 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bjg03mapt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 17:25:04 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 7 Jul 2017 18:25:01 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
	<f89c6897-9555-100a-7252-a705fcbc8ee6@linux.vnet.ibm.com>
	<20170705110414.GN2180@umbus.fritz.box>
	<0e4deabe-58e9-6c15-5910-cda9f8e63f9b@linux.vnet.ibm.com>
	<89240dbb-56b7-e540-8981-b6af20eb0d8c@linux.vnet.ibm.com>
	<20170707071409.GF24325@umbus.fritz.box>
	<0a4bc3ed-530f-ba4a-44af-37781ea41ad5@linux.vnet.ibm.com>
Date: Fri, 7 Jul 2017 18:24:52 -0300
MIME-Version: 1.0
In-Reply-To: <0a4bc3ed-530f-ba4a-44af-37781ea41ad5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <5ad4a1c3-1d14-0aa1-b347-f8e7e77b6883@linux.vnet.ibm.com>
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


> Anyway, this was more of an experiment than a serious fix proposal.
> I believe the general idea is solid but it'll get a couple of spins to 
> get a
> good patch for pushing. I'll send the POC as a RFC to get things 
> started and
> we'll see what happens.

I've sent the POC as RFC here:

"[RFC drcVI PATCH] spapr: reset DRCs on migration pre_load"


The patch mentions drcVI because it was made on top of this series. Let 
me know
what you think.

Daniel

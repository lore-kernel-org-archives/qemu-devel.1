Received: from eggs.gnu.org ([2001:4830:134:3::10]:55332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAIau-00068G-Em
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAIar-00028D-8J
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:11:36 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:33993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dAIar-000282-24
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:11:33 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9D588E2F30
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 18:11:31 +0200 (CEST)
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
	<20170515151602.61dc381d@bahia>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b2fe560d-e8ef-dc47-2f7a-e06092a503b6@kaod.org>
Date: Mon, 15 May 2017 18:11:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170515151602.61dc381d@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

>>> +        int smt = kvmppc_smt_threads();
>>> +        int nr_servers = DIV_ROUND_UP(max_cpus * smt, smp_threads);  
>>
>> may be we should reintroduce nr_servers at the machine level ? 
>>
> 
> I had reintroduced it but then I realized it was only used in this
> function.

nr_servers is also used when the device tree is populated with the 
interrupt controller nodes. No big deal.

C. 

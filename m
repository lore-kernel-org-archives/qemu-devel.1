Received: from eggs.gnu.org ([2001:4830:134:3::10]:41175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvMHH-0005QH-Rz
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvMHE-0005YT-Mm
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:37:51 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:36806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dvMHE-0005Y4-GO
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:37:48 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 206C06488C
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 13:37:47 +0200 (CEST)
References: <87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170921053107.GD4998@umbus.fritz.box>
	<87y3p7nugc.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<e2ad1b05-0e93-5389-92b5-7d9ebdd273f8@kaod.org>
	<20170922101201.GG4998@umbus.fritz.box>
	<8cf3e77a-e397-c082-f1a2-b6b8c6be439f@kaod.org>
	<20170922112042.GR4998@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <42a1f20a-09d0-f510-c3be-4062b7ffdafe@kaod.org>
Date: Fri, 22 Sep 2017 13:37:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170922112042.GR4998@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org

>> well, it would be good to be able to define chips with different
>> numbers of cpus. That is something will we want to do for sure.
> 
> You mean multiple chips in a single system with non-uniform numbers of
> cores?  Are there really such systems in the wild?
> 

When CPU fail for some reason, yes. They are garded by the FW and next
boot the system will have different numbers of CPUs on its chip.

C.

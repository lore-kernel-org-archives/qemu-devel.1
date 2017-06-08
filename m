Received: from eggs.gnu.org ([2001:4830:134:3::10]:35653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIzzS-0007Od-20
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIzzP-0001vi-Dk
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:08:54 -0400
Received: from 16.mo4.mail-out.ovh.net ([188.165.55.104]:57344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dIzzP-0001v8-7Q
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:08:51 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id CF4CF70C35
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 18:08:49 +0200 (CEST)
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692936183.12119.5013623492394505174.stgit@bahia>
	<5022e1af-9b70-518a-ce61-cadc905e637f@kaod.org>
	<20170608163207.45ba5618@bahia.ttt.fr.ibm.com>
	<018ad85d-6b7f-53d9-e3dc-4a79fcc81767@kaod.org>
	<20170608174559.053df142@bahia.ttt.fr.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a5d61649-5e45-7e36-b5ac-06dbf14a71a3@kaod.org>
Date: Thu, 8 Jun 2017 18:08:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170608174559.053df142@bahia.ttt.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/6] xics: introduce macros for ICP/ICS
 link properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>


>>> FWIW, other people do that as well (see hw/i386/pc_q35.c for example).  
>>
>> well, I don't see the benefits of changing a string constant by a 
>> define. 
>>
> 
> Improved semantics,  especially since the "xics" string appears in 
> many places with different meanings. 

ah ? If so, we should do a cleanup up. The code seems consistent from 
what I can see. xics is a general name for :

	'PowerPC interrupt controller (type 2)' 

and it is mostly used as a prefix. There are no "xics" object, only a 
XICSFabric which is a QOM interface of the machine with a bunch of 
handlers. It worked out pretty well for sPAPR and PowerNV.

It won't be the case for XIVE, the interrupt controller (type 3) for 
the P9. It is more complex and there are quite a lot of internal 
states which will need to be gathered under an object. We can keep 
the ICPState fortunately but the sources are quite different.

C.

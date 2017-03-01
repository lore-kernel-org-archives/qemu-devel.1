Received: from eggs.gnu.org ([2001:4830:134:3::10]:41861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cj0uZ-0004gd-Es
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cj0uT-0003tm-Vf
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:51:07 -0500
Received: from nm19-vm6.bullet.mail.ir2.yahoo.com ([212.82.96.239]:58152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cj0uT-0003ss-Gc
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:51:01 -0500
Date: Wed, 1 Mar 2017 09:50:58 +0000 (UTC)
From: oussema ben khedher <oussemakeder@yahoo.fr>
Reply-To: oussema ben khedher <oussemakeder@yahoo.fr>
Message-ID: <1580844463.210110.1488361858695@mail.yahoo.com>
MIME-Version: 1.0
References: <1580844463.210110.1488361858695.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] need help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


I am trying to understand the block chaining of QEMU. And I have a question about the branch direction of each executed TBs. Suppose the TB#1 has been executed now, and find the next_tb (TB#2). Then we know the direction is TB#1--->TB#2 and store the chain in code cache for speedup the execution next time. So, next time qemu find the next TB (which is TB#1), then TB#1--->TB#2 will be executed in code cache.
But I think that there are two branch direction of a TB.(branch taken/not taken) My question is how qemu ensure the direction is TB#1--->TB#2 next time?
Thanks all.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUn0v-0003wN-Kx
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUmvr-00026L-6A
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:14:48 -0500
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:39295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUmvq-000255-S0
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:14:43 -0500
Received: from player793.ha.ovh.net (unknown [10.109.146.50])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1949D108613
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 07:14:40 +0100 (CET)
References: <154405861291.2740.13102898879826160714@bb8f5089e434>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6fa9dfc4-5ed2-2e1f-1ac2-bb8e095199b7@kaod.org>
Date: Thu, 6 Dec 2018 07:14:34 +0100
MIME-Version: 1.0
In-Reply-To: <154405861291.2740.13102898879826160714@bb8f5089e434>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/37] ppc: support for the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

Hello,

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 25/37: spapr/xive: add state synchronization with KVM...
> Checking PATCH 26/37: spapr/xive: introduce a VM state change handler...
> ERROR: spaces required around that '*' (ctx:WxV)
> #38: FILE: hw/intc/spapr_xive_kvm.c:341:
> + static void kvmppc_xive_sync_all(sPAPRXive *xive, Error **errp)
>                                              ^
> 
> total: 1 errors, 0 warnings, 135 lines checked

This looks like a false positive.

C.

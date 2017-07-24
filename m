Received: from eggs.gnu.org ([2001:4830:134:3::10]:52559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZcyY-0007c5-07
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZcyT-0001Uc-G2
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:00:42 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:56740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZcyT-0001Ts-4F
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:00:37 -0400
Received: from player732.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 5EC3E123BA2
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 15:00:35 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5ead830d-760e-3486-9287-c1243acad3ea@kaod.org>
Date: Mon, 24 Jul 2017 15:00:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170719030849.GQ3140@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qapi/error.h"
>> +#include "target/ppc/cpu.h"
>> +#include "sysemu/cpus.h"
>> +#include "sysemu/dma.h"
>> +#include "monitor/monitor.h"
>> +#include "hw/ppc/xive.h"
>> +
>> +#include "xive-internal.h"
>> +
>> +/*
>> + * Main XIVE object
> 
> As with XICs, does it really make sense for there to be a "main" XIVE
> object, or should be an interface attached to the machine?

yes. There are internal tables which are very specific to the controller 
and I don't think they belong to the machine.

C.

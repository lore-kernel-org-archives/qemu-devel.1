Received: from eggs.gnu.org ([2001:4830:134:3::10]:45309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZocD-0001Bo-G5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 21:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZocA-0007SW-D5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 21:26:25 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:37580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dZocA-0007S6-61
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 21:26:22 -0400
Received: by mail-pg0-x236.google.com with SMTP id y129so64057611pgy.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 18:26:22 -0700 (PDT)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<5ead830d-760e-3486-9287-c1243acad3ea@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b94d43ed-3d9b-2727-fb0f-8ffb2910aa00@ozlabs.ru>
Date: Tue, 25 Jul 2017 11:26:13 +1000
MIME-Version: 1.0
In-Reply-To: <5ead830d-760e-3486-9287-c1243acad3ea@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 04/26] ppc/xive: introduce a
 skeleton for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 24/07/17 23:00, Cédric Le Goater wrote:
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/log.h"
>>> +#include "qapi/error.h"
>>> +#include "target/ppc/cpu.h"
>>> +#include "sysemu/cpus.h"
>>> +#include "sysemu/dma.h"
>>> +#include "monitor/monitor.h"
>>> +#include "hw/ppc/xive.h"
>>> +
>>> +#include "xive-internal.h"
>>> +
>>> +/*
>>> + * Main XIVE object
>>
>> As with XICs, does it really make sense for there to be a "main" XIVE
>> object, or should be an interface attached to the machine?
> 
> yes. There are internal tables which are very specific to the controller 
> and I don't think they belong to the machine.

These tables belong to a CPU chip (die?) and we do not emulate these now
(machines and cores are the closest) and since we do not want (do we?) to
treat a core as a chip, the machine is the most obvious owner for these tables.


-- 
Alexey

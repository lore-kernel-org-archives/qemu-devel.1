Received: from eggs.gnu.org ([2001:4830:134:3::10]:39482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ehcZy-0001Lp-40
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ehcZt-0002vo-4u
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:38 -0500
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:45424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ehcZs-0002uO-UO
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:33 -0500
Received: from player699.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5714D56D47
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:44:31 +0100 (CET)
References: <20180131082749.1803-1-clg@kaod.org>
	<20180131082749.1803-2-clg@kaod.org>
	<1517538846.2332.14.camel@gmail.com>
	<1517539284.2332.20.camel@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3257a71f-d21a-b09d-9d2b-5a773874e1f7@kaod.org>
Date: Fri, 2 Feb 2018 15:44:27 +0100
MIME-Version: 1.0
In-Reply-To: <1517539284.2332.20.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/ppc: add basic support for PTCR
 on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 02/02/2018 03:41 AM, Suraj Jitindar Singh wrote:
>>> +/*
>>> + * Partition table definitions
>>> + */
>>> +#define PTCR_PTAB               0x0FFFFFFFFFFFF000ULL /* Partition
>>> Table Base */
>>> +#define PTCR_PTAS               0x000000000000001FULL /* Partition
>>> Table Size */
>>> +
>> s/PTCR_PTAB/PTCR_PATB
>> s/PTCR_PTAS/PTCR_PATS
>> To match the ISA?
>
> Also these should be in target/ppc/mmu-book3s-v3.h, they're not hash
> specific
> 

OK. I Will fix that. 

Thanks,

C. 

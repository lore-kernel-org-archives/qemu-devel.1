Received: from eggs.gnu.org ([2001:4830:134:3::10]:34551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhiXn-0000AW-Fp
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 17:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhiXk-0007Ca-D0
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 17:39:03 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:44984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fhiXk-0007BA-5g
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 17:39:00 -0400
Received: from player762.ha.ovh.net (unknown [10.109.160.12])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B34841F6B1
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 23:38:58 +0200 (CEST)
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <25ee1a13-1a4c-0517-a018-d78b20db50cd@kaod.org>
Date: Mon, 23 Jul 2018 23:38:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180718061230.GE2102@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 07/18/2018 08:12 AM, David Gibson wrote:
>> +    /* Setup LSI offset */
>> +    ics->offset = comp + global;
> Oh.. changing ICS offset at runtime.  I hadn't considered that case..

Yes. The PowerNV FW defines the IRQ layout in the overall number space.

C. 

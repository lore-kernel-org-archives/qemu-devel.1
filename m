Received: from eggs.gnu.org ([2001:4830:134:3::10]:44401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@au1.ibm.com>) id 1eL8zj-0001b5-6y
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@au1.ibm.com>) id 1eL8zf-0002M9-MX
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:42:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@au1.ibm.com>) id 1eL8zf-0002KK-EZ
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:42:15 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB2EexfP128446
	for <qemu-devel@nongnu.org>; Sat, 2 Dec 2017 09:42:11 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ekqd8jvy3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 02 Dec 2017 09:42:11 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <benh@au1.ibm.com>;
	Sat, 2 Dec 2017 14:42:09 -0000
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
Date: Sat, 02 Dec 2017 08:41:59 -0600
In-Reply-To: <1512225554.2224.65.camel@kernel.crashing.org>
References: <20171123132955.1261-14-clg@kaod.org>
	<20171130043836.GB3023@umbus.fritz.box>
	<1512225554.2224.65.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <1512225719.2224.68.camel@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 13/25] spapr: introduce the XIVE Event
 Queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Sat, 2017-12-02 at 08:39 -0600, Benjamin Herrenschmidt wrote:
> The IVEs and EQs are managed by the virtualization controller. The VPs
> (aka ENDs) 

typo. aka NVTs

> are managed by the presentation controller. There's a VP per
> real and virtual CPU.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gRpej-0002D3-2b
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 21:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gRpee-0002h3-R1
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 21:32:48 -0500
Message-ID: <e49e34890be88a484b61e62e9a128ca3ff4f67ab.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 28 Nov 2018 13:32:21 +1100
In-Reply-To: <20181128001324.GS2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-10-clg@kaod.org>
	<20181128001324.GS2251@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/36] ppc/xive: notify the CPU when the
 interrupt priority is more privileged
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

On Wed, 2018-11-28 at 11:13 +1100, David Gibson wrote:
> Don't you need a cast to avoid (nsr << 8) being a shift-wider-than-size?

Shouldn't be a problem as long as it fits in an int, no ?

Cheers,
Ben.

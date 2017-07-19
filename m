Received: from eggs.gnu.org ([2001:4830:134:3::10]:59572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dXg5g-0001JJ-Up
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dXg5d-0007IF-QT
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:56:00 -0400
Message-ID: <1500436532.3350.8.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 19 Jul 2017 13:55:32 +1000
In-Reply-To: <20170719030053.GP3140@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<20170719030053.GP3140@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/26] guest exploitation of the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 2017-07-19 at 13:00 +1000, David Gibson wrote:
> So, this is probably obvious, but I'm not considering this a candidate
> for qemu 2.10 (seeing as the soft freeze was yesterday).  I'll still
> try to review and, once ready, queue for 2.11.

Right. I need to review still and we need to make sure we have the
right plumbing for migration etc... and of course I need to do the
KVM bits. So it's definitely not 2.10 material.

Cheers,
Ben.

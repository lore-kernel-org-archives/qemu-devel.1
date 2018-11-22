Received: from eggs.gnu.org ([2001:4830:134:3::10]:58693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gPio7-00013H-BM
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gPio1-000555-ED
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:49:45 -0500
Message-ID: <8e8f737a04e48673e40d3701a20346ac557a7ed7.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 22 Nov 2018 17:49:09 +1100
In-Reply-To: <20181122044127.GE10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-6-clg@kaod.org>
	<20181122044127.GE10448@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/36] ppc/xive: introduce the XIVE
 Event Notification Descriptors
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

On Thu, 2018-11-22 at 15:41 +1100, David Gibson wrote:
> 
> > +void xive_end_reset(XiveEND *end)
> > +{
> > +    memset(end, 0, sizeof(*end));
> > +
> > +    /* switch off the escalation and notification ESBs */
> > +    end->w1 = END_W1_ESe_Q | END_W1_ESn_Q;
> 
> It's not obvious to me what circumstances this would be called under.
> Since the ENDs are in system memory, a memset() seems like an odd
> thing for (virtual) hardware to be doing to it.
> 
> > +}

Not on PAPR ...

Ben.

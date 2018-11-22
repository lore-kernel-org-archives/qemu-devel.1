Received: from eggs.gnu.org ([2001:4830:134:3::10]:59404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gPip7-0001bE-65
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gPip0-0006Lk-IM
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:50:49 -0500
Message-ID: <121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 22 Nov 2018 17:50:07 +1100
In-Reply-To: <20181122044450.GF10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122044450.GF10448@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
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

On Thu, 2018-11-22 at 15:44 +1100, David Gibson wrote:
> 
> Sorry, didn't think of this in my first reply.
> 
> 1) Does the hardware ever actually write back to the EAS?  I know it
> does for the END, but it's not clear why it would need to for the
> EAS.  If not, we don't need the setter.

Nope, though the PAPR model will via hcalls

> 
> 2) The signatures are a bit odd here.  For the setter, a value would
> make sense than a (XiveEAS *), since it's just a word.  For the getter
> you could return the EAS value directly rather than using a pointer -
> there's already a valid bit in the EAS so you can construct a value
> with that cleared if the lisn is out of bounds.

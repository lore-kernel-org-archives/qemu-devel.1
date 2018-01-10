Received: from eggs.gnu.org ([2001:4830:134:3::10]:43064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZ4D0-0004LR-3e
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZ4Cz-0006X2-2W
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:25:33 -0500
Message-ID: <1515543921.1993.14.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 10 Jan 2018 11:25:21 +1100
In-Reply-To: <1316befd-f593-8082-bec5-a1635e866f61@linux.vnet.ibm.com>
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-3-sjitindarsingh@gmail.com>
	<1316befd-f593-8082-bec5-a1635e866f61@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [RFC 2/3]
 hw/spapr/spapr_caps: Add new caps safe_[cache/bounds_check/indirect_branch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Tue, 2018-01-09 at 09:15 -0200, Murilo Opsfelder Araújo wrote:
> On 01/09/2018 07:21 AM, Suraj Jitindar Singh wrote:
> > This patch adds three new capabilities:
> > cap-cfpc -> safe_cache
> > cap-sbbc -> safe_bounds_check
> > cap-ibs  -> safe_indirect_branch
> 
> Hi, Suraj.
> 
> What about splitting this into smaller patches, one per capability?

Yep

> 
> > Each capability is tristate with the possible values "broken",
> > "workaround" or "fixed". Add generic getter and setter functions
> > for
> > this new capability type. Add these new capabilities to the
> > capabilities
> > list. The maximum value for the capabilities is queried from kvm
> > through
> > new kvm capabilities. The requested values are considered to be
> > compatible if kvm can support an equal or higher value for each
> > capability.
> > 
> > Discussion:
> > Currently these new capabilities default to broken to allow for
> > backwards compatibility, is this the best option?
> 
> This could be placed in the cover letter, not in the commit 

Only here because this is an RFC

> 
> Cheers
> Murilo
> 

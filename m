Received: from eggs.gnu.org ([2001:4830:134:3::10]:52858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0P4B-0006L5-5c
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0P47-00020N-7P
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:37:11 -0400
Date: Fri, 6 Oct 2017 11:37:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171006113702.4a7d0380@nial.brq.redhat.com>
In-Reply-To: <20171006091202.GG10961@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-5-git-send-email-imammedo@redhat.com>
	<20171006030256.GF3260@umbus.fritz.box>
	<20171006102738.06b23f3f@nial.brq.redhat.com>
	<20171006091202.GG10961@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/23] ppc: mpc8544ds/e500plat: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

On Fri, 6 Oct 2017 20:12:02 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Oct 06, 2017 at 10:27:38AM +0200, Igor Mammedov wrote:
> > On Fri, 6 Oct 2017 14:02:56 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Thu, Oct 05, 2017 at 06:24:31PM +0200, Igor Mammedov wrote:  
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
> > > 
> > > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > > 
> > > Do you want me to queue the ppc patches here, or do you already have a
> > > plan for that?  
> > Id didn't want to distract others with only PPC related code so
> > I've posted this series separately for you to merge it via PPC tree  
> 
> Ok.  I'm happy to do that, but I have queries on a few patches, so at
> this point I'm anticipating a respin.
I'm planing to do it (most likely on Monday)

> Just to be clear, you're intending for me to take the whole series?
> Or just the patches within the ppc code?
if 1-3/23 isn't in master by the time you take series, you'd need them as well
(it shouldn't cause any conflicts if Eduardo merges them first)

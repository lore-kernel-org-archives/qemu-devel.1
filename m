Received: from eggs.gnu.org ([2001:4830:134:3::10]:37908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f94xr-0005EU-Q3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f94xn-0003d8-0L
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:30:47 -0400
Date: Thu, 19 Apr 2018 10:30:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180419103019.39f8850a@redhat.com>
In-Reply-To: <20180419041520.GJ2317@umbus.fritz.box>
References: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
	<1524061685-83305-3-git-send-email-imammedo@redhat.com>
	<20180419041520.GJ2317@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 v2 2/5] ppc: e500: switch E500
 based machines to full machine definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, Alexander Graf <agraf@suse.de>, "open list:e500" <qemu-ppc@nongnu.org>

On Thu, 19 Apr 2018 14:15:20 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Apr 18, 2018 at 04:28:02PM +0200, Igor Mammedov wrote:
> > Convert PPCE500Params to PCCE500MachineClass which it essentially is,
> > and introduce PCCE500MachineState to keep track of E500 specific
> > state instead of adding global variables or extra parameters to
> > functions when we need to keep data beyond machine init
> > (i.e. make it look like typical fully defined machine).
> > 
> > It's pretty shallow conversion instead of currently used trivial
> > DEFINE_MACHINE() macro. It adds extra 60LOC of boilerplate code
> > of full machine definition.
> > 
> > The patch on top[1] will use PCCE500MachineState to keep track of
> > platform_bus device and add E500Plate specific machine class
> > to use HOTPLUG_HANDLER for explicitly initializing dynamic
> > sysbus devices at the time they are added instead of delaying
> > it to machine done time by platform_bus_init_notify() which is
> > being removed.
> > 
> > 1)  <1523551221-11612-3-git-send-email-imammedo@redhat.com>
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>  
> 
> As noted elsewhere, I've already merged this into my ppc-for-2.13
> tree.  However, don't let that stop you from posting and/or queueing
> it elsewhere.  Whoever ends up merging first once 2.13 opens, it
> should be easy to resolve.
Yep, that's been intention, i.e. have whole series on list so
reader won't have to hunt for queued dependencies in different trees.
After all it's trivial to fix merge conflict when path is merged
in several trees.

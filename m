Received: from eggs.gnu.org ([2001:4830:134:3::10]:44703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1d2S0x-0002Ko-AP
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 20:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1d2S0u-0001Ko-5x
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 20:38:03 -0400
In-Reply-To: <20170423231722.GA14558@umbus.fritz.box>
References: <201704212158.v3LLwNYl031738@linux03a.ddci.com>
	<20170423231722.GA14558@umbus.fritz.box>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF7D33B8CD.4B2CD628-ON8625810C.00022270-8625810C.000378AB@ddci.com>
Date: Sun, 23 Apr 2017 19:37:55 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Qemu-devel] Subject: [PATCH] target-ppc: Add global timer
 group A to open-pic.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

David Gibson <david@gibson.dropbear.id.au> wrote on 04/23/2017 06:17:22 
PM:

> From: David Gibson <david@gibson.dropbear.id.au>
> To: Aaron Larson <alarson@ddci.com>
> Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
> Date: 04/23/2017 06:54 PM
> Subject: Re: Subject: [PATCH] target-ppc: Add global timer group A to 
open-pic.
> 
> On Fri, Apr 21, 2017 at 02:58:23PM -0700, Aaron Larson wrote:
> > Add global timer group A to open-pic.  This patch is still somewhat
> > dubious because I'm not sure how to determine what QEMU wants for the
> > timer frequency.  Suggestions solicited.
> 
> This commit message really needs some more context.  What's a "global
> time group A" a and why do we want it?

The open-pic spec includes two sets/groups of timers, groups A and B,
4 timers in each group.  Previously in QEMU the timer group A
registers were implemented but they did not "count" or generate any
interrupts.  The patch makes the timers to do both (count and generate
interrupts).

About a year ago I mentioned that we had implemented this and offered
to submit a patch, which seemed to be acceptable.  Sadly, when I
reviewed the implementation it had several egregious errors that I
didn't know how to fix until recently.

Quite frankly I didn't expect the patch to be accepted in its current
form for the reason mentioned in the above commit log and was hoping
for some guidance.  If this is no longer a desirable patch, I can
certainly continue to maintain it locally for our use.\

Aaron.

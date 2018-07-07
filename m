Received: from eggs.gnu.org ([2001:4830:134:3::10]:38445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fbugC-0006ZC-V3
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 17:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fbugC-0008Dh-4v
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 17:23:44 -0400
Date: Sat, 7 Jul 2018 14:23:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180707212325.GB1951@roeck-us.net>
References: <1530798684-23009-1-git-send-email-linux@roeck-us.net>
	<eb53939b-4a90-2e7b-32df-3dbe75169d3b@redhat.com>
	<20180706011849.GK3450@umbus.fritz.box>
	<afa973b5-f32e-c88e-ad2b-9edb864f6477@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa973b5-f32e-c88e-ad2b-9edb864f6477@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Add comment explaining ignored
 errors from fdt operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, Pilippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, Jul 06, 2018 at 02:41:18PM +0200, Paolo Bonzini wrote:
> On 06/07/2018 03:18, David Gibson wrote:
> >> Ok, but why would it even fail?  Maybe it's not this case, but even if
> >> it's not fatal for the OS, generating different device trees silently
> >> seems like a recipe for Heisenbugs.
> > Yes, quite.  Especially since the most likely errors I can see here
> > would actually indicate something has already gone horribly wrong with
> > the device tree construction, so a missing clock-frequency is the
> > least of our troubles.
> > 
> > I think using _FDT() here would be a better approach.
> 
> Or qemu_fdt_setprop_cell, which is there exactly for this reason.
> Volunteers needed to report it in checkpatch! :)
> 
Sure, except it uses different parameters. Why don't you come up with
an implementation that is acceptable to you ? I was asked earlier to add
the comment, which I did, only to now be told that it is insufficient.
This can go on forever. At this point, I'll be happy to send a revert
request.

Guenter

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fAWtE-0004lM-Gm
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fAWt7-00034d-6D
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:31:58 -0400
Message-ID: <1524472299.3017.20.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Mon, 23 Apr 2018 10:31:39 +0200
In-Reply-To: <20180420102117.GQ2434@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org

On Fri, 2018-04-20 at 20:21 +1000, David Gibson wrote:
> On Fri, Apr 20, 2018 at 11:31:10AM +0200, Andrea Bolognani wrote:
> > I'll check out what other distros are doing: if all the major ones
> > are defaulting to 64 KiB pages these days, it might be reasonable
> > to do the same and pretend smaller page sizes don't exist at all in
> > order to avoid the pain of having to tweak yet another knob, even
> > if that means leaving people compiling their own custom kernels
> > with 4 KiB page size in the dust.
> 
> That's my guess.

I just checked RHEL 7, Fedora 27, OpenSUSE Leap 42.3, Debian 9 and
Ubuntu 16.04: they all use 64 KiB pages, so I'd conclude leaving
out 4 KiB pages support is basically a non-issue.

-- 
Andrea Bolognani / Red Hat / Virtualization

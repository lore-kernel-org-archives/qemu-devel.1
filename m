Received: from eggs.gnu.org ([2001:4830:134:3::10]:42595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gEwDv-0005Ka-32
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gEwDp-0002mU-Bx
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:55:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gEwDn-0002gL-B2
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:55:45 -0400
Date: Tue, 23 Oct 2018 08:55:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023084024-mutt-send-email-mst@kernel.org>
References: <20181022183656.4902-1-sameo@linux.intel.com>
	<20181022172616-mutt-send-email-mst@kernel.org>
	<20181023090018.GA8387@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023090018.GA8387@caravaggio>
Subject: Re: [Qemu-devel] [PATCH 00/27] ACPI hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org

On Tue, Oct 23, 2018 at 11:00:18AM +0200, Samuel Ortiz wrote:
> > I wonder whether the code can be refactored slightly differently:
> > instead of common code calling out to platform specific one,
> > have platform code call out to generic one.
> > That would avoid indicectiin

should have been indirection

> > but I'm not sure at what cost
> > in complexity.
> I may be misunderstanding your point, so forgive me if that's the case.
> But the code refactoring actually lead to both of the code paths you're
> describing. The generic code calls into platform specific hooks for
> potentially calling custom ACPI tables, but the platform code also uses
> the now shared generic code.

Right. So if instead of both we could have only platform calling generic
code, we could drop some of the hooks.

What I'm saying is that if I look at patches 1-17 which are supposed to
be just refactorings, somehow at the surface instead of reducing lines
of code they add 100 LOC.

And the whole patchset adds about 1000 LOC, by comparison e.g. pc_q35.c
is just 400 LOC since q35 and pc share a bunch of code.  I wonder why
can't more code be shared with e.g. ARM which also has a virt machine
type. In other words, assuming we are doing PV, can't it be more
portable.

Again all that's still because all I read is the diffstats, it's without
reading the patches, sorry about that.

-- 
MST

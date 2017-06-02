Received: from eggs.gnu.org ([2001:4830:134:3::10]:50339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGe3Q-0004oh-EY
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 00:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGe3K-0001ch-9Z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 00:19:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dGe3K-0001c1-3Q
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 00:19:10 -0400
Date: Fri, 2 Jun 2017 12:18:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170602041857.GA4056@pxdev.xzpeter.org>
References: <87d1ar504h.fsf@dusky.pond.sub.org>
	<c666d24d-c8fc-ea77-af25-7f528aee0a81@redhat.com>
	<20170601192206.3z6yki3sji5efrjc@aurel32.net>
	<2178962.Og9WLNWV2W@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2178962.Og9WLNWV2W@np-p-burton>
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jun 01, 2017 at 03:06:29PM -0700, Paul Burton wrote:
> Hi Aurelien/Paolo/Marcel,
> 
> On Thursday, 1 June 2017 12:22:06 PDT Aurelien Jarno wrote:
> > On 2017-06-01 16:23, Paolo Bonzini wrote:
> > > On 01/06/2017 10:27, Marcel Apfelbaum wrote:
> > > > On 31/05/2017 11:28, Paolo Bonzini wrote:
> > > >> No, for now I'd rather just go and remove msi_nonbroken.  When someone
> > > >> reports a bug, we can add back "msi_broken".
> > > > 
> > > > Hi,
> > > > I agree with the direction, but I am concerned msi_nonbroken is there
> > > > for a reason.
> > > > We might break some (obscure/not in use) machine.
> > > > Maybe we should CC all arch machine maintainers/contributors to give
> > > > them a chance to object...
> > > 
> > > Yeah, Alpha, MIPS and SH are those that support PCI.  Adding Richard and
> > > Aurelien, do your platforms support MSI on real hardware but not in QEMU?
> > 
> > SH clearly doesn't support MSI.
> > 
> > The oldest MIPS board also do not support MSI, but I guess the Boston
> > board might support it. I am adding Paul Burton in Cc: who probably
> > knows about that.
> > 
> > Aurelien
> 
> Indeed, real Boston hardware does support MSI (or rather, the Xilinx AXI 
> Bridge for PCI Express IP used on Boston does) & we make use of it in Linux.
> 
> Thanks,
>     Paul

Does this mean that we'd better still keep the msi_nonbroken bit?

Anyway, maybe we can first merge Paolo's fix on edu device:

  [PATCH] edu: fix memory leak on msi_broken platforms

Then we can see whether we still need the rest of the changes.

Thanks,

-- 
Peter Xu

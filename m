Received: from eggs.gnu.org ([2001:4830:134:3::10]:40554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=413fbe59f=roger.pau@citrix.com>)
	id 1donbZ-0004bk-5W
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=413fbe59f=roger.pau@citrix.com>)
	id 1donbU-0000jY-Sr
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:23:41 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:38355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=413fbe59f=roger.pau@citrix.com>)
	id 1donbU-0000ia-HZ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:23:36 -0400
Date: Mon, 4 Sep 2017 10:23:31 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20170904092331.zj2nj4nawzobjero@MacBook-Pro-de-Roger.local>
References: <59A9A6260200007800176A6A@prv-mh.provo.novell.com>
	<59A9A6260200007800176A6A@prv-mh.provo.novell.com>
	<20170901182022.2m46ussfgiwo32c5@MacBook-Pro-de-Roger.local>
	<59AD3349020000780017704A@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59AD3349020000780017704A@prv-mh.provo.novell.com>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] xen: use vMSI related
 #define-s from public interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org

On Mon, Sep 04, 2017 at 03:04:41AM -0600, Jan Beulich wrote:
> >>> On 01.09.17 at 20:20, <roger.pau@citrix.com> wrote:
> > On Fri, Sep 01, 2017 at 10:25:42AM -0600, Jan Beulich wrote:
> >> Xen and qemu having identical #define-s (with different names) is a
> >> strong hint that these should have been part of the public interface
> >> from the very start. Use them if they're available, falling back to
> >> privately defined values only when using older headers.
> >> 
> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > 
> > Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> Thanks.
> 
> >> --- a/hw/xen/xen_pt_msi.c
> >> +++ b/hw/xen/xen_pt_msi.c
> >> @@ -18,6 +18,11 @@
> >>  
> >>  #define XEN_PT_AUTO_ASSIGN -1
> >>  
> >> +#ifndef XEN_DOMCTL_VMSI_X86_DEST_ID_MASK
> >> +#if XEN_DOMCTL_INTERFACE_VERSION >= 0x0000000e
> > 
> > XEN_DOMCTL_INTERFACE_VERSION is already 0xe (without you added
> > defines), I guess it doesn't matter much because we only care for
> > stable releases.
> 
> Well, that's if you build qemu against master Xen. What about
> people building against older Xen versions/headers?

Sorry, I think I haven't explained myself clearly. What I mean is
that if this change gets committed before the Xen side one, QEMU would
not compile against current Xen. As said, this is only a transitory
issue, and it's never going to be a problem in stable branches. This
is because of the "#error" that you add.

Roger.

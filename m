Received: from eggs.gnu.org ([2001:4830:134:3::10]:36425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=241876a3f=anthony.perard@citrix.com>)
	id 1coWgA-0001wK-E2
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=241876a3f=anthony.perard@citrix.com>)
	id 1coWg6-000462-Ez
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:47:02 -0400
Received: from smtp.citrix.com ([66.165.176.89]:22216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=241876a3f=anthony.perard@citrix.com>)
	id 1coWg6-00045x-6c
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:46:58 -0400
Date: Thu, 16 Mar 2017 14:46:56 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170316144656.GD1882@perard.uk.xensource.com>
References: <1489593679-31468-1-git-send-email-igor.druzhinin@citrix.com>
	<20170316122644.GC1882@perard.uk.xensource.com>
	<bfadc05e-4298-744b-a364-1ec75b7e5b0c@citrix.com>
	<383dc5c1-f8f6-d4f2-d548-96ff2712140b@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <383dc5c1-f8f6-d4f2-d548-96ff2712140b@citrix.com>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v5] xen: don't save/restore the
 physmap on VM save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: sstabellini@kernel.org, crosthwaite.peter@gmail.com, qemu-devel@nongnu.org, paul.durrant@citrix.com, pbonzini@redhat.com, xen-devel@lists.xenproject.org, rth@twiddle.net

On Thu, Mar 16, 2017 at 02:06:21PM +0000, Igor Druzhinin wrote:
> On 16/03/17 12:54, Igor Druzhinin wrote:
> > On 16/03/17 12:26, Anthony PERARD wrote:
> >> I've tried to migrate a guest with this patch, but once migrated, the
> >> screen is black (via VNC, keyboard is working fine).
> >>
> > Hmm. It works for me - I've tried to migrate between identical QEMUs
> > with this patch on localhost. Save/restore also works fine.
> > 
> Ok. I could track down the issue - starting from v4 the patch doesn't
> work for cirrus. The reason is that post_load handler is different for
> cirrus and doesn't call the parent handler from common vga code.
> 
> I manage to fix it by updating the corresponding handler by duplicating
> the code. But is it a good solution? Would it be better to have the
> common handler called in this function instead?

:(, vga_common_post_load have a misleading name. Yes, I think it would
be better to have a common post_load been called by every vga cards.

-- 
Anthony PERARD

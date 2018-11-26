Received: from eggs.gnu.org ([2001:4830:134:3::10]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86102624d=anthony.perard@citrix.com>)
	id 1gRIfb-0008KV-Hk
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86102624d=anthony.perard@citrix.com>)
	id 1gRIQA-0003zl-M3
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:03:42 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:55205)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=86102624d=anthony.perard@citrix.com>)
	id 1gRIQ7-0003vE-1v
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:03:32 -0500
Date: Mon, 26 Nov 2018 15:03:07 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181126150307.GM2448@perard.uk.xensource.com>
References: <20181119162658.30358-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181119162658.30358-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/xen/xen_pt_graphics: Don't
 trust the BIOS ROM contents so much
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Mon, Nov 19, 2018 at 04:26:58PM +0000, Peter Maydell wrote:
> Coverity (CID 796599) points out that xen_pt_setup_vga() trusts
> the rom->size field in the BIOS ROM from a PCI passthrough VGA
> device, and uses it as an index into the memory which contains
> the BIOS image. A corrupt BIOS ROM could therefore cause us to
> index off the end of the buffer.
> 
> Check that the size is within bounds before we use it.
> 
> We are also trusting the pcioffset field, and assuming that
> the whole rom_header is present; Coverity doesn't notice these,
> but check them too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Disclaimer: compile tested only, as I don't have a Xen setup,
> let alone one with pass-through PCI graphics.
> 
> Note that https://xenbits.xen.org/xsa/advisory-124.html
> defines that bugs which are only exploitable by a malicious
> piece of hardware that is passed through to the guest are
> not security vulnerabilities as far as the Xen Project is
> concerned, and are treated like normal non-security-related bugs.
> So this is just a bugfix, not a security issue.
> 
> Marked "for-3.1" because it would let us squash another Coverity
> issue, and it is a bug fix; on the other hand it's an obscure
> corner case and has been this way since forever.

I haven't tested that patch either, but the changes looks fine, so:

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

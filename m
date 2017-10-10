Received: from eggs.gnu.org ([2001:4830:134:3::10]:43909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e24KW-0001Wj-Jk
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e24KT-0007H6-VT
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e24KT-0007Gf-P4
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:52:53 -0400
Date: Tue, 10 Oct 2017 16:52:48 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20171002170132.GA2116@perard.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1710101651560.3105@sstabellini-ThinkPad-X260>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
	<1506437019-17946-4-git-send-email-owen.smith@citrix.com>
	<20171002170132.GA2116@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 3/3 v4] xenfb: Add
 [feature|request]-raw-pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Owen Smith <owen.smith@citrix.com>, sstabellini@kernel.org, kraxel@redhat.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On Mon, 2 Oct 2017, Anthony PERARD wrote:
> On Tue, Sep 26, 2017 at 02:43:39PM +0000, Owen Smith wrote:
> > Writes "feature-raw-pointer" during init to indicate the backend
> > can pass raw unscaled values for absolute axes to the frontend.
> > Frontends set "request-raw-pointer" to indicate the backend should
> > not attempt to scale absolute values to console size.
> > "request-raw-pointer" is only valid if "request-abs-pointer" is
> > also set. Raw unscaled pointer values are in the range [0, 0x7fff]
> > 
> > Signed-off-by: Owen Smith <owen.smith@citrix.com>
> 
> Hi Owen,
> 
> Why did you remove the following from the commit description?
> > "feature-raw-pointer" and "request-raw-pointer" added to Xen
> > header in commit 7868654ff7fe5e4a2eeae2b277644fa884a5031e
> 
> I think that with it, you could have kept stefano's reviewed-by tag.

Hi Anthony,

Have you tested this series with a few of different guests? Do you
consider it safe to merge? If so, we can send it upstream (either via
xen or via ui as Gerd kindly offered). 

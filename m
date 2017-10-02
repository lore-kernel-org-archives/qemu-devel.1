Received: from eggs.gnu.org ([2001:4830:134:3::10]:52069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=441524c13=anthony.perard@citrix.com>)
	id 1dz468-0001eP-K6
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=441524c13=anthony.perard@citrix.com>)
	id 1dz463-0003GJ-UY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:01:40 -0400
Received: from smtp.citrix.com ([66.165.176.89]:45214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=441524c13=anthony.perard@citrix.com>)
	id 1dz463-0003Fb-Ol
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:01:35 -0400
Date: Mon, 2 Oct 2017 18:01:33 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171002170132.GA2116@perard.uk.xensource.com>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
	<1506437019-17946-4-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1506437019-17946-4-git-send-email-owen.smith@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 3/3 v4] xenfb: Add
 [feature|request]-raw-pointer
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Owen Smith <owen.smith@citrix.com>
Cc: sstabellini@kernel.org, kraxel@redhat.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Tue, Sep 26, 2017 at 02:43:39PM +0000, Owen Smith wrote:
> Writes "feature-raw-pointer" during init to indicate the backend
> can pass raw unscaled values for absolute axes to the frontend.
> Frontends set "request-raw-pointer" to indicate the backend should
> not attempt to scale absolute values to console size.
> "request-raw-pointer" is only valid if "request-abs-pointer" is
> also set. Raw unscaled pointer values are in the range [0, 0x7fff]
> 
> Signed-off-by: Owen Smith <owen.smith@citrix.com>

Hi Owen,

Why did you remove the following from the commit description?
> "feature-raw-pointer" and "request-raw-pointer" added to Xen
> header in commit 7868654ff7fe5e4a2eeae2b277644fa884a5031e

I think that with it, you could have kept stefano's reviewed-by tag.

Thanks,

-- 
Anthony PERARD

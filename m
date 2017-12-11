Received: from eggs.gnu.org ([2001:4830:134:3::10]:35372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5116ce171=anthony.perard@citrix.com>)
	id 1eORPo-0004Uc-C0
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5116ce171=anthony.perard@citrix.com>)
	id 1eORPk-0008Ke-9P
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:58:52 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:35016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5116ce171=anthony.perard@citrix.com>)
	id 1eORPk-0008IA-2U
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:58:48 -0500
Date: Mon, 11 Dec 2017 16:58:44 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171211165844.GB2216@perard.uk.xensource.com>
References: <20171103115631.15175-1-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171103115631.15175-1-owen.smith@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/4] xenfb: Enablement for Windows PV
 HID frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Owen Smith <owen.smith@citrix.com>
Cc: sstabellini@kernel.org, kraxel@redhat.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org

On Fri, Nov 03, 2017 at 11:56:27AM +0000, Owen Smith wrote:
> Improve the input device model in xenfb, by updating the
> Qemu input handlers and adding a feature to allow for
> raw (unscaled) absolute coordinates to be represented.
> 
> Changes:
>   * use keycodedb to generate qcode to linux input mapping
>   * move rescaling to the mouse_event handler
>   * add activate for raw_pointer devices
> 
> Owen Smith (3):
>   ui: generate qcode to linux mappings
>   xenfb: Use Input Handlers directly
>   xenfb: Add [feature|request]-raw-pointer
>   xenfb: activate input handlers for raw pointer devices

The patch series looks good to me:
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

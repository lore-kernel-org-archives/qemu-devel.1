Received: from eggs.gnu.org ([2001:4830:134:3::10]:36392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=441524c13=anthony.perard@citrix.com>)
	id 1dz4bq-00025o-Ok
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=441524c13=anthony.perard@citrix.com>)
	id 1dz4bn-0005as-Kw
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:34:26 -0400
Received: from smtp.citrix.com ([66.165.176.89]:38757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=441524c13=anthony.perard@citrix.com>)
	id 1dz4bn-0005Zk-El
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:34:23 -0400
Date: Mon, 2 Oct 2017 18:33:40 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171002173340.GB2116@perard.uk.xensource.com>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
	<1506437019-17946-3-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1506437019-17946-3-git-send-email-owen.smith@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 2/3 v4] xenfb: Use Input Handlers directly
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

On Tue, Sep 26, 2017 at 02:43:38PM +0000, Owen Smith wrote:
> Avoid the unneccessary calls through the input-legacy.c file by
> using the qemu_input_handler_*() calls directly. This did require
> reworking the event and sync handlers to use the reverse mapping
> from qcode to linux using qemu_input_qcode_to_linux().
> Removes the scancode2linux mapping, and supporting documention.
> 
> Signed-off-by: Owen Smith <owen.smith@citrix.com>

There is a call to trace_xenfb_key_event() that have been added
upstream, just before the call to xenfb_send_key(), that should probably
be added to this patch, otherwise, the patch does not apply. With that
fix, you can add my:
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

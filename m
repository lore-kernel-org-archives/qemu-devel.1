Received: from eggs.gnu.org ([2001:4830:134:3::10]:43378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=595409ade=anthony.perard@citrix.com>)
	id 1esvFC-0007aB-D6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=595409ade=anthony.perard@citrix.com>)
	id 1esvF8-0004Dp-Fy
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:53:54 -0500
Received: from smtp.citrix.com ([66.165.176.89]:57696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=595409ade=anthony.perard@citrix.com>)
	id 1esvF8-0004DQ-89
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:53:50 -0500
Date: Mon, 5 Mar 2018 18:53:47 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180305185347.GC1921@perard.uk.xensource.com>
References: <20180305112732.26471-1-f4bug@amsat.org>
	<20180305112732.26471-31-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180305112732.26471-31-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 30/30] xen: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

On Mon, Mar 05, 2018 at 08:27:32AM -0300, Philippe Mathieu-Daudé wrote:
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
> 
> and modified manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Alan Robinson <Alan.Robinson@ts.fujitsu.com>
> ---
>  hw/block/xen_disk.c        |  4 ++--
>  hw/xenpv/xen_domainbuild.c | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

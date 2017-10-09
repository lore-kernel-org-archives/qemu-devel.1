Received: from eggs.gnu.org ([2001:4830:134:3::10]:33061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1auo-0002nm-EJ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1auj-0004xI-KY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:28:26 -0400
Received: from smtp.citrix.com ([66.165.176.89]:63651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1auj-0004wQ-EJ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:28:21 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23003.41880.818255.728737@mariner.uk.xensource.com>
Date: Mon, 9 Oct 2017 17:28:08 +0100
In-Reply-To: <1507564902-9000-2-git-send-email-ian.jackson@eu.citrix.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-2-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano  Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

Ian Jackson writes ("[PATCH 1/8] xen: link against xentoolcore"):
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> Xen libraries 4.10 will include a new xentoolcore library, without
> which xendevicemodel et al will not work.

The xentoolcore library was just committed to xen.git#staging, so at
least this patch (or something like it) should go into qemu RSN.

Anthony, do you plan to cherry pick this into the xen-specific qemu
branch used for osstest tests ?

Thanks,
Ian.

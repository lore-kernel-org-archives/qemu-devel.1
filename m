Received: from eggs.gnu.org ([2001:4830:134:3::10]:55363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e23O8-0005WA-0g
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e23O6-0004lr-TK
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:52:36 -0400
Received: from smtp.citrix.com ([66.165.176.89]:21360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e23O6-0004k6-MK
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:52:34 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23005.86.889060.625202@mariner.uk.xensource.com>
Date: Tue, 10 Oct 2017 18:16:06 +0100
In-Reply-To: <20171010114001.GF1771@perard.uk.xensource.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-4-git-send-email-ian.jackson@eu.citrix.com>
	<20171009155044.GC1771@perard.uk.xensource.com>
	<23003.43689.447516.6588@mariner.uk.xensource.com>
	<20171010114001.GF1771@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] xen: defer call to xen_restrict until
 after os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>

Anthony PERARD writes ("Re: [PATCH 3/8] xen: defer call to xen_restrict until after os_setup_post"):
> I'm tring to find out what does calling xen_restrict_all(0), when
> running an non-Xen guest. I think it would just lock(), then unlock()
> then there should not be any handle to restrict, and return 0; is that
> right?

Yes.  If the process has not opened any Xen control handles,
xentoolcore_restrict_all is a no-op.

Ian.

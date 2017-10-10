Received: from eggs.gnu.org ([2001:4830:134:3::10]:49529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e22vj-0000Pk-MY
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e22ve-0007lV-Ns
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:23:15 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:4954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e22ve-0007kF-HC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:23:10 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23005.423.259671.559076@mariner.uk.xensource.com>
Date: Tue, 10 Oct 2017 18:21:43 +0100
In-Reply-To: <74e38d45-c173-4df1-c696-ca19cda41287@citrix.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<892cb484-361b-f1c1-c294-6b5d7b5e92fb@citrix.com>
	<56626155ee594136b8fe0d0de03ca4f5@AMSPEX02CL03.citrite.net>
	<74e38d45-c173-4df1-c696-ca19cda41287@citrix.com>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2 0/*] xen: xen-domid-restrict
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano
	Stabellini <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>

Ross Lagerwall writes ("Re: [Xen-devel] [PATCH v2 0/*] xen: xen-domid-restrict improvements"):
> If no one objects, I propose adding the following calls to 
> libxendevicemodel (with underlying Xen implementations, of course) that 
> would be usable after the xendevicemodel handle has been restricted.
> 
> xendevicemodel_add_to_physmap(xendevicemodel_handle *dmod,
...
> xendevicemodel_pin_memory_cacheattr(xendevicemodel_handle *dmod,
...
> This is equivalent to xc_domain_pin_memory_cacheattr().

These seem fine to me.  If you want this in Xen 4.10 I think you will
want to make a case to Julien (not CC'd) for a release ack.

Ian.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGqH-0001eK-1g
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGqD-0002xx-RO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:09:45 -0500
Received: from smtp.citrix.com ([66.165.176.89]:58013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGqD-0002xi-L0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:09:41 -0500
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23202.31107.416270.677920@mariner.uk.xensource.com>
Date: Fri, 9 Mar 2018 12:09:39 +0000
In-Reply-To: <23202.31050.607695.817387@mariner.uk.xensource.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520530757-4477-4-git-send-email-ian.jackson@eu.citrix.com>
	<20180308200345.GD3417@localhost.localdomain>
	<23202.28943.344150.512881@mariner.uk.xensource.com>
	<23202.30969.590920.764930@mariner.uk.xensource.com>
	<23202.31050.607695.817387@mariner.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] xen: defer call to xen_restrict
 until just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S.
	Tsirkin" <mst@redhat.com>

Ian Jackson writes ("Re: [PATCH 03/11] xen: defer call to xen_restrict until just before os_setup_post"):
> Ian Jackson writes ("Re: [PATCH 03/11] xen: defer call to xen_restrict until just before os_setup_post"):
> > How about this ?
> 
> And here's the corresponding change to the Xen-specific patch.

I should say that I have build-tested this but not executed it yet.
If it seems like the right direction I'll run some tests this
afternoon and resend the whole series.

Ian.

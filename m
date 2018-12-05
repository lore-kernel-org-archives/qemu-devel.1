Received: from eggs.gnu.org ([2001:4830:134:3::10]:43295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUasW-0004ok-H1
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUasR-0007RX-H7
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:22:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gUasR-0007QI-Ac
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:22:23 -0500
Date: Wed, 5 Dec 2018 12:22:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181205121914-mutt-send-email-mst@kernel.org>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<CAKPgXcE1zoFiBgbEqn6VAdsQuR7GfCNTn+pHgekH1XwLAdq-ig@mail.gmail.com>
	<154402670926.16620.2184992513838364109@sif>
	<20181205170916.GK799@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205170916.GK799@angien.pipo.sk>
Subject: Re: [Qemu-devel] [libvirt] [RFC 0/2] Attempt to implement the
 standby feature for assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, libvir-list@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Dec 05, 2018 at 06:09:16PM +0100, Peter Krempa wrote:
> From managements point of view, bundling all this together is really not
> a good idea since it creates a very big matrix of failure scenarios.

I think this is clear. This is why we are doing it in QEMU where we can
actually do all the rollbacks transparently.

> In
> general even libvirt will prefer that upper layer management drives this
> externally, since any rolback scenario will result in a policy decision
> of what to do in certain cases, and what timeouts to pick.

Architectural ugliness of implementing what is from users perspective a
mechanism and not a policy aside, experience teaches that this isn't
going to happen.  People have been talking about the idea of doing
this at the upper layers for years.

-- 
MST

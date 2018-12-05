Received: from eggs.gnu.org ([2001:4830:134:3::10]:44986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUawk-0002uU-Cr
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUawg-00058e-9X
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:26:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gUawg-00057y-1k
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:26:46 -0500
Date: Wed, 5 Dec 2018 17:26:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181205172634.GF22100@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<CAKPgXcE1zoFiBgbEqn6VAdsQuR7GfCNTn+pHgekH1XwLAdq-ig@mail.gmail.com>
	<154402670926.16620.2184992513838364109@sif>
	<20181205170916.GK799@angien.pipo.sk>
	<20181205121914-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205121914-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, Sameeh Jubran <sameeh@daynix.com>, Eduardo Habkost <ehabkost@redhat.com>, libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

On Wed, Dec 05, 2018 at 12:22:18PM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 05, 2018 at 06:09:16PM +0100, Peter Krempa wrote:
> > From managements point of view, bundling all this together is really not
> > a good idea since it creates a very big matrix of failure scenarios.
> 
> I think this is clear. This is why we are doing it in QEMU where we can
> actually do all the rollbacks transparently.
> 
> > In
> > general even libvirt will prefer that upper layer management drives this
> > externally, since any rolback scenario will result in a policy decision
> > of what to do in certain cases, and what timeouts to pick.
> 
> Architectural ugliness of implementing what is from users perspective a
> mechanism and not a policy aside, experience teaches that this isn't
> going to happen.  People have been talking about the idea of doing
> this at the upper layers for years.

The ability to unplugg+replug VFIO devices either side of migration
has existed in OpenStack for a long time. They also have metadata
that can be exposed to the guest to allow it to describe which pairs
of (emulated,vfio) devices should be used together.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([209.51.188.92]:57101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0r5Q-0002er-Ex
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0r5P-00082L-I7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:09:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h0r5O-00080i-2f
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:09:06 -0500
Date: Mon, 4 Mar 2019 17:09:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190304170900.GS4239@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190211170924.uw6a6xyvmznk7w72@6wind.com>
	<20190220030707.GA5504@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220030707.GA5504@minyard.net>
Subject: Re: [Qemu-devel] -device ipmi-bmc-sim attached to -netdev vde
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: Robin Jarry <robin.jarry@6wind.com>, qemu-devel@nongnu.org

On Tue, Feb 19, 2019 at 09:07:08PM -0600, Corey Minyard wrote:
> My suggestion, though, would be to implement something that ran over
> TLS with two-way authentication.  It doesn't look too hard to do
> in qemu (though I haven't tried it) but you could have a qemu console
> running over TLS that would allow you control from another qemu session.
> Plus it would give you authorization and encryption on your qemu
> console logins, which is probably a good thing.
> 
> <shameless-plug> I have been working on a library that makes it easy
> (easier?  The pain is always in the key management) to make TLS
> connections.  It's at https://github.com/cminyard/gensio and you
> can use it from C or Python.</shameless-plug>

On the QEMU side, we already have a framework for doing socket
connections with TLS support in a straightforward manner via
the QIOChannel framework. The code using this in QEMU doesn't
really need to know anything about TLS in order to use this.
We have it wired up in character devices, VNC, migration and
NBD network sockets.

Last week my authorization series merged, so that we can also
easily deal with access control whitelisting permitted clients
via their x509 certificate distinguished name.

So I'd expect anything on the QEMU side that introduces new
network sockets usage to support TLS out of the box with
little extra effort required over plain TCP sockets.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

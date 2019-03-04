Received: from eggs.gnu.org ([209.51.188.92]:39407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1h0tOH-0007Rd-E1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1h0tOF-0005DM-Ju
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:36:45 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:41156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1h0tOF-0005BZ-5E
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:36:43 -0500
Received: by mail-ot1-x331.google.com with SMTP id t7so5242167otk.8
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 11:36:41 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Date: Mon, 4 Mar 2019 13:36:37 -0600
From: Corey Minyard <minyard@acm.org>
Message-ID: <20190304193637.GC25395@minyard.net>
Reply-To: minyard@acm.org
References: <20190211170924.uw6a6xyvmznk7w72@6wind.com>
	<20190220030707.GA5504@minyard.net>
	<20190304170900.GS4239@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190304170900.GS4239@redhat.com>
Subject: Re: [Qemu-devel] -device ipmi-bmc-sim attached to -netdev vde
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Robin Jarry <robin.jarry@6wind.com>, qemu-devel@nongnu.org

On Mon, Mar 04, 2019 at 05:09:00PM +0000, Daniel P. Berrangé wrote:
> On Tue, Feb 19, 2019 at 09:07:08PM -0600, Corey Minyard wrote:
> > My suggestion, though, would be to implement something that ran over
> > TLS with two-way authentication.  It doesn't look too hard to do
> > in qemu (though I haven't tried it) but you could have a qemu console
> > running over TLS that would allow you control from another qemu session.
> > Plus it would give you authorization and encryption on your qemu
> > console logins, which is probably a good thing.
> > 
> > <shameless-plug> I have been working on a library that makes it easy
> > (easier?  The pain is always in the key management) to make TLS
> > connections.  It's at https://github.com/cminyard/gensio and you
> > can use it from C or Python.</shameless-plug>
> 
> On the QEMU side, we already have a framework for doing socket
> connections with TLS support in a straightforward manner via
> the QIOChannel framework. The code using this in QEMU doesn't
> really need to know anything about TLS in order to use this.
> We have it wired up in character devices, VNC, migration and
> NBD network sockets.

Right, I wasn't clear, that was for the client side, not the
qemu side.  I saw that the TLS code was already present in
qemu; no qemu modifications should be required.

> 
> Last week my authorization series merged, so that we can also
> easily deal with access control whitelisting permitted clients
> via their x509 certificate distinguished name.

That's even better.

Thanks,

-corey

> 
> So I'd expect anything on the QEMU side that introduces new
> network sockets usage to support TLS out of the box with
> little extra effort required over plain TCP sockets.
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

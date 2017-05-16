Received: from eggs.gnu.org ([2001:4830:134:3::10]:34318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAcdT-0000MN-1h
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAcdP-0003Mk-4E
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:35:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dAcdO-0003MT-Tz
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:35:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B415D7F4A3
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 13:35:24 +0000 (UTC)
Date: Tue, 16 May 2017 14:35:16 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170516133516.GC16341@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170428121553.22408-1-berrange@redhat.com>
	<20170516123951.GB16341@redhat.com>
	<1494941391.29008.49.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1494941391.29008.49.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: ensure we can bind to both ipv4 &
 ipv6 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, May 16, 2017 at 03:29:51PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > Separately from this patch, I noticed one further possible
> > problem, 
> > 
> > Currently, the ipv4=on|off/ipv6=on|off settings are only
> > used to determine what getaddrinfo results we request/use.
> > 
> > This leads to the somewhat odd situation where if you set
> > ipv4=off,ipv6=on, QEMU won't be listening on an IPv4
> > socket, but *will still* accept IPv4 clients over the IPv6
> > socket due to our use of IPV6_V6ONLY=off.
> 
> Hmm, maybe we should just use IPV6_V6ONLY=on unconditionally?

This would certainly be my long term desire...

> Now that qemu finally supports multiple listening sockets we should be
> able to do the switch without regressions, and it also should remove all
> those nasty corner cases ...

...but we can't do it yet - only the VNC server code has been reworked
to support multiple listening sockets. We'd still have work todo on the
NBD server, chardevs, migration, network socket backend and guest agent
to support multiple listeners.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

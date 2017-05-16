Received: from eggs.gnu.org ([2001:4830:134:3::10]:39346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAcx9-0007DO-FF
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAcx5-0004jR-Ao
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:55:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dAcx5-0004iz-3o
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B83C280C18
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 13:55:39 +0000 (UTC)
Message-ID: <1494942935.29008.52.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 16 May 2017 15:55:35 +0200
In-Reply-To: <20170516133516.GC16341@redhat.com>
References: <20170428121553.22408-1-berrange@redhat.com>
	<20170516123951.GB16341@redhat.com>
	<1494941391.29008.49.camel@redhat.com>
	<20170516133516.GC16341@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Di, 2017-05-16 at 14:35 +0100, Daniel P. Berrange wrote:
> On Tue, May 16, 2017 at 03:29:51PM +0200, Gerd Hoffmann wrote:
> >   Hi,
> >=20
> > > Separately from this patch, I noticed one further possible
> > > problem,=20
> > >=20
> > > Currently, the ipv4=3Don|off/ipv6=3Don|off settings are only
> > > used to determine what getaddrinfo results we request/use.
> > >=20
> > > This leads to the somewhat odd situation where if you set
> > > ipv4=3Doff,ipv6=3Don, QEMU won't be listening on an IPv4
> > > socket, but *will still* accept IPv4 clients over the IPv6
> > > socket due to our use of IPV6_V6ONLY=3Doff.
> >=20
> > Hmm, maybe we should just use IPV6_V6ONLY=3Don unconditionally?
>=20
> This would certainly be my long term desire...
>=20
> > Now that qemu finally supports multiple listening sockets we should be
> > able to do the switch without regressions, and it also should remove al=
l
> > those nasty corner cases ...
>=20
> ...but we can't do it yet - only the VNC server code has been reworked
> to support multiple listening sockets. We'd still have work todo on the
> NBD server, chardevs, migration, network socket backend and guest agent
> to support multiple listeners.

Ah, ok.

I guess then I would not worry too much that we break stuff in case
ipv4=3Doff actually does what it is supposed to do ...

cheers,
  Gerd

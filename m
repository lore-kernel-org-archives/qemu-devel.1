Received: from eggs.gnu.org ([2001:4830:134:3::10]:33055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAcY7-0006nZ-Rx
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAcY4-0001P5-PN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:30:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dAcY4-0001Mw-JM
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:30:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 830563B46C
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 13:29:57 +0000 (UTC)
Message-ID: <1494941391.29008.49.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 16 May 2017 15:29:51 +0200
In-Reply-To: <20170516123951.GB16341@redhat.com>
References: <20170428121553.22408-1-berrange@redhat.com>
	<20170516123951.GB16341@redhat.com>
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

> Separately from this patch, I noticed one further possible
> problem,=20
>=20
> Currently, the ipv4=3Don|off/ipv6=3Don|off settings are only
> used to determine what getaddrinfo results we request/use.
>=20
> This leads to the somewhat odd situation where if you set
> ipv4=3Doff,ipv6=3Don, QEMU won't be listening on an IPv4
> socket, but *will still* accept IPv4 clients over the IPv6
> socket due to our use of IPV6_V6ONLY=3Doff.

Hmm, maybe we should just use IPV6_V6ONLY=3Don unconditionally?

Now that qemu finally supports multiple listening sockets we should be
able to do the switch without regressions, and it also should remove all
those nasty corner cases ...

cheers,
  Gerd

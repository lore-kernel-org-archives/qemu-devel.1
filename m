Received: from eggs.gnu.org ([2001:4830:134:3::10]:58951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIBnA-00086a-Lu
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIBn7-0006ZT-Dh
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:32:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dIBn7-0006ZK-7M
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:32:49 -0400
Message-ID: <1496745166.15129.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 06 Jun 2017 12:32:46 +0200
In-Reply-To: <20170601082935.19993-1-berrange@redhat.com>
References: <20170601082935.19993-1-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Fix handling of IPv4/IPv6 dual stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, 2017-06-01 at 09:29 +0100, Daniel P. Berrange wrote:
> This series aims to fix a lot of bugs related to handling of IPv4 /
> IPv6
> dual stack.
>=20
> =C2=A0- The VNC server mistakenly listened on two separate ports 5900+590=
1
> =C2=A0=C2=A0 when the to=3D parameter was given
> =C2=A0- IPv6 sockets are accepting IPv4 clients even when IPv4 is set to
> =C2=A0=C2=A0 be disabled
> =C2=A0- IPv6 sockets are failing to accept IPv4 clients when IPv4 is not
> set
> =C2=A0=C2=A0 to be disabled
> =C2=A0- The VNC server was loosing the ipv4=3D/ipv6=3D settings due to a =
bug
> =C2=A0=C2=A0 in the DNS resolver
>=20
> The behaviour of all this is really subtle and hard to get working
> correctly
> across all the different network backends. Thus, the most important
> part of
> this patch series is the last patch which adds a test case covering
> the
> backends for -vnc, -chardev tcp, -net socket, and -incoming socket,
> with
> a 120 entry matrix.

Acked-by: Gerd Hoffmann <kraxel@gmail.com>

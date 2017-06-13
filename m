Received: from eggs.gnu.org ([2001:4830:134:3::10]:52395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dKeUw-00030Y-OC
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 01:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dKeUt-0000OB-Gg
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 01:36:14 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:41091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dKeUt-0000Nu-7E
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 01:36:11 -0400
Message-ID: <1497332162.2975.14.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Tue, 13 Jun 2017 07:36:02 +0200
In-Reply-To: <b358f743-e2d2-6b6f-cb82-0452574e6b27@redhat.com>
References: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
	<b358f743-e2d2-6b6f-cb82-0452574e6b27@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] Unit test+fix for problem with QEMU
 handling of multiple bind()s to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 2017-06-09 at 14:39 -0500, Eric Blake wrote:
> On 06/09/2017 02:19 PM, Knut Omang wrote:
> > This series contains:
> > * a unit test that exposes a race condition which causes QEMU to fail
> >=C2=A0=C2=A0=C2=A0to find a port even when there is plenty of available =
ports.
> > * a refactor of the qemu-sockets inet_listen_saddr() function
> >=C2=A0=C2=A0=C2=A0to better handle this situation.
> >=C2=A0
> > Thanks,
> > Knut
> >=C2=A0
> > Knut Omang (2):
> >=C2=A0=C2=A0=C2=A0Add test-listen - a stress test for QEMU socket listen
> >=C2=A0=C2=A0=C2=A0socket: Handle race condition between binds to the sam=
e port
> >=C2=A0
>=20
> I'd reorder the series, to put the fix first and the test second, rather
> than the (crippled) test first.=C2=A0=C2=A0

Are there good reasons not to have the test first? (as long as it does not=
=20
break the build). IMHO the logical test driven approach=C2=A0
is to have the test first to highlight/reproduce=C2=A0the issue.

> Someone that wants to prove that the
> test works can easily apply the patches out of order.

Yes, but in my view that's both less logical and less convenient?

Thanks,
Knut

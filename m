Received: from eggs.gnu.org ([2001:4830:134:3::10]:36469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnO8P-0006HA-U9
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnO8L-0002kR-9X
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnO8L-0002k0-2d
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:59:41 -0400
Date: Thu, 31 Aug 2017 12:59:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170831115935.GQ13619@stefanha-x1.localdomain>
References: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
	<20170826003454.GA23546@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170826003454.GA23546@flamenco>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 0/5] hypertrace: Lightweight
 guest-to-QEMU trace channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>

On Fri, Aug 25, 2017 at 08:34:54PM -0400, Emilio G. Cota wrote:
> On Sun, Jul 30, 2017 at 17:08:18 +0300, Llu=EDs Vilanova wrote:
> > The hypertrace channel allows guest code to emit events in QEMU (the =
host) using
> > its tracing infrastructure (see "docs/trace.txt"). This works in both=
 'system'
> > and 'user' modes, is architecture-agnostic and introduces minimal noi=
se on the
> > guest.
> >=20
> > See first commit for a full description, use-cases and an example.
> >=20
> > Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
>=20
> This would be indeed very useful once TCG instrumentation is in place.
>=20
> However, I'm not very excited about this being PCI-only and Linux-only =
for
> system mode
> I wonder how we could make this work on all hosts -- did you consider u=
sing
> "magic" instructions? We'd need a different magic instruction for each
> guest ISA, but the library would hide that anyway (and the library code
> would be the same for user and system modes).

Magic instructions can potentially be implemented more efficiently in
TCG too.  They wouldn't work under KVM/HAX/hvf accelerators though.

Stefan

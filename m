Received: from eggs.gnu.org ([2001:4830:134:3::10]:49054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fqJMn-0003q5-Bl
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fqJMf-0001I6-Le
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:35:11 -0400
Received: from mail-am5eur03hn0238.outbound.protection.outlook.com
	([104.47.8.238]:10992
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fqJMY-0001G6-1z
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:35:00 -0400
Date: Thu, 16 Aug 2018 17:34:43 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180816143442.GA6075@rkaganb.sw.ru>
References: <20180514171913.17664-1-berrange@redhat.com>
	<20180607094747.GA12019@redhat.com>
	<20180710171157.GA3636@rkaganb.sw.ru>
	<20180710172309.GK914@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180710172309.GK914@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/3] i386: fix handling of multiboot modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Jul 10, 2018 at 02:23:09PM -0300, Eduardo Habkost wrote:
> On Tue, Jul 10, 2018 at 08:11:58PM +0300, Roman Kagan wrote:
> > On Thu, Jun 07, 2018 at 10:47:47AM +0100, Daniel P. Berrang=E9 wrote:
> > > ping...
> > >=20
> > > On Mon, May 14, 2018 at 06:19:10PM +0100, Daniel P. Berrang=E9 wrote:
> > > > This short series fixes a flaw identified by coverity which broke t=
he
> > > > handling of multiboot modules.
> > > >=20
> > > > Daniel P. Berrang=E9 (3):
> > > >   i386: fix regression parsing multiboot initrd modules
> > > >   i386: only parse the initrd_filename once for multiboot modules
> > > >   opts: remove redundant check for NULL parameter
> > > >=20
> > > >  hw/i386/multiboot.c | 35 ++++++++++++++++-------------------
> > > >  util/qemu-option.c  |  8 +++-----
> > > >  2 files changed, 19 insertions(+), 24 deletions(-)
> > > >=20
> > > > --=20
> > > > 2.17.0
> >=20
> > Any reason this hasn't been merged yet?
>=20
> Lack of reviews, unfortunately.  I guess we don't have many
> people familiar with the multiboot code.
>=20
> >=20
> > This fixes a regression that, in particular, makes QEMU segfault when
> > running kvm-unit-tests.
>=20
> As it is a bug fix, I will try to review merge it for the next
> rc.

Looks like it ended up missing 3.0, so kvm-unit-tests still segfault
with the released version of QEMU :(

Roman.

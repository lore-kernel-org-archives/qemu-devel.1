Received: from eggs.gnu.org ([2001:4830:134:3::10]:41499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fcwBX-0007Jf-25
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fcwBS-00024D-RX
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:12:19 -0400
Received: from mail-am5eur03hn0301.outbound.protection.outlook.com
	([2a01:111:f400:fe08::301]:14739
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fcwBS-00023M-5f
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:12:14 -0400
Date: Tue, 10 Jul 2018 20:11:58 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180710171157.GA3636@rkaganb.sw.ru>
References: <20180514171913.17664-1-berrange@redhat.com>
	<20180607094747.GA12019@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180607094747.GA12019@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] i386: fix handling of multiboot modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jun 07, 2018 at 10:47:47AM +0100, Daniel P. Berrang=E9 wrote:
> ping...
>=20
> On Mon, May 14, 2018 at 06:19:10PM +0100, Daniel P. Berrang=E9 wrote:
> > This short series fixes a flaw identified by coverity which broke the
> > handling of multiboot modules.
> >=20
> > Daniel P. Berrang=E9 (3):
> >   i386: fix regression parsing multiboot initrd modules
> >   i386: only parse the initrd_filename once for multiboot modules
> >   opts: remove redundant check for NULL parameter
> >=20
> >  hw/i386/multiboot.c | 35 ++++++++++++++++-------------------
> >  util/qemu-option.c  |  8 +++-----
> >  2 files changed, 19 insertions(+), 24 deletions(-)
> >=20
> > --=20
> > 2.17.0

Any reason this hasn't been merged yet?

This fixes a regression that, in particular, makes QEMU segfault when
running kvm-unit-tests.

Thanks,
Roman.

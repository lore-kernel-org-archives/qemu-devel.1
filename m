Received: from eggs.gnu.org ([2001:4830:134:3::10]:60826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVf7x-0004XU-8B
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVf7t-0001hZ-Ao
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:34:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVf7t-0001h6-5m
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:34:29 -0400
Date: Wed, 20 Jun 2018 18:34:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620183313-mutt-send-email-mst@kernel.org>
References: <20180514171913.17664-1-berrange@redhat.com>
	<20180620145756.GB5385@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180620145756.GB5385@rkaganb.sw.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] i386: fix handling of multiboot modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 20, 2018 at 05:57:56PM +0300, Roman Kagan wrote:
> On Mon, May 14, 2018 at 06:19:10PM +0100, Daniel P. Berrang=E9 wrote:
> > This short series fixes a flaw identified by coverity which broke the
> > handling of multiboot modules.
>=20
> This flaw also makes QEMU segfault when running kvm-unit-tests, and the
> series fixes it.
>=20
> So
>=20
> Tested-by: Roman Kagan <rkagan@virtuozzo.com>
>=20
> Wondering if anyone else runs kvm-unit-tests with QEMU master,
> Roman.

It might be a good idea to make it a submodule, and
use it for unit tests. I'll take a look.

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
> >=20
> >=20

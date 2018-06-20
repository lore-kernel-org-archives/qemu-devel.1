Received: from eggs.gnu.org ([2001:4830:134:3::10]:51903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fVeYu-0006D5-Bv
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fVeYr-00027u-B5
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:58:20 -0400
Received: from mail-ve1eur01hn0213.outbound.protection.outlook.com
	([104.47.1.213]:31652
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fVeYq-00027L-Ik
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:58:17 -0400
Date: Wed, 20 Jun 2018 17:57:56 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180620145756.GB5385@rkaganb.sw.ru>
References: <20180514171913.17664-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180514171913.17664-1-berrange@redhat.com>
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

On Mon, May 14, 2018 at 06:19:10PM +0100, Daniel P. Berrang=E9 wrote:
> This short series fixes a flaw identified by coverity which broke the
> handling of multiboot modules.

This flaw also makes QEMU segfault when running kvm-unit-tests, and the
series fixes it.

So

Tested-by: Roman Kagan <rkagan@virtuozzo.com>

Wondering if anyone else runs kvm-unit-tests with QEMU master,
Roman.

>=20
> Daniel P. Berrang=E9 (3):
>   i386: fix regression parsing multiboot initrd modules
>   i386: only parse the initrd_filename once for multiboot modules
>   opts: remove redundant check for NULL parameter
>=20
>  hw/i386/multiboot.c | 35 ++++++++++++++++-------------------
>  util/qemu-option.c  |  8 +++-----
>  2 files changed, 19 insertions(+), 24 deletions(-)
>=20
> --=20
> 2.17.0
>=20
>=20

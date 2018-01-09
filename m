Received: from eggs.gnu.org ([2001:4830:134:3::10]:39828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ1LD-0003YL-AP
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ1LA-0002Ll-6k
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:21:51 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:34038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eZ1LA-0002Km-09
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:21:48 -0500
Date: Tue, 9 Jan 2018 22:21:45 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180109212145.4tnftpc5yodxpk62@var.youpi.perso.aquilenet.fr>
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-7-f4bug@amsat.org>
	<67cdd023-c911-8e36-53c9-2a01b08846a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67cdd023-c911-8e36-53c9-2a01b08846a9@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/12] slirp: remove unused header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

Thomas Huth, on lun. 08 janv. 2018 19:54:27 +0100, wrote:
> On 08.01.2018 18:28, Philippe Mathieu-Daud=C3=A9 wrote:
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  slirp/slirp.h | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/slirp/slirp.h b/slirp/slirp.h
> > index 9a7287e7cc..447dc045a8 100644
> > --- a/slirp/slirp.h
> > +++ b/slirp/slirp.h
> > @@ -1,7 +1,6 @@
> >  #ifndef SLIRP_H
> >  #define SLIRP_H
> > =20
> > -#include "qemu/host-utils.h"
>=20
> This had been added by commit 87776ab72b02e3c99a042ab7a0a378bc457cc069
> which stated "There are some inclusions of qemu/host-utils.h in headers=
,
> but they are all necessary." ... I wonder why it is not necessary
> anymore today...?
>=20
> Anyway, seems like it compiles now fine without this:
>=20
> Tested-by: Thomas Huth <thuth@redhat.com>

Applied to my tree, thanks!

Samuel

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66545552d=Paul.Durrant@citrix.com>)
	id 1fI9x5-0000ZJ-AY
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66545552d=Paul.Durrant@citrix.com>)
	id 1fI9x1-0004RJ-Az
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:39:31 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:52070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=66545552d=Paul.Durrant@citrix.com>)
	id 1fI9x0-0004Ox-Vt
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:39:27 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 14 May 2018 09:38:57 +0000
Message-ID: <d912b54af4c141b990782912cf237ed9@AMSPEX02CL03.citrite.net>
References: <20180510091518.28199-1-paul.durrant@citrix.com>
In-Reply-To: <20180510091518.28199-1-paul.durrant@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/2] xen-hvm: use new resource mapping
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paul Durrant <Paul.Durrant@citrix.com>

Anthony, Stefano,

Ping?

I'd like to get your feedback before spinning a v3 to incorporate Eric's su=
ggestion regarding the commit comment for #2.

  Paul

> -----Original Message-----
> From: Paul Durrant [mailto:paul.durrant@citrix.com]
> Sent: 10 May 2018 10:15
> To: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Anthony Perard
> <anthony.perard@citrix.com>; Daniel P . Berrange <berrange@redhat.com>;
> Eric Blake <eblake@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Stefano Stabellini <sstabellini@kernel.org>
> Subject: [PATCH v2 0/2] xen-hvm: use new resource mapping API
>=20
> This series modifies QEMU to use the new guest resource mapping API
> (available in Xen 4.11+) to map ioreq pages.
>=20
> v2:
>  - Add a patch to checkpatch to avoid misparsing of Xen stable API handle=
s
>=20
> Paul Durrant (3):
>   xen-hvm: create separate function for ioreq server initialization
>   checkpatch: generalize xen handle matching in the list of types
>   xen-hvm: try to use xenforeignmemory_map_resource() to map ioreq
> pages
>=20
>  configure                   |   5 ++
>  hw/i386/xen/trace-events    |   1 +
>  hw/i386/xen/xen-hvm.c       | 114 ++++++++++++++++++++++++++++++++-
> -----------
>  include/hw/xen/xen_common.h |  14 ++++++
>  scripts/checkpatch.pl       |   2 +-
>  5 files changed, 105 insertions(+), 31 deletions(-)
> ---
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
>=20
> --
> 2.11.0

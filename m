Received: from eggs.gnu.org ([2001:4830:134:3::10]:37659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNysa-0006oe-OU
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNysV-000548-U1
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNysV-00052r-Of
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A1CE7F40C
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 09:58:18 +0000 (UTC)
References: <20170621140219.4568-1-marcandre.lureau@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <84972d96-ea88-01e4-c146-8cbe3143c571@redhat.com>
Date: Thu, 22 Jun 2017 11:58:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170621140219.4568-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

On 21.06.2017 16:02, Marc-Andr=C3=A9 Lureau wrote:
> Add a new Linux-specific memory backend, similar to hostmem-file,
> except that it doesn't need file path. It also try to enforce memory
> sealing if available. It is thus slightly easier and secure, and is
> compatible with transparent huge-pages since Linux 4.8.
>=20
> v4:
> - rebased, now that preliminary patches are merged
>=20
> v3:
> - make vhost-user-test use memfd only if possible
> - rebased
>=20
> v1->v2:
> - make it linux-specific
> - minor changes and commit message tweaks
>=20
> Marc-Andr=C3=A9 Lureau (3):
>   memfd: split qemu_memfd_alloc()
>   Add memfd based hostmem
>   tests: use memfd in vhost-user-test
>=20
>  include/qemu/memfd.h     |  2 ++
>  backends/hostmem-memfd.c | 67 ++++++++++++++++++++++++++++++++++++++++=
+++++++
>  tests/vhost-user-test.c  | 68 +++++++++++++++++++++++++++++++---------=
--------
>  util/memfd.c             | 42 ++++++++++++++++++------------
>  backends/Makefile.objs   |  2 ++
>  qemu-options.hx          | 11 ++++++++
>  6 files changed, 151 insertions(+), 41 deletions(-)
>  create mode 100644 backends/hostmem-memfd.c
>=20

Just wondering if it would make more sense to add a new parameter to the
ram backend. Sorry if this has already been discussed.

--=20

Thanks,

David

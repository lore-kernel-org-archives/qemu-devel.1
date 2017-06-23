Received: from eggs.gnu.org ([2001:4830:134:3::10]:45784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOVpB-0002xf-3Z
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 17:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOVp7-00017T-4q
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 17:09:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dOVp6-00016N-V5
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 17:09:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C49AD1CEAF7
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 21:08:59 +0000 (UTC)
Date: Fri, 23 Jun 2017 18:08:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170623210845.GA10776@localhost.localdomain>
References: <20170621140219.4568-1-marcandre.lureau@redhat.com>
	<20170621140219.4568-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170621140219.4568-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/3] Add memfd based hostmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

On Wed, Jun 21, 2017 at 04:02:18PM +0200, Marc-Andr=E9 Lureau wrote:
> Add a new memory backend, similar to hostmem-file, except that it
> doesn't need to create files. It also enforces memory sealing.
>=20
> This backend is mainly useful for sharing the memory with other
> processes.

How exactly can the memfd be used to share memory?  Is there an existing
mechanism for sharing the memfd file descriptor with another process?


>=20
> Note that Linux supports transparent huge-pages of shmem/memfd memory
> since 4.8. It is relatively easier to set up THP than a dedicate
> hugepage mount point by using "madvise" in
> /sys/kernel/mm/transparent_hugepage/shmem_enabled.
>=20
> Usage:
> -object memory-backend-memfd,id=3Dmem1,size=3D1G
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  backends/hostmem-memfd.c | 67 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>  backends/Makefile.objs   |  2 ++
>  qemu-options.hx          | 11 ++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 backends/hostmem-memfd.c
>=20
[...]

--=20
Eduardo

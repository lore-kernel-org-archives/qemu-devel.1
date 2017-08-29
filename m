Received: from eggs.gnu.org ([2001:4830:134:3::10]:38927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmi20-0003qK-DC
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmi1w-0007B9-Go
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dmi1w-0007Ap-Ar
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:02:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47AC47E443
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 15:02:15 +0000 (UTC)
Date: Tue, 29 Aug 2017 18:02:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170829180159-mutt-send-email-mst@kernel.org>
References: <20170829144805.28872-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170829144805.28872-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] vhost-user-bridge reconnect regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, victork@redhat.com

On Tue, Aug 29, 2017 at 04:48:03PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> libvhost-user doesn't support resuming with the same trick vubr had
> since commit 523b018dde3b7650fe5401d0499b30cf2f117515. The following
> two patches fix that regression.
>=20
> Thanks

Copy stable maybe?

> Marc-Andr=E9 Lureau (2):
>   libvhost-user: support resuming vq->last_avail_idx based on used_idx
>   vhost-user-bridge: fix resume regression (since 2.9)
>=20
>  contrib/libvhost-user/libvhost-user.h |  5 +++++
>  contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
>  tests/vhost-user-bridge.c             |  7 +++++++
>  3 files changed, 25 insertions(+)
>=20
> --=20
> 2.14.1.146.gd35faa819

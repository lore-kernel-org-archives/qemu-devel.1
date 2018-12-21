Received: from eggs.gnu.org ([2001:4830:134:3::10]:42145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaK4S-00049x-Rm
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaK4O-000653-B5
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:38:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaK4O-00063t-3U
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:38:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5014BC050069
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 12:38:23 +0000 (UTC)
Date: Fri, 21 Dec 2018 13:38:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221133818.030092bf.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-4-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 03/28] hw: apply machine compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com

On Fri, 21 Dec 2018 13:03:45 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Similarly to accel properties, move compat properties out of globals
> registration, and apply the machine compat properties during
> device_post_init().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/boards.h        |  3 +-
>  hw/arm/virt.c              | 27 ++++++++----
>  hw/core/machine.c          | 19 +--------
>  hw/core/qdev.c             |  2 +
>  hw/i386/pc_piix.c          | 87 +++++++++++++++++++++++++-------------
>  hw/i386/pc_q35.c           | 33 ++++++++++-----
>  hw/ppc/spapr.c             | 42 ++++++++++++------
>  hw/s390x/s390-virtio-ccw.c | 33 ++++++++++-----
>  vl.c                       |  1 -
>  9 files changed, 152 insertions(+), 95 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

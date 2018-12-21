Received: from eggs.gnu.org ([2001:4830:134:3::10]:49212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKMK-0006an-Ee
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKMH-0007Cw-3x
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:56:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaKMG-0007CV-UQ
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:56:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C4BDC059B6F
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 12:56:52 +0000 (UTC)
Date: Fri, 21 Dec 2018 13:56:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221135647.3165069e.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-12-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 11/28] compat: replace PC_COMPAT_2_9 &
 HW_COMPAT_2_9 macros
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

On Fri, 21 Dec 2018 13:03:53 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Use static arrays instead.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/boards.h        |  3 +++
>  include/hw/compat.h        | 19 -------------------
>  include/hw/i386/pc.h       |  9 ++-------
>  hw/arm/virt.c              |  6 +-----
>  hw/core/machine.c          | 21 +++++++++++++++++++++
>  hw/i386/pc.c               |  9 +++++++++
>  hw/i386/pc_piix.c          |  7 ++-----
>  hw/i386/pc_q35.c           |  7 ++-----
>  hw/ppc/spapr.c             |  2 +-
>  hw/s390x/s390-virtio-ccw.c |  2 +-
>  10 files changed, 42 insertions(+), 43 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

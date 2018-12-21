Received: from eggs.gnu.org ([2001:4830:134:3::10]:49711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKNy-0007Pp-Ox
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKNv-0008Hm-IF
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:58:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaKNt-0008Gg-Q7
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:58:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3090A41A5D
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 12:58:33 +0000 (UTC)
Date: Fri, 21 Dec 2018 13:58:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221135827.7290d99d.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-13-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/28] compat: replace PC_COMPAT_2_8 &
 HW_COMPAT_2_8 macros
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

On Fri, 21 Dec 2018 13:03:54 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Use static arrays instead.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/boards.h        |  3 +++
>  include/hw/compat.h        | 43 -----------------------------------
>  include/hw/i386/pc.h       | 29 ++----------------------
>  hw/arm/virt.c              |  5 +----
>  hw/core/machine.c          | 46 ++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc.c               | 29 ++++++++++++++++++++++++
>  hw/i386/pc_piix.c          |  7 ++----
>  hw/i386/pc_q35.c           |  7 ++----
>  hw/ppc/spapr.c             |  2 +-
>  hw/s390x/s390-virtio-ccw.c |  2 +-
>  10 files changed, 87 insertions(+), 86 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

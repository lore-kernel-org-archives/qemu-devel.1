Received: from eggs.gnu.org ([2001:4830:134:3::10]:46212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKDc-00027o-Ik
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKDY-0000Uz-JL
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:47:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaKDY-0000UX-Di
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:47:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C806B7F77E
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 12:47:51 +0000 (UTC)
Date: Fri, 21 Dec 2018 13:47:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221134747.73b7318e.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-7-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 06/28] compat: replace PC_COMPAT_3_1 &
 HW_COMPAT_3_1 macros
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

On Fri, 21 Dec 2018 13:03:48 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Use static arrays instead.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/boards.h        | 3 +++
>  include/hw/compat.h        | 3 ---
>  include/hw/i386/pc.h       | 4 ++--
>  hw/arm/virt.c              | 6 +-----
>  hw/core/machine.c          | 3 +++
>  hw/i386/pc.c               | 3 +++
>  hw/i386/pc_piix.c          | 7 ++-----
>  hw/i386/pc_q35.c           | 7 ++-----
>  hw/ppc/spapr.c             | 6 +-----
>  hw/s390x/s390-virtio-ccw.c | 6 +-----
>  10 files changed, 18 insertions(+), 30 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

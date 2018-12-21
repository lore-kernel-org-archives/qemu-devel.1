Received: from eggs.gnu.org ([2001:4830:134:3::10]:53746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKZv-0004yS-TU
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKZp-0001DI-Hv
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:10:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaKZo-00018g-Ip
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:10:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B2CB2DC37B
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:10:50 +0000 (UTC)
Date: Fri, 21 Dec 2018 14:10:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221141044.72263fec.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-21-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-21-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 20/28] include: remove compat.h
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

On Fri, 21 Dec 2018 13:04:02 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> The header is now empty.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/compat.h        | 4 ----
>  include/hw/i386/pc.h       | 1 -
>  hw/arm/virt.c              | 1 -
>  hw/ppc/spapr.c             | 1 -
>  hw/s390x/s390-virtio-ccw.c | 1 -
>  5 files changed, 8 deletions(-)
>  delete mode 100644 include/hw/compat.h

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

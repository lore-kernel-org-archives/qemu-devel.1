Received: from eggs.gnu.org ([2001:4830:134:3::10]:40331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaK0A-00016O-7W
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaK03-0000AF-5V
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaK02-00009d-Uh
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:33:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05DD8C04B2CD
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 12:33:54 +0000 (UTC)
Date: Fri, 21 Dec 2018 13:33:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221133347.1d8dd55f.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-3-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 02/28] machines: replace COMPAT define
 with a static array
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

On Fri, 21 Dec 2018 13:03:44 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/boards.h        |  10 +-
>  hw/arm/virt.c              |  45 +--
>  hw/i386/pc_piix.c          | 563 +++++++++++++++++++++----------------
>  hw/i386/pc_q35.c           |  66 ++++-
>  hw/ppc/spapr.c             | 201 ++++++-------
>  hw/s390x/s390-virtio-ccw.c | 219 ++++++++-------
>  6 files changed, 622 insertions(+), 482 deletions(-)
>=20

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

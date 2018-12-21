Received: from eggs.gnu.org ([2001:4830:134:3::10]:49120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaLg2-00037c-RK
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaLfz-0004jx-44
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:21:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gaLfy-0004We-Pi
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:21:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E02D22D800
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 14:21:04 +0000 (UTC)
Date: Fri, 21 Dec 2018 15:20:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181221152059.5c07530b@redhat.com>
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

[...]

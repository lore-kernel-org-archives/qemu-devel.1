Received: from eggs.gnu.org ([2001:4830:134:3::10]:60126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaJRv-0002Vq-2v
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaJRr-00077x-OC
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:58:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaJRr-0006us-Gr
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:58:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B66E725ECD
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 11:58:20 +0000 (UTC)
Date: Fri, 21 Dec 2018 12:58:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221125815.52f20a95.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-2-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 01/28] hw: apply accel compat properties
 without touching globals
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

On Fri, 21 Dec 2018 13:03:43 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Instead of registering compat properties as globals, let's keep them
> in their own array, to avoid mixing with user globals.
>=20
> Introduce object_apply_global_props() function, to apply compatibility
> properties from a GPtrArray.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/qdev-core.h | 10 ++++++++++
>  include/qom/object.h   |  3 +++
>  include/sysemu/accel.h |  4 +---
>  accel/accel.c          | 12 ------------
>  hw/core/qdev.c         |  9 +++++++++
>  hw/xen/xen-common.c    |  9 ++++++---
>  qom/object.c           | 25 +++++++++++++++++++++++++
>  vl.c                   |  1 -
>  8 files changed, 54 insertions(+), 19 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

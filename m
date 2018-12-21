Received: from eggs.gnu.org ([2001:4830:134:3::10]:41927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaMhW-0008As-Eo
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaMhS-0000qn-Gd
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:26:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaMhS-0000qY-A2
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:26:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A96C358E2C
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 15:26:53 +0000 (UTC)
Date: Fri, 21 Dec 2018 16:26:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221162645.776f69fc.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-24-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-24-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 23/28] qdev: all globals are now
 user-provided
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

On Fri, 21 Dec 2018 13:04:05 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> All globals are now either provided via -global or through -cpu
> features (CPU features are implemented by registering globals).
>=20
> If the global isn't being used, it should warn in either case.
>=20
> We can thus consider that all global_props are "user-provided"
> globals. No need to track this per-globals anymore.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/qdev-core.h         |  3 --
>  hw/core/qdev-properties.c      |  4 ---
>  tests/test-qdev-global-props.c | 57 ++++------------------------------
>  vl.c                           |  1 -
>  4 files changed, 6 insertions(+), 59 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

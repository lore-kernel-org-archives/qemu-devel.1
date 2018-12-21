Received: from eggs.gnu.org ([2001:4830:134:3::10]:41534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaMg6-0007Fq-33
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaMg5-0008EZ-Fj
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:25:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaMg5-0008E5-AC
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:25:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EEDA804ED
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 15:25:28 +0000 (UTC)
Date: Fri, 21 Dec 2018 16:25:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221162523.5538c4c3.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-23-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-23-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 22/28] qdev: make a separate helper
 function to apply compat properties
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

On Fri, 21 Dec 2018 13:04:04 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> This will allow to apply compat properties on other objects than QDev eas=
ily.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/qdev-core.h | 2 ++
>  hw/core/qdev.c         | 6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

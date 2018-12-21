Received: from eggs.gnu.org ([2001:4830:134:3::10]:53504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKZF-0004Vd-OC
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKZ5-0000eA-8C
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:10:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaKZ5-0000dw-1R
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:10:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48AFB13ABE7
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:10:06 +0000 (UTC)
Date: Fri, 21 Dec 2018 14:09:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221140959.24be3b91.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-20-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-20-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 19/28] compat: replace PC_COMPAT_2_1 &
 HW_COMPAT_2_1 macros
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

On Fri, 21 Dec 2018 13:04:01 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Use static arrays instead.  I decided to rename the conflicting
> pc_compat_2_1() function with pc_compat_2_1_fn().
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/boards.h  |  3 +++
>  include/hw/compat.h  | 31 -------------------------------
>  include/hw/i386/pc.h | 17 +++--------------
>  hw/core/machine.c    | 33 +++++++++++++++++++++++++++++++++
>  hw/i386/pc.c         | 15 +++++++++++++++
>  hw/i386/pc_piix.c    | 12 +++++-------
>  hw/ppc/spapr.c       |  6 +-----
>  7 files changed, 60 insertions(+), 57 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

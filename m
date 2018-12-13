Received: from eggs.gnu.org ([2001:4830:134:3::10]:56232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXPas-0008HW-MB
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXPam-0001Og-Pt
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:55:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gXPam-0001K5-CH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:55:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 216F088E54
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 11:55:45 +0000 (UTC)
Date: Thu, 13 Dec 2018 12:55:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181213125539.21d9afd4.cohuck@redhat.com>
In-Reply-To: <20181212214850.29953-7-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
	<20181212214850.29953-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 06/28] compat: replace PC_COMPAT_3_1 &
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

On Thu, 13 Dec 2018 01:48:28 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Use static arrays instead.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/boards.h  | 3 +++
>  include/hw/compat.h  | 3 ---
>  include/hw/i386/pc.h | 4 ++--
>  hw/arm/virt.c        | 6 +-----
>  hw/core/machine.c    | 3 +++
>  hw/i386/pc.c         | 3 +++
>  hw/i386/pc_piix.c    | 7 ++-----
>  hw/i386/pc_q35.c     | 7 ++-----
>  hw/ppc/spapr.c       | 6 +-----
>  9 files changed, 17 insertions(+), 25 deletions(-)

You'll need to make the same change for s390x once the latest pull
request hits master; but it is obviously trivial to make.

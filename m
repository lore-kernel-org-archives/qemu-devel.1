Received: from eggs.gnu.org ([2001:4830:134:3::10]:49448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaLgl-0003cV-EM
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaLgk-0005OH-26
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:22:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gaLgj-0005N0-Qo
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:22:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76201753FB
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 14:22:04 +0000 (UTC)
Date: Fri, 21 Dec 2018 15:21:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181221152159.717744c2@redhat.com>
In-Reply-To: <20181221090410.27250-5-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 04/28] machine: move compat properties
 out of globals
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

On Fri, 21 Dec 2018 13:03:46 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Move the compat arrays inside functions that use them.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/arm/virt.c              |  94 +++--
>  hw/i386/pc_piix.c          | 705 ++++++++++++++++++-------------------
>  hw/i386/pc_q35.c           | 121 +++----
>  hw/ppc/spapr.c             | 254 +++++++------
>  hw/s390x/s390-virtio-ccw.c | 239 ++++++-------
>  hw/xen/xen-common.c        |  38 +-
>  6 files changed, 685 insertions(+), 766 deletions(-)

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

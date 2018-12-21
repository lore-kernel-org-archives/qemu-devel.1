Received: from eggs.gnu.org ([2001:4830:134:3::10]:44733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKA9-0008ID-QC
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKA9-0005Pp-6j
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:44:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaKA8-0005PA-Vj
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:44:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5905B653C8
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 12:44:20 +0000 (UTC)
Date: Fri, 21 Dec 2018 13:44:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221134414.158270f1.cohuck@redhat.com>
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
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com

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
>=20

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

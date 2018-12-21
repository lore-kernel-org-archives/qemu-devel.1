Received: from eggs.gnu.org ([2001:4830:134:3::10]:47196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaLc2-0000Ut-Qm
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaLby-0000jg-N6
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:17:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gaLby-0000iQ-90
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:17:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3766537E80
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 14:17:08 +0000 (UTC)
Date: Fri, 21 Dec 2018 15:17:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181221151700.3630153c@redhat.com>
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

[...]

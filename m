Received: from eggs.gnu.org ([2001:4830:134:3::10]:34901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dapkB-0003hC-7A
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dapk7-0005N5-TG
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:50:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dapk7-0005MQ-Je
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:50:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RKnDog139535
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 16:50:46 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2byjkxw1c7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 16:50:46 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Jul 2017 16:50:44 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170727154505.14838-1-marcandre.lureau@redhat.com>
References: <20170727154505.14838-1-marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 15:22:26 -0500
Message-Id: <150118694640.22858.12035679972281344198@loki>
Subject: Re: [Qemu-devel] [PATCH] build-sys: there is no qemu-ga.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Quoting Marc-Andr=C3=A9 Lureau (2017-07-27 10:45:05)
> It got moved in qga/main.c from commit 2870dc3456c9c.
> =

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/Makefile b/Makefile
> index ef721480eb..97a58a0f4e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -443,7 +443,7 @@ $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.p=
y $(qapi-py)
>                 "GEN","$@")
>  =

>  QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h)
> -$(qga-obj-y) qemu-ga.o: $(QGALIB_GEN)
> +$(qga-obj-y): $(QGALIB_GEN)
>  =

>  qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
>         $(call LINK, $^)
> -- =

> 2.14.0.rc0.1.g40ca67566
> =

>=20

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHf-0002R0-83
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHc-0003eT-QE
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57356
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHc-0003dj-L9
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:28 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJcb98133015
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:26 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g7yv964ah-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:26 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:25 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-30-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-30-armbru@redhat.com>
Date: Mon, 19 Feb 2018 13:38:50 -0600
Message-Id: <151906913046.12376.8863533667709764446@sif>
Subject: Re: [Qemu-devel] [PATCH v2 29/29] qapi: Don't create useless
 directory qapi-generated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:36:07)
> We used to generate first test and later QGA QAPI code into
> qapi-generated/.  Commit b93b63f574 moved the test code to tests/.
> Commit 54c2e50205 moved the QGA code to qga/qapi-generated/.  The
> directory has been unused since.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  .gitignore | 1 -
>  Makefile   | 1 -
>  configure  | 1 -
>  3 files changed, 3 deletions(-)
> =

> diff --git a/.gitignore b/.gitignore
> index dabfe6bea8..4055e12ee8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -27,7 +27,6 @@
>  /libuser
>  /linux-headers/asm
>  /qga/qapi-generated
> -/qapi-generated
>  /qapi-gen-timestamp
>  /qapi/qapi-builtin-types.[ch]
>  /qapi/qapi-builtin-visit.[ch]
> diff --git a/Makefile b/Makefile
> index 84411ee6ab..7eb1ede6f4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -726,7 +726,6 @@ clean:
>         rm -f trace/generated-tracers-dtrace.h*
>         rm -f $(foreach f,$(GENERATED_FILES),$(f) $(f)-timestamp)
>         rm -f qapi-gen-timestamp
> -       rm -rf qapi-generated
>         rm -rf qga/qapi-generated
>         for d in $(ALL_SUBDIRS); do \
>         if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
> diff --git a/configure b/configure
> index 62562f08cf..f564a1639e 100755
> --- a/configure
> +++ b/configure
> @@ -7015,7 +7015,6 @@ DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm=
32 tests/libqos tests/qapi-sche
>  DIRS=3D"$DIRS docs docs/interop fsdev scsi"
>  DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>  DIRS=3D"$DIRS roms/seabios roms/vgabios"
> -DIRS=3D"$DIRS qapi-generated"
>  FILES=3D"Makefile tests/tcg/Makefile qdict-test-data.txt"
>  FILES=3D"$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
>  FILES=3D"$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Mak=
efile"
> -- =

> 2.13.6
>=20

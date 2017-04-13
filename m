Received: from eggs.gnu.org ([2001:4830:134:3::10]:36146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cylOU-00020d-4D
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cylOP-0007Q2-56
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:31:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35584
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cylOO-0007O5-VQ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:31:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3DKSgqW124645
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 16:30:59 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29t32rd8mw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 16:30:59 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 13 Apr 2017 16:30:58 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170403095438.15423-1-marcandre.lureau@redhat.com>
References: <20170403095438.15423-1-marcandre.lureau@redhat.com>
Date: Thu, 13 Apr 2017 15:30:49 -0500
Message-Id: <149211544929.21548.189783704203697160@loki>
Subject: Re: [Qemu-devel] [PATCH] qga: improve fsfreeze documentations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Quoting Marc-Andr=C3=A9 Lureau (2017-04-03 04:54:38)
> Some users find the fsfreeze behaviour confusing. Add some notes about
> invalid mount points and Windows usage.
> =

> Related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1436976
> =

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks, applied to qga tree:

  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/qapi-schema.json | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> =

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2d18..8d901f556a 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -426,7 +426,13 @@
>  ##
>  # @guest-fsfreeze-freeze:
>  #
> -# Sync and freeze all freezable, local guest filesystems
> +# Sync and freeze all freezable, local guest filesystems. If this
> +# command succeeded, you may call @guest-fsfreeze-thaw later to
> +# unfreeze.
> +#
> +# Note: On Windows, the command is implemented with the help of a
> +# Volume Shadow-copy Service DLL helper. The frozen state is limited
> +# for up to 10 seconds by VSS.
>  #
>  # Returns: Number of file systems currently frozen. On error, all filesy=
stems
>  # will be thawed.
> @@ -439,10 +445,12 @@
>  ##
>  # @guest-fsfreeze-freeze-list:
>  #
> -# Sync and freeze specified guest filesystems
> +# Sync and freeze specified guest filesystems.
> +# See also @guest-fsfreeze-freeze.
>  #
>  # @mountpoints: an array of mountpoints of filesystems to be frozen.
>  #               If omitted, every mounted filesystem is frozen.
> +#               Invalid mount points are ignored.
>  #
>  # Returns: Number of file systems currently frozen. On error, all filesy=
stems
>  # will be thawed.
> -- =

> 2.12.0.191.gc5d8de91d
>=20

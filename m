Received: from eggs.gnu.org ([2001:4830:134:3::10]:55808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffBCA-00044y-Qc
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffBC6-0001zi-TC
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:38:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ffBC6-0001zO-Ke
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:38:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6GLSns4116048
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 17:38:07 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k90v5df1u-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 17:38:07 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 16 Jul 2018 17:38:06 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20180715162156.12394-1-pbonzini@redhat.com>
In-Reply-To: <20180715162156.12394-1-pbonzini@redhat.com>
Date: Mon, 16 Jul 2018 16:37:25 -0500
Message-Id: <153177704505.16660.3745652255965789896@sif>
Subject: Re: [Qemu-devel] [PATCH for-3.0] qga: fix file descriptor leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Quoting Paolo Bonzini (2018-07-15 11:21:56)
> The file descriptor for /sys/power/state was never closed.  Reported
> by Coverity.
> =

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/commands-posix.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 233f78a406..4160aceaed 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1651,6 +1651,7 @@ static bool linux_sys_state_supports_mode(SuspendMo=
de mode, Error **errp)
>      }
> =

>      ret =3D read(fd, buf, sizeof(buf) - 1);
> +    close(fd);
>      if (ret <=3D 0) {
>          return false;
>      }
> -- =

> 2.17.1
>=20

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cyjqB-00061n-Vs
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cyjq5-0001a4-Kw
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:51:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47336
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cyjq5-0001Yh-Ep
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:51:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3DImo3u107407
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 14:51:28 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29t6qvrd1u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 14:51:28 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 13 Apr 2017 12:51:26 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170411125205.23121-1-sameeh@daynix.com>
References: <20170411125205.23121-1-sameeh@daynix.com>
Date: Thu, 13 Apr 2017 13:50:59 -0500
Message-Id: <149210945992.21548.17043913929649299558@loki>
Subject: Re: [Qemu-devel] [PATCH] qga-win: Enable 'can-offline' field in
 'guest-get-vcpus' reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>

Quoting Sameeh Jubran (2017-04-11 07:52:05)
> The QGA schema states:
> =

> @can-offline: Whether offlining the VCPU is possible. This member
>                is always filled in by the guest agent when the structure
>                is returned, and always ignored on input (hence it can be
>                omitted then).
> =

> Currently 'can-offline' is missing entirely from the reply. This causes
> errors in libvirt which is expecting the reply to be compliant with the
> schema docs.
> =

> BZ#1438735: https://bugzilla.redhat.com/show_bug.cgi?id=3D1438735
> =

> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>

Thanks, applied to qga tree:                                               =
                               =


  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/commands-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 19d72b2..f0d72a0 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1344,7 +1344,7 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Erro=
r **errp)
>                      vcpu =3D g_malloc0(sizeof *vcpu);
>                      vcpu->logical_id =3D current++;
>                      vcpu->online =3D true;
> -                    vcpu->has_can_offline =3D false;
> +                    vcpu->has_can_offline =3D true;
> =

>                      entry =3D g_malloc0(sizeof *entry);
>                      entry->value =3D vcpu;
> -- =

> 2.9.3
>=20

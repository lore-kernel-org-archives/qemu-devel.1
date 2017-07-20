Received: from eggs.gnu.org ([2001:4830:134:3::10]:47954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYGIO-0006HH-Sy
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYGIK-00078i-V3
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:35:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dYGIK-00076t-Ol
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:35:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B72B1C000402
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 18:35:27 +0000 (UTC)
Date: Thu, 20 Jul 2017 15:35:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170720183522.GW2757@localhost.localdomain>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-8-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170720162815.19802-8-ldoktor@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/11] qmp.py: Use object-based class for
 QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

On Thu, Jul 20, 2017 at 06:28:11PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> There is no need to define QEMUMonitorProtocol as old-style class.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
>  scripts/qmp/qmp.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index bb4d614..68f3420 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -30,7 +30,7 @@ class QMPTimeoutError(QMPError):
>      pass
> =20
> =20
> -class QEMUMonitorProtocol:
> +class QEMUMonitorProtocol(object):

I don't fully understand the consequences of changing to
new-style classes when using old-style SuperClass.__init__()
calls in the __init__().  Should we change QMPShell.__init__() to
use super()?


> =20
>      #: Socket's error class
>      error =3D socket.error
> --=20
> 2.9.4
>=20

--=20
Eduardo

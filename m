Received: from eggs.gnu.org ([2001:4830:134:3::10]:41864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYctp-0003wb-1q
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYctm-0002e1-0M
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dYctl-0002de-Py
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88F5B76A06
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 18:43:36 +0000 (UTC)
Date: Fri, 21 Jul 2017 15:43:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170721184330.GC2757@localhost.localdomain>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-8-ldoktor@redhat.com>
	<20170720183522.GW2757@localhost.localdomain>
	<79c348d8-fb6c-7b08-e143-eab8572b5468@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79c348d8-fb6c-7b08-e143-eab8572b5468@redhat.com>
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

On Fri, Jul 21, 2017 at 08:50:22AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 20.7.2017 v 20:35 Eduardo Habkost napsal(a):
> > On Thu, Jul 20, 2017 at 06:28:11PM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
> >> There is no need to define QEMUMonitorProtocol as old-style class.
> >>
> >> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> >> ---
> >>  scripts/qmp/qmp.py | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> >> index bb4d614..68f3420 100644
> >> --- a/scripts/qmp/qmp.py
> >> +++ b/scripts/qmp/qmp.py
> >> @@ -30,7 +30,7 @@ class QMPTimeoutError(QMPError):
> >>      pass
> >> =20
> >> =20
> >> -class QEMUMonitorProtocol:
> >> +class QEMUMonitorProtocol(object):
> >=20
> > I don't fully understand the consequences of changing to
> > new-style classes when using old-style SuperClass.__init__()
> > calls in the __init__().  Should we change QMPShell.__init__() to
> > use super()?
> >=20
> The consequence is it becomes a proper object with full object
> model and less workarounds. It also consumes a bit more memory
> but are the only available mode in py3.
>=20
> As for the old-style superclass, it works, but the correct
> approach is to replace it with `super` call. I'll address that
> in the v2 (I only checked for `.py` files but there are many
> python sources in qemu tree without the proper extension. I
> still need to get used to this.).

Thanks for the explanation.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo

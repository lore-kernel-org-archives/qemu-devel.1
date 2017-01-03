Received: from eggs.gnu.org ([2001:4830:134:3::10]:54399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cOSMF-0007ty-8n
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cOSMC-0004LN-7I
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:54:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cOSMC-0004LI-1c
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:54:40 -0500
Date: Tue, 3 Jan 2017 17:54:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170103175444.38b824fc@Igors-MacBook-Pro.local>
In-Reply-To: <dc14b54f-db61-c14c-7963-51d9b322a2a1@suse.de>
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
	<1483371890-289981-2-git-send-email-imammedo@redhat.com>
	<1c69ec6e-e8e9-d544-f2c5-52ace0acf2bb@redhat.com>
	<dc14b54f-db61-c14c-7963-51d9b322a2a1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] cleanup: remove not used header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas =?UTF-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com

On Tue, 3 Jan 2017 16:26:16 +0100
Andreas F=C3=A4rber <afaerber@suse.de> wrote:

> Am 03.01.2017 um 16:25 schrieb Eric Blake:
> > On 01/02/2017 09:44 AM, Igor Mammedov wrote:
> >=20
> > perhaps s/not used/unused/ in the subject
>=20
> ... and qom: instead of cleanup: if this gets re-spun.
sure

>=20
> Andreas
>=20
> >=20
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> >=20
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >>  qom/object_interfaces.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> >> index ded4d84..4b880d0 100644
> >> --- a/qom/object_interfaces.c
> >> +++ b/qom/object_interfaces.c
> >> @@ -3,7 +3,6 @@
> >>  #include "qom/object_interfaces.h"
> >>  #include "qemu/module.h"
> >>  #include "qapi-visit.h"
> >> -#include "qapi/qobject-output-visitor.h"
> >>  #include "qapi/opts-visitor.h"
> >> =20
> >>  void user_creatable_complete(Object *obj, Error **errp)
> >>
> >=20
>=20
>=20

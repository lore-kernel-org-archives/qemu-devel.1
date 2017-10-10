Received: from eggs.gnu.org ([2001:4830:134:3::10]:40413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e1sIc-0002dK-IS
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e1sIZ-0005uw-Gb
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:02:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e1sIZ-0005ui-At
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:02:07 -0400
Date: Tue, 10 Oct 2017 07:02:05 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1455195365.28175395.1507633325952.JavaMail.zimbra@redhat.com>
In-Reply-To: <1507623520.4061.30.camel@intel.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-23-marcandre.lureau@redhat.com>
	<1507623520.4061.30.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/42] tpm-backend: store TPMIf interface,
 improve backend_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

Hi

----- Original Message -----
> On Tue, 2017-10-10 at 00:56 +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Store the TPM interface, the actual object may be different from
> > TPMState. Keep a reference on the interface, and check the backend
> > wasn't already initialized.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > =C2=A0include/sysemu/tpm_backend.h |=C2=A0=C2=A07 ++++---
> > =C2=A0backends/tpm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 12 +++++++++---
> > =C2=A0hw/tpm/tpm_emulator.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A04 ++--
> > =C2=A0hw/tpm/tpm_passthrough.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A04 ++--
> > =C2=A0hw/tpm/tpm_tis.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > =C2=A05 files changed, 18 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/include/sysemu/tpm_backend.h
> > b/include/sysemu/tpm_backend.h
> > index 03ea5a3400..8d08765b3c 100644
> > --- a/include/sysemu/tpm_backend.h
> > +++ b/include/sysemu/tpm_backend.h
> > @@ -18,6 +18,7 @@
> > =C2=A0#include "qapi-types.h"
> > =C2=A0#include "qemu/option.h"
> > =C2=A0#include "sysemu/tpm.h"
> > +#include "hw/tpm/tpm_int.h"
> This is not supposed to be internal header?

You are right, moving the interface to include/sysemu/tpm.h directly, to av=
oid that header inclusion and later code churn in patch "tpm: lookup the th=
e TPM interface"

thanks

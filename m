Received: from eggs.gnu.org ([209.51.188.92]:38143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMPa-0008II-Tu
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMPZ-0004oL-PC
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJMPZ-0004nP-HJ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:14:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A485B3088D94
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 18:14:24 +0000 (UTC)
Date: Wed, 24 Apr 2019 15:14:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190424181420.GG18406@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<2b1d825f-8bd3-ba25-3e1b-8415aeec8ce6@redhat.com>
	<20190424083113.GE28615@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190424083113.GE28615@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Apr 24, 2019 at 09:31:13AM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Apr 24, 2019 at 09:56:53AM +0200, Thomas Huth wrote:
> > On 23/04/2019 23.22, Eduardo Habkost wrote:
> > > This series adds machine type deprecation information to the
> > > output of the `query-machines` QMP command.  With this, libvirt
> > > and management software will be able to show this information to
> > > users and/or suggest changes to VM configuration to avoid
> > > deprecated machine types.
> > >=20
> > > Eduardo Habkost (3):
> > >   qapi: SupportStatusInfo struct
> > >   machine: Use SupportStatusInfo for deprecation info
> > >   qmp: Add deprecation information to query-machines
> > >=20
> > >  qapi/common.json                   | 24 ++++++++++++++++++++++++
> > >  qapi/misc.json                     |  5 ++++-
> > >  include/hw/boards.h                |  7 ++++---
> > >  hw/i386/pc_piix.c                  |  4 +++-
> > >  hw/ppc/prep.c                      |  4 +++-
> > >  vl.c                               | 19 +++++++++++++++----
> > >  tests/acceptance/query_machines.py | 27 ++++++++++++++++++++++++++=
+
> > >  7 files changed, 80 insertions(+), 10 deletions(-)
> > >  create mode 100644 tests/acceptance/query_machines.py
> >=20
> > Good idea, but some questions come to my mind:
> >=20
> > - What about devices? IIRC Gerd wrote a patch series last year that d=
oes
> >   something similar for devices... It would be good to synchronize th=
e
> >   work, so that we do not have two completely interfaces between devi=
ces
> >   and machines here in the end...
>=20
> Might as well add  CPU models to that too as there's plenty of awful
> CPUs no one should use with KVM. The tricky thing is they are fine
> / sensible with TCG still.

Right.  We also have devices that are supported in some machines
but not in others.  We will probably need a separate API that
takes a (device type, machine type, accelerator) tuple as input.

--=20
Eduardo

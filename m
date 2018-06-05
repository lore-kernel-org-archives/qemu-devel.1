Received: from eggs.gnu.org ([2001:4830:134:3::10]:37312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQAje-0002SL-7C
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQAjd-0007rU-6I
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:06:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQAjd-0007qv-1r
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:06:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18B1F40BC05D
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 12:06:44 +0000 (UTC)
Date: Tue, 5 Jun 2018 14:06:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180605140642.2424bb4c@redhat.com>
In-Reply-To: <20180605134314.651edcee@redhat.com>
References: <ad910973c593c5ac2fed3a10ea958f7e9c12f82c.1527935663.git.mprivozn@redhat.com>
	<20180604103244.GD19749@redhat.com>
	<20180605004146.GD3184@localhost.localdomain>
	<20180605134314.651edcee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cli: Don't run early event loop if no
 --preconfig was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, 5 Jun 2018 13:43:14 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 4 Jun 2018 21:41:46 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Mon, Jun 04, 2018 at 11:32:44AM +0100, Daniel P. Berrang=C3=A9 wrote:
> > [...] =20
> > > Avoiding the double-run of main_loop is good, however, I think we sho=
uld
> > > also not have put current_run_state in RUN_STATE_PRECONFIG in the fir=
st
> > > place if --preconfig wasn't set.  I've sent a patch to fix that probl=
em
> > > too, so if yours is also applied, it could be changed to just do:
> > >=20
> > >     if (current_run_state =3D=3D RNU_STATE_PRECONFIG) {
> > >         main_loop();
> > >     }   =20
> >=20
> > So, this patch is desirable even if we refactor the state machine
> > as suggested in the other threads, right?
> >=20
> > I'm queueing it on machine-next right now.
> >  =20
> Maybe add a note to commit message that it also fixes
> qemu hang when -nodefaults CLI option is used.
>=20
> Also we would need Daniel's
>=20
>   [PATCH v2 2/2] vl: fix use of --daemonize with  --preconfig
>=20
> to fix the same issue with demonize but in case --preconfig were used
>=20

iotests are still broken even with it, so I'm looking into it right now=20

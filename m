Received: from eggs.gnu.org ([2001:4830:134:3::10]:42806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRq6V-00058W-Ep
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 21:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRq6S-00024l-Ah
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 21:24:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dRq6S-00023h-4k
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 21:24:40 -0400
Date: Mon, 3 Jul 2017 09:24:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170703012437.GF24859@pxdev.xzpeter.org>
References: <20170628113106.5248-1-quintela@redhat.com>
	<20170628113106.5248-5-quintela@redhat.com>
	<1c10b8db-1d3a-863b-cf06-ccfce5d71498@amsat.org>
	<76e39b4f-b5ba-baa4-e818-e01a0fc2fe79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76e39b4f-b5ba-baa4-e818-e01a0fc2fe79@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 04/14] migration: let MigrationState be a
 qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Jun 30, 2017 at 04:27:46PM -0500, Eric Blake wrote:
> On 06/30/2017 04:18 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Peter, Juan,
> >=20
> > On 06/28/2017 08:30 AM, Juan Quintela wrote:
> >> From: Peter Xu <peterx@redhat.com>
> >>
> >> Let the old man "MigrationState" join the object family. Direct bene=
fit
> >> is that we can start to use all the property features derived from
> >> current QDev, like: HW_COMPAT_* bits, command line setup for migrati=
on
> >> parameters (so will never need to set them up each time using HMP/QM=
P,
> >> this is really, really attractive for test writters), etc.
> >>
> >> I see no reason to disallow this happen yet. So let's start from thi=
s
> >> one, to see whether it would be anything good.
> >>
> >> Now we init the MigrationState struct statically in main() to make s=
ure
> >> it's initialized after global properties are applied, since we'll us=
e
> >> them during creation of the object.
> >>
> >> No functional change at all.
> >>
>=20
> > qemu-system-arm: migration/migration.c:127: migrate_get_current:
> > Assertion `current_migration' failed.
> >=20
> > I'v bisected to this commit using the following script:
>=20
> Known issue;
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06958.html

Yeah, I'll post the fix today. Really sorry for the inconvenience!

--=20
Peter Xu

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daLak-0006Br-1G
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daLag-0004E6-De
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:39:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daLag-0004Dn-7C
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:39:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 392F4461FE
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:39:01 +0000 (UTC)
Message-ID: <1501072736.29903.8.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 26 Jul 2017 14:38:56 +0200
In-Reply-To: <89ba674e-77f6-5859-bb17-1ffc1099a5eb@redhat.com>
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-5-kraxel@redhat.com>
	<85e9156c-1a11-4757-996d-877e40e316bc@redhat.com>
	<20170726120819.GH7620@redhat.com>
	<89ba674e-77f6-5859-bb17-1ffc1099a5eb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Wed, 2017-07-26 at 07:12 -0500, Eric Blake wrote:
> On 07/26/2017 07:08 AM, Daniel P. Berrange wrote:
> > On Wed, Jul 26, 2017 at 07:02:48AM -0500, Eric Blake wrote:
> > > On 07/26/2017 06:56 AM, Gerd Hoffmann wrote:
> > > > Add multimedia keys to QKeyCodes and to the keymaps.
> > > >=20
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > ---
> > > > =C2=A0ui/input-keymap.c | 44
> > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > > =C2=A0qapi-schema.json=C2=A0=C2=A0| 17 ++++++++++++++++-
> > > > =C2=A02 files changed, 60 insertions(+), 1 deletion(-)
> > > > +# @ac_*: since 2.10
> > >=20
> > > Borderline between bug-fix and new feature (arguing that the bug
> > > is that
> > > we don't represent all keys).=C2=A0=C2=A0Does this need to be 2.11 =
instead?
> >=20
> > It is really fixing a bug introduced in the PS2 driver in
> > 2.8.0.=C2=A0=C2=A0It
> > roundtrips via QKeyCode now, so any key where there is an AT Set 1
> > scancode defined, but for which we lack a QKeyCode can't be sent to
> > guests since QEMU 2.8.0 onwards.
>=20
> Sounds good to me, although that would be worth mentioning in the
> commit
> message.

5/5 is the actual fix, which has a Fixes: line.  It depends on this
patch.

cheers,
  Gerd

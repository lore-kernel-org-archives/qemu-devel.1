Received: from eggs.gnu.org ([2001:4830:134:3::10]:45227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <awilliam@redhat.com>) id 1gZeG3-0004oI-Lh
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <awilliam@redhat.com>) id 1gZeG2-00058V-C8
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:59:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <awilliam@redhat.com>) id 1gZeG2-0004we-2R
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:59:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A7B1356FE
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:59:29 +0000 (UTC)
Message-ID: <6c057e662b52f3dc23d580af5aa3de1a3e53e41e.camel@redhat.com>
From: Adam Williamson <awilliam@redhat.com>
Date: Wed, 19 Dec 2018 07:59:05 -0800
In-Reply-To: <20181219111712.GI20465@redhat.com>
References: <20180222070513.8740-1-kraxel@redhat.com>
	<20180222070513.8740-6-kraxel@redhat.com>
	<20181218184532.GA18660@redhat.com>
	<20181219075510.ci3yypwj3f2plcnv@sirius.home.kraxel.org>
	<20181219094213.lqh244w35unsbejc@sirius.home.kraxel.org>
	<20181219111712.GI20465@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/5] keymap: consider modifier state
 when picking a mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, 2018-12-19 at 11:17 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Dec 19, 2018 at 10:42:14AM +0100, Gerd Hoffmann wrote:
> >   Hi,
> > =20
> > > > This is quite horrible though. I'm more inclined
> > > > to revert this patch and find another way to fix the original pro=
blem
> > > > which won't require the UI frontends to track modifier state.
> > >=20
> > > The UIs track modifier state anyway.
> > >=20
> > > I fact I have some WIP patches to add a generic keyboard state trac=
ker,
> > > so the UIs can use common code instead of having their own state
> > > tracking code each.  Also to make UI hotkeys configurable, consiste=
nt
> > > across all UIs we have.  Guess I should undust them, at least the s=
tate
> > > tracking part of it.
> > >=20
> > > With that in place we can easily pass the full keyboard state to th=
e
> > > keymap code.
> >=20
> > Tried that:
> >   https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/kbd-state
>=20
> I've had a look & think that code makes sense & ought to be able to
> solve this problem.

I'll try and find a minute to do a scratch build with this patch (and
without my keymap patch) and throw it on openQA staging, since openQA
seems to do a great job of testing qemu input code. :P
--=20
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net

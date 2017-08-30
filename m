Received: from eggs.gnu.org ([2001:4830:134:3::10]:50579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn5zg-0007vs-8o
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn5zf-0006rC-E8
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dn5zf-0006qi-75
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:37:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11AF58B13C
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 16:37:30 +0000 (UTC)
Date: Wed, 30 Aug 2017 17:37:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170830163722.GD31465@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170815093615.16453-1-berrange@redhat.com>
	<20170815093615.16453-2-berrange@redhat.com>
	<20170815100410.GH9674@redhat.com>
	<1503499536.16071.27.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1503499536.16071.27.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/12] ui: add keycodemapdb repository
 as a GIT submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Wed, Aug 23, 2017 at 04:45:36PM +0200, Gerd Hoffmann wrote:
>   Hi,
> =C2=A0
> > > +(cd $source_path && git submodule update --init ui/keycodemapdb)
> > > +
> >=20
> > Urgh, no, this won't work because of course you don't have to
> > have a git checkout when running configure.
> >=20
> > Any suggestions on the "best" way to ensure that the ui/keycodemapdb
> > git submodule is always checked out, without requiring developers to
> > do something manually ?
>=20
> Don't require it?
>=20
> The updates shouldn't happen that frequently, IMO we should just commit
> the generated files so checking out the submodule is only needed if you
> work on the keycodemaps.

Ok, I guess that's simplest and matches what's done elsewhere in QEMU


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

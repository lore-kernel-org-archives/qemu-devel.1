Received: from eggs.gnu.org ([2001:4830:134:3::10]:44914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWud-0003nC-Ev
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWua-0005j6-7w
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:45:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dkWuZ-0005i7-P8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B228AC047B78
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 14:45:38 +0000 (UTC)
Message-ID: <1503499536.16071.27.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Aug 2017 16:45:36 +0200
In-Reply-To: <20170815100410.GH9674@redhat.com>
References: <20170815093615.16453-1-berrange@redhat.com>
	<20170815093615.16453-2-berrange@redhat.com>
	<20170815100410.GH9674@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

  Hi,
=C2=A0
> > +(cd $source_path && git submodule update --init ui/keycodemapdb)
> > +
>=20
> Urgh, no, this won't work because of course you don't have to
> have a git checkout when running configure.
>=20
> Any suggestions on the "best" way to ensure that the ui/keycodemapdb
> git submodule is always checked out, without requiring developers to
> do something manually ?

Don't require it?

The updates shouldn't happen that frequently, IMO we should just commit
the generated files so checking out the submodule is only needed if you
work on the keycodemaps.

cheers,
  Gerd

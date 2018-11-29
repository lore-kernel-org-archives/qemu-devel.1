Received: from eggs.gnu.org ([2001:4830:134:3::10]:54053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gSHWF-0003wH-NS
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gSHW9-0002ls-B0
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:17:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gSHW9-0002l7-4P
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:17:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F382723D9
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 08:17:48 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 629FC1019628
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 08:17:48 +0000 (UTC)
Date: Thu, 29 Nov 2018 03:17:47 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <352870113.46422499.1543479467839.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181129080926.qyji6olhjqzkkcuz@sirius.home.kraxel.org>
References: <20181128155932.16171-1-marcandre.lureau@redhat.com>
	<20181129080926.qyji6olhjqzkkcuz@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3] configure: bump spice-server
 required version to 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

>=20
> On Wed, Nov 28, 2018 at 07:59:32PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Looking at chardev/spice.c code, I realize compilation was broken for
> > a while with spice-server < 0.12.3. Let's bump required version
> > to 0.12.5, released May 19 2014, instead of adding more #ifdef.
>=20
> Oh, you did the 0.12.5 patch already.  Scratch my other reply then.
>=20
> > -  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
> > +  if $pkg_config --atleast-version=3D0.12.5 spice-server && \
> >       $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
>=20
> I think we should adjust spice-protocol too to whatever 0.12.5 requires
> to build.
>=20
> cheers,
>   Gerd
>=20

Was 0.12.8

Frediano

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZGqv-0006PG-3Q
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZGqr-0002QU-Rg
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:55:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eZGqr-0002Ps-Lb
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:55:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5511B5381
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:55:32 +0000 (UTC)
Date: Wed, 10 Jan 2018 13:55:13 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110135513.GV3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
	<20171218191228.31018-2-berrange@redhat.com>
	<20180108110849.325psbrk6g7bstsc@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180108110849.325psbrk6g7bstsc@sirius.home.kraxel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 01/13] ui: remove 'sync' parametr from
 vnc_update_client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>

On Mon, Jan 08, 2018 at 12:08:49PM +0100, Gerd Hoffmann wrote:
> On Mon, Dec 18, 2017 at 07:12:16PM +0000, Daniel P. Berrange wrote:
> > There is only one caller of vnc_update_client and that always passes =
false
> > for the 'sync' parameter.
>=20
> Unused since commit 50628d3479e4f9aa97e323506856e394fe7ad7a6.
> Good catch.
>=20
> What is the state of this series btw (/me busy wading through my
> email backlog ...) ?

Marc-Andr=C3=A9 reviewed it, but I was assuming you would want to review =
and
(if acceptable) queue it, since you're the designated VNC maintainer.
There's just one nit-pick in the Subject of this mail so far.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

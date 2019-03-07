Received: from eggs.gnu.org ([209.51.188.92]:43248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1s25-0000Tt-Qx
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1s24-0002PV-PW
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:21:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1s24-0002P0-IH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:21:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D45B33078ADC
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 12:21:51 +0000 (UTC)
Date: Thu, 7 Mar 2019 12:21:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307122143.GU32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227135523.16952-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227135523.16952-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/1] chardev: support for authorization
 control on TLS connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

ping - soft freeze is less than a week away & I would like to see this
in a chardev pull request in time for 4.0

On Wed, Feb 27, 2019 at 01:55:22PM +0000, Daniel P. Berrang=C3=A9 wrote:
> This series provides the chardev part of the authorization control seri=
es
> previously posted as:
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04482.ht=
ml
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05727.ht=
ml
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01639.ht=
ml
>   v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04319.ht=
ml
>=20
> The core authz framework is now merged & this patch has previously
> had positive review, but I removed the r-b due to need for changes
> to resolve merge conflicts with current chardev code. I expect this
> is none the less ready for the chardev tree, should the maintainer
> consider it acceptable.
>=20
> Daniel P. Berrang=C3=A9 (1):
>   chardev: add support for authorization for TLS clients
>=20
>  chardev/char-socket.c | 12 +++++++++++-
>  chardev/char.c        |  3 +++
>  qapi/char.json        |  6 ++++++
>  qemu-options.hx       |  9 +++++++--
>  4 files changed, 27 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.20.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Received: from eggs.gnu.org ([209.51.188.92]:42917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1s0i-0007kL-1e
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1s0c-0001sR-7R
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:20:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55761)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1s0c-0001s6-0Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:20:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FB53C4EC4
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 12:20:21 +0000 (UTC)
Date: Thu, 7 Mar 2019 12:20:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307122018.GT32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227145324.26188-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227145324.26188-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/1] migration: support for authorization
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
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

ping - soft freeze is less than a week away & I'd like to see this
merged for this release.

On Wed, Feb 27, 2019 at 02:53:23PM +0000, Daniel P. Berrang=C3=A9 wrote:
> This series provides the migration part of the authorization control se=
ries
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
> The core authz framework is now merged & this patch has had
> positive review. Thus this migration part is ready to go into the
> migration maintainer's tree, should the maintainer consider them
> acceptable.
>=20
> Daniel P. Berrang=C3=A9 (1):
>   migration: add support for a "tls-authz" migration parameter
>=20
>  hmp.c                 |  9 +++++++++
>  migration/migration.c |  8 ++++++++
>  migration/tls.c       |  2 +-
>  qapi/migration.json   | 14 +++++++++++++-
>  4 files changed, 31 insertions(+), 2 deletions(-)
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

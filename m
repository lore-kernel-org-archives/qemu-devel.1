Received: from eggs.gnu.org ([2001:4830:134:3::10]:46533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWn7-00021o-JZ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWn3-0008FZ-KA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:19:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsWn3-0008Ea-Bg
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:19:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09E5A7A7E7
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 17:19:28 +0000 (UTC)
Date: Wed, 22 Aug 2018 18:19:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822171920.GX12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180822170250.29573-1-marcandre.lureau@redhat.com>
	<20180822170250.29573-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822170250.29573-4-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/4] configure: require libseccomp 2.2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pmoore@redhat.com, eblake@redhat.com, Eduardo Otubo <otubo@redhat.com>

On Wed, Aug 22, 2018 at 07:02:49PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> The following patch is going to require TSYNC, which is only available
> since libseccomp 2.2.0.
>=20
> libseccomp 2.2.0 was released February 12, 2015.
>=20
> According to repology, libseccomp version in different distros:
>=20
>   RHEL-7: 2.3.1
>   Debian (Stretch): 2.3.1
>   OpenSUSE Leap 15: 2.3.2
>   Ubuntu (Xenial):  2.3.1
>=20
> This will drop support for -sandbox on:
>=20
>   Debian (Jessie): 2.1.1 (but 2.2.3 in backports)
>

Diverging slightly from our normal distro target set, but
acceptable given that this is a security feature which is
impossible to correctly implement with older versions.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  configure | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fkAZF-0003Sm-0w
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fkAZB-00062K-Nf
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:58:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fkAZB-000622-A9
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD6E87C6CA
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 15:58:36 +0000 (UTC)
Date: Mon, 30 Jul 2018 16:58:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180730155831.GM1626@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180730153639.26466-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180730153639.26466-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: remove glib_subprocess check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Jul 30, 2018 at 05:36:39PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> The check should be unnecessary since commit
> e7b3af81597db1a6b55f2c15d030d703c6b2c6ac "glib: bump min required glib
> library version to 2.40".
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-char.c             | 4 ----
>  tests/test-x86-cpuid-compat.c | 6 ------
>  tests/vhost-user-test.c       | 4 ----
>  configure                     | 3 ---
>  tests/Makefile.include        | 2 +-
>  5 files changed, 1 insertion(+), 18 deletions(-)

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

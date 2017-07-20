Received: from eggs.gnu.org ([2001:4830:134:3::10]:33657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYDSN-00032V-Tp
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYDSK-0007i1-2p
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dYDSJ-0007hd-TE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:33:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC6C8C04B92A
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 15:33:34 +0000 (UTC)
Date: Thu, 20 Jul 2017 16:33:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170720153328.GN21566@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170720145729.22141-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170720145729.22141-1-otubo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: add -Wno-format-truncation to
 QEMU_CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jul 20, 2017 at 04:57:29PM +0200, Eduardo Otubo wrote:
> Compilation breaks on GCC 7.1.1 20170622 (Fedora 26), thus adding
> -Wno-format-truncation to QEMU_CFLAGS on configure script is neecssary.
>=20
>     hw/usb/bus.c: In function =E2=80=98usb_port_location=E2=80=99:
>     hw/usb/bus.c:410:66: error: =E2=80=98%d=E2=80=99 directive output m=
ay be truncated writing between 1 and 11 bytes into a region of size betw=
een 0 and 15 [-Werror=3Dformat-truncation=3D]
>              snprintf(downstream->path, sizeof(downstream->path), "%s.%=
d",
>                                                                       ^=
~
>     In file included from /usr/include/stdio.h:939:0,
>                      from /home/otubo/develop/qemu/otubo/include/qemu/o=
sdep.h:68,
>                      from hw/usb/bus.c:1:
>     /usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprin=
tf_chk=E2=80=99 output between 3 and 28 bytes into a destination of size =
16
>        return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL -=
 1,
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
>             __bos (__s), __fmt, __va_arg_pack ());
>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors
>     make: *** [/home/otubo/develop/qemu/otubo/rules.mak:66: hw/usb/bus.=
o] Error 1
>     make: *** Waiting for unfinished jobs....
>=20
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
> This warning looks pretty much bogus to me. Since building with -Werror=
 is
> essential, we should add this flag to configure. If someone thinks this=
 warning
> is not a false positive, feel free to drop this patch.

This particular case of the warning may be a false positive, but the
-Wformat-truncation warning *can* detect serious real bugs so turning
it off is not appropriate. In any case there's a patch this problem
queued for merge already:

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06455.html


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

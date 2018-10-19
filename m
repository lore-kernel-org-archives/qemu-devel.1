Received: from eggs.gnu.org ([2001:4830:134:3::10]:50413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDUHe-0003KB-2O
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDUHa-0006mg-Mx
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gDUHa-0006g6-Bo
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:53:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AC55308FF21
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 12:53:35 +0000 (UTC)
References: <20181019122613.28663-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c74a4a2c-49e0-6d80-0a75-16f41316fa99@redhat.com>
Date: Fri, 19 Oct 2018 14:53:30 +0200
MIME-Version: 1.0
In-Reply-To: <20181019122613.28663-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: remove or downgrade myself to
 reviewer from some subsystems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 2018-10-19 14:26, Paolo Bonzini wrote:
> Other people are doing a much better work than myself at handling some
> subsystems.  For those files it is better if I downgrade myself to
> reviewer or recognize that I am not actually doing any work there.
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb81b3a8eb..8c814b2e60 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -105,9 +105,9 @@ Guest CPU cores (TCG):
>  ----------------------
>  Overall
>  L: qemu-devel@nongnu.org
> -M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  M: Richard Henderson <rth@twiddle.net>
> +R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: cpus.c
>  F: exec.c
> @@ -1132,7 +1132,8 @@ F: hw/pci-host/ppce500.c
>  F: hw/net/fsl_etsec/
> =20
>  Character devices
> -M: Paolo Bonzini <pbonzini@redhat.com>
> +M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Odd Fixes
>  F: hw/char/
> =20
> @@ -1517,8 +1518,8 @@ T: git git://github.com/famz/qemu.git bitmaps
>  T: git git://github.com/jnsnow/qemu.git bitmaps
> =20
>  Character device backends
> -M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: chardev/
>  F: include/chardev/
> @@ -1751,9 +1752,9 @@ F: tests/qmp-cmd-test.c
>  T: git git://repo.or.cz/qemu/armbru.git qapi-next
> =20
>  qtest
> -M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Thomas Huth <thuth@redhat.com>
>  M: Laurent Vivier <lvivier@redhat.com>
> +R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: qtest.c
>  F: tests/libqtest.*
> @@ -1860,7 +1861,6 @@ F: tests/test-io-*
>  Sockets
>  M: Daniel P. Berrange <berrange@redhat.com>
>  M: Gerd Hoffmann <kraxel@redhat.com>
> -M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: include/qemu/sockets.h
>  F: util/qemu-sockets.c
> @@ -2050,13 +2050,12 @@ M: Ronnie Sahlberg <ronniesahlberg@gmail.com>
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Peter Lieven <pl@kamp.de>
>  L: qemu-block@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: block/iscsi.c
>  F: block/iscsi-opts.c
> =20
>  Network Block Device (NBD)
>  M: Eric Blake <eblake@redhat.com>
> -M: Paolo Bonzini <pbonzini@redhat.com>
>  L: qemu-block@nongnu.org
>  S: Maintained
>  F: block/nbd*
>=20

:-(

Acked-by: Thomas Huth <thuth@redhat.com>

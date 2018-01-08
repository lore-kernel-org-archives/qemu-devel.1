Received: from eggs.gnu.org ([2001:4830:134:3::10]:47429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYcZD-0006ge-P1
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYcZA-0005oC-P5
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:54:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eYcZA-0005nv-Ii
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:54:36 -0500
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-7-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <67cdd023-c911-8e36-53c9-2a01b08846a9@redhat.com>
Date: Mon, 8 Jan 2018 19:54:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180108172904.8772-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/12] slirp: remove unused header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On 08.01.2018 18:28, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  slirp/slirp.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index 9a7287e7cc..447dc045a8 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -1,7 +1,6 @@
>  #ifndef SLIRP_H
>  #define SLIRP_H
> =20
> -#include "qemu/host-utils.h"

This had been added by commit 87776ab72b02e3c99a042ab7a0a378bc457cc069
which stated "There are some inclusions of qemu/host-utils.h in headers,
but they are all necessary." ... I wonder why it is not necessary
anymore today...?

Anyway, seems like it compiles now fine without this:

Tested-by: Thomas Huth <thuth@redhat.com>

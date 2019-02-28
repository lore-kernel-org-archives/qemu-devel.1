Received: from eggs.gnu.org ([209.51.188.92]:60390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzNbe-00029T-LV
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzNbc-0000Lo-4z
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:28:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzNbb-0000HP-LU
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:28:16 -0500
References: <155136636659.26299.15306206822524053043.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <755e3b06-3a24-1f8b-b469-7ee3744024aa@redhat.com>
Date: Thu, 28 Feb 2019 09:28:08 -0600
MIME-Version: 1.0
In-Reply-To: <155136636659.26299.15306206822524053043.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] crypto/block: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 2/28/19 9:06 AM, Greg Kurz wrote:
> Build fails with gcc 9:
>=20
> crypto/block-luks.c:689:18: error: taking address of packed member of =E2=
=80=98struct QCryptoBlockLUKSHeader=E2=80=99 may result in an unaligned p=
ointer value [-Werror=3Daddress-of-packed-member]
>   689 |     be32_to_cpus(&luks->header.payload_offset);
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

>=20
> All members of the QCryptoBlockLUKSKeySlot and QCryptoBlockLUKSHeader a=
re
> naturally aligned and we already check at build time there isn't any
> unwanted padding. Drop the QEMU_PACKED attribute.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  crypto/block-luks.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([209.51.188.92]:33736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghGAC-0004k6-Dm
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghGA5-0007CG-RN
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:53:04 -0500
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:37534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ghGA5-0007BB-Jx
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:52:57 -0500
Received: from player799.ha.ovh.net (unknown [10.109.159.90])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 80E8A14C145
	for <qemu-devel@nongnu.org>; Wed,  9 Jan 2019 16:52:54 +0100 (CET)
Date: Wed, 9 Jan 2019 16:52:44 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190109165130.6b50af02@bahia.lan>
In-Reply-To: <20190109151532.20504-1-clg@kaod.org>
References: <20190109151532.20504-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/xive: fix remaining
 XiveFabric names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed,  9 Jan 2019 16:15:32 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xive.h | 2 +-
>  hw/intc/xive.c        | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 4cd2e54c4958..0f935a146c66 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -146,7 +146,7 @@
>  #include "hw/ppc/xive_regs.h"
> =20
>  /*
> - * XIVE Fabric (Interface between Source and Router)
> + * XIVE Notifier (Interface between Source and Router)
>   */
> =20
>  typedef struct XiveNotifier {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 469c90e50c6a..39aac9f89d2a 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1659,9 +1659,9 @@ static const TypeInfo xive_end_source_info =3D {
>  };
> =20
>  /*
> - * XIVE Fabric
> + * XIVE Notifier
>   */
> -static const TypeInfo xive_fabric_info =3D {
> +static const TypeInfo xive_notifier_info =3D {
>      .name =3D TYPE_XIVE_NOTIFIER,
>      .parent =3D TYPE_INTERFACE,
>      .class_size =3D sizeof(XiveNotifierClass),
> @@ -1670,7 +1670,7 @@ static const TypeInfo xive_fabric_info =3D {
>  static void xive_register_types(void)
>  {
>      type_register_static(&xive_source_info);
> -    type_register_static(&xive_fabric_info);
> +    type_register_static(&xive_notifier_info);
>      type_register_static(&xive_router_info);
>      type_register_static(&xive_end_source_info);
>      type_register_static(&xive_tctx_info);

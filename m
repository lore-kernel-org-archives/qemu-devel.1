Received: from eggs.gnu.org ([209.51.188.92]:56319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk2vJ-0000qv-9f
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk2vH-0004CQ-FU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:21:13 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:42616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gk2vG-000497-B3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:21:11 -0500
Received: from player696.ha.ovh.net (unknown [10.109.143.189])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5A1DA1A3C1F
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 09:21:07 +0100 (CET)
Date: Thu, 17 Jan 2019 09:20:54 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190117092054.355ff46e@bahia.lan>
In-Reply-To: <20190117075327.22194-5-clg@kaod.org>
References: <20190117075327.22194-1-clg@kaod.org>
	<20190117075327.22194-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc: remove the interrupt presenters
 from under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 17 Jan 2019 08:53:27 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

The patch looks good, but I think it would be even better to apply this bef=
ore
Thomas's -std=3Dc99 patchset. This would allow to get rid of the controvers=
ial
"ppc: Fix duplicated typedefs to be able to compile  with Clang in gnu99 mo=
de"
patch :)

>  target/ppc/cpu.h | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index bde4dff1ba80..2c22292e7f41 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -23,11 +23,6 @@
>  #include "qemu-common.h"
>  #include "qemu/int128.h"
> =20
> -#ifndef CONFIG_USER_ONLY
> -#include "hw/ppc/xive.h" /* for XiveTCTX */
> -#include "hw/ppc/xics.h" /* for ICPState */
> -#endif
> -
>  //#define PPC_EMULATE_32BITS_HYPV
> =20
>  #if defined (TARGET_PPC64)
> @@ -1203,10 +1198,6 @@ struct PowerPCCPU {
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
> -#ifndef CONFIG_USER_ONLY
> -    ICPState *icp;
> -    XiveTCTX *tctx;
> -#endif
> =20
>      /* Fields related to migration compatibility hacks */
>      bool pre_2_8_migration;

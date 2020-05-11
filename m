Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED45BC38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCCE20746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KNQH6j/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCCE20746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXxY0-0007Hu-Pu
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUu-0000x3-Uq; Sun, 10 May 2020 21:44:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58229 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUr-0000em-PG; Sun, 10 May 2020 21:44:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L3dh03v4z9sSw; Mon, 11 May 2020 11:44:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589161480;
 bh=5ZPldB409X5z1tND777CO1ePCbkqodPGi3Km5qDwqz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KNQH6j/aAUO2dkdnYZWM4ffW4TqccSnX3kxHVr6Z1c2sVIYz7bU543BVSumYh0mni
 0s2kKas/DJePbs2CFFjk63JwFy+6Yz5hvJ6h3mAusjQyP8/paGb9CaTRg53X7g+0++
 WWoOYL4lMoaj3JZsW2exZmcKommPKAAL7h31LMCo=
Date: Mon, 11 May 2020 11:32:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 05/10] exec: Move qemu_minrampagesize/qemu_maxrampagesize
 to 'qemu-common.h'
Message-ID: <20200511013229.GJ2183@umbus.fritz.box>
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KjX7LgAomYr70Ka9"
Content-Disposition: inline
In-Reply-To: <20200507173958.25894-6-philmd@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 21:17:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KjX7LgAomYr70Ka9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 07:39:53PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Move these generic functions to a more common place, with other
> functions related to host page size. Document a little.
>=20
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/exec/ram_addr.h    |  3 ---
>  include/qemu-common.h      | 10 ++++++++++
>  hw/ppc/spapr_caps.c        |  2 +-
>  hw/s390x/s390-virtio-ccw.c |  1 +
>  hw/vfio/spapr.c            |  2 +-
>  5 files changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 06096e8c6a..195b67d3c8 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -93,9 +93,6 @@ static inline unsigned long int ramblock_recv_bitmap_of=
fset(void *host_addr,
> =20
>  bool ramblock_is_pmem(RAMBlock *rb);
> =20
> -long qemu_minrampagesize(void);
> -long qemu_maxrampagesize(void);
> -
>  /**
>   * qemu_ram_alloc_from_file,
>   * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified back=
ing
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index d0142f29ac..2821a6ef76 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -80,6 +80,16 @@ bool set_preferred_target_page_bits(int bits);
>   */
>  void finalize_target_page_bits(void);
> =20
> +/**
> + * qemu_minrampagesize:
> + * qemu_maxrampagesize:
> + *
> + * If backed via -memdev, return the device page size,
> + * else return the host kernel page size.
> + */
> +long qemu_minrampagesize(void);
> +long qemu_maxrampagesize(void);
> +
>  /**
>   * Sends a (part of) iovec down a socket, yielding when the socket is fu=
ll, or
>   * Receives data into a (part of) iovec from a socket,
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index eb54f94227..33a802a103 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -23,11 +23,11 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu-common.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "sysemu/hw_accel.h"
> -#include "exec/ram_addr.h"
>  #include "target/ppc/cpu.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "cpu-models.h"
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index f660070d22..c009384505 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -12,6 +12,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu-common.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "hw/boards.h"
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 2900bd1941..c64db940a7 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -9,13 +9,13 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu-common.h"
>  #include "cpu.h"
>  #include <sys/ioctl.h>
>  #include <linux/vfio.h>
> =20
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/hw.h"
> -#include "exec/ram_addr.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "trace.h"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KjX7LgAomYr70Ka9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64qywACgkQbDjKyiDZ
s5LSOQ/8DoqXkFkQQbCDPFtIUGQ3oeFCpV0TE75pPU5egshCGjuGLYgZTlIX2zsO
RJ2Pet//5fR20cTEYuUCMwzojFqmNuBLNNxlOWbaRHg3cHMk6Bff1iO/rI1KfIVs
HxmoJYhrdJvs31iyH0phWEexTYAsalCTosLBgqF4drSVl81xJupkHoSADshazKMt
3sJ+kJbF4WUgmulEHMf65aFJR69vgtbpzAenUQo9ompMUkBuz0LNd/W6kONVmQ/U
EcaCG2uPP9RiB2c5L5vEC8opbsEHNVD5hXqEyGzCaW+BHFN6FUh68PJOBsNbcECg
6tuNpNi5YUI19W8BKXj6xWzf0XZG4rZhDKZxqq9pP58CSS/F+oGDW0VYSMSdFnO9
4EDXr9oXUf4s2IbmrBuss65o9a9JxkskEN7H/6hsbydw+kRVtN1Mm6vpsy8qu/dP
SpK+6RrK6Nu54h0SBR9vlYNXh9yYo03UNt8xEBiaseT3lO6O7xiZ7jIciDUjsg/F
9dqHoCoJ5Op+so4mTfgiIO2M9/fjuxp30/BnbTqQZ1R/F8553l++x2HThvAJCkc8
gv3MSy6Xr9LIS4NfnnBbdf9tao9o0F2uH1rKsHinIjlCUnEJNeZpB193oTQ8RcSZ
+EN4ZIClC6XPC0wpcneqzvFr5Q4+QSZzHhek4bqVb4WMNKgaBlw=
=+G9O
-----END PGP SIGNATURE-----

--KjX7LgAomYr70Ka9--


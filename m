Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D175C2D0F0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E1220857
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E1220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJgCC-0006fX-Gp
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jJgBW-00062M-B0
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jJgBU-0007fC-Jo
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:25:46 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:42001)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jJgBT-0007de-HK
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:25:44 -0400
Received: from player698.ha.ovh.net (unknown [10.110.208.120])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 72650277974
 for <qemu-devel@nongnu.org>; Wed,  1 Apr 2020 18:25:41 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 4C70310FE5EA8;
 Wed,  1 Apr 2020 16:25:34 +0000 (UTC)
Date: Wed, 1 Apr 2020 18:25:33 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/2] ppc/xive: export PQ routines
Message-ID: <20200401182533.24740fb5@bahia.lan>
In-Reply-To: <20200401154536.3750-2-clg@kaod.org>
References: <20200401154536.3750-1-clg@kaod.org>
 <20200401154536.3750-2-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 13872494227475372427
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtddvgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.124.100
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  1 Apr 2020 17:45:35 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h    | 4 ++++
>  hw/intc/spapr_xive_kvm.c | 8 ++++----
>  hw/intc/xive.c           | 6 +++---
>  3 files changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 59ac075db080..d4e7c1f9217f 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -255,6 +255,10 @@ static inline hwaddr xive_source_esb_mgmt(XiveSource=
 *xsrc, int srcno)
>  #define XIVE_ESB_QUEUED       (XIVE_ESB_VAL_P | XIVE_ESB_VAL_Q)
>  #define XIVE_ESB_OFF          XIVE_ESB_VAL_Q
> =20
> +bool xive_esb_trigger(uint8_t *pq);
> +bool xive_esb_eoi(uint8_t *pq);
> +uint8_t xive_esb_set(uint8_t *pq, uint8_t value);
> +
>  /*
>   * "magic" Event State Buffer (ESB) MMIO offsets.
>   *
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index edb7ee0e74f1..43f4d56b958c 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -308,7 +308,7 @@ static uint8_t xive_esb_read(XiveSource *xsrc, int sr=
cno, uint32_t offset)
>      return xive_esb_rw(xsrc, srcno, offset, 0, 0) & 0x3;
>  }
> =20
> -static void xive_esb_trigger(XiveSource *xsrc, int srcno)
> +static void kvmppc_xive_esb_trigger(XiveSource *xsrc, int srcno)

And good riddance to the duplicate name, for a better gdb experience. :)

Reviewed-by: Greg Kurz <groug@kaod.org>

>  {
>      uint64_t *addr =3D xsrc->esb_mmap + xive_source_esb_page(xsrc, srcno=
);
> =20
> @@ -331,7 +331,7 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int src=
no, uint32_t offset,
>          offset =3D=3D XIVE_ESB_LOAD_EOI) {
>          xive_esb_read(xsrc, srcno, XIVE_ESB_SET_PQ_00);
>          if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> -            xive_esb_trigger(xsrc, srcno);
> +            kvmppc_xive_esb_trigger(xsrc, srcno);
>          }
>          return 0;
>      } else {
> @@ -375,7 +375,7 @@ void kvmppc_xive_source_set_irq(void *opaque, int src=
no, int val)
>          }
>      }
> =20
> -    xive_esb_trigger(xsrc, srcno);
> +    kvmppc_xive_esb_trigger(xsrc, srcno);
>  }
> =20
>  /*
> @@ -544,7 +544,7 @@ static void kvmppc_xive_change_state_handler(void *op=
aque, int running,
>               * generate a trigger.
>               */
>              if (pq =3D=3D XIVE_ESB_RESET && old_pq =3D=3D XIVE_ESB_QUEUE=
D) {
> -                xive_esb_trigger(xsrc, i);
> +                kvmppc_xive_esb_trigger(xsrc, i);
>              }
>          }
> =20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index b9656cd7556c..56ce3ed93e29 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -811,7 +811,7 @@ void xive_tctx_destroy(XiveTCTX *tctx)
>   * XIVE ESB helpers
>   */
> =20
> -static uint8_t xive_esb_set(uint8_t *pq, uint8_t value)
> +uint8_t xive_esb_set(uint8_t *pq, uint8_t value)
>  {
>      uint8_t old_pq =3D *pq & 0x3;
> =20
> @@ -821,7 +821,7 @@ static uint8_t xive_esb_set(uint8_t *pq, uint8_t valu=
e)
>      return old_pq;
>  }
> =20
> -static bool xive_esb_trigger(uint8_t *pq)
> +bool xive_esb_trigger(uint8_t *pq)
>  {
>      uint8_t old_pq =3D *pq & 0x3;
> =20
> @@ -841,7 +841,7 @@ static bool xive_esb_trigger(uint8_t *pq)
>      }
>  }
> =20
> -static bool xive_esb_eoi(uint8_t *pq)
> +bool xive_esb_eoi(uint8_t *pq)
>  {
>      uint8_t old_pq =3D *pq & 0x3;
> =20



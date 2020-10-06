Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD41C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4DD206DD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4DD206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqMv-0002Qf-Mn
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kPqM7-0001yw-7i; Tue, 06 Oct 2020 13:02:27 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:48239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kPqM5-0003aT-AH; Tue, 06 Oct 2020 13:02:26 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.7])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id A0C8C62ACB2A;
 Tue,  6 Oct 2020 19:02:23 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 6 Oct 2020
 19:02:23 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0026b3a4dc7-458f-422b-ab77-43fd9664d644,
 ABBA5CC1B3A583228A496F54FDB0659883642288) smtp.auth=groug@kaod.org
Date: Tue, 6 Oct 2020 19:02:22 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 4/6] spapr/xive: Enforce load-after-store ordering
Message-ID: <20201006190222.2db087a6@bahia.lan>
In-Reply-To: <20201005165147.526426-5-clg@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201005165147.526426-5-clg@kaod.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: eb316db2-26bd-4dd5-89e2-0e316b374041
X-Ovh-Tracer-Id: 11754113556606982563
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeeggddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 12:58:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Oct 2020 18:51:45 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The XIVE_ESB_SET_PQ_10 load operation is used to disable temporarily
> an interrupt source. If StoreEOI is active, a source could be left
> enabled if the load and store operations come out of order.
>=20
> QEMU makes use of this offset to quiesce the sources before a
> migration. Enforce the load-after-store ordering always when doing so
> without querying the characteristics of the sources on the host. The
> performance penalty will be very small for QEMU.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xive.h    |  8 ++++++++
>  hw/intc/spapr_xive_kvm.c | 12 ++++++++++++
>  hw/intc/xive.c           |  6 ++++++
>  3 files changed, 26 insertions(+)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 445eccfe6b73..39cd273f86d5 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -279,6 +279,14 @@ static inline hwaddr xive_source_esb_mgmt(XiveSource=
 *xsrc, int srcno)
>  #define XIVE_ESB_SET_PQ_10      0xe00 /* Load */
>  #define XIVE_ESB_SET_PQ_11      0xf00 /* Load */
> =20
> +/*
> + * Load-after-store ordering
> + *
> + * Adding this offset to the load address will enforce
> + * load-after-store ordering. This is required to use with StoreEOI.
> + */
> +#define XIVE_ESB_LD_ST_MO       0x40 /* Load-after-store ordering */
> +
>  uint8_t xive_source_esb_get(XiveSource *xsrc, uint32_t srcno);
>  uint8_t xive_source_esb_set(XiveSource *xsrc, uint32_t srcno, uint8_t pq=
);
> =20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 66bf4c06fe55..d428422a7b72 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -357,6 +357,18 @@ static uint64_t xive_esb_rw(XiveSource *xsrc, int sr=
cno, uint32_t offset,
> =20
>  static uint8_t xive_esb_read(XiveSource *xsrc, int srcno, uint32_t offse=
t)
>  {
> +    /*
> +     * The XIVE_ESB_SET_PQ_10 load operation is used to disable
> +     * temporarily an interrupt source. If StoreEOI is active, a
> +     * source could be left enabled if the load and store operations
> +     * come out of order.
> +     *
> +     * Enforce the load-after-store ordering always.
> +     */
> +    if (offset =3D=3D XIVE_ESB_SET_PQ_10) {
> +        offset |=3D XIVE_ESB_LD_ST_MO;
> +    }
> +
>      return xive_esb_rw(xsrc, srcno, offset, 0, 0) & 0x3;
>  }
> =20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 489e6256ef70..b710ba2df095 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -998,6 +998,12 @@ static uint64_t xive_source_esb_read(void *opaque, h=
waddr addr, unsigned size)
>      case XIVE_ESB_SET_PQ_01 ... XIVE_ESB_SET_PQ_01 + 0x0FF:
>      case XIVE_ESB_SET_PQ_10 ... XIVE_ESB_SET_PQ_10 + 0x0FF:
>      case XIVE_ESB_SET_PQ_11 ... XIVE_ESB_SET_PQ_11 + 0x0FF:
> +        if (offset =3D=3D XIVE_ESB_SET_PQ_10 &&
> +            xsrc->esb_flags & XIVE_SRC_STORE_EOI) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: load-after-store order=
ing "
> +                          "not enforced with Store EOI active for IRQ %d=
\n",
> +                          srcno);
> +        }
>          ret =3D xive_source_esb_set(xsrc, srcno, (offset >> 8) & 0x3);
>          break;
>      default:



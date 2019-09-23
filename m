Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0762BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E7F20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E7F20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCHE0-0000D2-W4
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 01:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iCHCa-0008Co-F3
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iCHCZ-0005aY-Ds
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:48:00 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:52330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iCHCZ-0005Zp-8R
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:47:59 -0400
Received: from player730.ha.ovh.net (unknown [10.108.42.73])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 1B93E699C8
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:47:55 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 495029F7C843;
 Mon, 23 Sep 2019 05:47:43 +0000 (UTC)
Subject: Re: [PATCH 05/15] qdev: Add a no default uuid property
To: minyard@acm.org, Peter Maydell <peter.maydell@linaro.org>
References: <20190919213924.31852-1-minyard@acm.org>
 <20190919213924.31852-6-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2249ed08-4353-cf39-3e03-e683df2f25e7@kaod.org>
Date: Mon, 23 Sep 2019 07:47:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919213924.31852-6-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6668423676725136312
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.233
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/2019 23:39, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> This is for IPMI, which will behave differently if the UUID is
> not set.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.


> ---
>  include/hw/qdev-properties.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.=
h
> index 2e98dd60db..c6a8cb5516 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -238,6 +238,13 @@ extern const PropertyInfo qdev_prop_pcie_link_widt=
h;
>  #define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
> =20
> +#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) {        \
> +        .name      =3D (_name),                                      \
> +        .info      =3D &qdev_prop_uuid,                              \
> +        .offset    =3D offsetof(_state, _field)                      \
> +            + type_check(QemuUUID, typeof_field(_state, _field)),  \
> +        }
> +
>  #define DEFINE_PROP_END_OF_LIST()               \
>      {}
> =20
>=20



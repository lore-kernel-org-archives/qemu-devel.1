Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4173C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F0C2222B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F0C2222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZquQ-00066x-TY
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 02:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kZqtb-0005Yr-EN; Tue, 03 Nov 2020 02:38:23 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:50572
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kZqtY-0004FX-PI; Tue, 03 Nov 2020 02:38:23 -0500
Received: from basile.remlab.net (dzyqn8ypzhx7l91mxjsvy-3.rev.dnainternet.fi
 [IPv6:2001:14ba:a01a:be01:9434:f69e:d553:3be2])
 (Authenticated sender: remi)
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 1DDDF5FBBF;
 Tue,  3 Nov 2020 08:38:16 +0100 (CET)
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 14/14] target/arm: enable Secure EL2 in max CPU
Date: Tue, 03 Nov 2020 09:38:15 +0200
Message-ID: <4572030.GXAFRqVoOG@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20201102105802.39332-14-remi.denis.courmont@huawei.com>
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-14-remi.denis.courmont@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:41d0:2:5a1a::; envelope-from=remi@remlab.net;
 helo=ns207790.ip-94-23-215.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 02:38:16
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le maanantaina 2. marraskuuta 2020, 12.58.02 EET=20
remi.denis.courmont@huawei.com a =C3=A9crit :
> From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
>=20
> Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu64.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 649213082f..8c3749268e 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -641,6 +641,7 @@ static void aarch64_max_initfn(Object *obj)
>          t =3D FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
>          t =3D FIELD_DP64(t, ID_AA64PFR0, FP, 1);
>          t =3D FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);
> +        t =3D FIELD_DP64(t, ID_AA64PFR0, SEL2, 1);
>          cpu->isar.id_aa64pfr0 =3D t;
>=20
>          t =3D cpu->isar.id_aa64pfr1;

Answering my own patch as I have a policy question here...

This exposes SEL2 without TTST (small translation tables). On a logical lev=
el,=20
the two extensions are orthogonal. But per DDI0487, SEL2 implies TTST, so I=
 am=20
not sure if this is considered an acceptable deviation in QEMU, or if=20
implementing TTST is deemed necessary.

Note that there's what seems like an editorial error in the spec: VSTCR=20
documentation covers the scenario that TTST is not supported by the CPU, ev=
en=20
though then VSTCR should not exist.

=2D-=20
=D0=A0=D0=B5=D0=BC=D0=B8 =D0=94=D1=91=D0=BD=D0=B8-=D0=9A=D1=83=D1=80=D0=BC=
=D0=BE=D0=BD
http://www.remlab.net/





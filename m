Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD99C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0852077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0852077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqCY-0002Nv-Kz
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iop53-0006NE-8Y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iop51-0001fN-PH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:39:32 -0500
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:38496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iop51-0001eA-J0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:39:31 -0500
Received: from player735.ha.ovh.net (unknown [10.108.16.143])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1743611CD43
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 14:39:28 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id 09FA4DBAC45B;
 Tue,  7 Jan 2020 13:39:17 +0000 (UTC)
Subject: Re: [PATCH v2 06/10] target/ppc: Remove RMOR register from POWER9 &
 POWER10
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 groug@kaod.org, philmd@redhat.com
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-7-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <179639b4-61fa-2fc2-53cd-96c882e584bb@kaod.org>
Date: Tue, 7 Jan 2020 14:39:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107044827.471355-7-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9948451578677332774
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgedgtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.73.133
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
Cc: aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-ppc@nongnu.org, lvivier@redhat.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 5:48 AM, David Gibson wrote:
> Currently we create the Real Mode Offset Register (RMOR) on all Book3S =
cpus
> from POWER7 onwards.  However the translation mode which the RMOR contr=
ols
> is no longer supported in POWER9, and so the register has been removed =
from
> the architecture.
>=20
> Remove it from our model on POWER9 and POWER10.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  target/ppc/translate_init.inc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> index 436d0d5a51..893fb12e90 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8003,12 +8003,16 @@ static void gen_spr_book3s_ids(CPUPPCState *env=
)
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_generic,
>                   0x00000000);
> -    spr_register_hv(env, SPR_RMOR, "RMOR",
> +    spr_register_hv(env, SPR_HRMOR, "HRMOR",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_generic,
>                   0x00000000);
> -    spr_register_hv(env, SPR_HRMOR, "HRMOR",
> +}
> +
> +static void gen_spr_rmor(CPUPPCState *env)
> +{
> +    spr_register_hv(env, SPR_RMOR, "RMOR",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_generic,
> @@ -8522,6 +8526,7 @@ static void init_proc_POWER7(CPUPPCState *env)
> =20
>      /* POWER7 Specific Registers */
>      gen_spr_book3s_ids(env);
> +    gen_spr_rmor(env);
>      gen_spr_amr(env);
>      gen_spr_book3s_purr(env);
>      gen_spr_power5p_common(env);
> @@ -8663,6 +8668,7 @@ static void init_proc_POWER8(CPUPPCState *env)
> =20
>      /* POWER8 Specific Registers */
>      gen_spr_book3s_ids(env);
> +    gen_spr_rmor(env);
>      gen_spr_amr(env);
>      gen_spr_iamr(env);
>      gen_spr_book3s_purr(env);
>=20



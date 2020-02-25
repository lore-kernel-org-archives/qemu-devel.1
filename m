Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE9C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D036D20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D036D20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YRX-0000xn-SA
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6YQY-0000Tc-Uw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6YQX-0002op-Qa
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:31:02 -0500
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:53044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6YQX-0002mN-LO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:31:01 -0500
Received: from player789.ha.ovh.net (unknown [10.110.171.31])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9BE2522801C
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 12:30:59 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id C3561FC5EC8D;
 Tue, 25 Feb 2020 11:30:43 +0000 (UTC)
Date: Tue, 25 Feb 2020 12:30:42 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 07/18] target/ppc: Remove RMOR register from POWER9 &
 POWER10
Message-ID: <20200225123042.03ef02b4@bahia.home>
In-Reply-To: <20200224233724.46415-8-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-8-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 392657593971153382
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledvgddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.8
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:13 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently we create the Real Mode Offset Register (RMOR) on all Book3S cp=
us
> from POWER7 onwards.  However the translation mode which the RMOR controls
> is no longer supported in POWER9, and so the register has been removed fr=
om
> the architecture.
>=20
> Remove it from our model on POWER9 and POWER10.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/translate_init.inc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index ab79975fec..925bc31ca5 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8015,12 +8015,16 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
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
> @@ -8535,6 +8539,7 @@ static void init_proc_POWER7(CPUPPCState *env)
> =20
>      /* POWER7 Specific Registers */
>      gen_spr_book3s_ids(env);
> +    gen_spr_rmor(env);
>      gen_spr_amr(env);
>      gen_spr_book3s_purr(env);
>      gen_spr_power5p_common(env);
> @@ -8676,6 +8681,7 @@ static void init_proc_POWER8(CPUPPCState *env)
> =20
>      /* POWER8 Specific Registers */
>      gen_spr_book3s_ids(env);
> +    gen_spr_rmor(env);
>      gen_spr_amr(env);
>      gen_spr_iamr(env);
>      gen_spr_book3s_purr(env);



Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B776C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060C620768
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZcAQLcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060C620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jElpp-0006hj-4d
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 23:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jElpD-00065n-5S
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jElpB-0006If-TU
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:26:27 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jElp9-00064v-4o; Wed, 18 Mar 2020 23:26:23 -0400
Received: by mail-pg1-x544.google.com with SMTP id 37so422730pgm.11;
 Wed, 18 Mar 2020 20:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=/mdqrLfDhinE7Tvec+d6LMLp8+n4KeR/lPsYQ4GyYqI=;
 b=TZcAQLcAu2UMQMyZSrbATwBQygBKo+Hg9vAZnEwJUKC0vv0/1u7w8EsCaVqYWrZein
 MOoQARy0M8+OzgWYfdXGDJfwVvhUNe6RskHCwUYRbVDsrB8DI0cOZT4CaVWlrOox+D+U
 Tdia3xEvuvHWQQn+SkxjRys7ArRuIk1hAWCQLqfadyyo4i0970FLZ2/ixtM0cIbEATxT
 2Y7QJLQQ+g3dtmxkm8dSdcRpYVXgwA6uxSfeylvvZGvwwAvV7ZK0/0nP5jlTBZkkt7ep
 C9yWqsNsgTReiK7AZqdJQtA9tj5/FkcKYhjk2+9ydBPzbuzgUQaPqmzknAfNYcPU2BNU
 EAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=/mdqrLfDhinE7Tvec+d6LMLp8+n4KeR/lPsYQ4GyYqI=;
 b=Fbw+VAWgsGWeQpYS+x+HRWkONt3GXOwK9JoHWgSre4ZlYKk31Whf6rQy9qiM54JZF7
 nwpzllkF/1OAcChXqFwMsxbrIUCdhlbbY8gmUq3bVzc//DfvHP+vU7/J6spsesfhR2jY
 GmkI5lf6zAEV+B+FxH5oYcDf4U9Q2RlTzfDrjGaZwQ3ZonDspk4r92JuBptDYqrVYrxy
 ZjSqviqDdXmX2qPafwhjkJNuVG3C34D6XmBZfFLF7q4DplENl4/agVhu5+e8tOtr4z7/
 4TLjjZZ789fp17O5Q3dCjdpnf1Hz4p/noJR9yprZZbbtzDKsjOHldnfZcKnKeij2VMFI
 y1Wg==
X-Gm-Message-State: ANhLgQ1ahoaX3ubjSbHG4XUpCDigRQ3x1WJ0Qny6VfS/II3cgPM1n6my
 fqJ9aT+dxdMKuf5y+6IUMgw=
X-Google-Smtp-Source: ADFU+vuFlwnH1T+JvOl0AcGVIDjFmaLNltFaGlMJD77otxuO/kcCaq7A7I0iNsWImYErUtVZYtadkw==
X-Received: by 2002:a63:f010:: with SMTP id k16mr1088147pgh.328.1584588381677; 
 Wed, 18 Mar 2020 20:26:21 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id d71sm405043pfd.46.2020.03.18.20.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 20:26:20 -0700 (PDT)
Date: Thu, 19 Mar 2020 13:24:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] ppc/spapr: Set the effective address provided flag in
 mc error log.
To: Mahesh Salgaonkar <mahesh@linux.ibm.com>, Qemu-ppc <qemu-ppc@nongnu.org>
References: <158451653844.22972.17999316676230071087.stgit@jupiter>
In-Reply-To: <158451653844.22972.17999316676230071087.stgit@jupiter>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584588180.mfardhks8k.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Qemu-devel <qemu-devel@nongnu.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mahesh Salgaonkar's on March 18, 2020 5:34 pm:
> Per PAPR, it is expected to set effective address provided flag in
> sub_err_type member of mc extended error log (i.e
> rtas_event_log_v6_mc.sub_err_type). This somehow got missed in original
> fwnmi-mce patch series. The current code just updates the effective addre=
ss
> but does not set the flag to indicate that it is available. Hence guest
> fails to extract effective address from mce rtas log. This patch fixes
> that.
>=20
> Without this patch guest MCE logs fails print DAR value:
>=20
> [   11.933608] Disabling lock debugging due to kernel taint
> [   11.933773] MCE: CPU0: machine check (Severe) Host TLB Multihit [Recov=
ered]
> [   11.933979] MCE: CPU0: NIP: [c000000000090b34] radix__flush_tlb_range_=
psize+0x194/0xf00
> [   11.934223] MCE: CPU0: Initiator CPU
> [   11.934341] MCE: CPU0: Unknown
>=20
> After the change:
>=20
> [   22.454149] Disabling lock debugging due to kernel taint
> [   22.454316] MCE: CPU0: machine check (Severe) Host TLB Multihit DAR: d=
eadbeefdeadbeef [Recovered]
> [   22.454605] MCE: CPU0: NIP: [c0000000003e5804] kmem_cache_alloc+0x84/0=
x330
> [   22.454820] MCE: CPU0: Initiator CPU
> [   22.454944] MCE: CPU0: Unknown

Thanks, I was wondering why my MCEs weren't printing a DAR!

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
>=20
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> ---
> Change in v2:
> - Fixed coding style issues.
> ---
>  hw/ppc/spapr_events.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 8b32b7eea5..cb6bfedc53 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -243,6 +243,14 @@ struct rtas_event_log_v6_mc {
>  #define RTAS_LOG_V6_MC_TLB_PARITY                        1
>  #define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
>  #define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
> +/*
> + * Per PAPR,
> + * For UE error type, set bit 1 of sub_err_type to indicate effective ad=
dr is
> + * provided. For other error types (SLB/ERAT/TLB), set bit 0 to indicate
> + * same.
> + */
> +#define RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDED               0x40
> +#define RTAS_LOG_V6_MC_EA_ADDR_PROVIDED                  0x80
>      uint8_t reserved_1[6];
>      uint64_t effective_address;
>      uint64_t logical_address;
> @@ -726,6 +734,22 @@ void spapr_hotplug_req_remove_by_count_indexed(Spapr=
DrcType drc_type,
>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
>  }
> =20
> +static void spapr_mc_set_ea_provided_flag(struct mc_extended_log *ext_el=
og)
> +{
> +    switch (ext_elog->mc.error_type) {
> +    case RTAS_LOG_V6_MC_TYPE_UE:
> +        ext_elog->mc.sub_err_type |=3D RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDE=
D;
> +        break;
> +    case RTAS_LOG_V6_MC_TYPE_SLB:
> +    case RTAS_LOG_V6_MC_TYPE_ERAT:
> +    case RTAS_LOG_V6_MC_TYPE_TLB:
> +        ext_elog->mc.sub_err_type |=3D RTAS_LOG_V6_MC_EA_ADDR_PROVIDED;
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
>  static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
>                                          struct mc_extended_log *ext_elog=
)
>  {
> @@ -751,6 +775,7 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *c=
pu, bool recovered,
>              ext_elog->mc.sub_err_type =3D mc_derror_table[i].error_subty=
pe;
>              if (mc_derror_table[i].dar_valid) {
>                  ext_elog->mc.effective_address =3D cpu_to_be64(env->spr[=
SPR_DAR]);
> +                spapr_mc_set_ea_provided_flag(ext_elog);
>              }
> =20
>              summary |=3D mc_derror_table[i].initiator
> @@ -769,6 +794,7 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *c=
pu, bool recovered,
>              ext_elog->mc.sub_err_type =3D mc_ierror_table[i].error_subty=
pe;
>              if (mc_ierror_table[i].nip_valid) {
>                  ext_elog->mc.effective_address =3D cpu_to_be64(env->nip)=
;
> +                spapr_mc_set_ea_provided_flag(ext_elog);
>              }
> =20
>              summary |=3D mc_ierror_table[i].initiator
>=20
>=20
=


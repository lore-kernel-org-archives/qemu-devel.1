Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6078FC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C862183E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C862183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41053 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH6Rc-0007f0-CN
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 08:47:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6QW-0007IU-MA
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6QV-0000a5-G3
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:46:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hH6QT-0000Yl-Oj; Thu, 18 Apr 2019 08:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3E1188ABB;
	Thu, 18 Apr 2019 12:46:00 +0000 (UTC)
Received: from [10.36.117.133] (ovpn-117-133.ams2.redhat.com [10.36.117.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FCC8600C5;
	Thu, 18 Apr 2019 12:45:59 +0000 (UTC)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-3-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
Date: Thu, 18 Apr 2019 14:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 18 Apr 2019 12:46:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/10] s390x/cpumodel: remove CSSKE from
 base model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418124558.egt2yaibRlY9oWfgOEI2C8g8u0Rp9GlCiUtVER4LMxM@z>

On 18.04.19 13:31, Christian Borntraeger wrote:
> conditional sske is deprecated and a distant future machine (will be on=
e
> where the IBC will not allow to fully go back to z14) will remove this
> feature. To prepare for this and allow for the z14 and older cpu model
> to still run on systems without csske, remove csske from the base (and

will csske feature be a default feature for zNext? Or is it not
available *at all*.

In case it is not available, baselining and cpu model comparison have to
be thought about "ignoring csske".

> thus the default models for z10..z14). For compat machines we have to
> add those back.

Base models are machine-independent. That means, changing base models is
not supported. Once we introduce new models like here, we can set the
new base models into stone.

>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c  |  2 ++
>  target/s390x/cpu_models.c   | 21 +++++++++++++++++++++
>  target/s390x/cpu_models.h   |  1 +
>  target/s390x/gen-features.c |  1 -
>  4 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d11069b860..3415948b2c 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -648,6 +648,8 @@ bool css_migration_enabled(void)
> =20
>  static void ccw_machine_4_0_instance_options(MachineState *machine)
>  {
> +    /* re-enable csske for compat machines in the base model */
> +    s390_cpumodel_fixup_csske();
>  }
> =20
>  static void ccw_machine_4_0_class_options(MachineClass *mc)
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index eb125d4d0d..4e5aa879f3 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -93,6 +93,27 @@ static S390FeatBitmap qemu_max_cpu_feat;
>  /* features part of a base model but not relevant for finding a base m=
odel */
>  S390FeatBitmap ignored_base_feat;
> =20
> +/*
> + * We removed CSSKE from the base features. This is a hook for compat =
machines
> + * to put this back for gen10..gen14. As the base model is also part o=
f the
> + * default model to have to fixup both bitfields
> + */
> +void s390_cpumodel_fixup_csske(void)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
> +        const S390CPUDef *def =3D &s390_cpu_defs[i];
> +
> +        if (def->gen < 10 || def->gen > 14) {
> +            continue;
> +        }
> +
> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->bas=
e_feat);
> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->def=
ault_feat);
> +    }
> +}

I think that can be avoided by smarter generation of the models, which I
would prefer.

> +
>  void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat)
>  {
>      const S390CPUDef *def;
> diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
> index 174a99e561..b2e37bc8cf 100644
> --- a/target/s390x/cpu_models.h
> +++ b/target/s390x/cpu_models.h
> @@ -73,6 +73,7 @@ struct S390CPUModel {
>  #define ibc_gen(x)        (x =3D=3D 0 ? 0 : ((x >> 4) + S390_GEN_Z10))
>  #define ibc_ec_ga(x)      (x & 0xf)
> =20
> +void s390_cpumodel_fixup_csske(void);
>  void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat);
>  void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat =
feat);
>  void s390_cpudef_group_featoff_greater(uint8_t gen, uint8_t ec_ga,
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index e4739a6b9f..bea2f80c49 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -301,7 +301,6 @@ static uint16_t base_GEN9_GA1[] =3D {
>  #define base_GEN9_GA3 EmptyFeat
> =20
>  static uint16_t base_GEN10_GA1[] =3D {
> -    S390_FEAT_CONDITIONAL_SSKE,
>      S390_FEAT_PARSING_ENH,
>      S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
>      S390_FEAT_EXTRACT_CPU_TIME,
>=20

Instead of doing that, can we rather start generating the next
generation "fresh", listing all base model features it contains instead
of doing it incrementally? Could end up "nicer"


In target/s390x/cpu_models.c we have:

"... For now, base features of a following release are always a subset
of base features of the previous release. Same is correct for the other
feature sets."

This is especially relevant for "s390_find_cpu_def", and goes into the
direction of baselining, as previously mentioned.

Luckily, we already have "ignored_base_feat", maybe we can simply add
csske there and have it working.

--=20

Thanks,

David / dhildenb


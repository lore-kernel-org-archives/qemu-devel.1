Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751FFC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4222B2083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4222B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrSi-0002PK-DQ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDg-0004Sl-HX; Mon, 31 Aug 2020 17:20:04 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDe-0001Yr-1U; Mon, 31 Aug 2020 17:20:04 -0400
Received: by mail-qv1-f65.google.com with SMTP id s15so3336906qvv.7;
 Mon, 31 Aug 2020 14:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F2QmUjKxgknkTpjif27qNU+W0a1swYhjYlyfFRQE5ps=;
 b=UDMuFGn5LZI/xK+itCBMwDrJV45cBvPnS5pWtkfXA4/TSHfEH7w6AJegj+NFo9qG8H
 l/oEFH8a5ngg/5Q47x7lZ6VUlRipwfKGOKBkXv+fbnf352XsFdhsVXMTZGLxyEAg9zgp
 uCy3yCGpFnfNgun7CHLexhjUXoIFFUCtgfhHdJ/TyEVXzayJzb2N0DB57puUkoOWCs9z
 qyaVw2OOachbpmesxHAVJNpQQuKWko61iPG7VdhB6VhKYVfDD3Hagdlc03qDaVGxtlHx
 3YjLM6HIgHUaxi93W40SkRW9vDyzUs9qVF8N+BMJH4bdW/Cwa4eRlp3Ss3Vi6k9/T5M4
 SB3w==
X-Gm-Message-State: AOAM531SVd31oKgeIMiREI8FVIx7X5f8ilg+evOTtr4sQxPO6ODLERRo
 tHZ2YCCfLSN3ppZ+H0PDJwtphagdBCipI9d2MaA=
X-Google-Smtp-Source: ABdhPJxlfYefVSpGHj3LcvER2ERQs9doqFE2fB12FC0NJob71KVT19K96pAdemnYxauGquUWL/PArQr4Yn5e4Tr9Bxw=
X-Received: by 2002:a0c:f493:: with SMTP id i19mr3017469qvm.84.1598908800880; 
 Mon, 31 Aug 2020 14:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200827124335.30586-1-leif@nuviainc.com>
In-Reply-To: <20200827124335.30586-1-leif@nuviainc.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:41:41 +0200
Message-ID: <CAAdtpL6LAa9h2sBNN9v=3kvwqOabd4KwE4CksPAwK6ERYw0C5g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/sbsa-ref: add "reg" property to DT cpu nodes
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: multipart/alternative; boundary="0000000000001ad54305ae32f72e"
Received-SPF: pass client-ip=209.85.219.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qv1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Tanmay Jagdale <tanmay.jagdale@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-devel@nongnu.org,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001ad54305ae32f72e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2020 14:45, Leif Lindholm <leif@nuviainc.com> a =C3=A9=
crit :

> The sbsa-ref platform uses a minimal device tree to pass amount of memory
> as well as number of cpus to the firmware. However, when dumping that
> minimal dtb (with -M sbsa-virt,dumpdtb=3D<file>), the resulting blob
> generates a warning when decompiled by dtc due to lack of reg property.
>
> Add a simple reg property per cpu, representing a 64-bit MPIDR_EL1.
>
> This also ends up being cleaner than having the firmware calculating its
> own IDs for generating APCI.
>
> Signed-off-by: Leif Lindholm <leif@nuviainc.com>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>
> As per Graeme's feedback, properly represent the MPIDR topology info
> in the reg property rather than just counting cores (and update the
> commit message on why this is useful).
> I'm using the local helper function sbsa_ref_cpu_mp_affinity() for this,
> and moving it up somewhat rather than adding a forward declaration.
>
>  hw/arm/sbsa-ref.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index f030a416fd..3e65ded9a0 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -138,6 +138,12 @@ static const int sbsa_ref_irqmap[] =3D {
>      [SBSA_EHCI] =3D 11,
>  };
>
> +static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> +{
> +    uint8_t clustersz =3D ARM_DEFAULT_CPUS_PER_CLUSTER;
> +    return arm_cpu_mp_affinity(idx, clustersz);
> +}
> +
>  /*
>   * Firmware on this machine only uses ACPI table to load OS, these limit=
ed
>   * device tree nodes are just to let firmware know the info which varies
> from
> @@ -183,14 +189,31 @@ static void create_fdt(SBSAMachineState *sms)
>          g_free(matrix);
>      }
>
> +    /*
> +     * From Documentation/devicetree/bindings/arm/cpus.yaml
> +     *  On ARM v8 64-bit systems this property is required
> +     *    and matches the MPIDR_EL1 register affinity bits.
> +     *
> +     *    * If cpus node's #address-cells property is set to 2
> +     *
> +     *      The first reg cell bits [7:0] must be set to
> +     *      bits [39:32] of MPIDR_EL1.
> +     *
> +     *      The second reg cell bits [23:0] must be set to
> +     *      bits [23:0] of MPIDR_EL1.
> +     */
>      qemu_fdt_add_subnode(sms->fdt, "/cpus");
> +    qemu_fdt_setprop_cell(sms->fdt, "/cpus", "#address-cells", 2);
> +    qemu_fdt_setprop_cell(sms->fdt, "/cpus", "#size-cells", 0x0);
>
>      for (cpu =3D sms->smp_cpus - 1; cpu >=3D 0; cpu--) {
>          char *nodename =3D g_strdup_printf("/cpus/cpu@%d", cpu);
>          ARMCPU *armcpu =3D ARM_CPU(qemu_get_cpu(cpu));
>          CPUState *cs =3D CPU(armcpu);
> +        uint64_t mpidr =3D sbsa_ref_cpu_mp_affinity(sms, cpu);
>
>          qemu_fdt_add_subnode(sms->fdt, nodename);
> +        qemu_fdt_setprop_u64(sms->fdt, nodename, "reg", mpidr);
>
>          if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
>              qemu_fdt_setprop_cell(sms->fdt, nodename, "numa-node-id",
> @@ -717,12 +740,6 @@ static void sbsa_ref_init(MachineState *machine)
>      arm_load_kernel(ARM_CPU(first_cpu), machine, &sms->bootinfo);
>  }
>
> -static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> -{
> -    uint8_t clustersz =3D ARM_DEFAULT_CPUS_PER_CLUSTER;
> -    return arm_cpu_mp_affinity(idx, clustersz);
> -}
> -
>  static const CPUArchIdList *sbsa_ref_possible_cpu_arch_ids(MachineState
> *ms)
>  {
>      unsigned int max_cpus =3D ms->smp.max_cpus;
> --
> 2.20.1
>
>
>

--0000000000001ad54305ae32f72e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le jeu. 27 ao=C3=BBt 2020 14:45, Leif Lindholm &lt;<a href=
=3D"mailto:leif@nuviainc.com">leif@nuviainc.com</a>&gt; a =C3=A9crit=C2=A0:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">The sbsa-ref platform uses a minim=
al device tree to pass amount of memory<br>
as well as number of cpus to the firmware. However, when dumping that<br>
minimal dtb (with -M sbsa-virt,dumpdtb=3D&lt;file&gt;), the resulting blob<=
br>
generates a warning when decompiled by dtc due to lack of reg property.<br>
<br>
Add a simple reg property per cpu, representing a 64-bit MPIDR_EL1.<br>
<br>
This also ends up being cleaner than having the firmware calculating its<br=
>
own IDs for generating APCI.<br>
<br>
Signed-off-by: Leif Lindholm &lt;<a href=3D"mailto:leif@nuviainc.com" targe=
t=3D"_blank" rel=3D"noreferrer">leif@nuviainc.com</a>&gt;<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=3D"fon=
t-family:sans-serif;font-size:13.696px">Reviewed-by: Philippe Mathieu-Daud=
=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.org" style=3D"text-decorati=
on:none;color:rgb(66,133,244);font-family:sans-serif;font-size:13.696px">f4=
bug@amsat.org</a><span style=3D"font-family:sans-serif;font-size:13.696px">=
&gt;</span><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
<br>
As per Graeme&#39;s feedback, properly represent the MPIDR topology info<br=
>
in the reg property rather than just counting cores (and update the<br>
commit message on why this is useful).<br>
I&#39;m using the local helper function sbsa_ref_cpu_mp_affinity() for this=
,<br>
and moving it up somewhat rather than adding a forward declaration.<br>
<br>
=C2=A0hw/arm/sbsa-ref.c | 29 +++++++++++++++++++++++------<br>
=C2=A01 file changed, 23 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c<br>
index f030a416fd..3e65ded9a0 100644<br>
--- a/hw/arm/sbsa-ref.c<br>
+++ b/hw/arm/sbsa-ref.c<br>
@@ -138,6 +138,12 @@ static const int sbsa_ref_irqmap[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0[SBSA_EHCI] =3D 11,<br>
=C2=A0};<br>
<br>
+static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)<b=
r>
+{<br>
+=C2=A0 =C2=A0 uint8_t clustersz =3D ARM_DEFAULT_CPUS_PER_CLUSTER;<br>
+=C2=A0 =C2=A0 return arm_cpu_mp_affinity(idx, clustersz);<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Firmware on this machine only uses ACPI table to load OS, these li=
mited<br>
=C2=A0 * device tree nodes are just to let firmware know the info which var=
ies from<br>
@@ -183,14 +189,31 @@ static void create_fdt(SBSAMachineState *sms)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(matrix);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* From Documentation/devicetree/bindings/arm/cpus.yaml=
<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 On ARM v8 64-bit systems this property is requ=
ired<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 and matches the MPIDR_EL1 register affi=
nity bits.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 * If cpus node&#39;s #address-cells pro=
perty is set to 2<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 The first reg cell bits [7:0] mu=
st be set to<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 bits [39:32] of MPIDR_EL1.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 The second reg cell bits [23:0] =
must be set to<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 bits [23:0] of MPIDR_EL1.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0qemu_fdt_add_subnode(sms-&gt;fdt, &quot;/cpus&quot;);<b=
r>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(sms-&gt;fdt, &quot;/cpus&quot;, &quot;=
#address-cells&quot;, 2);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(sms-&gt;fdt, &quot;/cpus&quot;, &quot;=
#size-cells&quot;, 0x0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (cpu =3D sms-&gt;smp_cpus - 1; cpu &gt;=3D 0; cpu--=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *nodename =3D g_strdup_printf(&quot;=
/cpus/cpu@%d&quot;, cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARMCPU *armcpu =3D ARM_CPU(qemu_get_cpu(c=
pu));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUState *cs =3D CPU(armcpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t mpidr =3D sbsa_ref_cpu_mp_affinity(sm=
s, cpu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_add_subnode(sms-&gt;fdt, nodenam=
e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_u64(sms-&gt;fdt, nodename, &q=
uot;reg&quot;, mpidr);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ms-&gt;possible_cpus-&gt;cpus[cs-&gt;=
cpu_index].props.has_node_id) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_setprop_cell(sms-&=
gt;fdt, nodename, &quot;numa-node-id&quot;,<br>
@@ -717,12 +740,6 @@ static void sbsa_ref_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0arm_load_kernel(ARM_CPU(first_cpu), machine, &amp;sms-&=
gt;bootinfo);<br>
=C2=A0}<br>
<br>
-static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)<b=
r>
-{<br>
-=C2=A0 =C2=A0 uint8_t clustersz =3D ARM_DEFAULT_CPUS_PER_CLUSTER;<br>
-=C2=A0 =C2=A0 return arm_cpu_mp_affinity(idx, clustersz);<br>
-}<br>
-<br>
=C2=A0static const CPUArchIdList *sbsa_ref_possible_cpu_arch_ids(MachineSta=
te *ms)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0unsigned int max_cpus =3D ms-&gt;smp.max_cpus;<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000001ad54305ae32f72e--


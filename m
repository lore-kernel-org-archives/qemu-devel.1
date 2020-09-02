Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EA7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB4A20BED
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="kIcangnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB4A20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDUc6-0006no-RL
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDUbK-0006LZ-CY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:23:06 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDUbI-0001Xx-3Y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:23:06 -0400
Received: by mail-pf1-x443.google.com with SMTP id b124so3008407pfg.13
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=HChnfNphg2YnSJwh89vQql/mPeTfOKviwi8kA7c1noo=;
 b=kIcangnSUWJziH82JdODJz5kNJnv7/jCLUHYDkEwfcKt6TE3QNU55ABzzo/5jsAzoc
 GM3U/O/mJSEu8JZyCT024MmDLiLkZh/AgoGbf9yduTmnO31N3RmIVEDQWy0wpjGq+0jC
 4epk5/ns6d3WlzoC1CAAlL/G+0ACEmO/PO9n7lWqm1AQNCsJDwSQdPpin+aefYZ1GNP4
 4/ndgqLWoFUnKbvouijCzwfp8Q6sxGGZwQMXlgEAKVVO7RligT5mGr1LQfM/fykwv/jS
 GnfcsfVdMtFJxRpxdjs9QrjoGF0lkyYf/EPr5eWdAtGMV2zTL4yHu8+nI3kuiffFUxgN
 PA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=HChnfNphg2YnSJwh89vQql/mPeTfOKviwi8kA7c1noo=;
 b=RG4aEkr+A1KwGcnq9YROiM3kV6PGZGSC17LypSn1WbMFAqTjbOtmWmzTfmar6EdKL7
 PNakL0+XGQFEUHpkGmyk0u+uCQShPi9bWshG7SxjRGM2Ij3aRGH5EdyBYwWIl8Yy6CfI
 h/AOKPfBDWvvvAmZ2BgMhG02IGFpwJhz/HsM0xTN8LdjJti+IiEBAuIhdsQk0DHf4ZLe
 MT2ffAtHEhMx6fwMJ8maUhKfHO1/UFsqpQlbyAazlzcnY7rheGBp6JfwZYJIQtjolhob
 SuGBrdl2YrnoM1JiJy4fw/5R1auaKNTkuRwDtELVfIyGDsrLnz26POMh73d48Ah/nHv+
 GFYg==
X-Gm-Message-State: AOAM533CnCaF32B9qB9kHJVmjHcjIYlpFvIs2K1P9JMiCSWQyeIlDrCE
 pn5mlrwMJL/gH9wujxR2GthJNpktE/dPILrI
X-Google-Smtp-Source: ABdhPJzQAkexnbeZURlX6/kCKc3cXV+b7fGc87Qdgh0Ouin2Olbs02SJYA8lUhicGPukeskowKQPKw==
X-Received: by 2002:a05:6a00:847:: with SMTP id
 q7mr3550622pfk.172.1599060181282; 
 Wed, 02 Sep 2020 08:23:01 -0700 (PDT)
Received: from [192.168.1.4] ([115.96.105.241])
 by smtp.gmail.com with ESMTPSA id r186sm6667138pfr.162.2020.09.02.08.22.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Sep 2020 08:23:00 -0700 (PDT)
Date: Wed, 2 Sep 2020 20:52:37 +0530
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Message-ID: <1c780e4b-9679-4551-a130-2a9d35756ab9@Spark>
In-Reply-To: <20200901094922.25514-2-ani@anisinha.ca>
References: <20200901094922.25514-1-ani@anisinha.ca>
 <20200901094922.25514-2-ani@anisinha.ca>
Subject: Re: [PATCH] piix4: don't reserve hw resources when hotplug is
 off globally
X-Readdle-Message-ID: 1c780e4b-9679-4551-a130-2a9d35756ab9@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f4fb8ce_327b23c6_1e8"
Received-SPF: none client-ip=2607:f8b0:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f4fb8ce_327b23c6_1e8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please provide comments for this patch.
On Sep 1, 2020, 15:20 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> When acpi hotplug is turned off for both root pci bus as well as for pci
> bridges, we should not generate the related amls for DSDT table or initialize
> related hw ports or reserve hw resources. This change makes sure all those
> operations are turned off in the case acpi pci hotplug is off globally.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
> hw/acpi/piix4.c | 6 ++++--
> hw/i386/acpi-build.c | 10 ++++++++--
> 2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index e6163bb6ce..b70b1f98af 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> "acpi-gpe0", GPE_LEN);
> memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>
> - acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> - s->use_acpi_hotplug_bridge);
> + if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
> + acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> + s->use_acpi_hotplug_bridge);
> + }
>
> s->cpu_hotplug_legacy = true;
> object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..5365b3d290 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
> bool s3_disabled;
> bool s4_disabled;
> bool pcihp_bridge_en;
> + bool pcihp_root_en;
> uint8_t s4_val;
> AcpiFadtData fadt;
> uint16_t cpu_hp_io_base;
> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> pm->pcihp_bridge_en =
> object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> NULL);
> + pm->pcihp_root_en =
> + object_property_get_bool(obj, "acpi-root-pci-hotplug",
> + NULL);
> }
>
> static void acpi_get_misc_info(AcpiMiscInfo *info)
> @@ -1504,7 +1508,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> build_hpet_aml(dsdt);
> build_piix4_isa_bridge(dsdt);
> build_isa_devices_aml(dsdt);
> - build_piix4_pci_hotplug(dsdt);
> + if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> + build_piix4_pci_hotplug(dsdt);
> + }
> build_piix4_pci0_int(dsdt);
> } else {
> sb_scope = aml_scope("_SB");
> @@ -1698,7 +1704,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> crs_range_set_free(&crs_range_set);
>
> /* reserve PCIHP resources */
> - if (pm->pcihp_io_len) {
> + if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
> dev = aml_device("PHPR");
> aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> aml_append(dev,
> --
> 2.17.1
>

--5f4fb8ce_327b23c6_1e8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Please provide comments for this patch.</div>
</div>
<div name=3D=22messageReplySection=22>On Sep 1, 2020, 15:20 +0530, Ani Si=
nha &lt;ani=40anisinha.ca&gt;, wrote:<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22>When acpi hotplug is turned off for both root pci bus as well a=
s for pci<br />
bridges, we should not generate the related amls for DSDT table or initia=
lize<br />
related hw ports or reserve hw resources. This change makes sure all thos=
e<br />
operations are turned off in the case acpi pci hotplug is off globally.<b=
r />
<br />
Signed-off-by: Ani Sinha &lt;ani=40anisinha.ca&gt;<br />
---<br />
hw/acpi/piix4.c =7C 6 ++++--<br />
hw/i386/acpi-build.c =7C 10 ++++++++--<br />
2 files changed, 12 insertions(+), 4 deletions(-)<br />
<br />
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c<br />
index e6163bb6ce..b70b1f98af 100644<br />
--- a/hw/acpi/piix4.c<br />
+++ b/hw/acpi/piix4.c<br />
=40=40 -596,8 +596,10 =40=40 static void piix4=5Facpi=5Fsystem=5Fhot=5Fad=
d=5Finit(MemoryRegion *parent,<br />
=22acpi-gpe0=22, GPE=5FLEN);<br />
memory=5Fregion=5Fadd=5Fsubregion(parent, GPE=5FBASE, &amp;s-&gt;io=5Fgpe=
);<br />
<br />
- acpi=5Fpcihp=5Finit(OBJECT(s), &amp;s-&gt;acpi=5Fpci=5Fhotplug, bus, pa=
rent,<br />
- s-&gt;use=5Facpi=5Fhotplug=5Fbridge);<br />
+ if (s-&gt;use=5Facpi=5Fhotplug=5Fbridge =7C=7C s-&gt;use=5Facpi=5Froot=5F=
pci=5Fhotplug) =7B<br />
+ acpi=5Fpcihp=5Finit(OBJECT(s), &amp;s-&gt;acpi=5Fpci=5Fhotplug, bus, pa=
rent,<br />
+ s-&gt;use=5Facpi=5Fhotplug=5Fbridge);<br />
+ =7D<br />
<br />
s-&gt;cpu=5Fhotplug=5Flegacy =3D true;<br />
object=5Fproperty=5Fadd=5Fbool(OBJECT(s), =22cpu-hotplug-legacy=22,<br />=

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c<br />
index b7bcbbbb2a..5365b3d290 100644<br />
--- a/hw/i386/acpi-build.c<br />
+++ b/hw/i386/acpi-build.c<br />
=40=40 -95,6 +95,7 =40=40 typedef struct AcpiPmInfo =7B<br />
bool s3=5Fdisabled;<br />
bool s4=5Fdisabled;<br />
bool pcihp=5Fbridge=5Fen;<br />
+ bool pcihp=5Froot=5Fen;<br />
uint8=5Ft s4=5Fval;<br />
Acpi=46adtData fadt;<br />
uint16=5Ft cpu=5Fhp=5Fio=5Fbase;<br />
=40=40 -245,6 +246,9 =40=40 static void acpi=5Fget=5Fpm=5Finfo(MachineSta=
te *machine, AcpiPmInfo *pm)<br />
pm-&gt;pcihp=5Fbridge=5Fen =3D<br />
object=5Fproperty=5Fget=5Fbool(obj, =22acpi-pci-hotplug-with-bridge-suppo=
rt=22,<br />
NULL);<br />
+ pm-&gt;pcihp=5Froot=5Fen =3D<br />
+ object=5Fproperty=5Fget=5Fbool(obj, =22acpi-root-pci-hotplug=22,<br />
+ NULL);<br />
=7D<br />
<br />
static void acpi=5Fget=5Fmisc=5Finfo(AcpiMiscInfo *info)<br />
=40=40 -1504,7 +1508,9 =40=40 build=5Fdsdt(GArray *table=5Fdata, BIOSLink=
er *linker,<br />
build=5Fhpet=5Faml(dsdt);<br />
build=5Fpiix4=5Fisa=5Fbridge(dsdt);<br />
build=5Fisa=5Fdevices=5Faml(dsdt);<br />
- build=5Fpiix4=5Fpci=5Fhotplug(dsdt);<br />
+ if (pm-&gt;pcihp=5Fbridge=5Fen =7C=7C pm-&gt;pcihp=5Froot=5Fen) =7B<br =
/>
+ build=5Fpiix4=5Fpci=5Fhotplug(dsdt);<br />
+ =7D<br />
build=5Fpiix4=5Fpci0=5Fint(dsdt);<br />
=7D else =7B<br />
sb=5Fscope =3D aml=5Fscope(=22=5FSB=22);<br />
=40=40 -1698,7 +1704,7 =40=40 build=5Fdsdt(GArray *table=5Fdata, BIOSLink=
er *linker,<br />
crs=5Frange=5Fset=5Ffree(&amp;crs=5Frange=5Fset);<br />
<br />
/* reserve PCIHP resources */<br />
- if (pm-&gt;pcihp=5Fio=5Flen) =7B<br />
+ if (pm-&gt;pcihp=5Fio=5Flen &amp;&amp; (pm-&gt;pcihp=5Fbridge=5Fen =7C=7C=
 pm-&gt;pcihp=5Froot=5Fen)) =7B<br />
dev =3D aml=5Fdevice(=22PHPR=22);<br />
aml=5Fappend(dev, aml=5Fname=5Fdecl(=22=5FHID=22, aml=5Fstring(=22PNP0A06=
=22)));<br />
aml=5Fappend(dev,<br />
--<br />
2.17.1<br />
<br /></blockquote>
</div>
</body>
</html>

--5f4fb8ce_327b23c6_1e8--



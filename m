Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1411C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 19:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA882067B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 19:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF/iJZ48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA882067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jekxS-0002ps-F9
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 15:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jekwY-0002LG-BZ
 for qemu-devel@nongnu.org; Fri, 29 May 2020 15:45:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jekwV-0001dg-I5
 for qemu-devel@nongnu.org; Fri, 29 May 2020 15:45:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id r15so5173802wmh.5
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ZN4BYjajpNlf9+94cUOYL+hr645JJrt6Dj67IvKdWE=;
 b=YF/iJZ4804BOvw5a+muXU7R10ZG94T0hbh2eWKqJT1hx0iS/hQPMcT0raEPenJ0G8E
 UN9RO1d7hairvIvZGQ0qN/+ZVV97HvI3EBc4t7RX1oObQuqTl4phqV7WMsOXDjCVkHLq
 egyVk9LJyDD6mb1txrnRy9g4JpExO4Uomu5FxSQYj3ywzlv9pXwlQNcUij5Z7xz+Dzi1
 RTqy6OKomNJOzEAwOyrsAlK4VJf4GTvZ1VqUVJ9bTD3V7X50cwJHD1tPdnxkKlY4lmzk
 tCXQyLikW/t540IIyj5cDga2vgDzidR71LTAEwmS01LDMZqDxl9+PykNVFFpjxqvGJWx
 D0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ZN4BYjajpNlf9+94cUOYL+hr645JJrt6Dj67IvKdWE=;
 b=KMAldO/tiV6C8xVCM0MnAS2AAMZLvDI4HzC61wNkatcw4YqBZqgEH2gh3f5e1bh71z
 D70Y5fROMECzCJQoQBep9LI3oBpY6+z30BtRD0la/T5jLPVYYTtyVDrDwOBSadD7y1gY
 QmmFBznoDMRMAweC328A4Rbjn0IC92P/okxs5y5Uiod0I0z6nxyi0BVvZ62Cl/5qF/Ms
 bu2OsPvoO288PO8r351QUsGnaovUd5eeHGnRGCa947xrFmpxG/8YHlceCclkcXbQZ5L6
 NH7qbKSOWuR8pkgCRaEABu7rZwgAAh8i98KFdE5oBFEjK4qlFNRGNHxkbMTzHFMCOS4K
 9Xew==
X-Gm-Message-State: AOAM530G4iM/qCgq1tWy2kYNqzR5pmUsJB5MqctSo/SzG+5ZEOa3iHLb
 6GTF59l30jCp8ck+ZEtn41HNLDYz2AuWHL5Hm68=
X-Google-Smtp-Source: ABdhPJzISYQ2ORt3LmlbZ/ryDlJehO5Q6LMqWCPOl47nl2xIoA4089XWIKbXH9wa4YWXcfH/BVkJqm/0gT45YR4oOxg=
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr10563927wme.26.1590781520483; 
 Fri, 29 May 2020 12:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200529192840.3921141-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200529192840.3921141-1-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 May 2020 21:45:07 +0200
Message-ID: <CAJ+F1CJLixcN2Ps=QJv8az1_UpGdoe8M_YjnRbgSjPG8fpKBhA@mail.gmail.com>
Subject: Re: [PATCH] acpi: tpm: Do not build TCPA table for TPM 2
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000071982105a6ceaf4f"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Auger Eric <eric.auger@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000071982105a6ceaf4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 9:28 PM Stefan Berger <stefanb@linux.vnet.ibm.com>
wrote:

> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Do not build a TCPA table for TPM 2 anymore but create the log area when
> building the TPM2 table. The TCPA table is only needed for TPM 1.2.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  hw/i386/acpi-build.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2e15f6848e..b5669d6c65 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2317,6 +2317,10 @@ build_tpm2(GArray *table_data, BIOSLinker *linker,
> GArray *tcpalog)
>      tpm2_ptr->log_area_minimum_length =3D
>          cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
>
> +    acpi_data_push(tcpalog,
> le32_to_cpu(tpm2_ptr->log_area_minimum_length));
> +    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
> +                             false);
> +
>      /* log area start address to be filled by Guest linker */
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                     log_addr_offset, log_addr_size,
> @@ -2848,10 +2852,10 @@ void acpi_build(AcpiBuildTables *tables,
> MachineState *machine)
>          build_hpet(tables_blob, tables->linker);
>      }
>      if (misc.tpm_version !=3D TPM_VERSION_UNSPEC) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        build_tpm_tcpa(tables_blob, tables->linker, tables->tcpalog);
> -
> -        if (misc.tpm_version =3D=3D TPM_VERSION_2_0) {
> +        if (misc.tpm_version =3D=3D TPM_VERSION_1_2) {
> +            acpi_add_table(table_offsets, tables_blob);
> +            build_tpm_tcpa(tables_blob, tables->linker, tables->tcpalog)=
;
> +        } else { /* TPM_VERSION_2_0 */
>              acpi_add_table(table_offsets, tables_blob);
>              build_tpm2(tables_blob, tables->linker, tables->tcpalog);
>          }
> --
> 2.24.1
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000071982105a6ceaf4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 29, 2020 at 9:28 PM Stefa=
n Berger &lt;<a href=3D"mailto:stefanb@linux.vnet.ibm.com">stefanb@linux.vn=
et.ibm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stefan Berger &lt;<a href=3D"mailto:stefanb@linux.ibm.com"=
 target=3D"_blank">stefanb@linux.ibm.com</a>&gt;<br>
<br>
Do not build a TCPA table for TPM 2 anymore but create the log area when<br=
>
building the TPM2 table. The TCPA table is only needed for TPM 1.2.<br>
<br>
Signed-off-by: Stefan Berger &lt;<a href=3D"mailto:stefanb@linux.ibm.com" t=
arget=3D"_blank">stefanb@linux.ibm.com</a>&gt;<br></blockquote><div><br></d=
iv><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre=
.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/i386/acpi-build.c | 12 ++++++++----<br>
=C2=A01 file changed, 8 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c<br>
index 2e15f6848e..b5669d6c65 100644<br>
--- a/hw/i386/acpi-build.c<br>
+++ b/hw/i386/acpi-build.c<br>
@@ -2317,6 +2317,10 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, G=
Array *tcpalog)<br>
=C2=A0 =C2=A0 =C2=A0tpm2_ptr-&gt;log_area_minimum_length =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);<b=
r>
<br>
+=C2=A0 =C2=A0 acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr-&gt;log_area_mi=
nimum_length));<br>
+=C2=A0 =C2=A0 bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcp=
alog, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0false);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* log area start address to be filled by Guest linker =
*/<br>
=C2=A0 =C2=A0 =C2=A0bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE=
_FILE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log_addr_offset, log_a=
ddr_size,<br>
@@ -2848,10 +2852,10 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_hpet(tables_blob, tables-&gt;linker=
);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (misc.tpm_version !=3D TPM_VERSION_UNSPEC) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_add_table(table_offsets, tables_blob);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_tpm_tcpa(tables_blob, tables-&gt;linker,=
 tables-&gt;tcpalog);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (misc.tpm_version =3D=3D TPM_VERSION_2_0) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (misc.tpm_version =3D=3D TPM_VERSION_1_2) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_add_table(table_offsets, ta=
bles_blob);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_tpm_tcpa(tables_blob, tabl=
es-&gt;linker, tables-&gt;tcpalog);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else { /* TPM_VERSION_2_0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_add_table(table_offset=
s, tables_blob);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_tpm2(tables_blob, tab=
les-&gt;linker, tables-&gt;tcpalog);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.24.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000071982105a6ceaf4f--


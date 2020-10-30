Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1853AC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210BA20739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtQK8qWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210BA20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXeo-0001zJ-59
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXcP-0008Dk-RE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:51:13 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXcM-00042D-Pq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:51:13 -0400
Received: by mail-ed1-x543.google.com with SMTP id g25so6525169edm.6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RnWt/zHVxhRkOJhdZ4kzrYAMEcu4MxJ0hiCsHZvWPvA=;
 b=PtQK8qWGqhl719/StbJCey8w0BlC6t9txfnTuRqgmxBfilGGzYVAL8XyMRy0ND1Ym+
 iGRoR3eocz5VxM1WllnjX50RdNjsDzW5yeGd7rAl4Ef7D9ZOFh432JMNNXebgjUWgdnY
 GJxDryzhD25Cl2BwSy8MTTJ+WI9ccZTEtaSwp6wt8VVDnm17ntTYRXBYNfbFjvW1xjOJ
 pc/Hdh4QJ6A0nGwFzsOEw/ViNP8Zoc3mDnTZx1c83lPmhk7UdHaHyUJtOj0iWmyGzJVk
 jnoB56RdhB6DSoJAIUO6YXr2ak4E6O+81Xc20Q4cHkLCgws3lRy9amtxapEmr9KmY0wY
 NK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RnWt/zHVxhRkOJhdZ4kzrYAMEcu4MxJ0hiCsHZvWPvA=;
 b=n93jtQNE2LSJkR/lY/i+A5uUHX/3S5nW7M4rWQclxBrs5/6bbr/jOvgJvAOAFUea23
 91L5aklQ/7pm0j0YD2OjjG35Xa2W2xkWjJUQ8j/81VqWXpUTvrKgZQLm+y0aCNSKMUpf
 yJG+gfZgOp29Pb4l5R3IZ5L3nP+KeThlCCYZb9DqFJOEV5g5EQ43GqwAFupmYgz8wSFo
 aG63N0XCST7PmCgJNXprEaNYGLws3l5yBRxGzJYJ0Qc5b7bO5Nu2kfcuegiN1LuOymVa
 hYP0To3FQixUl7WWOguD9g1QicsgRxstl2BBvrb+SQrR9wjXpXaNoj7ebuhyepKbc4iv
 Mo/w==
X-Gm-Message-State: AOAM530bWfYotWa9/maaSXvFis9oE933Nda1xK7dRfxpbaiohZX8DAQJ
 zSnh6BxiM4Vh2eiLcanf2peVyl111a101vrvUH8=
X-Google-Smtp-Source: ABdhPJxt6sf3lwJgO22eR1rJFg7KyphCWKUIGY4ghH1BFdSsx2v15RGOOQAArQbrSyygcERbHeKzkS8foRYY8Aw5ZBY=
X-Received: by 2002:a50:a441:: with SMTP id v1mr3400353edb.30.1604076668798;
 Fri, 30 Oct 2020 09:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-25-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-25-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 20:50:57 +0400
Message-ID: <CAJ+F1CJydxHwz+fFeEo2+rRa-tG85VmWHu=+WoESepK2BJMv7Q@mail.gmail.com>
Subject: Re: [PATCH 24/36] qdev: Rename qdev_propinfo_* to object_propinfo_*
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000094b6005b2e634c1"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000094b6005b2e634c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:13 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> These functions will be moved to be part of QOM, so rename them.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/core/qdev-prop-internal.h     | 28 +++++++++----------
>  hw/core/qdev-properties-system.c | 48 ++++++++++++++++----------------
>  hw/core/qdev-properties.c        | 48 ++++++++++++++++----------------
>  3 files changed, 62 insertions(+), 62 deletions(-)
>
> diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
> index c8006a21c7..41ec9e8942 100644
> --- a/hw/core/qdev-prop-internal.h
> +++ b/hw/core/qdev-prop-internal.h
> @@ -8,22 +8,22 @@
>  #ifndef HW_CORE_QDEV_PROP_INTERNAL_H
>  #define HW_CORE_QDEV_PROP_INTERNAL_H
>
> -void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp);
> -void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp);
> +void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
> +                              void *opaque, Error **errp);
> +void object_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
> +                              void *opaque, Error **errp);
>
> -void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
> -                                          const Property *prop);
> -void qdev_propinfo_set_default_value_int(ObjectProperty *op,
> -                                         const Property *prop);
> -void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
> -                                          const Property *prop);
> +void object_propinfo_set_default_value_enum(ObjectProperty *op,
> +                                            const Property *prop);
> +void object_propinfo_set_default_value_int(ObjectProperty *op,
> +                                           const Property *prop);
> +void object_propinfo_set_default_value_uint(ObjectProperty *op,
> +                                            const Property *prop);
>
> -void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
> -                             void *opaque, Error **errp);
> -void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp);
> +void object_propinfo_get_int32(Object *obj, Visitor *v, const char *name=
,
> +                               void *opaque, Error **errp);
> +void object_propinfo_get_size32(Object *obj, Visitor *v, const char *nam=
e,
> +                                void *opaque, Error **errp);
>
>  /**
>   * object_property_add_static: Add a static property to an object instan=
ce
> diff --git a/hw/core/qdev-properties-system.c
> b/hw/core/qdev-properties-system.c
> index 60a45f5620..d9355053d2 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -535,9 +535,9 @@ QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) !=3D
> sizeof(int));
>  const PropertyInfo qdev_prop_losttickpolicy =3D {
>      .name  =3D "LostTickPolicy",
>      .enum_table  =3D &LostTickPolicy_lookup,
> -    .get   =3D qdev_propinfo_get_enum,
> -    .set   =3D qdev_propinfo_set_enum,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .get   =3D object_propinfo_get_enum,
> +    .set   =3D object_propinfo_set_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
>
>  /* --- blocksize --- */
> @@ -566,9 +566,9 @@ const PropertyInfo qdev_prop_blocksize =3D {
>      .name  =3D "size",
>      .description =3D "A power of two between " MIN_BLOCK_SIZE_STR
>                     " and " MAX_BLOCK_SIZE_STR,
> -    .get   =3D qdev_propinfo_get_size32,
> +    .get   =3D object_propinfo_get_size32,
>      .set   =3D set_blocksize,
> -    .set_default_value =3D qdev_propinfo_set_default_value_uint,
> +    .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
>  /* --- Block device error handling policy --- */
> @@ -580,9 +580,9 @@ const PropertyInfo qdev_prop_blockdev_on_error =3D {
>      .description =3D "Error handling policy, "
>                     "report/ignore/enospc/stop/auto",
>      .enum_table =3D &BlockdevOnError_lookup,
> -    .get =3D qdev_propinfo_get_enum,
> -    .set =3D qdev_propinfo_set_enum,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .get =3D object_propinfo_get_enum,
> +    .set =3D object_propinfo_set_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
>
>  /* --- BIOS CHS translation */
> @@ -594,9 +594,9 @@ const PropertyInfo qdev_prop_bios_chs_trans =3D {
>      .description =3D "Logical CHS translation algorithm, "
>                     "auto/none/lba/large/rechs",
>      .enum_table =3D &BiosAtaTranslation_lookup,
> -    .get =3D qdev_propinfo_get_enum,
> -    .set =3D qdev_propinfo_set_enum,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .get =3D object_propinfo_get_enum,
> +    .set =3D object_propinfo_set_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
>
>  /* --- FDC default drive types */
> @@ -606,9 +606,9 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
>      .description =3D "FDC drive type, "
>                     "144/288/120/none/auto",
>      .enum_table =3D &FloppyDriveType_lookup,
> -    .get =3D qdev_propinfo_get_enum,
> -    .set =3D qdev_propinfo_set_enum,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .get =3D object_propinfo_get_enum,
> +    .set =3D object_propinfo_set_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
>
>  /* --- MultiFDCompression --- */
> @@ -618,9 +618,9 @@ const PropertyInfo qdev_prop_multifd_compression =3D =
{
>      .description =3D "multifd_compression values, "
>                     "none/zlib/zstd",
>      .enum_table =3D &MultiFDCompression_lookup,
> -    .get =3D qdev_propinfo_get_enum,
> -    .set =3D qdev_propinfo_set_enum,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .get =3D object_propinfo_get_enum,
> +    .set =3D object_propinfo_set_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
>
>  /* --- Reserved Region --- */
> @@ -764,9 +764,9 @@ const PropertyInfo qdev_prop_pci_devfn =3D {
>      .name  =3D "int32",
>      .description =3D "Slot and optional function number, example: 06.0 o=
r
> 06",
>      .print =3D print_pci_devfn,
> -    .get   =3D qdev_propinfo_get_int32,
> +    .get   =3D object_propinfo_get_int32,
>      .set   =3D set_pci_devfn,
> -    .set_default_value =3D qdev_propinfo_set_default_value_int,
> +    .set_default_value =3D object_propinfo_set_default_value_int,
>  };
>
>  /* --- pci host address --- */
> @@ -879,9 +879,9 @@ const PropertyInfo qdev_prop_off_auto_pcibar =3D {
>      .name =3D "OffAutoPCIBAR",
>      .description =3D "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
>      .enum_table =3D &OffAutoPCIBAR_lookup,
> -    .get =3D qdev_propinfo_get_enum,
> -    .set =3D qdev_propinfo_set_enum,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .get =3D object_propinfo_get_enum,
> +    .set =3D object_propinfo_set_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
>
>  /* --- PCIELinkSpeed 2_5/5/8/16 -- */
> @@ -951,7 +951,7 @@ const PropertyInfo qdev_prop_pcie_link_speed =3D {
>      .enum_table =3D &PCIELinkSpeed_lookup,
>      .get =3D get_prop_pcielinkspeed,
>      .set =3D set_prop_pcielinkspeed,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
>
>  /* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
> @@ -1039,5 +1039,5 @@ const PropertyInfo qdev_prop_pcie_link_width =3D {
>      .enum_table =3D &PCIELinkWidth_lookup,
>      .get =3D get_prop_pcielinkwidth,
>      .set =3D set_prop_pcielinkwidth,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 5189626c09..e4aba2b237 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -93,7 +93,7 @@ static ObjectPropertyAccessor *static_prop_setter(const
> PropertyInfo *info)
>      return info->set ? static_prop_set : NULL;
>  }
>
> -void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
> +void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
>      Property *prop =3D opaque;
> @@ -102,7 +102,7 @@ void qdev_propinfo_get_enum(Object *obj, Visitor *v,
> const char *name,
>      visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
>  }
>
> -void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
> +void object_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
>      Property *prop =3D opaque;
> @@ -111,7 +111,7 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v,
> const char *name,
>      visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
>  }
>
> -void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
> +void object_propinfo_set_default_value_enum(ObjectProperty *op,
>                                            const Property *prop)
>  {
>      object_property_set_default_str(op,
> @@ -120,9 +120,9 @@ void
> qdev_propinfo_set_default_value_enum(ObjectProperty *op,
>
>  const PropertyInfo qdev_prop_enum =3D {
>      .name  =3D "enum",
> -    .get   =3D qdev_propinfo_get_enum,
> -    .set   =3D qdev_propinfo_set_enum,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .get   =3D object_propinfo_get_enum,
> +    .set   =3D object_propinfo_set_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
>
>  /* Bit */
> @@ -275,13 +275,13 @@ static void set_uint8(Object *obj, Visitor *v, cons=
t
> char *name, void *opaque,
>      visit_type_uint8(v, name, ptr, errp);
>  }
>
> -void qdev_propinfo_set_default_value_int(ObjectProperty *op,
> +void object_propinfo_set_default_value_int(ObjectProperty *op,
>                                           const Property *prop)
>  {
>      object_property_set_default_int(op, prop->defval.i);
>  }
>
> -void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
> +void object_propinfo_set_default_value_uint(ObjectProperty *op,
>                                            const Property *prop)
>  {
>      object_property_set_default_uint(op, prop->defval.u);
> @@ -291,7 +291,7 @@ const PropertyInfo qdev_prop_uint8 =3D {
>      .name  =3D "uint8",
>      .get   =3D get_uint8,
>      .set   =3D set_uint8,
> -    .set_default_value =3D qdev_propinfo_set_default_value_uint,
> +    .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
>  /* --- 16bit integer --- */
> @@ -318,7 +318,7 @@ const PropertyInfo qdev_prop_uint16 =3D {
>      .name  =3D "uint16",
>      .get   =3D get_uint16,
>      .set   =3D set_uint16,
> -    .set_default_value =3D qdev_propinfo_set_default_value_uint,
> +    .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
>  /* --- 32bit integer --- */
> @@ -341,7 +341,7 @@ static void set_uint32(Object *obj, Visitor *v, const
> char *name,
>      visit_type_uint32(v, name, ptr, errp);
>  }
>
> -void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
> +void object_propinfo_get_int32(Object *obj, Visitor *v, const char *name=
,
>                               void *opaque, Error **errp)
>  {
>      Property *prop =3D opaque;
> @@ -363,14 +363,14 @@ const PropertyInfo qdev_prop_uint32 =3D {
>      .name  =3D "uint32",
>      .get   =3D get_uint32,
>      .set   =3D set_uint32,
> -    .set_default_value =3D qdev_propinfo_set_default_value_uint,
> +    .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
>  const PropertyInfo qdev_prop_int32 =3D {
>      .name  =3D "int32",
> -    .get   =3D qdev_propinfo_get_int32,
> +    .get   =3D object_propinfo_get_int32,
>      .set   =3D set_int32,
> -    .set_default_value =3D qdev_propinfo_set_default_value_int,
> +    .set_default_value =3D object_propinfo_set_default_value_int,
>  };
>
>  /* --- 64bit integer --- */
> @@ -415,14 +415,14 @@ const PropertyInfo qdev_prop_uint64 =3D {
>      .name  =3D "uint64",
>      .get   =3D get_uint64,
>      .set   =3D set_uint64,
> -    .set_default_value =3D qdev_propinfo_set_default_value_uint,
> +    .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
>  const PropertyInfo qdev_prop_int64 =3D {
>      .name  =3D "int64",
>      .get   =3D get_int64,
>      .set   =3D set_int64,
> -    .set_default_value =3D qdev_propinfo_set_default_value_int,
> +    .set_default_value =3D object_propinfo_set_default_value_int,
>  };
>
>  /* --- string --- */
> @@ -474,14 +474,14 @@ const PropertyInfo qdev_prop_on_off_auto =3D {
>      .name =3D "OnOffAuto",
>      .description =3D "on/off/auto",
>      .enum_table =3D &OnOffAuto_lookup,
> -    .get =3D qdev_propinfo_get_enum,
> -    .set =3D qdev_propinfo_set_enum,
> -    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +    .get =3D object_propinfo_get_enum,
> +    .set =3D object_propinfo_set_enum,
> +    .set_default_value =3D object_propinfo_set_default_value_enum,
>  };
>
>  /* --- 32bit unsigned int 'size' type --- */
>
> -void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
> +void object_propinfo_get_size32(Object *obj, Visitor *v, const char *nam=
e,
>                                void *opaque, Error **errp)
>  {
>      Property *prop =3D opaque;
> @@ -515,9 +515,9 @@ static void set_size32(Object *obj, Visitor *v, const
> char *name, void *opaque,
>
>  const PropertyInfo qdev_prop_size32 =3D {
>      .name  =3D "size",
> -    .get =3D qdev_propinfo_get_size32,
> +    .get =3D object_propinfo_get_size32,
>      .set =3D set_size32,
> -    .set_default_value =3D qdev_propinfo_set_default_value_uint,
> +    .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
>  /* --- UUID --- */
> @@ -686,7 +686,7 @@ const PropertyInfo qdev_prop_arraylen =3D {
>      .name =3D "uint32",
>      .get =3D get_uint32,
>      .set =3D set_prop_arraylen,
> -    .set_default_value =3D qdev_propinfo_set_default_value_uint,
> +    .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
>  /* --- public helpers --- */
> @@ -885,7 +885,7 @@ const PropertyInfo qdev_prop_size =3D {
>      .name  =3D "size",
>      .get =3D get_size,
>      .set =3D set_size,
> -    .set_default_value =3D qdev_propinfo_set_default_value_uint,
> +    .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
>  /* --- object link property --- */
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000094b6005b2e634c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:13 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Th=
ese functions will be moved to be part of QOM, so rename them.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
;</div><div><br></div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
---<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Cc: &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"mailto:berrange@redh=
at.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Cc: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_b=
lank">ehabkost@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0hw/core/qdev-prop-internal.h=C2=A0 =C2=A0 =C2=A0| 28 +++++++++-------=
---<br>
=C2=A0hw/core/qdev-properties-system.c | 48 ++++++++++++++++---------------=
-<br>
=C2=A0hw/core/qdev-properties.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 48 +++++++++++=
+++++----------------<br>
=C2=A03 files changed, 62 insertions(+), 62 deletions(-)<br>
<br>
diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h<br=
>
index c8006a21c7..41ec9e8942 100644<br>
--- a/hw/core/qdev-prop-internal.h<br>
+++ b/hw/core/qdev-prop-internal.h<br>
@@ -8,22 +8,22 @@<br>
=C2=A0#ifndef HW_CORE_QDEV_PROP_INTERNAL_H<br>
=C2=A0#define HW_CORE_QDEV_PROP_INTERNAL_H<br>
<br>
-void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp);<br>
-void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp);<br>
+void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp);<br>
+void object_propinfo_set_enum(Object *obj, Visitor *v, const char *name,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp);<br>
<br>
-void qdev_propinfo_set_default_value_enum(ObjectProperty *op,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
onst Property *prop);<br>
-void qdev_propinfo_set_default_value_int(ObjectProperty *op,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
nst Property *prop);<br>
-void qdev_propinfo_set_default_value_uint(ObjectProperty *op,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
onst Property *prop);<br>
+void object_propinfo_set_default_value_enum(ObjectProperty *op,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 const Property *prop);<br>
+void object_propinfo_set_default_value_int(ObjectProperty *op,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const Property *prop);<br>
+void object_propinfo_set_default_value_uint(ObjectProperty *op,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 const Property *prop);<br>
<br>
-void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp);<br>
-void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp);<br>
+void object_propinfo_get_int32(Object *obj, Visitor *v, const char *name,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp);<br>
+void object_propinfo_get_size32(Object *obj, Visitor *v, const char *name,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp);<br>
<br>
=C2=A0/**<br>
=C2=A0 * object_property_add_static: Add a static property to an object ins=
tance<br>
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-sys=
tem.c<br>
index 60a45f5620..d9355053d2 100644<br>
--- a/hw/core/qdev-properties-system.c<br>
+++ b/hw/core/qdev-properties-system.c<br>
@@ -535,9 +535,9 @@ QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) !=3D sizeof(in=
t));<br>
=C2=A0const PropertyInfo qdev_prop_losttickpolicy =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;LostTickPolicy&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.enum_table=C2=A0 =3D &amp;LostTickPolicy_lookup,<br>
-=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D qdev_propinfo_get_enum,<br>
-=C2=A0 =C2=A0 .set=C2=A0 =C2=A0=3D qdev_propinfo_set_enum,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D object_propinfo_get_enum,<br>
+=C2=A0 =C2=A0 .set=C2=A0 =C2=A0=3D object_propinfo_set_enum,<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- blocksize --- */<br>
@@ -566,9 +566,9 @@ const PropertyInfo qdev_prop_blocksize =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;size&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;A power of two between &quot; MI=
N_BLOCK_SIZE_STR<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
; and &quot; MAX_BLOCK_SIZE_STR,<br>
-=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D qdev_propinfo_get_size32,<br>
+=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D object_propinfo_get_size32,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_blocksize,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_uint,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_uin=
t,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- Block device error handling policy --- */<br>
@@ -580,9 +580,9 @@ const PropertyInfo qdev_prop_blockdev_on_error =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;Error handling policy, &quot;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;report/ignore/enospc/stop/auto&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.enum_table =3D &amp;BlockdevOnError_lookup,<br>
-=C2=A0 =C2=A0 .get =3D qdev_propinfo_get_enum,<br>
-=C2=A0 =C2=A0 .set =3D qdev_propinfo_set_enum,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .get =3D object_propinfo_get_enum,<br>
+=C2=A0 =C2=A0 .set =3D object_propinfo_set_enum,<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- BIOS CHS translation */<br>
@@ -594,9 +594,9 @@ const PropertyInfo qdev_prop_bios_chs_trans =3D {<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;Logical CHS translation algorith=
m, &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;auto/none/lba/large/rechs&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.enum_table =3D &amp;BiosAtaTranslation_lookup,<br>
-=C2=A0 =C2=A0 .get =3D qdev_propinfo_get_enum,<br>
-=C2=A0 =C2=A0 .set =3D qdev_propinfo_set_enum,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .get =3D object_propinfo_get_enum,<br>
+=C2=A0 =C2=A0 .set =3D object_propinfo_set_enum,<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- FDC default drive types */<br>
@@ -606,9 +606,9 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;FDC drive type, &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;144/288/120/none/auto&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.enum_table =3D &amp;FloppyDriveType_lookup,<br>
-=C2=A0 =C2=A0 .get =3D qdev_propinfo_get_enum,<br>
-=C2=A0 =C2=A0 .set =3D qdev_propinfo_set_enum,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .get =3D object_propinfo_get_enum,<br>
+=C2=A0 =C2=A0 .set =3D object_propinfo_set_enum,<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- MultiFDCompression --- */<br>
@@ -618,9 +618,9 @@ const PropertyInfo qdev_prop_multifd_compression =3D {<=
br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;multifd_compression values, &quo=
t;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;none/zlib/zstd&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.enum_table =3D &amp;MultiFDCompression_lookup,<br>
-=C2=A0 =C2=A0 .get =3D qdev_propinfo_get_enum,<br>
-=C2=A0 =C2=A0 .set =3D qdev_propinfo_set_enum,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .get =3D object_propinfo_get_enum,<br>
+=C2=A0 =C2=A0 .set =3D object_propinfo_set_enum,<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- Reserved Region --- */<br>
@@ -764,9 +764,9 @@ const PropertyInfo qdev_prop_pci_devfn =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;int32&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;Slot and optional function numbe=
r, example: 06.0 or 06&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.print =3D print_pci_devfn,<br>
-=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D qdev_propinfo_get_int32,<br>
+=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D object_propinfo_get_int32,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_pci_devfn,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_int,<=
br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_int=
,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- pci host address --- */<br>
@@ -879,9 +879,9 @@ const PropertyInfo qdev_prop_off_auto_pcibar =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D &quot;OffAutoPCIBAR&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;off/auto/bar0/bar1/bar2/bar3/bar=
4/bar5&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.enum_table =3D &amp;OffAutoPCIBAR_lookup,<br>
-=C2=A0 =C2=A0 .get =3D qdev_propinfo_get_enum,<br>
-=C2=A0 =C2=A0 .set =3D qdev_propinfo_set_enum,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .get =3D object_propinfo_get_enum,<br>
+=C2=A0 =C2=A0 .set =3D object_propinfo_set_enum,<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- PCIELinkSpeed 2_5/5/8/16 -- */<br>
@@ -951,7 +951,7 @@ const PropertyInfo qdev_prop_pcie_link_speed =3D {<br>
=C2=A0 =C2=A0 =C2=A0.enum_table =3D &amp;PCIELinkSpeed_lookup,<br>
=C2=A0 =C2=A0 =C2=A0.get =3D get_prop_pcielinkspeed,<br>
=C2=A0 =C2=A0 =C2=A0.set =3D set_prop_pcielinkspeed,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */<br>
@@ -1039,5 +1039,5 @@ const PropertyInfo qdev_prop_pcie_link_width =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0.enum_table =3D &amp;PCIELinkWidth_lookup,<br>
=C2=A0 =C2=A0 =C2=A0.get =3D get_prop_pcielinkwidth,<br>
=C2=A0 =C2=A0 =C2=A0.set =3D set_prop_pcielinkwidth,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 5189626c09..e4aba2b237 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -93,7 +93,7 @@ static ObjectPropertyAccessor *static_prop_setter(const P=
ropertyInfo *info)<br>
=C2=A0 =C2=A0 =C2=A0return info-&gt;set ? static_prop_set : NULL;<br>
=C2=A0}<br>
<br>
-void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,<br>
+void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Property *prop =3D opaque;<br>
@@ -102,7 +102,7 @@ void qdev_propinfo_get_enum(Object *obj, Visitor *v, co=
nst char *name,<br>
=C2=A0 =C2=A0 =C2=A0visit_type_enum(v, prop-&gt;name, ptr, prop-&gt;info-&g=
t;enum_table, errp);<br>
=C2=A0}<br>
<br>
-void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,<br>
+void object_propinfo_set_enum(Object *obj, Visitor *v, const char *name,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Property *prop =3D opaque;<br>
@@ -111,7 +111,7 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, co=
nst char *name,<br>
=C2=A0 =C2=A0 =C2=A0visit_type_enum(v, prop-&gt;name, ptr, prop-&gt;info-&g=
t;enum_table, errp);<br>
=C2=A0}<br>
<br>
-void qdev_propinfo_set_default_value_enum(ObjectProperty *op,<br>
+void object_propinfo_set_default_value_enum(ObjectProperty *op,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const Property *prop)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_default_str(op,<br>
@@ -120,9 +120,9 @@ void qdev_propinfo_set_default_value_enum(ObjectPropert=
y *op,<br>
<br>
=C2=A0const PropertyInfo qdev_prop_enum =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;enum&quot;,<br>
-=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D qdev_propinfo_get_enum,<br>
-=C2=A0 =C2=A0 .set=C2=A0 =C2=A0=3D qdev_propinfo_set_enum,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D object_propinfo_get_enum,<br>
+=C2=A0 =C2=A0 .set=C2=A0 =C2=A0=3D object_propinfo_set_enum,<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
<br>
=C2=A0/* Bit */<br>
@@ -275,13 +275,13 @@ static void set_uint8(Object *obj, Visitor *v, const =
char *name, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0visit_type_uint8(v, name, ptr, errp);<br>
=C2=A0}<br>
<br>
-void qdev_propinfo_set_default_value_int(ObjectProperty *op,<br>
+void object_propinfo_set_default_value_int(ObjectProperty *op,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
onst Property *prop)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_default_int(op, prop-&gt;defval.i);=
<br>
=C2=A0}<br>
<br>
-void qdev_propinfo_set_default_value_uint(ObjectProperty *op,<br>
+void object_propinfo_set_default_value_uint(ObjectProperty *op,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const Property *prop)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_default_uint(op, prop-&gt;defval.u)=
;<br>
@@ -291,7 +291,7 @@ const PropertyInfo qdev_prop_uint8 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;uint8&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_uint8,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_uint8,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_uint,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_uin=
t,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- 16bit integer --- */<br>
@@ -318,7 +318,7 @@ const PropertyInfo qdev_prop_uint16 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;uint16&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_uint16,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_uint16,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_uint,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_uin=
t,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- 32bit integer --- */<br>
@@ -341,7 +341,7 @@ static void set_uint32(Object *obj, Visitor *v, const c=
har *name,<br>
=C2=A0 =C2=A0 =C2=A0visit_type_uint32(v, name, ptr, errp);<br>
=C2=A0}<br>
<br>
-void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,<br=
>
+void object_propinfo_get_int32(Object *obj, Visitor *v, const char *name,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Property *prop =3D opaque;<br>
@@ -363,14 +363,14 @@ const PropertyInfo qdev_prop_uint32 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;uint32&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_uint32,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_uint32,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_uint,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_uin=
t,<br>
=C2=A0};<br>
<br>
=C2=A0const PropertyInfo qdev_prop_int32 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;int32&quot;,<br>
-=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D qdev_propinfo_get_int32,<br>
+=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D object_propinfo_get_int32,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_int32,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_int,<=
br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_int=
,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- 64bit integer --- */<br>
@@ -415,14 +415,14 @@ const PropertyInfo qdev_prop_uint64 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;uint64&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_uint64,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_uint64,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_uint,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_uin=
t,<br>
=C2=A0};<br>
<br>
=C2=A0const PropertyInfo qdev_prop_int64 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;int64&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_int64,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_int64,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_int,<=
br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_int=
,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- string --- */<br>
@@ -474,14 +474,14 @@ const PropertyInfo qdev_prop_on_off_auto =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D &quot;OnOffAuto&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;on/off/auto&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.enum_table =3D &amp;OnOffAuto_lookup,<br>
-=C2=A0 =C2=A0 .get =3D qdev_propinfo_get_enum,<br>
-=C2=A0 =C2=A0 .set =3D qdev_propinfo_set_enum,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_enum,=
<br>
+=C2=A0 =C2=A0 .get =3D object_propinfo_get_enum,<br>
+=C2=A0 =C2=A0 .set =3D object_propinfo_set_enum,<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_enu=
m,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- 32bit unsigned int &#39;size&#39; type --- */<br>
<br>
-void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,<b=
r>
+void object_propinfo_get_size32(Object *obj, Visitor *v, const char *name,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Property *prop =3D opaque;<br>
@@ -515,9 +515,9 @@ static void set_size32(Object *obj, Visitor *v, const c=
har *name, void *opaque,<br>
<br>
=C2=A0const PropertyInfo qdev_prop_size32 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;size&quot;,<br>
-=C2=A0 =C2=A0 .get =3D qdev_propinfo_get_size32,<br>
+=C2=A0 =C2=A0 .get =3D object_propinfo_get_size32,<br>
=C2=A0 =C2=A0 =C2=A0.set =3D set_size32,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_uint,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_uin=
t,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- UUID --- */<br>
@@ -686,7 +686,7 @@ const PropertyInfo qdev_prop_arraylen =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D &quot;uint32&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get =3D get_uint32,<br>
=C2=A0 =C2=A0 =C2=A0.set =3D set_prop_arraylen,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_uint,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_uin=
t,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- public helpers --- */<br>
@@ -885,7 +885,7 @@ const PropertyInfo qdev_prop_size =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;size&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get =3D get_size,<br>
=C2=A0 =C2=A0 =C2=A0.set =3D set_size,<br>
-=C2=A0 =C2=A0 .set_default_value =3D qdev_propinfo_set_default_value_uint,=
<br>
+=C2=A0 =C2=A0 .set_default_value =3D object_propinfo_set_default_value_uin=
t,<br>
=C2=A0};<br>
<br>
=C2=A0/* --- object link property --- */<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000094b6005b2e634c1--


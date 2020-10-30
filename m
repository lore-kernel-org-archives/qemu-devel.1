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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42036C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604692075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbeFTSd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604692075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXqO-000100-DB
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXnm-00082n-2I; Fri, 30 Oct 2020 13:02:58 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXnh-0005gz-9P; Fri, 30 Oct 2020 13:02:57 -0400
Received: by mail-ed1-x542.google.com with SMTP id dg9so7343620edb.12;
 Fri, 30 Oct 2020 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j8EbmZjY0JJ9UdQuyuuVvsaWNJd7dNJdhnicJM+IcSo=;
 b=NbeFTSd4omYUavS+m+/+NQhvdXk0jQmCaMmmw5LPEMI3n+tKd9Vi33WSGURoW9PTLO
 B2yMSADoy8swzyglYcTPcYcXv2FgZ+eQ5peEZ2F+0pgBKcorCjDJnuE75J7RgVO6czT1
 Wsu7StSuRv9UbvxKO11ZANN5MtIvcAZbSzobPiBId2nbsHpYmEDc9D+PVJYiIqXLGlxZ
 Nx8QNlelkpRLVd402L7ZE1lP+wqgEeX7H7hVjBgTpgWPsbbGOvyfyv7hsMAfjIou0BfV
 GK/G9jImwIaGZP21mlUgrTctlOQIxnrDgKi57fAUHn6R/5Pusw4X+9gmAO5bRBPKAdrj
 wZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j8EbmZjY0JJ9UdQuyuuVvsaWNJd7dNJdhnicJM+IcSo=;
 b=djw+6wR4XnQ8BRmqwResGYoEiXqvicDjE4CCr7keywu0PP5VkLjl9rcuyXMkVdHVs7
 VkxY0h68nBJKeJM854ht7Z8sXbmDUReB/wsaJ0tY5nn0mmZzan9qlbX7KnzvzyHTPzOg
 yr+h57Ja8e5CjI3EWz0O8HMYIB/LJZfrCTvktpPHqNQbi3UdHucL+bI7J3lEY1tWAMvo
 aVg9AaS+eCTIyWwHj+IgYwN3xEEo4nFQ4NYpaxFLKycITuzNnir18XGfCF6xAN3k2sch
 nmdFLCpAETsljf8c5SfW8QCcAamkvrdaQ7BcRR6SXI0UF2znhXmw5/ctOrxoy/wODOCi
 wojw==
X-Gm-Message-State: AOAM5313kmOw8B7vlUxPQDbUs9Wqg4+Yl1DBxlZbL0Dixs1GfCRB+cX6
 hdFz8pN0G0hUgDimV0+puU7wMXmAODM8EbO68oA=
X-Google-Smtp-Source: ABdhPJxGfK3XuHNuP2+7g4dcXzAtq3gE/WMmKDVtr4k6a/c28cAFQq4j31K4PHGijaNDQGsP4WZHpoylNVMHGZtMBgU=
X-Received: by 2002:a50:a441:: with SMTP id v1mr3458737edb.30.1604077371331;
 Fri, 30 Oct 2020 10:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-31-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-31-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 21:02:39 +0400
Message-ID: <CAJ+F1CJeZ2rKeeJKWDyLaW_vXxseR5NrEmn0hY8B1OT+5Ggu2A@mail.gmail.com>
Subject: Re: [PATCH 30/36] qdev: Rename qdev_prop_* to prop_info_*
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e91efa05b2e65d0c"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e91efa05b2e65d0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:19 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> The basic property types in qdev-properties.c are not going to be
> qdev-specific anymore.  Rename the variables to prop_info_*.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  include/hw/qdev-properties.h | 68 ++++++++++++++++++------------------
>  hw/core/qdev-properties.c    | 38 ++++++++++----------
>  hw/intc/arm_gicv3_common.c   |  2 +-
>  hw/intc/rx_icu.c             |  4 +--
>  hw/misc/arm_sysctl.c         |  4 +--
>  hw/net/e1000e.c              |  6 ++--
>  target/arm/cpu.c             |  2 +-
>  target/sparc/cpu.c           |  2 +-
>  8 files changed, 63 insertions(+), 63 deletions(-)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 2b00a1bcf6..7a08946448 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -6,23 +6,23 @@
>
>  /*** qdev-properties.c ***/
>
> -extern const PropertyInfo qdev_prop_bit;
> -extern const PropertyInfo qdev_prop_bit64;
> -extern const PropertyInfo qdev_prop_bool;
> -extern const PropertyInfo qdev_prop_enum;
> -extern const PropertyInfo qdev_prop_uint8;
> -extern const PropertyInfo qdev_prop_uint16;
> -extern const PropertyInfo qdev_prop_uint32;
> -extern const PropertyInfo qdev_prop_int32;
> -extern const PropertyInfo qdev_prop_uint64;
> -extern const PropertyInfo qdev_prop_int64;
> -extern const PropertyInfo qdev_prop_size;
> -extern const PropertyInfo qdev_prop_string;
> -extern const PropertyInfo qdev_prop_on_off_auto;
> -extern const PropertyInfo qdev_prop_size32;
> -extern const PropertyInfo qdev_prop_uuid;
> -extern const PropertyInfo qdev_prop_arraylen;
> -extern const PropertyInfo qdev_prop_link;
> +extern const PropertyInfo prop_info_bit;
> +extern const PropertyInfo prop_info_bit64;
> +extern const PropertyInfo prop_info_bool;
> +extern const PropertyInfo prop_info_enum;
> +extern const PropertyInfo prop_info_uint8;
> +extern const PropertyInfo prop_info_uint16;
> +extern const PropertyInfo prop_info_uint32;
> +extern const PropertyInfo prop_info_int32;
> +extern const PropertyInfo prop_info_uint64;
> +extern const PropertyInfo prop_info_int64;
> +extern const PropertyInfo prop_info_size;
> +extern const PropertyInfo prop_info_string;
> +extern const PropertyInfo prop_info_on_off_auto;
> +extern const PropertyInfo prop_info_size32;
> +extern const PropertyInfo prop_info_uuid;
> +extern const PropertyInfo prop_info_arraylen;
> +extern const PropertyInfo prop_info_link;
>
>  #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
>          .name      =3D (_name),                                    \
> @@ -41,7 +41,7 @@ extern const PropertyInfo qdev_prop_link;
>      DEFINE_PROP(_name, _state, _field, _prop, _type)
>
>  #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval)   \
> -    DEFINE_PROP(_name, _state, _field, qdev_prop_bit, uint32_t, \
> +    DEFINE_PROP(_name, _state, _field, prop_info_bit, uint32_t, \
>                  .bitnr       =3D (_bit),                          \
>                  .set_default =3D true,                            \
>                  .defval.u    =3D (bool)_defval)
> @@ -55,13 +55,13 @@ extern const PropertyInfo qdev_prop_link;
>      DEFINE_PROP(_name, _state, _field, _prop, _type)
>
>  #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval)   \
> -    DEFINE_PROP(_name, _state, _field, qdev_prop_bit64, uint64_t, \
> +    DEFINE_PROP(_name, _state, _field, prop_info_bit64, uint64_t, \
>                  .bitnr    =3D (_bit),                               \
>                  .set_default =3D true,                              \
>                  .defval.u  =3D (bool)_defval)
>
>  #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
> -    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
> +    DEFINE_PROP(_name, _state, _field, prop_info_bool, bool, \
>                  .set_default =3D true,                         \
>                  .defval.u    =3D (bool)_defval)
>
> @@ -94,7 +94,7 @@ extern const PropertyInfo qdev_prop_link;
>  #define DEFINE_PROP_ARRAY(_name, _state, _field,               \
>                            _arrayfield, _arrayprop, _arraytype) \
>      DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
> -                _state, _field, qdev_prop_arraylen, uint32_t,  \
> +                _state, _field, prop_info_arraylen, uint32_t,  \
>                  .set_default =3D true,                           \
>                  .defval.u =3D 0,                                 \
>                  .arrayinfo =3D &(_arrayprop),                    \
> @@ -102,34 +102,34 @@ extern const PropertyInfo qdev_prop_link;
>                  .arrayoffset =3D offsetof(_state, _arrayfield))
>
>  #define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
> -    DEFINE_PROP(_name, _state, _field, qdev_prop_link, _ptr_type,     \
> +    DEFINE_PROP(_name, _state, _field, prop_info_link, _ptr_type,     \
>                  .link_type  =3D _type)
>
>  #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint8, uint8_t)
>  #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint16, uint16_t)
>  #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint32, uint32_t)
>  #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int32, int32_t)
>  #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint64, uint64_t)
>  #define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int64, int64_t)
>  #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size, uint64_t)
>  #define DEFINE_PROP_STRING(_n, _s, _f)             \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
> +    DEFINE_PROP(_n, _s, _f, prop_info_string, char*)
>  #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_on_off_auto, OnOffAuto)
>  #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size32, uint32_t)
>  #define DEFINE_PROP_UUID(_name, _state, _field)                      \
> -    DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID,     \
> +    DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID,     \
>                  .set_default =3D true)
>  #define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
> -    DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID)
> +    DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID)
>
>  #define DEFINE_PROP_END_OF_LIST()               \
>      {}
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 1b27ba7236..59d65a7362 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -76,7 +76,7 @@ void
> object_propinfo_set_default_value_enum(ObjectProperty *op,
>          qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
>  }
>
> -const PropertyInfo qdev_prop_enum =3D {
> +const PropertyInfo prop_info_enum =3D {
>      .name  =3D "enum",
>      .get   =3D object_propinfo_get_enum,
>      .set   =3D object_propinfo_set_enum,
> @@ -87,7 +87,7 @@ const PropertyInfo qdev_prop_enum =3D {
>
>  static uint32_t qdev_get_prop_mask(Property *prop)
>  {
> -    assert(prop->info =3D=3D &qdev_prop_bit);
> +    assert(prop->info =3D=3D &prop_info_bit);
>      return 0x1 << prop->bitnr;
>  }
>
> @@ -129,7 +129,7 @@ static void set_default_value_bool(ObjectProperty *op=
,
> const Property *prop)
>      object_property_set_default_bool(op, prop->defval.u);
>  }
>
> -const PropertyInfo qdev_prop_bit =3D {
> +const PropertyInfo prop_info_bit =3D {
>      .name  =3D "bool",
>      .description =3D "on/off",
>      .get   =3D prop_get_bit,
> @@ -141,7 +141,7 @@ const PropertyInfo qdev_prop_bit =3D {
>
>  static uint64_t qdev_get_prop_mask64(Property *prop)
>  {
> -    assert(prop->info =3D=3D &qdev_prop_bit64);
> +    assert(prop->info =3D=3D &prop_info_bit64);
>      return 0x1ull << prop->bitnr;
>  }
>
> @@ -178,7 +178,7 @@ static void prop_set_bit64(Object *obj, Visitor *v,
> const char *name,
>      bit64_prop_set(obj, prop, value);
>  }
>
> -const PropertyInfo qdev_prop_bit64 =3D {
> +const PropertyInfo prop_info_bit64 =3D {
>      .name  =3D "bool",
>      .description =3D "on/off",
>      .get   =3D prop_get_bit64,
> @@ -206,7 +206,7 @@ static void set_bool(Object *obj, Visitor *v, const
> char *name, void *opaque,
>      visit_type_bool(v, name, ptr, errp);
>  }
>
> -const PropertyInfo qdev_prop_bool =3D {
> +const PropertyInfo prop_info_bool =3D {
>      .name  =3D "bool",
>      .get   =3D get_bool,
>      .set   =3D set_bool,
> @@ -245,7 +245,7 @@ void
> object_propinfo_set_default_value_uint(ObjectProperty *op,
>      object_property_set_default_uint(op, prop->defval.u);
>  }
>
> -const PropertyInfo qdev_prop_uint8 =3D {
> +const PropertyInfo prop_info_uint8 =3D {
>      .name  =3D "uint8",
>      .get   =3D get_uint8,
>      .set   =3D set_uint8,
> @@ -272,7 +272,7 @@ static void set_uint16(Object *obj, Visitor *v, const
> char *name,
>      visit_type_uint16(v, name, ptr, errp);
>  }
>
> -const PropertyInfo qdev_prop_uint16 =3D {
> +const PropertyInfo prop_info_uint16 =3D {
>      .name  =3D "uint16",
>      .get   =3D get_uint16,
>      .set   =3D set_uint16,
> @@ -317,14 +317,14 @@ static void set_int32(Object *obj, Visitor *v, cons=
t
> char *name, void *opaque,
>      visit_type_int32(v, name, ptr, errp);
>  }
>
> -const PropertyInfo qdev_prop_uint32 =3D {
> +const PropertyInfo prop_info_uint32 =3D {
>      .name  =3D "uint32",
>      .get   =3D get_uint32,
>      .set   =3D set_uint32,
>      .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
> -const PropertyInfo qdev_prop_int32 =3D {
> +const PropertyInfo prop_info_int32 =3D {
>      .name  =3D "int32",
>      .get   =3D object_propinfo_get_int32,
>      .set   =3D set_int32,
> @@ -369,14 +369,14 @@ static void set_int64(Object *obj, Visitor *v, cons=
t
> char *name,
>      visit_type_int64(v, name, ptr, errp);
>  }
>
> -const PropertyInfo qdev_prop_uint64 =3D {
> +const PropertyInfo prop_info_uint64 =3D {
>      .name  =3D "uint64",
>      .get   =3D get_uint64,
>      .set   =3D set_uint64,
>      .set_default_value =3D object_propinfo_set_default_value_uint,
>  };
>
> -const PropertyInfo qdev_prop_int64 =3D {
> +const PropertyInfo prop_info_int64 =3D {
>      .name  =3D "int64",
>      .get   =3D get_int64,
>      .set   =3D set_int64,
> @@ -419,7 +419,7 @@ static void set_string(Object *obj, Visitor *v, const
> char *name,
>      *ptr =3D str;
>  }
>
> -const PropertyInfo qdev_prop_string =3D {
> +const PropertyInfo prop_info_string =3D {
>      .name  =3D "str",
>      .release =3D release_string,
>      .get   =3D get_string,
> @@ -428,7 +428,7 @@ const PropertyInfo qdev_prop_string =3D {
>
>  /* --- on/off/auto --- */
>
> -const PropertyInfo qdev_prop_on_off_auto =3D {
> +const PropertyInfo prop_info_on_off_auto =3D {
>      .name =3D "OnOffAuto",
>      .description =3D "on/off/auto",
>      .enum_table =3D &OnOffAuto_lookup,
> @@ -471,7 +471,7 @@ static void set_size32(Object *obj, Visitor *v, const
> char *name, void *opaque,
>      *ptr =3D value;
>  }
>
> -const PropertyInfo qdev_prop_size32 =3D {
> +const PropertyInfo prop_info_size32 =3D {
>      .name  =3D "size",
>      .get =3D object_propinfo_get_size32,
>      .set =3D set_size32,
> @@ -519,7 +519,7 @@ static void set_default_uuid_auto(ObjectProperty *op,
> const Property *prop)
>      object_property_set_default_str(op, UUID_VALUE_AUTO);
>  }
>
> -const PropertyInfo qdev_prop_uuid =3D {
> +const PropertyInfo prop_info_uuid =3D {
>      .name  =3D "str",
>      .description =3D "UUID (aka GUID) or \"" UUID_VALUE_AUTO
>          "\" for random value (default)",
> @@ -640,7 +640,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v=
,
> const char *name,
>      }
>  }
>
> -const PropertyInfo qdev_prop_arraylen =3D {
> +const PropertyInfo prop_info_arraylen =3D {
>      .name =3D "uint32",
>      .get =3D get_uint32,
>      .set =3D set_prop_arraylen,
> @@ -839,7 +839,7 @@ static void set_size(Object *obj, Visitor *v, const
> char *name, void *opaque,
>      visit_type_size(v, name, ptr, errp);
>  }
>
> -const PropertyInfo qdev_prop_size =3D {
> +const PropertyInfo prop_info_size =3D {
>      .name  =3D "size",
>      .get =3D get_size,
>      .set =3D set_size,
> @@ -860,7 +860,7 @@ static ObjectProperty
> *create_link_property(ObjectClass *oc, Property *prop)
>                                            OBJ_PROP_LINK_STRONG);
>  }
>
> -const PropertyInfo qdev_prop_link =3D {
> +const PropertyInfo prop_info_link =3D {
>      .name =3D "link",
>      .create =3D create_link_property,
>  };
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 58ef65f589..6d06b4d4c5 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -496,7 +496,7 @@ static Property arm_gicv3_common_properties[] =3D {
>      DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
>      DEFINE_PROP_BOOL("has-security-extensions", GICv3State,
> security_extn, 0),
>      DEFINE_PROP_ARRAY("redist-region-count", GICv3State,
> nb_redist_regions,
> -                      redist_region_count, qdev_prop_uint32, uint32_t),
> +                      redist_region_count, prop_info_uint32, uint32_t),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
> index 94e17a9dea..823160d9a8 100644
> --- a/hw/intc/rx_icu.c
> +++ b/hw/intc/rx_icu.c
> @@ -365,9 +365,9 @@ static const VMStateDescription vmstate_rxicu =3D {
>
>  static Property rxicu_properties[] =3D {
>      DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
> -                      qdev_prop_uint8, uint8_t),
> +                      prop_info_uint8, uint8_t),
>      DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
> -                      qdev_prop_uint8, uint8_t),
> +                      prop_info_uint8, uint8_t),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
> index 42d4693854..634f3d916f 100644
> --- a/hw/misc/arm_sysctl.c
> +++ b/hw/misc/arm_sysctl.c
> @@ -628,10 +628,10 @@ static Property arm_sysctl_properties[] =3D {
>      DEFINE_PROP_UINT32("proc_id", arm_sysctl_state, proc_id, 0),
>      /* Daughterboard power supply voltages (as reported via SYS_CFG) */
>      DEFINE_PROP_ARRAY("db-voltage", arm_sysctl_state, db_num_vsensors,
> -                      db_voltage, qdev_prop_uint32, uint32_t),
> +                      db_voltage, prop_info_uint32, uint32_t),
>      /* Daughterboard clock reset values (as reported via SYS_CFG) */
>      DEFINE_PROP_ARRAY("db-clock", arm_sysctl_state, db_num_clocks,
> -                      db_clock_reset, qdev_prop_uint32, uint32_t),
> +                      db_clock_reset, prop_info_uint32, uint32_t),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index b6f1ae3c8f..7928939ae2 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -686,15 +686,15 @@ static void e1000e_class_init(ObjectClass *class,
> void *data)
>      dc->reset =3D e1000e_qdev_reset;
>      dc->vmsd =3D &e1000e_vmstate;
>
> -    e1000e_prop_disable_vnet =3D qdev_prop_uint8;
> +    e1000e_prop_disable_vnet =3D prop_info_uint8;
>      e1000e_prop_disable_vnet.description =3D "Do not use virtio headers,=
 "
>                                             "perform SW offloads emulatio=
n
> "
>                                             "instead";
>
> -    e1000e_prop_subsys_ven =3D qdev_prop_uint16;
> +    e1000e_prop_subsys_ven =3D prop_info_uint16;
>      e1000e_prop_subsys_ven.description =3D "PCI device Subsystem Vendor =
ID";
>
> -    e1000e_prop_subsys =3D qdev_prop_uint16;
> +    e1000e_prop_subsys =3D prop_info_uint16;
>      e1000e_prop_subsys.description =3D "PCI device Subsystem ID";
>
>      device_class_set_props(dc, e1000e_properties);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 07492e9f9a..cef92879b0 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1108,7 +1108,7 @@ static Property arm_cpu_has_mpu_property =3D
>  static Property arm_cpu_pmsav7_dregion_property =3D
>              DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
>                                             pmsav7_dregion,
> -                                           qdev_prop_uint32, uint32_t);
> +                                           prop_info_uint32, uint32_t);
>
>  static bool arm_get_pmu(Object *obj, Error **errp)
>  {
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index cf21efd85f..a03ec9b0e8 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -839,7 +839,7 @@ static Property sparc_cpu_properties[] =3D {
>      DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features, 12, false),
>      DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features, 13, false),
>      DEFINE_PROP_UNSIGNED("iu-version", SPARCCPU, env.def.iu_version, 0,
> -                         qdev_prop_uint64, target_ulong),
> +                         prop_info_uint64, target_ulong),
>      DEFINE_PROP_UINT32("fpu-version", SPARCCPU, env.def.fpu_version, 0),
>      DEFINE_PROP_UINT32("mmu-version", SPARCCPU, env.def.mmu_version, 0),
>      { .name  =3D "nwindows", .info  =3D &qdev_prop_nwindows },
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e91efa05b2e65d0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:19 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Th=
e basic property types in qdev-properties.c are not going to be<br>
qdev-specific anymore.=C2=A0 Rename the variables to prop_info_*.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
;</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Cc: &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"mailto:berrange@redh=
at.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Cc: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_b=
lank">ehabkost@redhat.com</a>&gt;<br>
Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D=
"_blank">peter.maydell@linaro.org</a>&gt;<br>
Cc: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourceforge.jp" target=
=3D"_blank">ysato@users.sourceforge.jp</a>&gt;<br>
Cc: Dmitry Fleytman &lt;<a href=3D"mailto:dmitry.fleytman@gmail.com" target=
=3D"_blank">dmitry.fleytman@gmail.com</a>&gt;<br>
Cc: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank"=
>jasowang@redhat.com</a>&gt;<br>
Cc: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" t=
arget=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt;<br>
Cc: Artyom Tarasenko &lt;<a href=3D"mailto:atar4qemu@gmail.com" target=3D"_=
blank">atar4qemu@gmail.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
Cc: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank">qemu-arm@nongn=
u.org</a><br>
---<br>
=C2=A0include/hw/qdev-properties.h | 68 ++++++++++++++++++-----------------=
-<br>
=C2=A0hw/core/qdev-properties.c=C2=A0 =C2=A0 | 38 ++++++++++----------<br>
=C2=A0hw/intc/arm_gicv3_common.c=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/intc/rx_icu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 +--<br>
=C2=A0hw/misc/arm_sysctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +--<b=
r>
=C2=A0hw/net/e1000e.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 6 ++--<br>
=C2=A0target/arm/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-<br>
=C2=A0target/sparc/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 =
+-<br>
=C2=A08 files changed, 63 insertions(+), 63 deletions(-)<br>
<br>
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h<br=
>
index 2b00a1bcf6..7a08946448 100644<br>
--- a/include/hw/qdev-properties.h<br>
+++ b/include/hw/qdev-properties.h<br>
@@ -6,23 +6,23 @@<br>
<br>
=C2=A0/*** qdev-properties.c ***/<br>
<br>
-extern const PropertyInfo qdev_prop_bit;<br>
-extern const PropertyInfo qdev_prop_bit64;<br>
-extern const PropertyInfo qdev_prop_bool;<br>
-extern const PropertyInfo qdev_prop_enum;<br>
-extern const PropertyInfo qdev_prop_uint8;<br>
-extern const PropertyInfo qdev_prop_uint16;<br>
-extern const PropertyInfo qdev_prop_uint32;<br>
-extern const PropertyInfo qdev_prop_int32;<br>
-extern const PropertyInfo qdev_prop_uint64;<br>
-extern const PropertyInfo qdev_prop_int64;<br>
-extern const PropertyInfo qdev_prop_size;<br>
-extern const PropertyInfo qdev_prop_string;<br>
-extern const PropertyInfo qdev_prop_on_off_auto;<br>
-extern const PropertyInfo qdev_prop_size32;<br>
-extern const PropertyInfo qdev_prop_uuid;<br>
-extern const PropertyInfo qdev_prop_arraylen;<br>
-extern const PropertyInfo qdev_prop_link;<br>
+extern const PropertyInfo prop_info_bit;<br>
+extern const PropertyInfo prop_info_bit64;<br>
+extern const PropertyInfo prop_info_bool;<br>
+extern const PropertyInfo prop_info_enum;<br>
+extern const PropertyInfo prop_info_uint8;<br>
+extern const PropertyInfo prop_info_uint16;<br>
+extern const PropertyInfo prop_info_uint32;<br>
+extern const PropertyInfo prop_info_int32;<br>
+extern const PropertyInfo prop_info_uint64;<br>
+extern const PropertyInfo prop_info_int64;<br>
+extern const PropertyInfo prop_info_size;<br>
+extern const PropertyInfo prop_info_string;<br>
+extern const PropertyInfo prop_info_on_off_auto;<br>
+extern const PropertyInfo prop_info_size32;<br>
+extern const PropertyInfo prop_info_uuid;<br>
+extern const PropertyInfo prop_info_arraylen;<br>
+extern const PropertyInfo prop_info_link;<br>
<br>
=C2=A0#define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {=C2=A0=
 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =3D (_name),=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -41,7 +41,7 @@ extern const PropertyInfo qdev_prop_link;<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP(_name, _state, _field, _prop, _type)<br>
<br>
=C2=A0#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval)=C2=A0 =
=C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, qdev_prop_bit, uint32_t, =
\<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, prop_info_bit, uint32_t, =
\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.bitnr=C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D (_bit),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_default =
=3D true,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.defval.u=C2=
=A0 =C2=A0 =3D (bool)_defval)<br>
@@ -55,13 +55,13 @@ extern const PropertyInfo qdev_prop_link;<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP(_name, _state, _field, _prop, _type)<br>
<br>
=C2=A0#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval)=C2=A0=
 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, qdev_prop_bit64, uint64_t=
, \<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, prop_info_bit64, uint64_t=
, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.bitnr=C2=A0 =
=C2=A0 =3D (_bit),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_default =
=3D true,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.defval.u=C2=
=A0 =3D (bool)_defval)<br>
<br>
=C2=A0#define DEFINE_PROP_BOOL(_name, _state, _field, _defval)=C2=A0 =C2=A0=
 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \<b=
r>
+=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, prop_info_bool, bool, \<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_default =
=3D true,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.defval.u=C2=
=A0 =C2=A0 =3D (bool)_defval)<br>
<br>
@@ -94,7 +94,7 @@ extern const PropertyInfo qdev_prop_link;<br>
=C2=A0#define DEFINE_PROP_ARRAY(_name, _state, _field,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0_arrayfield, _arrayprop, _arraytype) \<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _state, _field, qd=
ev_prop_arraylen, uint32_t,=C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _state, _field, pr=
op_info_arraylen, uint32_t,=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_default =
=3D true,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.defval.u =3D=
 0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.arrayinfo =
=3D &amp;(_arrayprop),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
@@ -102,34 +102,34 @@ extern const PropertyInfo qdev_prop_link;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.arrayoffset =
=3D offsetof(_state, _arrayfield))<br>
<br>
=C2=A0#define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)=C2=
=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, qdev_prop_link, _ptr_type=
,=C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, prop_info_link, _ptr_type=
,=C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.link_type=C2=
=A0 =3D _type)<br>
<br>
=C2=A0#define DEFINE_PROP_UINT8(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_=
t)<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint8, uint8_=
t)<br>
=C2=A0#define DEFINE_PROP_UINT16(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint1=
6_t)<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint16, uint1=
6_t)<br>
=C2=A0#define DEFINE_PROP_UINT32(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint3=
2_t)<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint32, uint3=
2_t)<br>
=C2=A0#define DEFINE_PROP_INT32(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)=
<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int32, int32_t)=
<br>
=C2=A0#define DEFINE_PROP_UINT64(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint6=
4_t)<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint64, uint6=
4_t)<br>
=C2=A0#define DEFINE_PROP_INT64(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)=
<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int64, int64_t)=
<br>
=C2=A0#define DEFINE_PROP_SIZE(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_=
t)<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size, uint64_=
t)<br>
=C2=A0#define DEFINE_PROP_STRING(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, prop_info_string, char*)<br>
=C2=A0#define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, On=
OffAuto)<br>
+=C2=A0 =C2=A0 DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_on_off_auto, On=
OffAuto)<br>
=C2=A0#define DEFINE_PROP_SIZE32(_n, _s, _f, _d)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint3=
2_t)<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size32, uint3=
2_t)<br>
=C2=A0#define DEFINE_PROP_UUID(_name, _state, _field)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID,=
=C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID,=
=C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_default =
=3D true)<br>
=C2=A0#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \<br>
-=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID)=
<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID)=
<br>
<br>
=C2=A0#define DEFINE_PROP_END_OF_LIST()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0{}<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 1b27ba7236..59d65a7362 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -76,7 +76,7 @@ void object_propinfo_set_default_value_enum(ObjectPropert=
y *op,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_enum_lookup(prop-&gt;info-&gt;enum_t=
able, prop-&gt;defval.i));<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_enum =3D {<br>
+const PropertyInfo prop_info_enum =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;enum&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D object_propinfo_get_enum,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D object_propinfo_set_enum,<br>
@@ -87,7 +87,7 @@ const PropertyInfo qdev_prop_enum =3D {<br>
<br>
=C2=A0static uint32_t qdev_get_prop_mask(Property *prop)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 assert(prop-&gt;info =3D=3D &amp;qdev_prop_bit);<br>
+=C2=A0 =C2=A0 assert(prop-&gt;info =3D=3D &amp;prop_info_bit);<br>
=C2=A0 =C2=A0 =C2=A0return 0x1 &lt;&lt; prop-&gt;bitnr;<br>
=C2=A0}<br>
<br>
@@ -129,7 +129,7 @@ static void set_default_value_bool(ObjectProperty *op, =
const Property *prop)<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_default_bool(op, prop-&gt;defval.u)=
;<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_bit =3D {<br>
+const PropertyInfo prop_info_bit =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;bool&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;on/off&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D prop_get_bit,<br>
@@ -141,7 +141,7 @@ const PropertyInfo qdev_prop_bit =3D {<br>
<br>
=C2=A0static uint64_t qdev_get_prop_mask64(Property *prop)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 assert(prop-&gt;info =3D=3D &amp;qdev_prop_bit64);<br>
+=C2=A0 =C2=A0 assert(prop-&gt;info =3D=3D &amp;prop_info_bit64);<br>
=C2=A0 =C2=A0 =C2=A0return 0x1ull &lt;&lt; prop-&gt;bitnr;<br>
=C2=A0}<br>
<br>
@@ -178,7 +178,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, con=
st char *name,<br>
=C2=A0 =C2=A0 =C2=A0bit64_prop_set(obj, prop, value);<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_bit64 =3D {<br>
+const PropertyInfo prop_info_bit64 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;bool&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;on/off&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D prop_get_bit64,<br>
@@ -206,7 +206,7 @@ static void set_bool(Object *obj, Visitor *v, const cha=
r *name, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0visit_type_bool(v, name, ptr, errp);<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_bool =3D {<br>
+const PropertyInfo prop_info_bool =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;bool&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_bool,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_bool,<br>
@@ -245,7 +245,7 @@ void object_propinfo_set_default_value_uint(ObjectPrope=
rty *op,<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_default_uint(op, prop-&gt;defval.u)=
;<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_uint8 =3D {<br>
+const PropertyInfo prop_info_uint8 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;uint8&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_uint8,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_uint8,<br>
@@ -272,7 +272,7 @@ static void set_uint16(Object *obj, Visitor *v, const c=
har *name,<br>
=C2=A0 =C2=A0 =C2=A0visit_type_uint16(v, name, ptr, errp);<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_uint16 =3D {<br>
+const PropertyInfo prop_info_uint16 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;uint16&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_uint16,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_uint16,<br>
@@ -317,14 +317,14 @@ static void set_int32(Object *obj, Visitor *v, const =
char *name, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0visit_type_int32(v, name, ptr, errp);<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_uint32 =3D {<br>
+const PropertyInfo prop_info_uint32 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;uint32&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_uint32,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_uint32,<br>
=C2=A0 =C2=A0 =C2=A0.set_default_value =3D object_propinfo_set_default_valu=
e_uint,<br>
=C2=A0};<br>
<br>
-const PropertyInfo qdev_prop_int32 =3D {<br>
+const PropertyInfo prop_info_int32 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;int32&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D object_propinfo_get_int32,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_int32,<br>
@@ -369,14 +369,14 @@ static void set_int64(Object *obj, Visitor *v, const =
char *name,<br>
=C2=A0 =C2=A0 =C2=A0visit_type_int64(v, name, ptr, errp);<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_uint64 =3D {<br>
+const PropertyInfo prop_info_uint64 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;uint64&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_uint64,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_uint64,<br>
=C2=A0 =C2=A0 =C2=A0.set_default_value =3D object_propinfo_set_default_valu=
e_uint,<br>
=C2=A0};<br>
<br>
-const PropertyInfo qdev_prop_int64 =3D {<br>
+const PropertyInfo prop_info_int64 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;int64&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_int64,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_int64,<br>
@@ -419,7 +419,7 @@ static void set_string(Object *obj, Visitor *v, const c=
har *name,<br>
=C2=A0 =C2=A0 =C2=A0*ptr =3D str;<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_string =3D {<br>
+const PropertyInfo prop_info_string =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;str&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.release =3D release_string,<br>
=C2=A0 =C2=A0 =C2=A0.get=C2=A0 =C2=A0=3D get_string,<br>
@@ -428,7 +428,7 @@ const PropertyInfo qdev_prop_string =3D {<br>
<br>
=C2=A0/* --- on/off/auto --- */<br>
<br>
-const PropertyInfo qdev_prop_on_off_auto =3D {<br>
+const PropertyInfo prop_info_on_off_auto =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D &quot;OnOffAuto&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;on/off/auto&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.enum_table =3D &amp;OnOffAuto_lookup,<br>
@@ -471,7 +471,7 @@ static void set_size32(Object *obj, Visitor *v, const c=
har *name, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0*ptr =3D value;<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_size32 =3D {<br>
+const PropertyInfo prop_info_size32 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;size&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get =3D object_propinfo_get_size32,<br>
=C2=A0 =C2=A0 =C2=A0.set =3D set_size32,<br>
@@ -519,7 +519,7 @@ static void set_default_uuid_auto(ObjectProperty *op, c=
onst Property *prop)<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_default_str(op, UUID_VALUE_AUTO);<b=
r>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_uuid =3D {<br>
+const PropertyInfo prop_info_uuid =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;str&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.description =3D &quot;UUID (aka GUID) or \&quot;&quot;=
 UUID_VALUE_AUTO<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\&quot; for random value (default)&=
quot;,<br>
@@ -640,7 +640,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, =
const char *name,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_arraylen =3D {<br>
+const PropertyInfo prop_info_arraylen =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D &quot;uint32&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get =3D get_uint32,<br>
=C2=A0 =C2=A0 =C2=A0.set =3D set_prop_arraylen,<br>
@@ -839,7 +839,7 @@ static void set_size(Object *obj, Visitor *v, const cha=
r *name, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0visit_type_size(v, name, ptr, errp);<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_size =3D {<br>
+const PropertyInfo prop_info_size =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;size&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.get =3D get_size,<br>
=C2=A0 =C2=A0 =C2=A0.set =3D set_size,<br>
@@ -860,7 +860,7 @@ static ObjectProperty *create_link_property(ObjectClass=
 *oc, Property *prop)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0OBJ_PROP_LINK_STRONG);<br>
=C2=A0}<br>
<br>
-const PropertyInfo qdev_prop_link =3D {<br>
+const PropertyInfo prop_info_link =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D &quot;link&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.create =3D create_link_property,<br>
=C2=A0};<br>
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c<br>
index 58ef65f589..6d06b4d4c5 100644<br>
--- a/hw/intc/arm_gicv3_common.c<br>
+++ b/hw/intc/arm_gicv3_common.c<br>
@@ -496,7 +496,7 @@ static Property arm_gicv3_common_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;revision&quot;, GICv3State, re=
vision, 3),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;has-security-extensions&quot;, G=
ICv3State, security_extn, 0),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_ARRAY(&quot;redist-region-count&quot;, GICv=
3State, nb_redist_regions,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 redist_region_count, qdev_prop_uint32, uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 redist_region_count, prop_info_uint32, uint32_t),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
=C2=A0};<br>
<br>
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c<br>
index 94e17a9dea..823160d9a8 100644<br>
--- a/hw/intc/rx_icu.c<br>
+++ b/hw/intc/rx_icu.c<br>
@@ -365,9 +365,9 @@ static const VMStateDescription vmstate_rxicu =3D {<br>
<br>
=C2=A0static Property rxicu_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_ARRAY(&quot;ipr-map&quot;, RXICUState, nr_i=
rqs, map,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 qdev_prop_uint8, uint8_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 prop_info_uint8, uint8_t),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_ARRAY(&quot;trigger-level&quot;, RXICUState=
, nr_sense, init_sense,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 qdev_prop_uint8, uint8_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 prop_info_uint8, uint8_t),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
=C2=A0};<br>
<br>
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c<br>
index 42d4693854..634f3d916f 100644<br>
--- a/hw/misc/arm_sysctl.c<br>
+++ b/hw/misc/arm_sysctl.c<br>
@@ -628,10 +628,10 @@ static Property arm_sysctl_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;proc_id&quot;, arm_sysctl_stat=
e, proc_id, 0),<br>
=C2=A0 =C2=A0 =C2=A0/* Daughterboard power supply voltages (as reported via=
 SYS_CFG) */<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_ARRAY(&quot;db-voltage&quot;, arm_sysctl_st=
ate, db_num_vsensors,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 db_voltage, qdev_prop_uint32, uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 db_voltage, prop_info_uint32, uint32_t),<br>
=C2=A0 =C2=A0 =C2=A0/* Daughterboard clock reset values (as reported via SY=
S_CFG) */<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_ARRAY(&quot;db-clock&quot;, arm_sysctl_stat=
e, db_num_clocks,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 db_clock_reset, qdev_prop_uint32, uint32_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 db_clock_reset, prop_info_uint32, uint32_t),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
=C2=A0};<br>
<br>
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c<br>
index b6f1ae3c8f..7928939ae2 100644<br>
--- a/hw/net/e1000e.c<br>
+++ b/hw/net/e1000e.c<br>
@@ -686,15 +686,15 @@ static void e1000e_class_init(ObjectClass *class, voi=
d *data)<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;reset =3D e1000e_qdev_reset;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;vmsd =3D &amp;e1000e_vmstate;<br>
<br>
-=C2=A0 =C2=A0 e1000e_prop_disable_vnet =3D qdev_prop_uint8;<br>
+=C2=A0 =C2=A0 e1000e_prop_disable_vnet =3D prop_info_uint8;<br>
=C2=A0 =C2=A0 =C2=A0e1000e_prop_disable_vnet.description =3D &quot;Do not u=
se virtio headers, &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;perform SW offloads emulation &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;instead&quot;;<br>
<br>
-=C2=A0 =C2=A0 e1000e_prop_subsys_ven =3D qdev_prop_uint16;<br>
+=C2=A0 =C2=A0 e1000e_prop_subsys_ven =3D prop_info_uint16;<br>
=C2=A0 =C2=A0 =C2=A0e1000e_prop_subsys_ven.description =3D &quot;PCI device=
 Subsystem Vendor ID&quot;;<br>
<br>
-=C2=A0 =C2=A0 e1000e_prop_subsys =3D qdev_prop_uint16;<br>
+=C2=A0 =C2=A0 e1000e_prop_subsys =3D prop_info_uint16;<br>
=C2=A0 =C2=A0 =C2=A0e1000e_prop_subsys.description =3D &quot;PCI device Sub=
system ID&quot;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0device_class_set_props(dc, e1000e_properties);<br>
diff --git a/target/arm/cpu.c b/target/arm/cpu.c<br>
index 07492e9f9a..cef92879b0 100644<br>
--- a/target/arm/cpu.c<br>
+++ b/target/arm/cpu.c<br>
@@ -1108,7 +1108,7 @@ static Property arm_cpu_has_mpu_property =3D<br>
=C2=A0static Property arm_cpu_pmsav7_dregion_property =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UNSIGNED_NODEFA=
ULT(&quot;pmsav7-dregion&quot;, ARMCPU,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pmsav7_dregion,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0qdev_prop_uint32, uint32_t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0prop_info_uint32, uint32_t);<br>
<br>
=C2=A0static bool arm_get_pmu(Object *obj, Error **errp)<br>
=C2=A0{<br>
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c<br>
index cf21efd85f..a03ec9b0e8 100644<br>
--- a/target/sparc/cpu.c<br>
+++ b/target/sparc/cpu.c<br>
@@ -839,7 +839,7 @@ static Property sparc_cpu_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BIT(&quot;cmt&quot;,=C2=A0 =C2=A0 =C2=A0 SP=
ARCCPU, env.def.features, 12, false),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BIT(&quot;gl&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0SPARCCPU, env.def.features, 13, false),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UNSIGNED(&quot;iu-version&quot;, SPARCCPU, =
env.def.iu_version, 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0qdev_prop_uint64, target_ulong),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0prop_info_uint64, target_ulong),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;fpu-version&quot;, SPARCCPU, e=
nv.def.fpu_version, 0),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;mmu-version&quot;, SPARCCPU, e=
nv.def.mmu_version, 0),<br>
=C2=A0 =C2=A0 =C2=A0{ .name=C2=A0 =3D &quot;nwindows&quot;, .info=C2=A0 =3D=
 &amp;qdev_prop_nwindows },<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000e91efa05b2e65d0c--


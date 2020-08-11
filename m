Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878EA20756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qAQxoELs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878EA20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5c0B-0007rr-P7
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 17:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k5bzW-0007Qu-Ba
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:39:30 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k5bzQ-0005fE-DA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:39:28 -0400
Received: by mail-ej1-x644.google.com with SMTP id c16so14683026ejx.12
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 14:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yjG6SYgpkcsPtENi2gnupSbhCi2zdWZJ6AoMohRdvhE=;
 b=qAQxoELsiR27AjBC7XevKArp9QACy2+90B5xELGM8hI8P0SoLsN3+biPdqPL7GWAFg
 2wFXX1roa/To+Y8u4GL0NrAQAmx0zQknXJvZcZjdBres/rFmM34zMaYV27k+vBaR3kIS
 AGEfMqLVWDVQBBlsUheUJNi0MN1cCs4Wr1iVdpEfsHlUdPKrwpJZNUBE6vNPscXSbHxN
 oGRTl6+gQRuH4fXriK0ED9Oem5Mf54SVGSZGgnr0phCvG4FW1mBFrQvebROoGt7yJwEF
 fg6XcQvBgt8gOxkxZ+NTcutHLKki+8MVnzJO9gGsA4AxWu7014JD47WuIivJsLORg9uX
 dWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yjG6SYgpkcsPtENi2gnupSbhCi2zdWZJ6AoMohRdvhE=;
 b=HOTVGHYmPIsm8BQo9JWcMpdResk4IuV9S0IvYV2dvfvHbKGB06p1WVnMYR4Qc7atpO
 i6ESMmp3Oi1wPDFEPIOR4DdsEpBtptiUUe03VmLLJhX7kyDuKi4yxa6MfrLFQQ0Qg19H
 K1JrpOHVOwkRLGaOWrmnc9Ps12I/MCG37L0LvEm6vDxDwvs+Wvgam2YQ45z82XeNQ4Xo
 9CPTC2HXcr0jdhBEXOWVBZ147FzFlqkj6seLu0Q1Fc0hHBUHnaCs9LXYh6jVqPrxTfWc
 G/soprdoAYm9fw9AiQl1d/XEx/8NH795cP/nL2NcjdYVdqu6xn4sDplH7pq1kW816LHB
 dcEw==
X-Gm-Message-State: AOAM5304nmUiyqX1pjp3/1UZbCHVhpFFshoBPSpwaA5hyTkLWH2nVuec
 9gdqz8sAoDR4xDgnbZhUzSU/7FFBcUVZVsE9jWzRVTbXx5U=
X-Google-Smtp-Source: ABdhPJz6Yi2xv65tR/pSwvtzQJZLum/aj7wtxPpu0gWQvDZEW1MCXiSls9qKA8yBA+ok/Vuq5+KuIE1HpSFG6CwVhVQ=
X-Received: by 2002:a17:906:2356:: with SMTP id
 m22mr27880189eja.124.1597181961660; 
 Tue, 11 Aug 2020 14:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
 <e0754f52180aee6418eae8b3b8aa5981fcac12fd.1597129029.git.scw@google.com>
In-Reply-To: <e0754f52180aee6418eae8b3b8aa5981fcac12fd.1597129029.git.scw@google.com>
From: Shu-Chun Weng <scw@google.com>
Date: Tue, 11 Aug 2020 14:39:10 -0700
Message-ID: <CAF3nBxgAxd2=8vNQM8AGzfojjoaB-r5TKn7Emw8yZVL1aiB=Lg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] thunk: supports flexible arrays
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000007f02cc05aca0e734"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=scw@google.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007f02cc05aca0e734
Content-Type: multipart/alternative; boundary="00000000000077db2605aca0e77d"

--00000000000077db2605aca0e77d
Content-Type: text/plain; charset="UTF-8"

Forgot to +riku.voipio@iki.fi when generating v2.

On Tue, Aug 11, 2020 at 12:10 AM Shu-Chun Weng <scw@google.com> wrote:

> Flexible arrays may appear in the last field of a struct and are heavily
> used in the ioctl(SIOCETHTOOL) system call on Linux. E.g.
>
>   struct ethtool_regs {
>       __u32   cmd;
>       __u32   version; /* driver-specific, indicates different chips/revs
> */
>       __u32   len; /* bytes */
>       __u8    data[0];
>   };
>
> where number of elements in `data` is specified in `len`. It is translated
> into:
>
>   STRUCT(ethtool_regs,
>          TYPE_INT, /* cmd */
>          TYPE_INT, /* version */
>          TYPE_INT, /* len */
>          MK_FLEXIBLE_ARRAY(TYPE_CHAR, 2)) /* data[0]: len */
>
> where the "2" passed to `MK_FLEXIBLE_ARRAY` means the number of element
> is specified by field number 2 (0-index).
>
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
> v1 -> v2:
>   Fix style problems.
>
>  include/exec/user/thunk.h |  24 ++++++
>  thunk.c                   | 152 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 174 insertions(+), 2 deletions(-)
>
> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
> index 7992475c9f..d0d7c83f1f 100644
> --- a/include/exec/user/thunk.h
> +++ b/include/exec/user/thunk.h
> @@ -39,12 +39,21 @@ typedef enum argtype {
>      TYPE_ARRAY,
>      TYPE_STRUCT,
>      TYPE_OLDDEVT,
> +    TYPE_FLEXIBLE_ARRAY,
>  } argtype;
>
>  #define MK_PTR(type) TYPE_PTR, type
>  #define MK_ARRAY(type, size) TYPE_ARRAY, size, type
>  #define MK_STRUCT(id) TYPE_STRUCT, id
>
> +/*
> + * Should only appear as the last element of a TYPE_STRUCT.
> `len_field_idx` is
> + * the index into the fields in the enclosing struct that specify the
> length of
> + * the flexibly array. The length field MUST be a TYPE_INT field.
> + */
> +#define MK_FLEXIBLE_ARRAY(type, len_field_idx) \
> +    TYPE_FLEXIBLE_ARRAY, (len_field_idx), type
> +
>  #define THUNK_TARGET 0
>  #define THUNK_HOST   1
>
> @@ -55,6 +64,8 @@ typedef struct {
>      int *field_offsets[2];
>      /* special handling */
>      void (*convert[2])(void *dst, const void *src);
> +    int (*thunk_size[2])(const void *src);
> +
>      int size[2];
>      int align[2];
>      const char *name;
> @@ -75,6 +86,11 @@ const argtype *thunk_convert(void *dst, const void *src,
>                               const argtype *type_ptr, int to_host);
>  const argtype *thunk_print(void *arg, const argtype *type_ptr);
>
> +bool thunk_type_has_flexible_array(const argtype *type_ptr);
> +/* thunk_type_size but can handle TYPE_FLEXIBLE_ARRAY */
> +int thunk_type_size_with_src(const void *src, const argtype *type_ptr,
> +                             int is_host);
> +
>  extern StructEntry *struct_entries;
>
>  int thunk_type_size_array(const argtype *type_ptr, int is_host);
> @@ -137,6 +153,12 @@ static inline int thunk_type_size(const argtype
> *type_ptr, int is_host)
>      case TYPE_STRUCT:
>          se = struct_entries + type_ptr[1];
>          return se->size[is_host];
> +    case TYPE_FLEXIBLE_ARRAY:
> +        /*
> +         * Flexible arrays do not count toward sizeof(). Users of
> structures
> +         * containing them need to calculate it themselves.
> +         */
> +        return 0;
>      default:
>          g_assert_not_reached();
>      }
> @@ -187,6 +209,8 @@ static inline int thunk_type_align(const argtype
> *type_ptr, int is_host)
>      case TYPE_STRUCT:
>          se = struct_entries + type_ptr[1];
>          return se->align[is_host];
> +    case TYPE_FLEXIBLE_ARRAY:
> +        return thunk_type_align_array(type_ptr + 2, is_host);
>      default:
>          g_assert_not_reached();
>      }
> diff --git a/thunk.c b/thunk.c
> index c5d9719747..d9c6cba3bd 100644
> --- a/thunk.c
> +++ b/thunk.c
> @@ -50,6 +50,8 @@ static inline const argtype *thunk_type_next(const
> argtype *type_ptr)
>          return thunk_type_next_ptr(type_ptr + 1);
>      case TYPE_STRUCT:
>          return type_ptr + 1;
> +    case TYPE_FLEXIBLE_ARRAY:
> +        return thunk_type_next_ptr(type_ptr + 1);
>      default:
>          return NULL;
>      }
> @@ -122,6 +124,34 @@ void thunk_register_struct_direct(int id, const char
> *name,
>      se->name = name;
>  }
>
> +static const argtype *
> +thunk_convert_flexible_array(void *dst, const void *src,
> +                             const uint8_t *dst_struct,
> +                             const uint8_t *src_struct, const argtype
> *type_ptr,
> +                             const StructEntry *se, int to_host) {
> +    int len_field_idx, dst_size, src_size, i;
> +    uint32_t array_length;
> +    uint8_t *d;
> +    const uint8_t *s;
> +
> +    assert(*type_ptr == TYPE_FLEXIBLE_ARRAY);
> +    type_ptr++;
> +    len_field_idx = *type_ptr++;
> +    array_length =
> +        *(const uint32_t *)(to_host ?
> +                            dst_struct +
> se->field_offsets[1][len_field_idx] :
> +                            src_struct +
> se->field_offsets[0][len_field_idx]);
> +    dst_size = thunk_type_size(type_ptr, to_host);
> +    src_size = thunk_type_size(type_ptr, to_host);
> +    d = dst;
> +    s = src;
> +    for (i = 0; i < array_length; i++) {
> +        thunk_convert(d, s, type_ptr, to_host);
> +        d += dst_size;
> +        s += src_size;
> +    }
> +    return thunk_type_next(type_ptr);
> +}
>
>  /* now we can define the main conversion functions */
>  const argtype *thunk_convert(void *dst, const void *src,
> @@ -246,7 +276,7 @@ const argtype *thunk_convert(void *dst, const void
> *src,
>
>              assert(*type_ptr < max_struct_entries);
>              se = struct_entries + *type_ptr++;
> -            if (se->convert[0] != NULL) {
> +            if (se->convert[to_host] != NULL) {
>                  /* specific conversion is needed */
>                  (*se->convert[to_host])(dst, src);
>              } else {
> @@ -256,7 +286,18 @@ const argtype *thunk_convert(void *dst, const void
> *src,
>                  src_offsets = se->field_offsets[1 - to_host];
>                  d = dst;
>                  s = src;
> -                for(i = 0;i < se->nb_fields; i++) {
> +                for (i = 0; i < se->nb_fields; i++) {
> +                    if (*field_types == TYPE_FLEXIBLE_ARRAY) {
> +                        field_types = thunk_convert_flexible_array(
> +                            d + dst_offsets[i],
> +                            s + src_offsets[i],
> +                            d,
> +                            s,
> +                            field_types,
> +                            se,
> +                            to_host);
> +                        continue;
> +                    }
>                      field_types = thunk_convert(d + dst_offsets[i],
>                                                  s + src_offsets[i],
>                                                  field_types, to_host);
> @@ -264,6 +305,11 @@ const argtype *thunk_convert(void *dst, const void
> *src,
>              }
>          }
>          break;
> +    case TYPE_FLEXIBLE_ARRAY:
> +        fprintf(stderr,
> +                "Invalid flexible array (type 0x%x) outside of a
> structure\n",
> +                type);
> +        break;
>      default:
>          fprintf(stderr, "Invalid type 0x%x\n", type);
>          break;
> @@ -271,6 +317,45 @@ const argtype *thunk_convert(void *dst, const void
> *src,
>      return type_ptr;
>  }
>
> +static const argtype *
> +thunk_print_flexible_array(void *arg, const uint8_t *arg_struct,
> +                           const argtype *type_ptr, const StructEntry
> *se) {
> +    int array_length, len_field_idx, arg_size, i;
> +    uint8_t *a;
> +    int is_string = 0;
> +
> +    assert(*type_ptr == TYPE_FLEXIBLE_ARRAY);
> +    type_ptr++;
> +    len_field_idx = *type_ptr++;
> +
> +    array_length = tswap32(
> +        *(const uint32_t *)(arg_struct +
> se->field_offsets[0][len_field_idx]));
> +    arg_size = thunk_type_size(type_ptr, 0);
> +    a = arg;
> +
> +    if (*type_ptr == TYPE_CHAR) {
> +        qemu_log("\"");
> +        is_string = 1;
> +    } else {
> +        qemu_log("[");
> +    }
> +
> +    for (i = 0; i < array_length; i++) {
> +        if (i > 0 && !is_string) {
> +            qemu_log(",");
> +        }
> +        thunk_print(a, type_ptr);
> +        a += arg_size;
> +    }
> +
> +    if (is_string) {
> +        qemu_log("\"");
> +    } else {
> +        qemu_log("]");
> +    }
> +    return thunk_type_next(type_ptr);
> +}
> +
>  const argtype *thunk_print(void *arg, const argtype *type_ptr)
>  {
>      int type;
> @@ -414,17 +499,80 @@ const argtype *thunk_print(void *arg, const argtype
> *type_ptr)
>                  if (i > 0) {
>                      qemu_log(",");
>                  }
> +                if (*field_types == TYPE_FLEXIBLE_ARRAY) {
> +                    field_types = thunk_print_flexible_array(
> +                        a + arg_offsets[i], a, field_types, se);
> +                    continue;
> +                }
>                  field_types = thunk_print(a + arg_offsets[i],
> field_types);
>              }
>              qemu_log("}");
>          }
>          break;
> +    case TYPE_FLEXIBLE_ARRAY:
> +        fprintf(stderr,
> +                "Invalid flexible array (type 0x%x) outside of a
> structure\n",
> +                type);
> +        break;
>      default:
>          g_assert_not_reached();
>      }
>      return type_ptr;
>  }
>
> +bool thunk_type_has_flexible_array(const argtype *type_ptr)
> +{
> +  int i;
> +  const StructEntry *se;
> +  const argtype *field_types;
> +    if (*type_ptr != TYPE_STRUCT) {
> +        return false;
> +    }
> +    se = struct_entries + type_ptr[1];
> +    field_types = se->field_types;
> +    for (i = 0; i < se->nb_fields; i++) {
> +        if (*field_types == TYPE_FLEXIBLE_ARRAY) {
> +            return true;
> +        }
> +        field_types = thunk_type_next(type_ptr);
> +    }
> +    return false;
> +}
> +
> +int thunk_type_size_with_src(const void *src, const argtype *type_ptr,
> +                             int is_host)
> +{
> +    switch (*type_ptr) {
> +    case TYPE_STRUCT: {
> +        int i;
> +        const StructEntry *se = struct_entries + type_ptr[1];
> +        const argtype *field_types;
> +        if (se->thunk_size[is_host] != NULL) {
> +            return (*se->thunk_size[is_host])(src);
> +        }
> +
> +        field_types = se->field_types;
> +        for (i = 0; i < se->nb_fields; i++) {
> +            if (*field_types == TYPE_FLEXIBLE_ARRAY) {
> +                uint32_t array_length = *(const uint32_t *)(
> +                    (const uint8_t *)src +
> +                    se->field_offsets[is_host][field_types[1]]);
> +                if (!is_host) {
> +                    array_length = tswap32(array_length);
> +                }
> +                return se->size[is_host] +
> +                    array_length *
> +                    thunk_type_size(field_types + 2, is_host);
> +            }
> +            field_types = thunk_type_next(type_ptr);
> +        }
> +        return se->size[is_host];
> +    }
> +    default:
> +        return thunk_type_size(type_ptr, is_host);
> +    }
> +}
> +
>  /* from em86 */
>
>  /* Utility function: Table-driven functions to translate bitmasks
> --
> 2.28.0.220.ged08abb693-goog
>
>

--00000000000077db2605aca0e77d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Forgot to +<span style=3D"font-family:Roboto,RobotoDraft,H=
elvetica,Arial,sans-serif;font-size:14px"><a href=3D"mailto:riku.voipio@iki=
.fi">riku.voipio@iki.fi</a> when generating v2.</span><br></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 11, 2=
020 at 12:10 AM Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com">scw@goo=
gle.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Flexible arrays may appear in the last field of a struct and are hea=
vily<br>
used in the ioctl(SIOCETHTOOL) system call on Linux. E.g.<br>
<br>
=C2=A0 struct ethtool_regs {<br>
=C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0cmd;<br>
=C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0version; /* driver-specific, indicat=
es different chips/revs */<br>
=C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0len; /* bytes */<br>
=C2=A0 =C2=A0 =C2=A0 __u8=C2=A0 =C2=A0 data[0];<br>
=C2=A0 };<br>
<br>
where number of elements in `data` is specified in `len`. It is translated<=
br>
into:<br>
<br>
=C2=A0 STRUCT(ethtool_regs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_INT, /* cmd */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_INT, /* version */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_INT, /* len */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MK_FLEXIBLE_ARRAY(TYPE_CHAR, 2)) /* data[=
0]: len */<br>
<br>
where the &quot;2&quot; passed to `MK_FLEXIBLE_ARRAY` means the number of e=
lement<br>
is specified by field number 2 (0-index).<br>
<br>
Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" target=
=3D"_blank">scw@google.com</a>&gt;<br>
---<br>
v1 -&gt; v2:<br>
=C2=A0 Fix style problems.<br>
<br>
=C2=A0include/exec/user/thunk.h |=C2=A0 24 ++++++<br>
=C2=A0thunk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 152 +++++++++++++++++++++++++++++++++++++-<br>
=C2=A02 files changed, 174 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h<br>
index 7992475c9f..d0d7c83f1f 100644<br>
--- a/include/exec/user/thunk.h<br>
+++ b/include/exec/user/thunk.h<br>
@@ -39,12 +39,21 @@ typedef enum argtype {<br>
=C2=A0 =C2=A0 =C2=A0TYPE_ARRAY,<br>
=C2=A0 =C2=A0 =C2=A0TYPE_STRUCT,<br>
=C2=A0 =C2=A0 =C2=A0TYPE_OLDDEVT,<br>
+=C2=A0 =C2=A0 TYPE_FLEXIBLE_ARRAY,<br>
=C2=A0} argtype;<br>
<br>
=C2=A0#define MK_PTR(type) TYPE_PTR, type<br>
=C2=A0#define MK_ARRAY(type, size) TYPE_ARRAY, size, type<br>
=C2=A0#define MK_STRUCT(id) TYPE_STRUCT, id<br>
<br>
+/*<br>
+ * Should only appear as the last element of a TYPE_STRUCT. `len_field_idx=
` is<br>
+ * the index into the fields in the enclosing struct that specify the leng=
th of<br>
+ * the flexibly array. The length field MUST be a TYPE_INT field.<br>
+ */<br>
+#define MK_FLEXIBLE_ARRAY(type, len_field_idx) \<br>
+=C2=A0 =C2=A0 TYPE_FLEXIBLE_ARRAY, (len_field_idx), type<br>
+<br>
=C2=A0#define THUNK_TARGET 0<br>
=C2=A0#define THUNK_HOST=C2=A0 =C2=A01<br>
<br>
@@ -55,6 +64,8 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0int *field_offsets[2];<br>
=C2=A0 =C2=A0 =C2=A0/* special handling */<br>
=C2=A0 =C2=A0 =C2=A0void (*convert[2])(void *dst, const void *src);<br>
+=C2=A0 =C2=A0 int (*thunk_size[2])(const void *src);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0int size[2];<br>
=C2=A0 =C2=A0 =C2=A0int align[2];<br>
=C2=A0 =C2=A0 =C2=A0const char *name;<br>
@@ -75,6 +86,11 @@ const argtype *thunk_convert(void *dst, const void *src,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const argtype *type_ptr, int to_host);<br>
=C2=A0const argtype *thunk_print(void *arg, const argtype *type_ptr);<br>
<br>
+bool thunk_type_has_flexible_array(const argtype *type_ptr);<br>
+/* thunk_type_size but can handle TYPE_FLEXIBLE_ARRAY */<br>
+int thunk_type_size_with_src(const void *src, const argtype *type_ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int is_host);<br>
+<br>
=C2=A0extern StructEntry *struct_entries;<br>
<br>
=C2=A0int thunk_type_size_array(const argtype *type_ptr, int is_host);<br>
@@ -137,6 +153,12 @@ static inline int thunk_type_size(const argtype *type_=
ptr, int is_host)<br>
=C2=A0 =C2=A0 =C2=A0case TYPE_STRUCT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0se =3D struct_entries + type_ptr[1];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return se-&gt;size[is_host];<br>
+=C2=A0 =C2=A0 case TYPE_FLEXIBLE_ARRAY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Flexible arrays do not count toward si=
zeof(). Users of structures<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* containing them need to calculate it t=
hemselves.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -187,6 +209,8 @@ static inline int thunk_type_align(const argtype *type_=
ptr, int is_host)<br>
=C2=A0 =C2=A0 =C2=A0case TYPE_STRUCT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0se =3D struct_entries + type_ptr[1];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return se-&gt;align[is_host];<br>
+=C2=A0 =C2=A0 case TYPE_FLEXIBLE_ARRAY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return thunk_type_align_array(type_ptr + 2, is=
_host);<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/thunk.c b/thunk.c<br>
index c5d9719747..d9c6cba3bd 100644<br>
--- a/thunk.c<br>
+++ b/thunk.c<br>
@@ -50,6 +50,8 @@ static inline const argtype *thunk_type_next(const argtyp=
e *type_ptr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return thunk_type_next_ptr(type_ptr + 1);=
<br>
=C2=A0 =C2=A0 =C2=A0case TYPE_STRUCT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return type_ptr + 1;<br>
+=C2=A0 =C2=A0 case TYPE_FLEXIBLE_ARRAY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return thunk_type_next_ptr(type_ptr + 1);<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -122,6 +124,34 @@ void thunk_register_struct_direct(int id, const char *=
name,<br>
=C2=A0 =C2=A0 =C2=A0se-&gt;name =3D name;<br>
=C2=A0}<br>
<br>
+static const argtype *<br>
+thunk_convert_flexible_array(void *dst, const void *src,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint8_t *dst_struct,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint8_t *src_struct, const argtype *ty=
pe_ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const StructEntry *se, int to_host) {<br>
+=C2=A0 =C2=A0 int len_field_idx, dst_size, src_size, i;<br>
+=C2=A0 =C2=A0 uint32_t array_length;<br>
+=C2=A0 =C2=A0 uint8_t *d;<br>
+=C2=A0 =C2=A0 const uint8_t *s;<br>
+<br>
+=C2=A0 =C2=A0 assert(*type_ptr =3D=3D TYPE_FLEXIBLE_ARRAY);<br>
+=C2=A0 =C2=A0 type_ptr++;<br>
+=C2=A0 =C2=A0 len_field_idx =3D *type_ptr++;<br>
+=C2=A0 =C2=A0 array_length =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(const uint32_t *)(to_host ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dst_struct + se-&gt;field_offsets[1][len_field_idx=
] :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 src_struct + se-&gt;field_offsets[0][len_field_idx=
]);<br>
+=C2=A0 =C2=A0 dst_size =3D thunk_type_size(type_ptr, to_host);<br>
+=C2=A0 =C2=A0 src_size =3D thunk_type_size(type_ptr, to_host);<br>
+=C2=A0 =C2=A0 d =3D dst;<br>
+=C2=A0 =C2=A0 s =3D src;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; array_length; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 thunk_convert(d, s, type_ptr, to_host);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D dst_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s +=3D src_size;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return thunk_type_next(type_ptr);<br>
+}<br>
<br>
=C2=A0/* now we can define the main conversion functions */<br>
=C2=A0const argtype *thunk_convert(void *dst, const void *src,<br>
@@ -246,7 +276,7 @@ const argtype *thunk_convert(void *dst, const void *src=
,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(*type_ptr &lt; max_s=
truct_entries);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0se =3D struct_entries + *ty=
pe_ptr++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (se-&gt;convert[0] !=3D NULL)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (se-&gt;convert[to_host] !=3D=
 NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* specific c=
onversion is needed */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*se-&gt;conv=
ert[to_host])(dst, src);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -256,7 +286,18 @@ const argtype *thunk_convert(void *dst, const void *sr=
c,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_offsets =
=3D se-&gt;field_offsets[1 - to_host];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =3D dst;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s =3D src;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for(i =3D 0;i &lt;=
 se-&gt;nb_fields; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &l=
t; se-&gt;nb_fields; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
*field_types =3D=3D TYPE_FLEXIBLE_ARRAY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 field_types =3D thunk_convert_flexible_array(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 d + dst_offsets[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s + src_offsets[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 field_types,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 se,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 to_host);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0field_types =3D thunk_convert(d + dst_offsets[i],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s + src_offsets[i],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0field_types, to_host);<br>
@@ -264,6 +305,11 @@ const argtype *thunk_convert(void *dst, const void *sr=
c,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case TYPE_FLEXIBLE_ARRAY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Invalid flex=
ible array (type 0x%x) outside of a structure\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Invalid type 0x%x\n=
&quot;, type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -271,6 +317,45 @@ const argtype *thunk_convert(void *dst, const void *sr=
c,<br>
=C2=A0 =C2=A0 =C2=A0return type_ptr;<br>
=C2=A0}<br>
<br>
+static const argtype *<br>
+thunk_print_flexible_array(void *arg, const uint8_t *arg_struct,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const argtype *type_ptr, const StructEntry *se) {<b=
r>
+=C2=A0 =C2=A0 int array_length, len_field_idx, arg_size, i;<br>
+=C2=A0 =C2=A0 uint8_t *a;<br>
+=C2=A0 =C2=A0 int is_string =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 assert(*type_ptr =3D=3D TYPE_FLEXIBLE_ARRAY);<br>
+=C2=A0 =C2=A0 type_ptr++;<br>
+=C2=A0 =C2=A0 len_field_idx =3D *type_ptr++;<br>
+<br>
+=C2=A0 =C2=A0 array_length =3D tswap32(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(const uint32_t *)(arg_struct + se-&gt;field_=
offsets[0][len_field_idx]));<br>
+=C2=A0 =C2=A0 arg_size =3D thunk_type_size(type_ptr, 0);<br>
+=C2=A0 =C2=A0 a =3D arg;<br>
+<br>
+=C2=A0 =C2=A0 if (*type_ptr =3D=3D TYPE_CHAR) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;\&quot;&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_string =3D 1;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;[&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; array_length; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 0 &amp;&amp; !is_string) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 thunk_print(a, type_ptr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 a +=3D arg_size;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (is_string) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;\&quot;&quot;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;]&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return thunk_type_next(type_ptr);<br>
+}<br>
+<br>
=C2=A0const argtype *thunk_print(void *arg, const argtype *type_ptr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int type;<br>
@@ -414,17 +499,80 @@ const argtype *thunk_print(void *arg, const argtype *=
type_ptr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i &gt; 0)=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0qemu_log(&quot;,&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*field_types =
=3D=3D TYPE_FLEXIBLE_ARRAY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fiel=
d_types =3D thunk_print_flexible_array(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 a + arg_offsets[i], a, field_types, se);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cont=
inue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0field_types =
=3D thunk_print(a + arg_offsets[i], field_types);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log(&quot;}&quot;);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case TYPE_FLEXIBLE_ARRAY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Invalid flex=
ible array (type 0x%x) outside of a structure\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return type_ptr;<br>
=C2=A0}<br>
<br>
+bool thunk_type_has_flexible_array(const argtype *type_ptr)<br>
+{<br>
+=C2=A0 int i;<br>
+=C2=A0 const StructEntry *se;<br>
+=C2=A0 const argtype *field_types;<br>
+=C2=A0 =C2=A0 if (*type_ptr !=3D TYPE_STRUCT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 se =3D struct_entries + type_ptr[1];<br>
+=C2=A0 =C2=A0 field_types =3D se-&gt;field_types;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; se-&gt;nb_fields; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*field_types =3D=3D TYPE_FLEXIBLE_ARRAY) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 field_types =3D thunk_type_next(type_ptr);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+int thunk_type_size_with_src(const void *src, const argtype *type_ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int is_host)<br>
+{<br>
+=C2=A0 =C2=A0 switch (*type_ptr) {<br>
+=C2=A0 =C2=A0 case TYPE_STRUCT: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const StructEntry *se =3D struct_entries + typ=
e_ptr[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const argtype *field_types;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (se-&gt;thunk_size[is_host] !=3D NULL) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (*se-&gt;thunk_size[is_ho=
st])(src);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 field_types =3D se-&gt;field_types;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; se-&gt;nb_fields; i++) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*field_types =3D=3D TYPE_FLE=
XIBLE_ARRAY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t array_len=
gth =3D *(const uint32_t *)(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (con=
st uint8_t *)src +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 se-&=
gt;field_offsets[is_host][field_types[1]]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_host) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arra=
y_length =3D tswap32(array_length);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return se-&gt;size=
[is_host] +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arra=
y_length *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 thun=
k_type_size(field_types + 2, is_host);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 field_types =3D thunk_type_next(=
type_ptr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return se-&gt;size[is_host];<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return thunk_type_size(type_ptr, is_host);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0/* from em86 */<br>
<br>
=C2=A0/* Utility function: Table-driven functions to translate bitmasks<br>
-- <br>
2.28.0.220.ged08abb693-goog<br>
<br>
</blockquote></div>

--00000000000077db2605aca0e77d--

--0000000000007f02cc05aca0e734
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPAAYJKoZIhvcNAQcCoIIO8TCCDu0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxjMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEERTBDMEEG
CCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3NtaW1lY2Ey
MDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2MDSgMqAw
hi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0GCSqGSIb3
DQEBCwUAA4IBAQB0zgx4rAhCKzIVBMrEn4R/8FrisDQWZwJvA4VLbgtBPI1kP/Ys+cw3oYecxHED
MAHXOYclqmcaKudfjsLKZ/jrpdjZMAHDazo86g4BREWWiAxAtnMPhKrL4Ciqs0Yx/fj4VJlJRgES
1wscHQQNh2BgbqP15O5D2CtZVsLIuc9pSY3DZNYUrMQy55hszPnhgeghImVgNLtzUkF8oLKlnrWs
blvMc7fi7e42/rSnhbE6WUWGHvXcQ3+qIptP079GF+p1ZnEVmXIrQeoP1Rh0wS2ThPBorHqMY8OB
+c1AbPa2A/qY7QkFA6Oq7I8gUPNRO1NyuEElN4LJy+SCH0kWzLawMYICYTCCAl0CAQEwXzBLMQsw
CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xvYmFsU2ln
biBTTUlNRSBDQSAyMDE4AhAB2NRaeBKJjaSQ9CGctwQsMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqG
SIb3DQEJBDEiBCAtfGguor06P2+31IOUeKs6wQxZSqqnky47ALPMnTHnITAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA4MTEyMTM5MjJaMGkGCSqGSIb3DQEJDzFc
MFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJ
KoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAojqi
tqj/4f0epAXT0LYOLtnM8PG/Cda2PXaMAP6MtjerUcCm6C8+56TAcilign9Wnsqo2UnsA9fmPK4e
KM94IO9CVR9gbvfxI6ZAUJONcwhFEt+g+VMkk2pdEEdNuYI+UkkVn57vJneVCVetVv12lswVZxS7
9C6SNPggKgwkrVsfJqYJ4NpkUX1+7s9IVc82+qgH+ONcU5JnJAK4ZPmFWA13oyrKtBHYt9ShVx6U
kKA+scBaHC/cePCkp32Y84vKR+fXNOrwhRuxxnYLAERXyWPdQ/DsKl32K/2rADNacXmjNvAKcrO4
QoPPEW7MzO7yh38wJMbgsiRUvLihzm5P4w==
--0000000000007f02cc05aca0e734--


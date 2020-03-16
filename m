Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20604C3F2CE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E110B20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbCOmVTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E110B20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuNL-0006Uz-3d
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDt4X-0000ad-QE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDt4W-0008SL-CV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:58:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDt4W-0008Hf-4B
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:58:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id x3so13755826wmj.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/IyIk2BTcvPs8I3/VKKNUhLoQ3ERclU8Qqyj1NidovE=;
 b=CbCOmVTpayfG0H6psD1EMsb31I7bizoY0vGd4f5rNb8HtPxaEOTG1elEHdvzVt6tv1
 xcpkj4cAX39QWUaMhx399nrA2aVi7/g87eLrNifm4bWnCUR8FpHa8SCZkvJZAu9jB/HB
 ULXOUOVxFqJUN5787ZoeT0qQCqiXG0UT7XzlPNR+CbtqhbXyDxcuAJn9cN3TpbVsQJ0H
 ICVam1x+oKnICUc9VEZfvP8EDPNQAfnGYYGeLb8O8CK45OKgeHTN3uJQaWcolbGg3W4T
 MrFr9YLLw4pbz/rKK8lVNxvEik3JboZiOvDesYHA9wqpUqaSMtipcbmUQIgDx1+sf44M
 QiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/IyIk2BTcvPs8I3/VKKNUhLoQ3ERclU8Qqyj1NidovE=;
 b=dKQW2Qxh+wkHzqewUmjmktdiri3TDRRQr7SgeCvJ4dDZk/E6Fai4Uaqj5shC44s+xP
 FRi42Pyp9ogARkpyzV5jXkN61pXj2l6aD3ZcI3iKaXuQMZG/sxrcaCkF4qeal8hqDHqK
 LIxCjNpvdK46gC7xGhhH6TDC9Y/oIfoHedkFD7X3qvVYYVBVF4TG/GCLVw/oVME+TF+S
 S0uO6CI1ROza61HVzO/X4dULkhsa5F7iXxK5SbJrTvfNAGedt9oZ6ydIOmHp1x0L/hZX
 9qvYKlCas/+dpuz4MnJ8oTHH1DgbWrbFPhqJRUBIzByTR8q04tMbBUVGK3QJ44imMQVW
 +XDA==
X-Gm-Message-State: ANhLgQ0Z+0bL5GxLTA89DH8vd+sL1fPcNFoUBwuqkWUvRwZajfZZTgGc
 0seTzfLfTIyumRjPvaaPQKoK3PPeaL64W/V6gkJgDkudf1E=
X-Google-Smtp-Source: ADFU+vtfUok6TWQaOMapJYyyD+jDYANqG3/+N0e9FYt2R5mZNnQMeUaKvOfotsz804SL7/CQPtJHpPgeFja7jRCZsDE=
X-Received: by 2002:a7b:c391:: with SMTP id s17mr57798wmj.55.1584377915132;
 Mon, 16 Mar 2020 09:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-16-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-16-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 17:58:22 +0100
Message-ID: <CAJ+F1CJUSB+21vdCXz-5aG3x=-NugB-NJwsZJ_x8Y6Wt9a1DsA@mail.gmail.com>
Subject: Re: [PATCH v3 15/34] qapi/introspect: Factor out _make_tree()
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 15, 2020 at 4:14 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> The value of @qmp_schema_qlit is generated from an expression tree.
> Tree nodes are created in several places.  Factor out the common code
> into _make_tree().  This isn't much of a win now.  It will pay off
> when we add feature flags in the next few commits.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/introspect.py | 44 +++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index e4fc9d90f1..a3fa9865db 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -16,6 +16,18 @@ from qapi.schema import (QAPISchemaArrayType, QAPISche=
maBuiltinType,
>                           QAPISchemaType)
>
>
> +def _make_tree(obj, ifcond, features, extra=3DNone):
> +    if extra is None:
> +        extra =3D {}
> +    if ifcond:
> +        extra['if'] =3D ifcond
> +    if features:
> +        obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in feature=
s]
> +    if extra:
> +        return (obj, extra)
> +    return obj
> +
> +
>  def _tree_to_qlit(obj, level=3D0, suppress_first_indent=3DFalse):
>
>      def indent(level):
> @@ -146,47 +158,38 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>          return self._name(typ.name)
>
>      def _gen_tree(self, name, mtype, obj, ifcond, features):
> -        extra =3D {}
> +        extra =3D None
>          if mtype not in ('command', 'event', 'builtin', 'array'):
>              if not self._unmask:
>                  # Output a comment to make it easy to map masked names
>                  # back to the source when reading the generated output.
> -                extra['comment'] =3D '"%s" =3D %s' % (self._name(name), =
name)
> +                extra =3D {'comment': '"%s" =3D %s' % (self._name(name),=
 name)}
>              name =3D self._name(name)
>          obj['name'] =3D name
>          obj['meta-type'] =3D mtype
> -        if features:
> -            obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in fea=
tures]
> -        if ifcond:
> -            extra['if'] =3D ifcond
> -        if extra:
> -            self._trees.append((obj, extra))
> -        else:
> -            self._trees.append(obj)
> +        self._trees.append(_make_tree(obj, ifcond, features, extra))
>
>      def _gen_member(self, member):
> -        ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
> +        obj =3D {'name': member.name, 'type': self._use_type(member.type=
)}
>          if member.optional:
> -            ret['default'] =3D None
> -        if member.ifcond:
> -            ret =3D (ret, {'if': member.ifcond})
> -        return ret
> +            obj['default'] =3D None
> +        return _make_tree(obj, member.ifcond, None)
>
>      def _gen_variants(self, tag_name, variants):
>          return {'tag': tag_name,
>                  'variants': [self._gen_variant(v) for v in variants]}
>
>      def _gen_variant(self, variant):
> -        return ({'case': variant.name, 'type': self._use_type(variant.ty=
pe)},
> -                {'if': variant.ifcond})
> +        obj =3D {'case': variant.name, 'type': self._use_type(variant.ty=
pe)}
> +        return _make_tree(obj, variant.ifcond, None)
>
>      def visit_builtin_type(self, name, info, json_type):
>          self._gen_tree(name, 'builtin', {'json-type': json_type}, [], No=
ne)
>
>      def visit_enum_type(self, name, info, ifcond, features, members, pre=
fix):
>          self._gen_tree(name, 'enum',
> -                       {'values':
> -                        [(m.name, {'if': m.ifcond}) for m in members]},
> +                       {'values': [_make_tree(m.name, m.ifcond, None)
> +                                   for m in members]},
>                         ifcond, features)
>
>      def visit_array_type(self, name, info, ifcond, element_type):
> @@ -206,7 +209,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>      def visit_alternate_type(self, name, info, ifcond, features, variant=
s):
>          self._gen_tree(name, 'alternate',
>                         {'members': [
> -                           ({'type': self._use_type(m.type)}, {'if': m.i=
fcond})
> +                           _make_tree({'type': self._use_type(m.type)},
> +                                      m.ifcond, None)
>                             for m in variants.variants]},
>                         ifcond, features)
>
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


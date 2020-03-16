Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC22C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D4E20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCImbRAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D4E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtbv-0001r9-Vc
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDt0T-0001j3-BL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDt0R-0002Al-Oh
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:54:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDt0R-000216-G2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:54:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id x3so13747760wmj.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c7vrua55ertCuPKNks3J3QAz0H3p9AO2iYd+F17dc58=;
 b=cCImbRAkeUvKfHxcpKjyweEMLVh7+ZnsAfvbZIjTqVHdp/jY0n6GeyyJhH6aqXq/JI
 jMViba+/wrziOUOA2aNObBtHoOp8lD0EEeegeT0qHFvBqznnmiDOILcK5wsaFaoC0HSL
 aBnr3OKom9dkSbdgHfqTrQLlUbWA6jcpZOSJ0oNuezSROMNpClYmrDaamgzeNdVQEJLG
 l6VdZ+oLnfPS7cjjxAB4wT9dw7iXZGbMKmM5cJIEROXuKrU6NMhssv1mVbJF0PFqvjnX
 7WSmoGMe2n0GiZRKaIkGyP2gs4/RtM1va4z0HAD+l95t3NV69Vm2njaQT5ffMLRLJD8X
 Rbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c7vrua55ertCuPKNks3J3QAz0H3p9AO2iYd+F17dc58=;
 b=SvfOSufFW65aUUTV6u6dkwy+Pw0kT+sIGgLC9IeEudI+RpjQJfaEsyywP9SMfcQAgN
 4hvIi6t75tKnqRL4OVbpkBLNAO1+liDimlDaBMjvP6rjsRu00xsHbWL7ZkEaGq2qHVgM
 aQlFf5e0hZIjPxw/5c439JHDbe1mIvZG0y3IZJKtaZrRiKOG+zeDbD1Tzz3qgXgkRJNi
 KwRaiOyLddrl9cX8uANQ9mBSz40YXt/m6cEouDaK4NoRoT1bVLwYR/oz5M5BzgdAQo7m
 sVvtFDoFmz5siG65NIeL5VcPn+zBEY9nNBlxmZqQmYvInegWEJ64n8oZuP7qENTe0cWK
 O3fg==
X-Gm-Message-State: ANhLgQ1QRWezgRFq7KBhh1ZFxiqV0RZi+DKSkA8sp+RYtM57XDYH3eB0
 s+p6SIPy77B3fqzZjqOe5veBHpJWCxD3bXUuM9o=
X-Google-Smtp-Source: ADFU+vtXLr+5nDUfsOpr0r1SYoVvq9AZlq50h/bvCNxIcOaIPfWdzQ7WH6pgkjr4X32ai56fHOTY05eylp4zYBVrIj8=
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr91865wmf.4.1584377662314;
 Mon, 16 Mar 2020 09:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-15-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-15-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 17:54:09 +0100
Message-ID: <CAJ+F1C+U7ahEZN=D3W-6xTaNO+-uD+hqXwg-DFcKr8zLKGBN=w@mail.gmail.com>
Subject: Re: [PATCH v3 14/34] qapi/introspect: Rename *qlit* to reduce
 confusion
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

On Sun, Mar 15, 2020 at 4:19 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> We generate the value of qmp_schema_qlit from an expression tree.  The
> function doing that is named to_qlit(), and its inputs are accumulated
> in QAPISchemaGenIntrospectVisitor._qlits.  We call both its input and
> its output "qlit".  This is confusing.
>
> Use "tree" for input, and "qlit" only for output: rename to_qlit() to
> _tree_to_qlit(), ._qlits to ._trees, ._gen_qlit() to ._gen_tree().
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/introspect.py | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index b54910510d..e4fc9d90f1 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -16,7 +16,7 @@ from qapi.schema import (QAPISchemaArrayType, QAPISchem=
aBuiltinType,
>                           QAPISchemaType)
>
>
> -def to_qlit(obj, level=3D0, suppress_first_indent=3DFalse):
> +def _tree_to_qlit(obj, level=3D0, suppress_first_indent=3DFalse):
>
>      def indent(level):
>          return level * 4 * ' '
> @@ -30,7 +30,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
>              ret +=3D indent(level) + '/* %s */\n' % comment
>          if ifcond:
>              ret +=3D gen_if(ifcond)
> -        ret +=3D to_qlit(ifobj, level)
> +        ret +=3D _tree_to_qlit(ifobj, level)
>          if ifcond:
>              ret +=3D '\n' + gen_endif(ifcond)
>          return ret
> @@ -43,7 +43,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
>      elif isinstance(obj, str):
>          ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
>      elif isinstance(obj, list):
> -        elts =3D [to_qlit(elt, level + 1).strip('\n')
> +        elts =3D [_tree_to_qlit(elt, level + 1).strip('\n')
>                  for elt in obj]
>          elts.append(indent(level + 1) + "{}")
>          ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
> @@ -53,7 +53,8 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
>          elts =3D []
>          for key, value in sorted(obj.items()):
>              elts.append(indent(level + 1) + '{ %s, %s }' %
> -                        (to_c_string(key), to_qlit(value, level + 1, Tru=
e)))
> +                        (to_c_string(key),
> +                         _tree_to_qlit(value, level + 1, True)))
>          elts.append(indent(level + 1) + '{}')
>          ret +=3D 'QLIT_QDICT(((QLitDictEntry[]) {\n'
>          ret +=3D ',\n'.join(elts) + '\n'
> @@ -79,7 +80,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolith=
icCVisitor):
>              ' * QAPI/QMP schema introspection', __doc__)
>          self._unmask =3D unmask
>          self._schema =3D None
> -        self._qlits =3D []
> +        self._trees =3D []
>          self._used_types =3D []
>          self._name_map =3D {}
>          self._genc.add(mcgen('''
> @@ -108,9 +109,9 @@ extern const QLitObject %(c_name)s;
>  const QLitObject %(c_name)s =3D %(c_string)s;
>  ''',
>                               c_name=3Dc_name(name),
> -                             c_string=3Dto_qlit(self._qlits)))
> +                             c_string=3D_tree_to_qlit(self._trees)))
>          self._schema =3D None
> -        self._qlits =3D []
> +        self._trees =3D []
>          self._used_types =3D []
>          self._name_map =3D {}
>
> @@ -144,7 +145,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>              return '[' + self._use_type(typ.element_type) + ']'
>          return self._name(typ.name)
>
> -    def _gen_qlit(self, name, mtype, obj, ifcond, features):
> +    def _gen_tree(self, name, mtype, obj, ifcond, features):
>          extra =3D {}
>          if mtype not in ('command', 'event', 'builtin', 'array'):
>              if not self._unmask:
> @@ -159,9 +160,9 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>          if ifcond:
>              extra['if'] =3D ifcond
>          if extra:
> -            self._qlits.append((obj, extra))
> +            self._trees.append((obj, extra))
>          else:
> -            self._qlits.append(obj)
> +            self._trees.append(obj)
>
>      def _gen_member(self, member):
>          ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
> @@ -180,17 +181,17 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>                  {'if': variant.ifcond})
>
>      def visit_builtin_type(self, name, info, json_type):
> -        self._gen_qlit(name, 'builtin', {'json-type': json_type}, [], No=
ne)
> +        self._gen_tree(name, 'builtin', {'json-type': json_type}, [], No=
ne)
>
>      def visit_enum_type(self, name, info, ifcond, features, members, pre=
fix):
> -        self._gen_qlit(name, 'enum',
> +        self._gen_tree(name, 'enum',
>                         {'values':
>                          [(m.name, {'if': m.ifcond}) for m in members]},
>                         ifcond, features)
>
>      def visit_array_type(self, name, info, ifcond, element_type):
>          element =3D self._use_type(element_type)
> -        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement},
> +        self._gen_tree('[' + element + ']', 'array', {'element-type': el=
ement},
>                         ifcond, None)
>
>      def visit_object_type_flat(self, name, info, ifcond, features,
> @@ -200,10 +201,10 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>              obj.update(self._gen_variants(variants.tag_member.name,
>                                            variants.variants))
>
> -        self._gen_qlit(name, 'object', obj, ifcond, features)
> +        self._gen_tree(name, 'object', obj, ifcond, features)
>
>      def visit_alternate_type(self, name, info, ifcond, features, variant=
s):
> -        self._gen_qlit(name, 'alternate',
> +        self._gen_tree(name, 'alternate',
>                         {'members': [
>                             ({'type': self._use_type(m.type)}, {'if': m.i=
fcond})
>                             for m in variants.variants]},
> @@ -218,11 +219,11 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>                 'ret-type': self._use_type(ret_type)}
>          if allow_oob:
>              obj['allow-oob'] =3D allow_oob
> -        self._gen_qlit(name, 'command', obj, ifcond, features)
> +        self._gen_tree(name, 'command', obj, ifcond, features)
>
>      def visit_event(self, name, info, ifcond, features, arg_type, boxed)=
:
>          arg_type =3D arg_type or self._schema.the_empty_object_type
> -        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)},
> +        self._gen_tree(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)},
>                         ifcond, features)
>
>
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A00C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E75420409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggxM5D/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E75420409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuSY-0007wS-ES
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDszG-0007SW-FC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDszE-0000hU-Ab
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:53:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDszE-0000VE-0l
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:53:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id 25so18484539wmk.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VI4mbd3B2oWxXYLAt8oWmbegrxmq0MeKs/7FeQkOLFk=;
 b=ggxM5D/jQonjVvRf4hOhz1t+bjLab9L1sTPpAcdrjwNw1imJsM7G6up4114FB858JM
 0rREoVyXFjNkUnkHJtokxL0hpM4pM/rM2XMpCZqvFbeLzVjn/dpVhsrji4ylRbwr34Ou
 Aywdjvz+kasA+LS86S3CiMlPshthAWoD7qvRLdHhKcZzHSLryxVczetoG4KbQgztlIQM
 k3OdTceYh4g+/5QIq8/gUqIDrhwXEIls+rHNWLE56If++0ORgzuxTN9PQrgHzaVZyeIF
 KaAIY/U6pLtSKeRD86cc8Clp7GH4cp6LfnE6mu1heMgDO/i9rzMh9F9OrQNiM6nAZCk0
 2Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VI4mbd3B2oWxXYLAt8oWmbegrxmq0MeKs/7FeQkOLFk=;
 b=L7osFfEchptNphD3imH+GauY/AEPf2qJNFVaqAqSY8wHf8vBQr2aPDG6dHzfzdPaxE
 KBN8xuq1barZ1lQPvl3FxId15pDyHW1Vd8z2L0ckdDMdHvw0xgd1RmS/NWEekomYvxGt
 TumupFlq8dHfNF/K82jm8V6qi9f7jcG5C7l7yTBrKnc7RWm1n1OPze5ozWtvhpzBqsCj
 coFn0fYr2Xb4cJkhLlFcfgdFU6Vn06mz5XURtfmg4ZCP32u/HH4eISoTxBk3SQ2MQeTC
 aPW2TLHp1Y1VHzllegTbIZjo/FHktXEca35sJ9pJ6LT5AgrdqUwLSZ2cMDrBItRXF688
 bp8A==
X-Gm-Message-State: ANhLgQ1ASt8UGPwcrNfAIexmvKXknQxGff43rqxrrD6hYsWU1UlXa/Qp
 vZGmFOhPr5UW1zyVaXcqpt0aHnG0LEZJV5pny6MUrIr9bQ8=
X-Google-Smtp-Source: ADFU+vtl98cITYu2RUnfTdVXSlelw5FeBg/yEc59bqCzwdVnL8zHqKB2lxRVgLonq18ONuVHly0lWqBfhGDHB8Y/2mY=
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr88416wma.26.1584377586765;
 Mon, 16 Mar 2020 09:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-14-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-14-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 17:52:53 +0100
Message-ID: <CAJ+F1C+GQjA1do86sCroCu=gLB=m=VO2297i8Be2uA0oTu9p+A@mail.gmail.com>
Subject: Re: [PATCH v3 13/34] qapi: Consistently put @features parameter right
 after @ifcond
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

On Sun, Mar 15, 2020 at 4:51 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/commands.py       |  6 +++---
>  scripts/qapi/doc.py            | 10 +++++-----
>  scripts/qapi/introspect.py     | 10 +++++-----
>  scripts/qapi/schema.py         | 36 ++++++++++++++++------------------
>  scripts/qapi/types.py          |  4 ++--
>  scripts/qapi/visit.py          |  4 ++--
>  tests/qapi-schema/test-qapi.py | 10 +++++-----
>  7 files changed, 39 insertions(+), 41 deletions(-)
>
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index 0e13e82989..bc30876c88 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -283,9 +283,9 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
>                                        prefix=3Dself._prefix))
>          self._genc.add(gen_registry(self._regy.get_content(), self._pref=
ix))
>
> -    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfi=
g,
> -                      features):
> +    def visit_command(self, name, info, ifcond, features,
> +                      arg_type, ret_type, gen, success_response, boxed,
> +                      allow_oob, allow_preconfig):
>          if not gen:
>              return
>          # FIXME: If T is a user-defined type, the user is responsible
> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
> index 36e823338b..92f584edcf 100644
> --- a/scripts/qapi/doc.py
> +++ b/scripts/qapi/doc.py
> @@ -249,8 +249,8 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
>                                  texi_members(doc, 'Values',
>                                               member_func=3Dtexi_enum_val=
ue)))
>
> -    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
> -                          features):
> +    def visit_object_type(self, name, info, ifcond, features,
> +                          base, members, variants):
>          doc =3D self.cur_doc
>          if base and base.is_implicit():
>              base =3D None
> @@ -262,9 +262,9 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
>          self._gen.add(texi_type('Alternate', doc, ifcond,
>                                  texi_members(doc, 'Members')))
>
> -    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfi=
g,
> -                      features):
> +    def visit_command(self, name, info, ifcond, features,
> +                      arg_type, ret_type, gen, success_response, boxed,
> +                      allow_oob, allow_preconfig):
>          doc =3D self.cur_doc
>          self._gen.add(texi_msg('Command', doc, ifcond,
>                                 texi_arguments(doc,
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 2e9e00aa1f..b54910510d 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -193,8 +193,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>          self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement},
>                         ifcond, None)
>
> -    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts,
> -                               features):
> +    def visit_object_type_flat(self, name, info, ifcond, features,
> +                               members, variants):
>          obj =3D {'members': [self._gen_member(m) for m in members]}
>          if variants:
>              obj.update(self._gen_variants(variants.tag_member.name,
> @@ -209,9 +209,9 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>                             for m in variants.variants]},
>                         ifcond, features)
>
> -    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfi=
g,
> -                      features):
> +    def visit_command(self, name, info, ifcond, features,
> +                      arg_type, ret_type, gen, success_response, boxed,
> +                      allow_oob, allow_preconfig):
>          arg_type =3D arg_type or self._schema.the_empty_object_type
>          ret_type =3D ret_type or self._schema.the_empty_object_type
>          obj =3D {'arg-type': self._use_type(arg_type),
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 22238005ff..958756ecd6 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -115,20 +115,20 @@ class QAPISchemaVisitor:
>      def visit_array_type(self, name, info, ifcond, element_type):
>          pass
>
> -    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
> -                          features):
> +    def visit_object_type(self, name, info, ifcond, features,
> +                          base, members, variants):
>          pass
>
> -    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts,
> -                               features):
> +    def visit_object_type_flat(self, name, info, ifcond, features,
> +                               members, variants):
>          pass
>
>      def visit_alternate_type(self, name, info, ifcond, features, variant=
s):
>          pass
>
> -    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfi=
g,
> -                      features):
> +    def visit_command(self, name, info, ifcond, features,
> +                      arg_type, ret_type, gen, success_response, boxed,
> +                      allow_oob, allow_preconfig):
>          pass
>
>      def visit_event(self, name, info, ifcond, features, arg_type, boxed)=
:
> @@ -436,12 +436,12 @@ class QAPISchemaObjectType(QAPISchemaType):
>
>      def visit(self, visitor):
>          super().visit(visitor)
> -        visitor.visit_object_type(self.name, self.info, self.ifcond,
> -                                  self.base, self.local_members, self.va=
riants,
> -                                  self.features)
> -        visitor.visit_object_type_flat(self.name, self.info, self.ifcond=
,
> -                                       self.members, self.variants,
> -                                       self.features)
> +        visitor.visit_object_type(
> +            self.name, self.info, self.ifcond, self.features,
> +            self.base, self.local_members, self.variants)
> +        visitor.visit_object_type_flat(
> +            self.name, self.info, self.ifcond, self.features,
> +            self.members, self.variants)
>
>
>  class QAPISchemaMember:
> @@ -745,12 +745,10 @@ class QAPISchemaCommand(QAPISchemaEntity):
>
>      def visit(self, visitor):
>          super().visit(visitor)
> -        visitor.visit_command(self.name, self.info, self.ifcond,
> -                              self.arg_type, self.ret_type,
> -                              self.gen, self.success_response,
> -                              self.boxed, self.allow_oob,
> -                              self.allow_preconfig,
> -                              self.features)
> +        visitor.visit_command(
> +            self.name, self.info, self.ifcond, self.features,
> +            self.arg_type, self.ret_type, self.gen, self.success_respons=
e,
> +            self.boxed, self.allow_oob, self.allow_preconfig)
>
>
>  class QAPISchemaEvent(QAPISchemaEntity):
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index d0d5c03646..3ad33af4ee 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -289,8 +289,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
>              self._genh.add(gen_array(name, element_type))
>              self._gen_type_cleanup(name)
>
> -    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
> -                          features):
> +    def visit_object_type(self, name, info, ifcond, features,
> +                          base, members, variants):
>          # Nothing to do for the special empty builtin
>          if name =3D=3D 'q_empty':
>              return
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 6e5ed781d7..23d9194aa4 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -326,8 +326,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
>              self._genh.add(gen_visit_decl(name))
>              self._genc.add(gen_visit_list(name, element_type))
>
> -    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
> -                          features):
> +    def visit_object_type(self, name, info, ifcond, features,
> +                          base, members, variants):
>          # Nothing to do for the special empty builtin
>          if name =3D=3D 'q_empty':
>              return
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index af5b57a0b1..8e09e54edb 100755
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -46,8 +46,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>          print('array %s %s' % (name, element_type.name))
>          self._print_if(ifcond)
>
> -    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
> -                          features):
> +    def visit_object_type(self, name, info, ifcond, features,
> +                          base, members, variants):
>          print('object %s' % name)
>          if base:
>              print('    base %s' % base.name)
> @@ -65,9 +65,9 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>          self._print_if(ifcond)
>          self._print_features(features)
>
> -    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfi=
g,
> -                      features):
> +    def visit_command(self, name, info, ifcond, features,
> +                      arg_type, ret_type, gen, success_response, boxed,
> +                      allow_oob, allow_preconfig):
>          print('command %s %s -> %s'
>                % (name, arg_type and arg_type.name,
>                   ret_type and ret_type.name))
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


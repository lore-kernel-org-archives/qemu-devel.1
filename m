Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B91C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C007C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgQVAIZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C007C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuVt-0005r4-Vu
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDt9u-0001W4-8h
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDt9s-0007Bt-3A
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:04:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDt9r-0006w2-P0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:04:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id a141so18914516wme.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s1f+8wQMmbHF4wgDhoO/EqOXdUHOi+/PNSvxX/QXg8s=;
 b=lgQVAIZpwQJivmW28tB3rr9hlmeszFjEVRs8RJIfzgfjp9eO7TO56h3T0L8Wsyglif
 kXzspUay93YHoS58cceohwo4txgMIkkeXLuq6ZecLj9HbVdTS8+Z+EaWs0QxZJDY3Hz+
 tiKC3HlTyoIq9XXEzDOpi5mNtGVY549Y+W8inDstL9nbRFfcl+U6xMVCyc4Ujr4gcQ6y
 uy0/+nfqvqq78Al7pddQNSVOqFUd1AhJn3U71GfP6u4Pz1t4p5AlOIDRTq1EeS/DA166
 RcweL/NbBTCoA3psAN6QuCm5/4/KaAwW1xp/ZtBLPAuJ+Ha/O0nWI+7sMP3w53CN83m+
 4llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s1f+8wQMmbHF4wgDhoO/EqOXdUHOi+/PNSvxX/QXg8s=;
 b=HDISo2pQDyM0VFttB0ID/Y9X23h7hegjk+fpDW2uAPmSBe/uA0JcmnItGW5iOU2izS
 Nlw18tsJju9E7jfzQNz+bWscVjo9ghb34I5JB6zwa94MjhKNs1jY3+PPiacN+DjgAhWy
 Y/aQPZHt5lLvhuNh3Sv1Gjpsa51hNrxRGZALuftcPP6nPoDwnN8yGlNnUjOgKu8tau55
 IT2Y9/cgGZIzCKrmUh0fHK7ytz6kNfHIYDyAoAHfeP/v7TSc8+2Zb6xTTaPJe+g3Bkth
 zjB20HotBV36GViKJVyTJsfWXaDSLoNg3MAsbpo60nLKXsXBczs0LAOKIOv9+fM2Nnlm
 RRtg==
X-Gm-Message-State: ANhLgQ0juuQaXb4QmsjFkED5qDhAKTINBxm/H52RRMg4/vnBBp+Ko2jZ
 JsJ81DHTw+LdWJ6gLhDEZ0zdRy/iqAxkUXn2biI=
X-Google-Smtp-Source: ADFU+vuHBUjFikIZd5pqB9NiLMJHONLjB+dyqgRJl8ch79FWwJ0IX7PQssiRq8AzioLA6+CjawEwgCH9SGVzdWFeGDY=
X-Received: by 2002:a7b:c153:: with SMTP id z19mr75963wmi.37.1584378246323;
 Mon, 16 Mar 2020 10:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-18-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-18-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 18:03:52 +0100
Message-ID: <CAJ+F1CLXm_9C4YMWoBMbjw+qXrd0g6Q-=HmchL51Oxx4+dirjQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/34] qapi/schema: Reorder classes so related ones are
 together
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Hi

On Sun, Mar 15, 2020 at 4:05 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Move QAPISchemaAlternateType up some, so that all QAPISchemaFOOType
> are together.  Move QAPISchemaObjectTypeVariants right behind its
> users.

not fond of churn, but ok
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/schema.py | 284 ++++++++++++++++++++---------------------
>  1 file changed, 142 insertions(+), 142 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 4d8ad67303..0acf8b466f 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -444,82 +444,72 @@ class QAPISchemaObjectType(QAPISchemaType):
>              self.members, self.variants)
>
>
> -class QAPISchemaMember:
> -    """ Represents object members, enum members and features """
> -    role =3D 'member'
> -
> -    def __init__(self, name, info, ifcond=3DNone):
> -        assert isinstance(name, str)
> -        self.name =3D name
> -        self.info =3D info
> -        self.ifcond =3D ifcond or []
> -        self.defined_in =3D None
> -
> -    def set_defined_in(self, name):
> -        assert not self.defined_in
> -        self.defined_in =3D name
> -
> -    def check_clash(self, info, seen):
> -        cname =3D c_name(self.name)
> -        if cname in seen:
> -            raise QAPISemError(
> -                info,
> -                "%s collides with %s"
> -                % (self.describe(info), seen[cname].describe(info)))
> -        seen[cname] =3D self
> -
> -    def describe(self, info):
> -        role =3D self.role
> -        defined_in =3D self.defined_in
> -        assert defined_in
> -
> -        if defined_in.startswith('q_obj_'):
> -            # See QAPISchema._make_implicit_object_type() - reverse the
> -            # mapping there to create a nice human-readable description
> -            defined_in =3D defined_in[6:]
> -            if defined_in.endswith('-arg'):
> -                # Implicit type created for a command's dict 'data'
> -                assert role =3D=3D 'member'
> -                role =3D 'parameter'
> -            elif defined_in.endswith('-base'):
> -                # Implicit type created for a flat union's dict 'base'
> -                role =3D 'base ' + role
> -            else:
> -                # Implicit type created for a simple union's branch
> -                assert defined_in.endswith('-wrapper')
> -                # Unreachable and not implemented
> -                assert False
> -        elif defined_in.endswith('Kind'):
> -            # See QAPISchema._make_implicit_enum_type()
> -            # Implicit enum created for simple union's branches
> -            assert role =3D=3D 'value'
> -            role =3D 'branch'
> -        elif defined_in !=3D info.defn_name:
> -            return "%s '%s' of type '%s'" % (role, self.name, defined_in=
)
> -        return "%s '%s'" % (role, self.name)
> -
> -
> -class QAPISchemaEnumMember(QAPISchemaMember):
> -    role =3D 'value'
> -
> -
> -class QAPISchemaFeature(QAPISchemaMember):
> -    role =3D 'feature'
> -
> -
> -class QAPISchemaObjectTypeMember(QAPISchemaMember):
> -    def __init__(self, name, info, typ, optional, ifcond=3DNone):
> -        super().__init__(name, info, ifcond)
> -        assert isinstance(typ, str)
> -        assert isinstance(optional, bool)
> -        self._type_name =3D typ
> -        self.type =3D None
> -        self.optional =3D optional
> +class QAPISchemaAlternateType(QAPISchemaType):
> +    meta =3D 'alternate'
> +
> +    def __init__(self, name, info, doc, ifcond, features, variants):
> +        super().__init__(name, info, doc, ifcond, features)
> +        assert isinstance(variants, QAPISchemaObjectTypeVariants)
> +        assert variants.tag_member
> +        variants.set_defined_in(name)
> +        variants.tag_member.set_defined_in(self.name)
> +        self.variants =3D variants
>
>      def check(self, schema):
> -        assert self.defined_in
> -        self.type =3D schema.resolve_type(self._type_name, self.info,
> -                                        self.describe)
> +        super().check(schema)
> +        self.variants.tag_member.check(schema)
> +        # Not calling self.variants.check_clash(), because there's nothi=
ng
> +        # to clash with
> +        self.variants.check(schema, {})
> +        # Alternate branch names have no relation to the tag enum values=
;
> +        # so we have to check for potential name collisions ourselves.
> +        seen =3D {}
> +        types_seen =3D {}
> +        for v in self.variants.variants:
> +            v.check_clash(self.info, seen)
> +            qtype =3D v.type.alternate_qtype()
> +            if not qtype:
> +                raise QAPISemError(
> +                    self.info,
> +                    "%s cannot use %s"
> +                    % (v.describe(self.info), v.type.describe()))
> +            conflicting =3D set([qtype])
> +            if qtype =3D=3D 'QTYPE_QSTRING':
> +                if isinstance(v.type, QAPISchemaEnumType):
> +                    for m in v.type.members:
> +                        if m.name in ['on', 'off']:
> +                            conflicting.add('QTYPE_QBOOL')
> +                        if re.match(r'[-+0-9.]', m.name):
> +                            # lazy, could be tightened
> +                            conflicting.add('QTYPE_QNUM')
> +                else:
> +                    conflicting.add('QTYPE_QNUM')
> +                    conflicting.add('QTYPE_QBOOL')
> +            for qt in conflicting:
> +                if qt in types_seen:
> +                    raise QAPISemError(
> +                        self.info,
> +                        "%s can't be distinguished from '%s'"
> +                        % (v.describe(self.info), types_seen[qt]))
> +                types_seen[qt] =3D v.name
> +
> +    def connect_doc(self, doc=3DNone):
> +        super().connect_doc(doc)
> +        doc =3D doc or self.doc
> +        if doc:
> +            for v in self.variants.variants:
> +                doc.connect_member(v)
> +
> +    def c_type(self):
> +        return c_name(self.name) + pointer_suffix
> +
> +    def json_type(self):
> +        return 'value'
> +
> +    def visit(self, visitor):
> +        super().visit(visitor)
> +        visitor.visit_alternate_type(
> +            self.name, self.info, self.ifcond, self.features, self.varia=
nts)
>
>
>  class QAPISchemaObjectTypeVariants:
> @@ -613,6 +603,84 @@ class QAPISchemaObjectTypeVariants:
>              v.type.check_clash(info, dict(seen))
>
>
> +class QAPISchemaMember:
> +    """ Represents object members, enum members and features """
> +    role =3D 'member'
> +
> +    def __init__(self, name, info, ifcond=3DNone):
> +        assert isinstance(name, str)
> +        self.name =3D name
> +        self.info =3D info
> +        self.ifcond =3D ifcond or []
> +        self.defined_in =3D None
> +
> +    def set_defined_in(self, name):
> +        assert not self.defined_in
> +        self.defined_in =3D name
> +
> +    def check_clash(self, info, seen):
> +        cname =3D c_name(self.name)
> +        if cname in seen:
> +            raise QAPISemError(
> +                info,
> +                "%s collides with %s"
> +                % (self.describe(info), seen[cname].describe(info)))
> +        seen[cname] =3D self
> +
> +    def describe(self, info):
> +        role =3D self.role
> +        defined_in =3D self.defined_in
> +        assert defined_in
> +
> +        if defined_in.startswith('q_obj_'):
> +            # See QAPISchema._make_implicit_object_type() - reverse the
> +            # mapping there to create a nice human-readable description
> +            defined_in =3D defined_in[6:]
> +            if defined_in.endswith('-arg'):
> +                # Implicit type created for a command's dict 'data'
> +                assert role =3D=3D 'member'
> +                role =3D 'parameter'
> +            elif defined_in.endswith('-base'):
> +                # Implicit type created for a flat union's dict 'base'
> +                role =3D 'base ' + role
> +            else:
> +                # Implicit type created for a simple union's branch
> +                assert defined_in.endswith('-wrapper')
> +                # Unreachable and not implemented
> +                assert False
> +        elif defined_in.endswith('Kind'):
> +            # See QAPISchema._make_implicit_enum_type()
> +            # Implicit enum created for simple union's branches
> +            assert role =3D=3D 'value'
> +            role =3D 'branch'
> +        elif defined_in !=3D info.defn_name:
> +            return "%s '%s' of type '%s'" % (role, self.name, defined_in=
)
> +        return "%s '%s'" % (role, self.name)
> +
> +
> +class QAPISchemaEnumMember(QAPISchemaMember):
> +    role =3D 'value'
> +
> +
> +class QAPISchemaFeature(QAPISchemaMember):
> +    role =3D 'feature'
> +
> +
> +class QAPISchemaObjectTypeMember(QAPISchemaMember):
> +    def __init__(self, name, info, typ, optional, ifcond=3DNone):
> +        super().__init__(name, info, ifcond)
> +        assert isinstance(typ, str)
> +        assert isinstance(optional, bool)
> +        self._type_name =3D typ
> +        self.type =3D None
> +        self.optional =3D optional
> +
> +    def check(self, schema):
> +        assert self.defined_in
> +        self.type =3D schema.resolve_type(self._type_name, self.info,
> +                                        self.describe)
> +
> +
>  class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
>      role =3D 'branch'
>
> @@ -620,74 +688,6 @@ class QAPISchemaObjectTypeVariant(QAPISchemaObjectTy=
peMember):
>          super().__init__(name, info, typ, False, ifcond)
>
>
> -class QAPISchemaAlternateType(QAPISchemaType):
> -    meta =3D 'alternate'
> -
> -    def __init__(self, name, info, doc, ifcond, features, variants):
> -        super().__init__(name, info, doc, ifcond, features)
> -        assert isinstance(variants, QAPISchemaObjectTypeVariants)
> -        assert variants.tag_member
> -        variants.set_defined_in(name)
> -        variants.tag_member.set_defined_in(self.name)
> -        self.variants =3D variants
> -
> -    def check(self, schema):
> -        super().check(schema)
> -        self.variants.tag_member.check(schema)
> -        # Not calling self.variants.check_clash(), because there's nothi=
ng
> -        # to clash with
> -        self.variants.check(schema, {})
> -        # Alternate branch names have no relation to the tag enum values=
;
> -        # so we have to check for potential name collisions ourselves.
> -        seen =3D {}
> -        types_seen =3D {}
> -        for v in self.variants.variants:
> -            v.check_clash(self.info, seen)
> -            qtype =3D v.type.alternate_qtype()
> -            if not qtype:
> -                raise QAPISemError(
> -                    self.info,
> -                    "%s cannot use %s"
> -                    % (v.describe(self.info), v.type.describe()))
> -            conflicting =3D set([qtype])
> -            if qtype =3D=3D 'QTYPE_QSTRING':
> -                if isinstance(v.type, QAPISchemaEnumType):
> -                    for m in v.type.members:
> -                        if m.name in ['on', 'off']:
> -                            conflicting.add('QTYPE_QBOOL')
> -                        if re.match(r'[-+0-9.]', m.name):
> -                            # lazy, could be tightened
> -                            conflicting.add('QTYPE_QNUM')
> -                else:
> -                    conflicting.add('QTYPE_QNUM')
> -                    conflicting.add('QTYPE_QBOOL')
> -            for qt in conflicting:
> -                if qt in types_seen:
> -                    raise QAPISemError(
> -                        self.info,
> -                        "%s can't be distinguished from '%s'"
> -                        % (v.describe(self.info), types_seen[qt]))
> -                types_seen[qt] =3D v.name
> -
> -    def connect_doc(self, doc=3DNone):
> -        super().connect_doc(doc)
> -        doc =3D doc or self.doc
> -        if doc:
> -            for v in self.variants.variants:
> -                doc.connect_member(v)
> -
> -    def c_type(self):
> -        return c_name(self.name) + pointer_suffix
> -
> -    def json_type(self):
> -        return 'value'
> -
> -    def visit(self, visitor):
> -        super().visit(visitor)
> -        visitor.visit_alternate_type(
> -            self.name, self.info, self.ifcond, self.features, self.varia=
nts)
> -
> -
>  class QAPISchemaCommand(QAPISchemaEntity):
>      meta =3D 'command'
>
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


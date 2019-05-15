Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D7C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C5C216FD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C5C216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35167 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQrh9-0007oG-9K
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 07:03:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQrcc-0004ar-Uw
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQrcb-00059p-Dv
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:58:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hQrcX-000523-Vr; Wed, 15 May 2019 06:58:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 461E859454;
	Wed, 15 May 2019 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-220.ams2.redhat.com
	[10.36.116.220])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 113BF5D71E;
	Wed, 15 May 2019 10:58:47 +0000 (UTC)
Date: Wed, 15 May 2019 12:58:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190515105846.GB7508@localhost.localdomain>
References: <20190408143543.3982-1-kwolf@redhat.com>
	<20190408143543.3982-2-kwolf@redhat.com>
	<87d0ljjd3f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0ljjd3f.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 15 May 2019 10:58:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] qapi: Support features for structs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.04.2019 um 22:03 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Sometimes, the behaviour of QEMU changes compatibly, but without a
> > change in the QMP syntax (usually by allowing values or operations that
> > previously resulted in an error). QMP clients may still need to know
> > whether the extension is available.
> >
> > This allows to add a list of features to struct definitions that will be
> > made visible to QMP clients through schema introspection.
> 
> Only a first step, but that's okay.  I think we want to be able to tack
> features to all user-defined types, commands, and events.  Ideally even
> to members of enum and object types.
> 
> Use case: feature 'deprecated'.  We talked about ways to communicate
> deprecation to management applications.  Introspection was proposed.
> Feature 'deprecated' delivers it.

How does introspection solve the problem? It requires the client to
actively look for a deprecation instead of notifying it that it is using
something deprecated.

Do you expect libvirt to check a full list of all QMP commands, types,
etc. it ever uses against the schema after starting a VM or something
like that?

> >  def check_exprs(exprs):
> >      global all_names
> > @@ -986,8 +1007,10 @@ def check_exprs(exprs):
> >              normalize_members(expr['data'])
> >          elif 'struct' in expr:
> >              meta = 'struct'
> > -            check_keys(expr_elem, 'struct', ['data'], ['base', 'if'])
> > +            check_keys(expr_elem, 'struct', ['data'],
> > +                       ['base', 'if', 'features'])
> >              normalize_members(expr['data'])
> > +            normalize_features(expr.get('features'))
> >              struct_types[expr[meta]] = expr
> >          elif 'command' in expr:
> >              meta = 'command'
> > @@ -1126,10 +1149,12 @@ class QAPISchemaVisitor(object):
> >      def visit_array_type(self, name, info, ifcond, element_type):
> >          pass
> >  
> > -    def visit_object_type(self, name, info, ifcond, base, members, variants):
> > +    def visit_object_type(self, name, info, ifcond, base, members, variants,
> > +                          features):
> >          pass
> >  
> > -    def visit_object_type_flat(self, name, info, ifcond, members, variants):
> > +    def visit_object_type_flat(self, name, info, ifcond, members, variants,
> > +                               features):
> >          pass
> >  
> >      def visit_alternate_type(self, name, info, ifcond, variants):
> > @@ -1290,7 +1315,7 @@ class QAPISchemaArrayType(QAPISchemaType):
> >  
> >  class QAPISchemaObjectType(QAPISchemaType):
> >      def __init__(self, name, info, doc, ifcond,
> > -                 base, local_members, variants):
> > +                 base, local_members, variants, features):
> >          # struct has local_members, optional base, and no variants
> >          # flat union has base, variants, and no local_members
> >          # simple union has local_members, variants, and no base
> > @@ -1307,6 +1332,7 @@ class QAPISchemaObjectType(QAPISchemaType):
> >          self.local_members = local_members
> >          self.variants = variants
> >          self.members = None
> > +        self.features = features
> 
> I think this should be
> 
>            self.features = listify_cond(features)

Not quite, listify_cond() takes the condition it, not the entity that
contains it. But I can do this:

    self.features = features
    for f in self.features or []:
        f['if'] = listify_cond(f.get('if'))

> > @@ -1752,9 +1780,10 @@ class QAPISchema(object):
> >          base = expr.get('base')
> >          data = expr['data']
> >          ifcond = expr.get('if')
> > +        features = expr.get('features')
> >          self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond, base,
> >                                                self._make_members(data, info),
> > -                                              None))
> > +                                              None, features))
> 
> This is struct.  Okay.
> 
> For enum, we do:
> 
>         self._def_entity(QAPISchemaEnumType(
>             name, info, doc, ifcond,
>             self._make_enum_members(data), prefix))
> 
> where
> 
>     def _make_enum_members(self, values):
>         return [QAPISchemaMember(v['name'], v.get('if')) for v in values]
> 
> i.e. we represent the enum members as a list of QAPISchemaMember.
> 
> Features remain a list of dicts.
> 
> Any particular reason for not making them QAPISchemaMember?

I don't know what QAPISchemaMember is, and the documentation doesn't
tell me either. Its code looks related to generated C code, but features
don't generate C code.

I guess I could use it anyway and just never call any of its methods but
just use it to store things in attributes rather than dict entries, but
somehow creating an object and not making use of anything the class
provides feels like abuse.

Maybe I could be convinced otherwise if you suggest a docstring to add
to the QAPISchemaMember class that explains for which cases it is meant.

> > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> > index f7f2ca07e4..8909cecde4 100644
> > --- a/scripts/qapi/introspect.py
> > +++ b/scripts/qapi/introspect.py
> > @@ -188,11 +188,15 @@ const QLitObject %(c_name)s = %(c_string)s;
> >          self._gen_qlit('[' + element + ']', 'array', {'element-type': element},
> >                         ifcond)
> >  
> > -    def visit_object_type_flat(self, name, info, ifcond, members, variants):
> > +    def visit_object_type_flat(self, name, info, ifcond, members, variants,
> > +                               features):
> >          obj = {'members': [self._gen_member(m) for m in members]}
> >          if variants:
> >              obj.update(self._gen_variants(variants.tag_member.name,
> >                                            variants.variants))
> > +        if features:
> > +            obj['features'] = [ (f['name'], f) for f in features ]
> 
> Compare:
> 
>     def visit_enum_type(self, name, info, ifcond, members, prefix):
>         self._gen_qlit(name, 'enum',
>                        {'values':
>                         [(m.name, {'if': m.ifcond}) for m in members]},
>                        ifcond)
> 
> Since f is a dict, not an object, we need to use f['name'].
> 
> Since f is a dict, abusing it as the tuple's second element works.
> Cleaner: (f['name'], {'if': f['if']})

to_qlit() doesn't document what it expects for obj. From the code, if
it's a tuple, the first item is the content to generate and the second
item is a dict 'extra' that contains additional information. The 'if'
and 'comment' keys in it are used, the rest is silently ignored.

f is already a dict that satisfies the expectations of the to_qlit()
interface, so it feels unnecessary to duplicate it. But if we really
do want to duplicate it, it would look like this:

        if features:
            obj['features'] = [ (f['name'],
                                 {'if': f['if']} if 'if' in f else {})
                                for f in features ]

Or we could pull the condition one level up:

        if features:
            obj['features'] = [ (f['name'], {'if': f['if']})
                                if 'if' in f else f['name']
                                for f in features ]

I don't consider either way very readable compared to what I currently
have, but I'll make the change if you insist on it.

Kevin


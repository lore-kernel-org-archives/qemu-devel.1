Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB927C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813602070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813602070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37461 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQuI0-0002og-Ry
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 09:49:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQuGt-0002JG-0Q
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQuGr-0002L4-1x
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hQuGm-0002B4-Qk; Wed, 15 May 2019 09:48:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0029B30821AE;
	Wed, 15 May 2019 13:48:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7257F608A6;
	Wed, 15 May 2019 13:48:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EA9F711385E4; Wed, 15 May 2019 15:48:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190408143543.3982-1-kwolf@redhat.com>
	<20190408143543.3982-2-kwolf@redhat.com>
	<87d0ljjd3f.fsf@dusky.pond.sub.org>
	<20190515105846.GB7508@localhost.localdomain>
Date: Wed, 15 May 2019 15:48:29 +0200
In-Reply-To: <20190515105846.GB7508@localhost.localdomain> (Kevin Wolf's
	message of "Wed, 15 May 2019 12:58:46 +0200")
Message-ID: <87k1er6d76.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 15 May 2019 13:48:32 +0000 (UTC)
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 18.04.2019 um 22:03 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Sometimes, the behaviour of QEMU changes compatibly, but without a
>> > change in the QMP syntax (usually by allowing values or operations that
>> > previously resulted in an error). QMP clients may still need to know
>> > whether the extension is available.
>> >
>> > This allows to add a list of features to struct definitions that will be
>> > made visible to QMP clients through schema introspection.
>> 
>> Only a first step, but that's okay.  I think we want to be able to tack
>> features to all user-defined types, commands, and events.  Ideally even
>> to members of enum and object types.
>> 
>> Use case: feature 'deprecated'.  We talked about ways to communicate
>> deprecation to management applications.  Introspection was proposed.
>> Feature 'deprecated' delivers it.
>
> How does introspection solve the problem? It requires the client to
> actively look for a deprecation instead of notifying it that it is using
> something deprecated.
>
> Do you expect libvirt to check a full list of all QMP commands, types,
> etc. it ever uses against the schema after starting a VM or something
> like that?

I'm merely responding to demand.

Subject: Minutes of KVM Forum BoF on deprecating stuff
Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>

* We need to communicate "you're using something that is deprecated".
  How?  Right now, we print a deprecation message.  Okay when humans use
  QEMU directly in a shell.  However, when QEMU sits at the bottom of a
  software stack, the message will likely end up in a log file that is
  effectively write-only.
 
  - The one way to get people read log files is crashing their
    application.  A command line option --future could make QEMU crash
    right after printing a deprecation message.  This could help with
    finding use of deprecated features in a testing environment.

  - A less destructive way to grab people's attention is to make things
    run really, really slow: have QEMU go to sleep for a while after
    printing a deprecation message.
    
  - We can also pass the buck to the next layer up: emit a QMP event.

    Sadly, by the time the next layer connects to QMP, plenty of stuff
    already happened.  We'd have to buffer deprecation events somehow.

    What would libvirt do with such an event?  Log it, taint the domain,
    emit a (libvirt) event to pass it on to the next layer up.

  - A completely different idea is to have a configuratin linter.  To
    support doing this at the libvirt level, QEMU could expose "is
    deprecated" in interface introspection.  Feels feasible for QMP,
    where we already have sufficiently expressive introspection.  For
    CLI, we'd first have to provide that (but we want that anyway).

  - We might also want to dispay deprecation messages in QEMU's GUI
    somehow, or on serial consoles.

Second to last item.

>> >  def check_exprs(exprs):
>> >      global all_names
>> > @@ -986,8 +1007,10 @@ def check_exprs(exprs):
>> >              normalize_members(expr['data'])
>> >          elif 'struct' in expr:
>> >              meta = 'struct'
>> > -            check_keys(expr_elem, 'struct', ['data'], ['base', 'if'])
>> > +            check_keys(expr_elem, 'struct', ['data'],
>> > +                       ['base', 'if', 'features'])
>> >              normalize_members(expr['data'])
>> > +            normalize_features(expr.get('features'))
>> >              struct_types[expr[meta]] = expr
>> >          elif 'command' in expr:
>> >              meta = 'command'
>> > @@ -1126,10 +1149,12 @@ class QAPISchemaVisitor(object):
>> >      def visit_array_type(self, name, info, ifcond, element_type):
>> >          pass
>> >  
>> > -    def visit_object_type(self, name, info, ifcond, base, members, variants):
>> > +    def visit_object_type(self, name, info, ifcond, base, members, variants,
>> > +                          features):
>> >          pass
>> >  
>> > -    def visit_object_type_flat(self, name, info, ifcond, members, variants):
>> > +    def visit_object_type_flat(self, name, info, ifcond, members, variants,
>> > +                               features):
>> >          pass
>> >  
>> >      def visit_alternate_type(self, name, info, ifcond, variants):
>> > @@ -1290,7 +1315,7 @@ class QAPISchemaArrayType(QAPISchemaType):
>> >  
>> >  class QAPISchemaObjectType(QAPISchemaType):
>> >      def __init__(self, name, info, doc, ifcond,
>> > -                 base, local_members, variants):
>> > +                 base, local_members, variants, features):
>> >          # struct has local_members, optional base, and no variants
>> >          # flat union has base, variants, and no local_members
>> >          # simple union has local_members, variants, and no base
>> > @@ -1307,6 +1332,7 @@ class QAPISchemaObjectType(QAPISchemaType):
>> >          self.local_members = local_members
>> >          self.variants = variants
>> >          self.members = None
>> > +        self.features = features
>> 
>> I think this should be
>> 
>>            self.features = listify_cond(features)
>
> Not quite, listify_cond() takes the condition it, not the entity that
> contains it. But I can do this:
>
>     self.features = features
>     for f in self.features or []:
>         f['if'] = listify_cond(f.get('if'))
>
>> > @@ -1752,9 +1780,10 @@ class QAPISchema(object):
>> >          base = expr.get('base')
>> >          data = expr['data']
>> >          ifcond = expr.get('if')
>> > +        features = expr.get('features')
>> >          self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond, base,
>> >                                                self._make_members(data, info),
>> > -                                              None))
>> > +                                              None, features))
>> 
>> This is struct.  Okay.
>> 
>> For enum, we do:
>> 
>>         self._def_entity(QAPISchemaEnumType(
>>             name, info, doc, ifcond,
>>             self._make_enum_members(data), prefix))
>> 
>> where
>> 
>>     def _make_enum_members(self, values):
>>         return [QAPISchemaMember(v['name'], v.get('if')) for v in values]
>> 
>> i.e. we represent the enum members as a list of QAPISchemaMember.
>> 
>> Features remain a list of dicts.
>> 
>> Any particular reason for not making them QAPISchemaMember?
>
> I don't know what QAPISchemaMember is, and the documentation doesn't
> tell me either. Its code looks related to generated C code, but features
> don't generate C code.

QAPISchemaMember (and all of the QAPISchemaFOO) are not about generating
C code.

QAPISchema is the intermediate representation.  It uses the
QAPISchemaFOO to represent schema entities.

QAPISchemaMember is what enum members and object members have in common.
For Enum members, the common stuff is all there is, and that's why
they're represented as QAPISchemaMember.  Object members are more
complex, and that's why they're represented as
QAPISchemaObjectTypeMember, subtype of QAPISchemaMember.

QAPISchema provides three services:

* Looking up schema identities by name (public methods .lookup_entity(),
  .lookup_type()).

* Semantic checker (public method .check()).  Delegates checking the
  parts to the QAPISchemaFOO.  QAPISchemaMember.check_clash() is part of
  this.

* Walking the IR (public method .visit()).  Delegates walking parts to
  the QAPISchemaFOO.  QAPISchemaMember has no code for this purpose,
  because it has no parts to walk.

QAPISchema is related to generating C only by .visit() getting used by
the code generating C.

Some QAPISchemaFOO are additionally related by providing it helpers such
as QAPISchemaType.c_type().  QAPISchemaMember provides no such helper.

So, QAPISchemaMember serves just two purposes:

* Represent an enum member or (the common part of) an object type member

  Method __init__().

* Check this enum member or (the common part of) this object type member

  All the other code.

  What is checked?  Naming rules and name clashes with sibling members.

  The simplest case is actually the one closest to features: rejecting
  duplicate enum members (as in
  tests/qapi-schema/enum-clash-member.json).  See use of
  QAPISchemaMember.check_clash() in QAPISchemaEnumType.check().

  By the way, that case is missing from your tests :)

> I guess I could use it anyway and just never call any of its methods but
> just use it to store things in attributes rather than dict entries, but
> somehow creating an object and not making use of anything the class
> provides feels like abuse.

Add the test case, and you'll likely want to use its .check_clash()
method :)

> Maybe I could be convinced otherwise if you suggest a docstring to add
> to the QAPISchemaMember class that explains for which cases it is meant.

Yes, scripts/qapi/ is under-documented.  Technical debt.  We all try to
pay it back when we can, and avoid incurring more, but we don't always
succeed.

>> > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>> > index f7f2ca07e4..8909cecde4 100644
>> > --- a/scripts/qapi/introspect.py
>> > +++ b/scripts/qapi/introspect.py
>> > @@ -188,11 +188,15 @@ const QLitObject %(c_name)s = %(c_string)s;
>> >          self._gen_qlit('[' + element + ']', 'array', {'element-type': element},
>> >                         ifcond)
>> >  
>> > -    def visit_object_type_flat(self, name, info, ifcond, members, variants):
>> > +    def visit_object_type_flat(self, name, info, ifcond, members, variants,
>> > +                               features):
>> >          obj = {'members': [self._gen_member(m) for m in members]}
>> >          if variants:
>> >              obj.update(self._gen_variants(variants.tag_member.name,
>> >                                            variants.variants))
>> > +        if features:
>> > +            obj['features'] = [ (f['name'], f) for f in features ]
>> 
>> Compare:
>> 
>>     def visit_enum_type(self, name, info, ifcond, members, prefix):
>>         self._gen_qlit(name, 'enum',
>>                        {'values':
>>                         [(m.name, {'if': m.ifcond}) for m in members]},
>>                        ifcond)
>> 
>> Since f is a dict, not an object, we need to use f['name'].
>> 
>> Since f is a dict, abusing it as the tuple's second element works.
>> Cleaner: (f['name'], {'if': f['if']})
>
> to_qlit() doesn't document what it expects for obj. From the code, if
> it's a tuple, the first item is the content to generate and the second
> item is a dict 'extra' that contains additional information. The 'if'
> and 'comment' keys in it are used, the rest is silently ignored.

to_qlit()'s tuple case was added in commit d626b6c1ae7 to make it
generate #if.

    qapi-introspect: add preprocessor conditions to generated QLit
    
    This commit adds 'ifcond' conditions to top-level QLit objects.
    Future work will add them to object and enum type members, i.e. within
    QLit objects.
    
    Extend the QLit generator to_qlit() to accept (@obj, @cond) tuples in
    addition to just @obj.  The tuple causes the QLit generated for
    objects for @obj with #if/#endif conditions for @cond.

Simple, but ugly.  The tuple's second element was the if condition then.

Commit 8c643361eeb turned the tuple's second element into a dict with
keys 'if' and 'comment', for generating comments.  No other dict keys
occur.  Still simple, and still ugly.

Your patch adds other dict keys.  I'd prefer not to do that.

Your tacit criticism that code that's this ugly should at least explain
itself in comments is valid.

> f is already a dict that satisfies the expectations of the to_qlit()
> interface, so it feels unnecessary to duplicate it. But if we really
> do want to duplicate it, it would look like this:
>
>         if features:
>             obj['features'] = [ (f['name'],
>                                  {'if': f['if']} if 'if' in f else {})
>                                 for f in features ]
>
> Or we could pull the condition one level up:
>
>         if features:
>             obj['features'] = [ (f['name'], {'if': f['if']})
>                                 if 'if' in f else f['name']
>                                 for f in features ]
>
> I don't consider either way very readable compared to what I currently
> have, but I'll make the change if you insist on it.

Since to_qlit() treats

    (obj, {'if': None})
    (obj, {})
    obj

the same, the following should work:

            obj['features'] = [(f['name'], {'if': f.get('if')})
                               for f in features]


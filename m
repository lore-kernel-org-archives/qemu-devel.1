Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6521EC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 19:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790B820709
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 19:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNrpt0e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790B820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNiBE-00045h-8x
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 15:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNi9g-0003du-5B
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNi9Y-0006i9-Ot
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:52:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601495559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zW4atEBfSZP4yNYxK8+uppKU9+nEKjL66OTKk2CGST4=;
 b=bNrpt0e18fA1U3I8Ns6y/6hT2RoU48gRHvhAr9YRDFO6LoyYMEfmzGqXN4osiiCdQ5dgo3
 3NP2lmX5FCVyj+KInI0UHhKTKDhbbuYjOhMOFwHils10BAAz3flSJXocz95G3jOlS+Poos
 qNyCnOO0iZllVoCbH+K0r4aIYyMQ4r8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-rtAYAt9HPoCiScVZ1ZcklQ-1; Wed, 30 Sep 2020 15:52:17 -0400
X-MC-Unique: rtAYAt9HPoCiScVZ1ZcklQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C6F9CC06;
 Wed, 30 Sep 2020 19:52:16 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59B375C1CF;
 Wed, 30 Sep 2020 19:52:16 +0000 (UTC)
Date: Wed, 30 Sep 2020 15:52:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 41/46] qapi/introspect.py: create a typed 'Node' data
 structure
Message-ID: <20200930195215.GA3717385@habkost.net>
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-42-jsnow@redhat.com>
 <20200930183918.GY3717385@habkost.net>
 <4282f45c-b5e2-6c60-8010-a9858098f395@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4282f45c-b5e2-6c60-8010-a9858098f395@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 02:58:04PM -0400, John Snow wrote:
> On 9/30/20 2:39 PM, Eduardo Habkost wrote:
> > On Wed, Sep 30, 2020 at 12:31:45AM -0400, John Snow wrote:
> > > This replaces _make_tree with Node.__init__(), effectively. By creating
> > > it as a generic container, we can more accurately describe the exact
> > > nature of this particular Node.
> > > 
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   scripts/qapi/introspect.py | 77 +++++++++++++++++++-------------------
> > >   1 file changed, 38 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> > > index 43b6ba5df1f..86286e755ca 100644
> > > --- a/scripts/qapi/introspect.py
> > > +++ b/scripts/qapi/introspect.py
> > > @@ -12,11 +12,12 @@
> > >   from typing import (
> > >       Dict,
> > > +    Generic,
> > > +    Iterable,
> > >       List,
> > >       Optional,
> > >       Sequence,
> > > -    Tuple,
> > > -    Union,
> > > +    TypeVar,
> > >   )
> > >   from .common import (
> > > @@ -43,42 +44,42 @@
> > >   # The correct type for TreeNode is actually:
> > > -# Union[AnnotatedNode, List[TreeNode], Dict[str, TreeNode], str, bool]
> > > +# Union[Node[TreeNode], List[TreeNode], Dict[str, TreeNode], str, bool]
> > >   # but mypy does not support recursive types yet.
> > >   TreeNode = object
> > > +_NodeType = TypeVar('_NodeType', bound=TreeNode)
> > >   _DObject = Dict[str, object]
> > > -Extra = Dict[str, object]
> > > -AnnotatedNode = Tuple[TreeNode, Extra]
> > 
> > Do you have plans to make Node replace TreeNode completely?
> > 
> > I'd understand this patch as a means to reach that goal, but I'm
> > not sure the intermediate state of having both Node and TreeNode
> > types (that can be confused with each other) is desirable.
> > 
> 
> The problem is that _tree_to_qlit still accepts a broad array of types. The
> "TreeNode" comment above explains that those types are:
> 
> Node[TreeNode], List[TreeNode], Dict[str, TreeNode], str, bool
> 
> Three are containers, two are leaf values.
> of the containers, the Node container is special in that it houses
> explicitly one of the four other types (but never itself.)
> 
> Even if I somehow always enforced Node[T] heading into _tree_to_qlit, I
> would still need to describe what 'T' is, which is another recursive type
> that I cannot exactly describe with mypy's current descriptive power:
> 
> INNER_TYPE = List[Node[INNER_TYPE]], Dict[str, Node[INNER_TYPE]], str, bool
> 
> And that's not really a huge win, or indeed any different to the existing
> TreeNode being an "object".
> 
> So ... no, I felt like I was going to stop here, where we have
> fundamentally:
> 
> 1. Undecorated nodes (list, dict, str, bool) ("TreeNode")
> 2. Decorated nodes (Node[T])                 ("Node")
> 
> which leads to the question: Why bother swapping Tuple for Node at that
> point?
> 
> My answer is simply that having a strong type name allows us to distinguish
> this from garden-variety Tuples that might sneak in for other reasons in
> other data types.

Would:
  AnnotatedNode = NewType('AnnotatedNode', Tuple[TreeNode, Extra])
be enough, then?

> 
> Maybe we want a different nomenclature though, like Node vs AnnotatedNode?

Yes, I believe having a more explicit name would be better.


> 
> --js
> 
> (Also: 'TreeNode' is just an alias for object, it doesn't mean anything
> grammatically. I could just as soon erase it entirely if you felt it
> provided no value. It doesn't enforce that it only takes objects we declared
> were 'TreeNode' types, for instance. It's just a preprocessor name,
> basically.)
> 
> > > -def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
> > > -               comment: Optional[str] = None) -> AnnotatedNode:
> > > -    extra: Extra = {
> > > -        'if': ifcond,
> > > -        'comment': comment,
> > > -    }
> > > -    return (obj, extra)
> > > +class Node(Generic[_NodeType]):
> > > +    """
> > > +    Node generally contains a SchemaInfo-like type (as a dict),
> > > +    But it also used to wrap comments/ifconds around leaf value types.
> > > +    """
> > > +    # Remove after 3.7 adds @dataclass:
> > > +    # pylint: disable=too-few-public-methods
> > > +    def __init__(self, data: _NodeType, ifcond: Iterable[str],
> > > +                 comment: Optional[str] = None):
> > > +        self.data = data
> > > +        self.comment: Optional[str] = comment
> > > +        self.ifcond: Sequence[str] = tuple(ifcond)
> > > -def _tree_to_qlit(obj: TreeNode,
> > > -                  level: int = 0,
> > > +def _tree_to_qlit(obj: TreeNode, level: int = 0,
> > >                     suppress_first_indent: bool = False) -> str:
> > >       def indent(level: int) -> str:
> > >           return level * 4 * ' '
> > > -    if isinstance(obj, tuple):
> > > -        ifobj, extra = obj
> > > -        ifcond = extra.get('if')
> > > -        comment = extra.get('comment')
> > > +    if isinstance(obj, Node):
> > >           ret = ''
> > > -        if comment:
> > > -            ret += indent(level) + '/* %s */\n' % comment
> > > -        if ifcond:
> > > -            ret += gen_if(ifcond)
> > > -        ret += _tree_to_qlit(ifobj, level)
> > > -        if ifcond:
> > > -            ret += '\n' + gen_endif(ifcond)
> > > +        if obj.comment:
> > > +            ret += indent(level) + '/* %s */\n' % obj.comment
> > > +        if obj.ifcond:
> > > +            ret += gen_if(obj.ifcond)
> > > +        ret += _tree_to_qlit(obj.data, level)
> > > +        if obj.ifcond:
> > > +            ret += '\n' + gen_endif(obj.ifcond)
> > >           return ret
> > >       ret = ''
> > > @@ -125,7 +126,7 @@ def __init__(self, prefix: str, unmask: bool):
> > >               ' * QAPI/QMP schema introspection', __doc__)
> > >           self._unmask = unmask
> > >           self._schema: Optional[QAPISchema] = None
> > > -        self._trees: List[AnnotatedNode] = []
> > > +        self._trees: List[Node[_DObject]] = []
> > >           self._used_types: List[QAPISchemaType] = []
> > >           self._name_map: Dict[str, str] = {}
> > >           self._genc.add(mcgen('''
> > > @@ -192,9 +193,8 @@ def _use_type(self, typ: QAPISchemaType) -> str:
> > >       @classmethod
> > >       def _gen_features(cls,
> > > -                      features: List[QAPISchemaFeature]
> > > -                      ) -> List[AnnotatedNode]:
> > > -        return [_make_tree(f.name, f.ifcond) for f in features]
> > > +                      features: List[QAPISchemaFeature]) -> List[Node[str]]:
> > > +        return [Node(f.name, f.ifcond) for f in features]
> > >       def _gen_tree(self, name: str, mtype: str, obj: _DObject,
> > >                     ifcond: List[str],
> > > @@ -210,10 +210,10 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
> > >           obj['meta-type'] = mtype
> > >           if features:
> > >               obj['features'] = self._gen_features(features)
> > > -        self._trees.append(_make_tree(obj, ifcond, comment))
> > > +        self._trees.append(Node(obj, ifcond, comment))
> > >       def _gen_member(self,
> > > -                    member: QAPISchemaObjectTypeMember) -> AnnotatedNode:
> > > +                    member: QAPISchemaObjectTypeMember) -> Node[_DObject]:
> > >           obj: _DObject = {
> > >               'name': member.name,
> > >               'type': self._use_type(member.type)
> > > @@ -222,19 +222,19 @@ def _gen_member(self,
> > >               obj['default'] = None
> > >           if member.features:
> > >               obj['features'] = self._gen_features(member.features)
> > > -        return _make_tree(obj, member.ifcond)
> > > +        return Node(obj, member.ifcond)
> > >       def _gen_variants(self, tag_name: str,
> > >                         variants: List[QAPISchemaVariant]) -> _DObject:
> > >           return {'tag': tag_name,
> > >                   'variants': [self._gen_variant(v) for v in variants]}
> > > -    def _gen_variant(self, variant: QAPISchemaVariant) -> AnnotatedNode:
> > > +    def _gen_variant(self, variant: QAPISchemaVariant) -> Node[_DObject]:
> > >           obj: _DObject = {
> > >               'case': variant.name,
> > >               'type': self._use_type(variant.type)
> > >           }
> > > -        return _make_tree(obj, variant.ifcond)
> > > +        return Node(obj, variant.ifcond)
> > >       def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
> > >                              json_type: str) -> None:
> > > @@ -245,8 +245,7 @@ def visit_enum_type(self, name: str, info: QAPISourceInfo,
> > >                           members: List[QAPISchemaEnumMember],
> > >                           prefix: Optional[str]) -> None:
> > >           self._gen_tree(name, 'enum',
> > > -                       {'values': [_make_tree(m.name, m.ifcond, None)
> > > -                                   for m in members]},
> > > +                       {'values': [Node(m.name, m.ifcond) for m in members]},
> > >                          ifcond, features)
> > >       def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
> > > @@ -274,9 +273,9 @@ def visit_alternate_type(self, name: str, info: QAPISourceInfo,
> > >                                variants: QAPISchemaVariants) -> None:
> > >           self._gen_tree(name, 'alternate',
> > >                          {'members': [
> > > -                           _make_tree({'type': self._use_type(m.type)},
> > > -                                      m.ifcond, None)
> > > -                           for m in variants.variants]},
> > > +                           Node({'type': self._use_type(m.type)}, m.ifcond)
> > > +                           for m in variants.variants
> > > +                       ]},
> > >                          ifcond, features)
> > >       def visit_command(self, name: str, info: QAPISourceInfo, ifcond: List[str],
> > > -- 
> > > 2.26.2
> > > 
> > 
> 

-- 
Eduardo



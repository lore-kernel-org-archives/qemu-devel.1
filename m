Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C67C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F7C2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4Y+Opcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F7C2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNgnF-0007rg-VM
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 14:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNgmS-0007Iw-LT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNgmP-0007vI-Lc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:24:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601490279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tT3tP8SGG+FQYfaGNHCR8aagEHp9A898lHOh9e+9a8Y=;
 b=I4Y+OpcvaHI18aBxPfJkteFOT/LilwHr4P6hR+/2tF8pHyjetWcx+fzYrDARsABWl0O52o
 EjSd06CSkdEBTc2bIMyyWjI49le5ffWVdEvFwB1vSVOG/iVrEGCYY16KH+ODUSovvMgK2f
 M9qS3MnXtO6IcVrtIH6EDEi8yKmcHCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-5lz_U2PRO-WSrt2T1ONt1g-1; Wed, 30 Sep 2020 14:24:10 -0400
X-MC-Unique: 5lz_U2PRO-WSrt2T1ONt1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99A941007B00;
 Wed, 30 Sep 2020 18:24:09 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC4E5C1CF;
 Wed, 30 Sep 2020 18:24:09 +0000 (UTC)
Date: Wed, 30 Sep 2020 14:24:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 39/46] qapi/introspect.py: Unify return type of
 _make_tree()
Message-ID: <20200930182408.GV3717385@habkost.net>
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-40-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200930043150.1454766-40-jsnow@redhat.com>
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

On Wed, Sep 30, 2020 at 12:31:43AM -0400, John Snow wrote:
> Returning a *something* or a Tuple of *something* is hard to accurately
> type. Let's just always return a tuple for structural consistency.
> 
> Instances of the 'TreeNode' type can be replaced with the slightly more
> specific 'AnnotatedNode' type.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

So, the only place where this seems to make a difference is
_tree_to_qlit().

We just need to prove that
  _tree_to_qlit(o, ...)
will have exactly the same result as
  _tree_to_qlit((o, None), ...).

For reference, this is the beginning of _tree_to_qlit():

| def _tree_to_qlit(obj: TreeNode,
|                   level: int = 0,
|                   suppress_first_indent: bool = False) -> str:
| 
|     def indent(level: int) -> str:
|         return level * 4 * ' '
| 
|     if isinstance(obj, tuple):
|         ifobj, extra = obj

`obj` is the return value of _make_tree()

`ifobj` is the original `obj` argument to _make_tree().

|         ifcond = extra.get('if')

ifcond will be None.

|         comment = extra.get('comment')

comment will be None

|         ret = ''
|         if comment:
|             ret += indent(level) + '/* %s */\n' % comment

nop

|         if ifcond:
|             ret += gen_if(ifcond)

nop

|         ret += _tree_to_qlit(ifobj, level)

ret will be '', so this is equivalent to:

  ret = _tree_to_qlit(ifobj, level)

which is almost good.

The only difference seems to that suppress_first_indent=True will
be ignored.  We should pass suppress_first_indent as argument in
the recursive call above, just in case.

The existing code will behave weirdly if there are comments or
conditions and suppress_first_indent=True, but I suggest we try
to address this issue later.

|         if ifcond:
|             ret += '\n' + gen_endif(ifcond)

nop

|         return ret


> ---
>  scripts/qapi/introspect.py | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 5cbdc7414bd..1c3ba41f1dc 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -53,14 +53,12 @@
>  
>  def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
>                 extra: Optional[Extra] = None
> -               ) -> Union[TreeNode, AnnotatedNode]:
> +               ) -> AnnotatedNode:
>      if extra is None:
>          extra = {}
>      if ifcond:
>          extra['if'] = ifcond
> -    if extra:
> -        return (obj, extra)
> -    return obj
> +    return (obj, extra)
>  
>  
>  def _tree_to_qlit(obj: TreeNode,
> @@ -128,7 +126,7 @@ def __init__(self, prefix: str, unmask: bool):
>              ' * QAPI/QMP schema introspection', __doc__)
>          self._unmask = unmask
>          self._schema: Optional[QAPISchema] = None
> -        self._trees: List[TreeNode] = []
> +        self._trees: List[AnnotatedNode] = []
>          self._used_types: List[QAPISchemaType] = []
>          self._name_map: Dict[str, str] = {}
>          self._genc.add(mcgen('''
> @@ -195,7 +193,8 @@ def _use_type(self, typ: QAPISchemaType) -> str:
>  
>      @classmethod
>      def _gen_features(cls,
> -                      features: List[QAPISchemaFeature]) -> List[TreeNode]:
> +                      features: List[QAPISchemaFeature]
> +                      ) -> List[AnnotatedNode]:
>          return [_make_tree(f.name, f.ifcond) for f in features]
>  
>      def _gen_tree(self, name: str, mtype: str, obj: _DObject,
> @@ -215,7 +214,7 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
>          self._trees.append(_make_tree(obj, ifcond, extra))
>  
>      def _gen_member(self,
> -                    member: QAPISchemaObjectTypeMember) -> TreeNode:
> +                    member: QAPISchemaObjectTypeMember) -> AnnotatedNode:
>          obj: _DObject = {
>              'name': member.name,
>              'type': self._use_type(member.type)
> @@ -231,7 +230,7 @@ def _gen_variants(self, tag_name: str,
>          return {'tag': tag_name,
>                  'variants': [self._gen_variant(v) for v in variants]}
>  
> -    def _gen_variant(self, variant: QAPISchemaVariant) -> TreeNode:
> +    def _gen_variant(self, variant: QAPISchemaVariant) -> AnnotatedNode:
>          obj: _DObject = {
>              'case': variant.name,
>              'type': self._use_type(variant.type)
> -- 
> 2.26.2
> 

-- 
Eduardo



Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885C0C47429
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C809207C3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBYQ6iMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C809207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfq3-0007vq-AF
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNfnf-0005H6-PH
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNfne-0001ne-1f
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:21:55 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601486513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJp+jj6L1g+0m7V1zCIPAnf+661oVAR5VynrzU31F6c=;
 b=eBYQ6iMZklz1Phte0XhEaS78rQpk4TWQOBO51l2gWFBUhaRJKwodaeQoYgfV0e8Pa6CeRa
 pAt0sA9nTPqdbW6oyzCrrVsmYb/L6qT8MIArrnwPSfpz7KL7Q/31vBNnJDEcIcOaZJhrGV
 8ECVdwnKvlplCNNaB1xeAUxObsuqyFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-iJUBDa0cN4GLxTuZBrJj-Q-1; Wed, 30 Sep 2020 13:21:49 -0400
X-MC-Unique: iJUBDa0cN4GLxTuZBrJj-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D77BD802B7F;
 Wed, 30 Sep 2020 17:21:48 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9628B10013C4;
 Wed, 30 Sep 2020 17:21:48 +0000 (UTC)
Date: Wed, 30 Sep 2020 13:21:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 38/46] qapi/introspect.py: add _gen_features helper
Message-ID: <20200930172147.GT3717385@habkost.net>
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-39-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200930043150.1454766-39-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On Wed, Sep 30, 2020 at 12:31:42AM -0400, John Snow wrote:
> _make_tree might receive a dict or some other type. Adding features
> information should arguably be performed by the caller at such a time
> when we know the type of the object and don't have to re-interrogate it.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/introspect.py | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index f7de3953391..5cbdc7414bd 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -52,16 +52,12 @@
>  
>  
>  def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
> -               features: List[QAPISchemaFeature],
>                 extra: Optional[Extra] = None
>                 ) -> Union[TreeNode, AnnotatedNode]:
>      if extra is None:
>          extra = {}
>      if ifcond:
>          extra['if'] = ifcond
> -    if features:
> -        assert isinstance(obj, dict)
> -        obj['features'] = [(f.name, {'if': f.ifcond}) for f in features]

Now the reason for moving this code outside _make_tree() is more
obvious due to the type annotations.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

>      if extra:
>          return (obj, extra)
>      return obj
> @@ -197,6 +193,11 @@ def _use_type(self, typ: QAPISchemaType) -> str:
>              return '[' + self._use_type(typ.element_type) + ']'
>          return self._name(typ.name)
>  
> +    @classmethod
> +    def _gen_features(cls,
> +                      features: List[QAPISchemaFeature]) -> List[TreeNode]:
> +        return [_make_tree(f.name, f.ifcond) for f in features]
> +
>      def _gen_tree(self, name: str, mtype: str, obj: _DObject,
>                    ifcond: List[str],
>                    features: Optional[List[QAPISchemaFeature]]) -> None:
> @@ -209,7 +210,9 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
>              name = self._name(name)
>          obj['name'] = name
>          obj['meta-type'] = mtype
> -        self._trees.append(_make_tree(obj, ifcond, features, extra))
> +        if features:
> +            obj['features'] = self._gen_features(features)
> +        self._trees.append(_make_tree(obj, ifcond, extra))
>  
>      def _gen_member(self,
>                      member: QAPISchemaObjectTypeMember) -> TreeNode:
> @@ -219,7 +222,9 @@ def _gen_member(self,
>          }
>          if member.optional:
>              obj['default'] = None
> -        return _make_tree(obj, member.ifcond, member.features)
> +        if member.features:
> +            obj['features'] = self._gen_features(member.features)
> +        return _make_tree(obj, member.ifcond)
>  
>      def _gen_variants(self, tag_name: str,
>                        variants: List[QAPISchemaVariant]) -> _DObject:
> @@ -231,7 +236,7 @@ def _gen_variant(self, variant: QAPISchemaVariant) -> TreeNode:
>              'case': variant.name,
>              'type': self._use_type(variant.type)
>          }
> -        return _make_tree(obj, variant.ifcond, None)
> +        return _make_tree(obj, variant.ifcond)
>  
>      def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
>                             json_type: str) -> None:
> -- 
> 2.26.2
> 

-- 
Eduardo



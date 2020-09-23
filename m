Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6427C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B10920791
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImWQrV0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B10920791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7l8-0007FX-9H
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL7kG-00066l-1u
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL7kE-0002Yt-60
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600878948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrN1XqWRGQr8wdGWUf8FHKMS/h9V4u6EdZoOKJ8Nzgw=;
 b=ImWQrV0Q2n82Kc+pD3LBPt0q3VaFgkbMrcJGb0sGSNTRIm9eSvnwQg4c2nCMxlgzh+Nzd1
 /Uaw+TS3uhqOiBa8UXv7gzHfSs8LyN3Zcow5muTE874w1tfXgv24LZoXxNTorTYMMITy/D
 xxptdpxboDChmXFty2T+2ULHFeIJ0kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-TgWjFQH4O5CNKeNHbdkVRQ-1; Wed, 23 Sep 2020 12:35:29 -0400
X-MC-Unique: TgWjFQH4O5CNKeNHbdkVRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8950E801ABC;
 Wed, 23 Sep 2020 16:35:28 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC3460BF1;
 Wed, 23 Sep 2020 16:35:27 +0000 (UTC)
Date: Wed, 23 Sep 2020 12:35:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 31/38] qapi/introspect.py: add _gen_features helper
Message-ID: <20200923163526.GS3312949@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-32-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-32-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:00:54PM -0400, John Snow wrote:
> _make_tree doesn't know if it is receiving an object or some other type;
> adding features information should arguably be performed by the caller.
> 
> This will help us refactor _make_tree more gracefully in the next patch.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/introspect.py | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 41ca8afc67..e1edd0b179 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -10,7 +10,7 @@
>  See the COPYING file in the top-level directory.
>  """
>  
> -from typing import (NamedTuple, Optional, Sequence)
> +from typing import (NamedTuple, List, Optional, Sequence)
>  
>  from .common import (
>      c_name,
> @@ -20,7 +20,7 @@
>  )
>  from .gen import QAPISchemaMonolithicCVisitor
>  from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
> -                     QAPISchemaType)
> +                     QAPISchemaFeature, QAPISchemaType)
>  
>  
>  class Extra(NamedTuple):
> @@ -31,12 +31,10 @@ class Extra(NamedTuple):
>      ifcond: Sequence[str] = tuple()
>  
>  
> -def _make_tree(obj, ifcond, features,
> +def _make_tree(obj, ifcond,
>                 extra: Optional[Extra] = None):
>      comment = extra.comment if extra else None
>      extra = Extra(comment, ifcond)

I believe these two lines above should be removed, as suggested
in patch 30, but let's ignore that for now.

> -    if features:
> -        obj['features'] = [(f.name, Extra(None, f.ifcond)) for f in features]

I can't say I understand completely why moving these two lines
outside _make_tree() is useful, but if it makes the cleanup work
you did easier, I trust this is the right thing to do.  The
changes look correct.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>


>      return (obj, extra)
>  
>  
> @@ -169,6 +167,10 @@ def _use_type(self, typ):
>              return '[' + self._use_type(typ.element_type) + ']'
>          return self._name(typ.name)
>  
> +    @classmethod
> +    def _gen_features(cls, features: List[QAPISchemaFeature]):
> +        return [_make_tree(f.name, f.ifcond) for f in features]
> +
>      def _gen_tree(self, name, mtype, obj, ifcond, features):
>          extra = None
>          if mtype not in ('command', 'event', 'builtin', 'array'):
> @@ -179,13 +181,17 @@ def _gen_tree(self, name, mtype, obj, ifcond, features):
>              name = self._name(name)
>          obj['name'] = name
>          obj['meta-type'] = mtype
> -        self._trees.append(_make_tree(obj, ifcond, features, extra))
> +        if features:
> +            obj['features'] = self._gen_features(features)
> +        self._trees.append(_make_tree(obj, ifcond, extra))
>  
>      def _gen_member(self, member):
>          obj = {'name': member.name, 'type': self._use_type(member.type)}
>          if member.optional:
>              obj['default'] = None
> -        return _make_tree(obj, member.ifcond, member.features)
> +        if member.features:
> +            obj['features'] = self._gen_features(member.features)
> +        return _make_tree(obj, member.ifcond)
>  
>      def _gen_variants(self, tag_name, variants):
>          return {'tag': tag_name,
> @@ -193,7 +199,7 @@ def _gen_variants(self, tag_name, variants):
>  
>      def _gen_variant(self, variant):
>          obj = {'case': variant.name, 'type': self._use_type(variant.type)}
> -        return _make_tree(obj, variant.ifcond, None)
> +        return _make_tree(obj, variant.ifcond)
>  
>      def visit_builtin_type(self, name, info, json_type):
>          self._gen_tree(name, 'builtin', {'json-type': json_type}, [], None)
> -- 
> 2.26.2
> 

-- 
Eduardo



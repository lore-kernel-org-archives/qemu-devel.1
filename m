Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB7AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432052065E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZKs0sFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432052065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7a7-0003WT-BT
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL7Oj-0006cD-Sr
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL7Oh-0006ol-WB
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M9Im8loTRqLDhDj0v5PJwfhSxrrv52LMDuGzeP62qKQ=;
 b=TZKs0sFEj7pcegoZ6wtaNZxB1Eqbbg1YWFc7FRJVwGRWBhLJBFDgIfcXMDqcCp7QWDqW/D
 8jvaHc7Z2uexhZ7TKWewvoLxYtRi5HzRVioebHxVrbQO4YFL8GnW4GSfW0hR9VbdzhpOT9
 AKcMCOdmU9y6PGGBDJMtQkDRr5cnir4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-BHi_x72QN4COnJk8FuvPrA-1; Wed, 23 Sep 2020 12:13:08 -0400
X-MC-Unique: BHi_x72QN4COnJk8FuvPrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2D1585B66C;
 Wed, 23 Sep 2020 16:13:07 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F5405D990;
 Wed, 23 Sep 2020 16:13:07 +0000 (UTC)
Date: Wed, 23 Sep 2020 12:13:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 30/38] qapi/introspect.py: Add a typed 'extra' structure
Message-ID: <20200923161306.GR3312949@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-31-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-31-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Tue, Sep 22, 2020 at 05:00:53PM -0400, John Snow wrote:
> Typing arbitrarily shaped dicts with mypy is difficult prior to Python
> 3.8; using explicit structures is nicer.
> 
> Since we always define an Extra type now, the return type of _make_tree
> simplifies and always returns the tuple.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/introspect.py | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 

Here I'm confused by both the original code and the new code.

I will try to review as a refactoring of existing code, but I'll
have suggestions for follow ups:

> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index b036fcf9ce..41ca8afc67 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -10,6 +10,8 @@
>  See the COPYING file in the top-level directory.
>  """
>  
> +from typing import (NamedTuple, Optional, Sequence)
> +
>  from .common import (
>      c_name,
>      gen_endif,
> @@ -21,16 +23,21 @@
>                       QAPISchemaType)
>  
>  
> -def _make_tree(obj, ifcond, features, extra=None):
> -    if extra is None:
> -        extra = {}
> -    if ifcond:
> -        extra['if'] = ifcond
> +class Extra(NamedTuple):
> +    """
> +    Extra contains data that isn't intended for output by introspection.
> +    """
> +    comment: Optional[str] = None
> +    ifcond: Sequence[str] = tuple()
> +
> +
> +def _make_tree(obj, ifcond, features,
> +               extra: Optional[Extra] = None):
> +    comment = extra.comment if extra else None
> +    extra = Extra(comment, ifcond)

Here we have one big difference: now `extra` is being recreated,
and all fields except `extra.comment` are being ignored.  On the
original version, all fields in `extra` were being kept.  This
makes the existence of the `extra` argument pointless.

If you are going through the trouble of changing the type of the
4rd argument to _make_tree(), this seems more obvious:

  diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
  index 41ca8afc672..c62af94c9ad 100644
  --- a/scripts/qapi/introspect.py
  +++ b/scripts/qapi/introspect.py
  @@ -32,8 +32,7 @@ class Extra(NamedTuple):
   
   
   def _make_tree(obj, ifcond, features,
  -               extra: Optional[Extra] = None):
  -    comment = extra.comment if extra else None
  +               comment: Optional[str] = None):
       extra = Extra(comment, ifcond)
       if features:
           obj['features'] = [(f.name, Extra(None, f.ifcond)) for f in features]
  @@ -170,16 +169,16 @@ const QLitObject %(c_name)s = %(c_string)s;
           return self._name(typ.name)
   
       def _gen_tree(self, name, mtype, obj, ifcond, features):
  -        extra = None
  +        comment = None
           if mtype not in ('command', 'event', 'builtin', 'array'):
               if not self._unmask:
                   # Output a comment to make it easy to map masked names
                   # back to the source when reading the generated output.
  -                extra = Extra(comment=f'"{self._name(name)}" = {name}')
  +                comment = f'"{self._name(name)}" = {name}'
               name = self._name(name)
           obj['name'] = name
           obj['meta-type'] = mtype
  -        self._trees.append(_make_tree(obj, ifcond, features, extra))
  +        self._trees.append(_make_tree(obj, ifcond, features, comment))
   
       def _gen_member(self, member):
           obj = {'name': member.name, 'type': self._use_type(member.type)}

I understand you're trying to just make minimal refactoring, and I
don't think this should block your cleanup series.  So:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>


>      if features:
> -        obj['features'] = [(f.name, {'if': f.ifcond}) for f in features]
> -    if extra:
> -        return (obj, extra)
> -    return obj
> +        obj['features'] = [(f.name, Extra(None, f.ifcond)) for f in features]
> +    return (obj, extra)
>  
>  
>  def _tree_to_qlit(obj, level=0, suppress_first_indent=False):
> @@ -40,8 +47,8 @@ def indent(level):
>  
>      if isinstance(obj, tuple):
>          ifobj, extra = obj
> -        ifcond = extra.get('if')
> -        comment = extra.get('comment')
> +        ifcond = extra.ifcond
> +        comment = extra.comment
>          ret = ''
>          if comment:
>              ret += indent(level) + '/* %s */\n' % comment
> @@ -168,7 +175,7 @@ def _gen_tree(self, name, mtype, obj, ifcond, features):
>              if not self._unmask:
>                  # Output a comment to make it easy to map masked names
>                  # back to the source when reading the generated output.
> -                extra = {'comment': '"%s" = %s' % (self._name(name), name)}
> +                extra = Extra(comment=f'"{self._name(name)}" = {name}')
>              name = self._name(name)
>          obj['name'] = name
>          obj['meta-type'] = mtype
> -- 
> 2.26.2
> 

-- 
Eduardo



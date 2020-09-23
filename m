Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B7DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3651A20888
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbT242R3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3651A20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAkn-00066I-S6
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLAet-0001id-5p
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLAer-0001Cp-Ds
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600890148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqnMv37cHLefYDKWCqTKJMcoGBNmSXZCMIVZfaDUZtk=;
 b=FbT242R3hf4G0z4WoKCLMPY0URriqPmtHVCtpBtLgHgWJv0rdUyUeRpbfpu+K+70fzWXOj
 IFJ7ZuFde2u/Ovum4p1uRNabqv+vXFPHInc4NJkaXOefhdkt9IfGpZNLyDJeerchYNXBvi
 7x6o0zDtcKXy6q4FolPY4Moz4Tb1JAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-XbNMI44fMWu_v0ge2HLt-w-1; Wed, 23 Sep 2020 15:42:26 -0400
X-MC-Unique: XbNMI44fMWu_v0ge2HLt-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6D111074652;
 Wed, 23 Sep 2020 19:42:25 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78BA11002C03;
 Wed, 23 Sep 2020 19:42:25 +0000 (UTC)
Date: Wed, 23 Sep 2020 15:42:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 03/16] qapi/expr.py: constrain incoming expression types
Message-ID: <20200923194224.GD3312949@habkost.net>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-4-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-4-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:13:00PM -0400, John Snow wrote:
> mypy does not know the types of values stored in Dicts that masquerade
> as objects. Help the type checker out by constraining the type.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/expr.py | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index 1872a8a3cc..f6b55a87c1 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -15,9 +15,17 @@
>  # See the COPYING file in the top-level directory.
>  
>  import re
> +from typing import MutableMapping, Optional
>  
>  from .common import c_name
>  from .error import QAPISemError
> +from .parser import QAPIDoc
> +from .source import QAPISourceInfo
> +
> +
> +# Expressions in their raw form are JSON-like structures with arbitrary forms.
> +# Minimally, their top-level form must be a mapping of strings to values.
> +Expression = MutableMapping[str, object]
>  
>  
>  # Names must be letters, numbers, -, and _.  They must start with letter,
> @@ -280,9 +288,20 @@ def check_event(expr, info):
>  
>  def check_exprs(exprs):
>      for expr_elem in exprs:
> -        expr = expr_elem['expr']
> -        info = expr_elem['info']
> -        doc = expr_elem.get('doc')
> +        # Expression
> +        assert isinstance(expr_elem['expr'], dict)
> +        expr: Expression = expr_elem['expr']
> +        for key in expr.keys():
> +            assert isinstance(key, str)

mypy doesn't seem to require the key type asserts, on my testing.

> +
> +        # QAPISourceInfo
> +        assert isinstance(expr_elem['info'], QAPISourceInfo)
> +        info: QAPISourceInfo = expr_elem['info']
> +
> +        # Optional[QAPIDoc]
> +        tmp = expr_elem.get('doc')
> +        assert tmp is None or isinstance(tmp, QAPIDoc)
> +        doc: Optional[QAPIDoc] = tmp

Do you need a separate variable here?  This seems to work too:

        doc = expr_elem.get('doc')
        assert doc is None or isinstance(doc, QAPIDoc)

after the assert, mypy will infer the type of doc to be
Optional[QAPIDoc].

None of this should block a useful 120-patch cleanup series, so:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

>  
>          if 'include' in expr:
>              continue
> -- 
> 2.26.2
> 

-- 
Eduardo



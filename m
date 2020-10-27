Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D8C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAD6207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co2JCVu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAD6207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXWS1-0004Ri-Tb
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 17:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXWQB-0003ZG-JY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXWQ7-00046z-Vj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603833738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLeGWvu+sbUhXFblVummAS//dJK0fym+6D/9hwOSXBY=;
 b=Co2JCVu9ZasoQYKAokKeyijT2fo0+JF0RBYDHblV6BBRg4GTdrkTZg/xemWKdITbJ0JcRy
 98ynzNm6pbfRqr2R7BpN2O0DL6sjsvrITF9PPpcGFm8sdRtRjEZ1Frs2TnXYAMh4CJE0IZ
 j5NGS+KL/Y4Ufrm62PgCOlYBgW3f5RM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-Z0P1H38LMW2QqBtyHDUoMg-1; Tue, 27 Oct 2020 17:22:14 -0400
X-MC-Unique: Z0P1H38LMW2QqBtyHDUoMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1A248049E0;
 Tue, 27 Oct 2020 21:22:13 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF4EA5B4A3;
 Tue, 27 Oct 2020 21:22:09 +0000 (UTC)
Subject: Re: [PATCH 1/9] qapi: replace List[str] by IfCond
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
 <20201015165255.1573897-2-marcandre.lureau@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b669f195-9440-16d7-5b41-c082f4cac9bb@redhat.com>
Date: Tue, 27 Oct 2020 17:22:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015165255.1573897-2-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 12:52 PM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Wrap the 'if' condition in a higher-level object. Not only this is
> allows more type safety but also further refactoring without too much
> chrun. The following patches will extend the syntax of 'if' and will
> have some extra handling and types.
> 

Probably a good idea. Thanks for basing it on Pt6; I'll try to push 
ahead as fast as I can -- though there are some more aggressive cleanups 
in error, expr, and parser that we haven't discussed on list yet much 
and are quite prone to change.

Let me know if you have any comments or feedbacks regarding what you 
found there!

Pts 2 (introspect.py) and 3 (expr.py) are recently re-sent to list, if 
you have specific critique in those areas.

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   docs/sphinx/qapidoc.py     |  2 +-
>   scripts/qapi/commands.py   |  4 +-
>   scripts/qapi/common.py     | 26 ++++++++---
>   scripts/qapi/events.py     |  4 +-
>   scripts/qapi/gen.py        |  9 ++--
>   scripts/qapi/introspect.py | 21 ++++-----
>   scripts/qapi/schema.py     | 91 ++++++++++++++++++++------------------
>   scripts/qapi/types.py      | 11 ++---
>   scripts/qapi/visit.py      |  9 ++--
>   9 files changed, 102 insertions(+), 75 deletions(-)
> 
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 11e97839de..db9520f37f 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -116,7 +116,7 @@ class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
>           the conditions are in literal-text and the commas are not.
>           If with_if is False, we don't return the "(If: " and ")".
>           """
> -        condlist = intersperse([nodes.literal('', c) for c in ifcond],
> +        condlist = intersperse([nodes.literal('', c) for c in ifcond.ifcond],
>                                  nodes.Text(', '))
>           if not with_if:
>               return condlist
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index 50978090b4..03deac5fdd 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -20,7 +20,7 @@ from typing import (
>       Set,
>   )
>   
> -from .common import c_name, mcgen
> +from .common import IfCond, c_name, mcgen
>   from .gen import (
>       QAPIGenC,
>       QAPIGenCCode,
> @@ -301,7 +301,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>       def visit_command(self,
>                         name: str,
>                         info: QAPISourceInfo,
> -                      ifcond: List[str],
> +                      ifcond: IfCond,
>                         features: List[QAPISchemaFeature],
>                         arg_type: Optional[QAPISchemaObjectType],
>                         ret_type: Optional[QAPISchemaType],
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 11b86beeab..59e6a400da 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -12,7 +12,7 @@
>   # See the COPYING file in the top-level directory.
>   
>   import re
> -from typing import Optional, Sequence
> +from typing import Optional, Sequence, Union
>   
>   
>   #: Magic string that gets removed along with all space to its right.
> @@ -194,18 +194,34 @@ def guardend(name: str) -> str:
>                    name=c_fname(name).upper())
>   
>   
> -def gen_if(ifcond: Sequence[str]) -> str:
> +class IfCond:
> +    def __init__(self, ifcond: Optional[Sequence[str]] = None):
> +        self.ifcond = ifcond or []
> +
> +    def __bool__(self) -> bool:
> +        return bool(self.ifcond)
> +
> +    def __repr__(self) -> str:
> +        return repr(self.ifcond)
> +
> +    def __eq__(self, other: object) -> bool:
> +        if not isinstance(other, IfCond):
> +            return NotImplemented
> +        return self.ifcond == other.ifcond
> +

Haven't looked ahead yet, forgive me if this is a bad idea:

worth adding an __iter__ method here so that callers don't have to call 
"for x in ifcond.ifcond" ?

Maybe you refactor such that this is becomes pointless.

Also; should we create an Ifcond object in schema.py instead in common, 
as it's a generic representation of the #if conditionals, less tied to 
the C generation?


[...]



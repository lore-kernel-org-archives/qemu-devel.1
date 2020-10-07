Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480DEC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A8620789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hy2iX3cU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A8620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ95e-00088R-56
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ93Q-0006wu-P2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ93N-0001OO-Tc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602075618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5N44qcyv90fDygsIhmARljod4dX7CrsBgdZJkPMvplU=;
 b=hy2iX3cUjUO3Sit9fxrVpKaSPjPNDjUAU8IbDooxo0/smjT6xOq8kjqOUeyO1fQdo0UVZO
 YE4lnupRxBD4iPQQphaYXmNwT9C7+hBJJdm/UjbY5C3TD0RiBjyyVggtLH2IFjMqjqYV9D
 Ai5JP7NhgdH0rANkAOZFgDxvOL/dJnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-3JhsiduePe6FxNuVi7KC2g-1; Wed, 07 Oct 2020 09:00:15 -0400
X-MC-Unique: 3JhsiduePe6FxNuVi7KC2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1935C1029D59
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 13:00:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE3F15D9DD;
 Wed,  7 Oct 2020 13:00:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 15F9A11329C1; Wed,  7 Oct 2020 15:00:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 36/36] qapi/visit.py: add type hint annotations
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-37-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 15:00:11 +0200
In-Reply-To: <20201005195158.2348217-37-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:58 -0400")
Message-ID: <87sgaq9oo4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> Annotations do not change runtime behavior.
> This commit *only* adds annotations.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi/mypy.ini |  5 ---
>  scripts/qapi/visit.py | 73 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 56 insertions(+), 22 deletions(-)
>
> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> index 83f19813553..74fc6c82153 100644
> --- a/scripts/qapi/mypy.ini
> +++ b/scripts/qapi/mypy.ini
> @@ -28,8 +28,3 @@ check_untyped_defs = False
>  disallow_untyped_defs = False
>  disallow_incomplete_defs = False
>  check_untyped_defs = False
> -
> -[mypy-qapi.visit]
> -disallow_untyped_defs = False
> -disallow_incomplete_defs = False
> -check_untyped_defs = False
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index e54694e23db..14d4f0b261f 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -13,6 +13,8 @@
>  See the COPYING file in the top-level directory.
>  """
>  
> +from typing import List, Optional
> +
>  from .common import (
>      c_enum_const,
>      c_name,
> @@ -22,10 +24,20 @@
>      mcgen,
>  )
>  from .gen import QAPISchemaModularCVisitor, ifcontext
> -from .schema import QAPISchemaEnumType, QAPISchemaObjectType
> +from .schema import (
> +    QAPISchema,
> +    QAPISchemaEnumMember,
> +    QAPISchemaEnumType,
> +    QAPISchemaFeature,
> +    QAPISchemaObjectType,
> +    QAPISchemaObjectTypeMember,
> +    QAPISchemaType,
> +    QAPISchemaVariants,
> +)
> +from .source import QAPISourceInfo
>  
>  
> -def gen_visit_decl(name, scalar=False):
> +def gen_visit_decl(name: str, scalar: bool = False) -> str:

More abuse of review to learn: even through we initialize with False, we
still need the type hint?

>      c_type = c_name(name) + ' *'
>      if not scalar:
>          c_type += '*'
[...]



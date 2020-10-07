Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625AAC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C4E20789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRkMYcyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C4E20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8mq-0001Sl-EG
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ8lz-00011r-4o
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ8lv-0007iZ-F8
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602074537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ridR/h3jd7a35kOipTeOt+KYoeFg57n/+AY/BUe77rI=;
 b=CRkMYcybIvGyuaqExoEIukrCqRiCGjmvQXZoHxW1BKWNccDNIS7+mrMoQuJJ8nR4j1S/DB
 SVjGRH9Zsnjm+yg5y9dmYwZufO2iwtcHWzqRpjFyvZvCMa1CAjJqmwIZgchWwaHUK+jTVc
 nnO7+64ktij802LUQNMcm1FWHMXwMHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-nCTlkGk8Nt6fAbWVvhBSTQ-1; Wed, 07 Oct 2020 08:42:03 -0400
X-MC-Unique: nCTlkGk8Nt6fAbWVvhBSTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B50608030D0
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 12:42:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8538160E1C;
 Wed,  7 Oct 2020 12:42:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D76B211329C1; Wed,  7 Oct 2020 14:42:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 33/36] qapi/types.py: remove one-letter variables
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-34-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 14:42:00 +0200
In-Reply-To: <20201005195158.2348217-34-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:55 -0400")
Message-ID: <87r1qab42v.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

> "John, if pylint told you to jump off a bridge, would you?"
> Hey, if it looked like fun, I might.
>
> Now that this file is clean, enable pylint checks on this file.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi/pylintrc |  1 -
>  scripts/qapi/types.py | 29 +++++++++++++++--------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
> index 8badcb11cda..b3c4cf46dbf 100644
> --- a/scripts/qapi/pylintrc
> +++ b/scripts/qapi/pylintrc
> @@ -6,7 +6,6 @@ ignore-patterns=error.py,
>                  expr.py,
>                  parser.py,
>                  schema.py,
> -                types.py,
>                  visit.py,
>  
>  
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index 766822feb3a..9d1e79d503d 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -49,14 +49,14 @@ def gen_enum_lookup(name: str,
>      .array = (const char *const[]) {
>  ''',
>                  c_name=c_name(name))
> -    for m in members:
> -        ret += gen_if(m.ifcond)
> -        index = c_enum_const(name, m.name, prefix)
> +    for member in members:

Let's use @memb.  It's more visually distinct from @members, and
gen_struct_members() already uses it.

> +        ret += gen_if(member.ifcond)
> +        index = c_enum_const(name, member.name, prefix)
>          ret += mcgen('''
>          [%(index)s] = "%(name)s",
>  ''',
> -                     index=index, name=m.name)
> -        ret += gen_endif(m.ifcond)
> +                     index=index, name=member.name)
> +        ret += gen_endif(member.ifcond)
>  
>      ret += mcgen('''
>      },
> @@ -79,13 +79,13 @@ def gen_enum(name: str,
>  ''',
>                  c_name=c_name(name))
>  
> -    for m in enum_members:
> -        ret += gen_if(m.ifcond)
> +    for member in enum_members:
> +        ret += gen_if(member.ifcond)
>          ret += mcgen('''
>      %(c_enum)s,
>  ''',
> -                     c_enum=c_enum_const(name, m.name, prefix))
> -        ret += gen_endif(m.ifcond)
> +                     c_enum=c_enum_const(name, member.name, prefix))
> +        ret += gen_endif(member.ifcond)
>  
>      ret += mcgen('''
>  } %(c_name)s;
> @@ -148,11 +148,12 @@ def gen_object(name: str, ifcond: List[str],
>      objects_seen.add(name)
>  
>      ret = ''
> -    if variants:
> -        for v in variants.variants:
> -            if isinstance(v.type, QAPISchemaObjectType):
> -                ret += gen_object(v.type.name, v.type.ifcond, v.type.base,
> -                                  v.type.local_members, v.type.variants)
> +    for variant in variants.variants if variants else ():

Let's use @var, for consistency with gen_variants().

> +        obj = variant.type
> +        if not isinstance(obj, QAPISchemaObjectType):
> +            continue
> +        ret += gen_object(obj.name, obj.ifcond, obj.base,
> +                          obj.local_members, obj.variants)
>  
>      ret += mcgen('''



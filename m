Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A02FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430232073C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb+O0X4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430232073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icGts-0006JD-6S
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 17:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icGjf-0001FT-4Q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icGjb-0002VI-NQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:33:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30401
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icGja-0002KG-0u
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575412403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b20WeRXM7Jp/KM12IcdxyevGaUj2UlSo3qzmwyF+85o=;
 b=fb+O0X4DHdIcxGRs7z+qhJ5y7FnLHEnc0p2M0HphmdTzHrEIrOCWX0V97Ok1TBijLhMYnp
 3SSeUreyq7nTp0jQQUaiTh6orn609pXpshFA0E99bRAJh9nPYSMOkZd7B7NTrdApTTh+Lf
 urMWo9mXkUB/j/29ySh1D3qb32iCgxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-1BgQdtTpMdmx4GPNhZ9QCg-1; Tue, 03 Dec 2019 17:33:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE7391856A82;
 Tue,  3 Dec 2019 22:33:18 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDD736B8CD;
 Tue,  3 Dec 2019 22:33:15 +0000 (UTC)
Subject: Re: [PATCH 7/6] Makefile: Make Makefile depend on generated qga
 files, too
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191120182551.23795-1-armbru@redhat.com>
 <20191129095927.17382-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <45cff400-7e88-cefe-560e-7642d2ea1d00@redhat.com>
Date: Tue, 3 Dec 2019 16:33:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129095927.17382-1-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1BgQdtTpMdmx4GPNhZ9QCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/29/19 3:59 AM, Markus Armbruster wrote:
> Generated .h need to be generated before compiling any .c using them.
> To know which .h a .c uses, we need to compile it.
> 
> Since commit 4115852bb0 "build: do not sprinkle around
> GENERATED_HEADERS dependencies", we break this circular dependency the
> simple & stupid way: the generated headers are a prerequisite of
> Makefile, which causes Make to generate them first, then start over.

which is a pain when using 'make --dry-run' to see what would get built 
(a dependency of Makefile _is_ rebuilt if Makefile itself has to be 
updated), but not the fault of this patch.

> 
> Except for qga we still use the older method of making all its .o
> summarily depend on all its generated .h (commit 016c77ad62 "Makefile:
> add missing deps on $(GENERATED_HEADERS)").
> 
> Add qga's generated files to generated-files-y to get rid of this
> exception.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   Makefile | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


> +++ b/Makefile
> @@ -130,6 +130,15 @@ GENERATED_QAPI_FILES += qapi/qapi-doc.texi
>   
>   generated-files-y += $(GENERATED_QAPI_FILES)
>   
> +GENERATED_QGA_FILES := qga-qapi-types.c qga-qapi-types.h
> +GENERATED_QGA_FILES += qga-qapi-visit.c qga-qapi-visit.h
> +GENERATED_QGA_FILES += qga-qapi-commands.h qga-qapi-commands.c
> +GENERATED_QGA_FILES += qga-qapi-init-commands.h qga-qapi-init-commands.c
> +GENERATED_QGA_FILES += qga-qapi-doc.texi
> +GENERATED_QGA_FILES := $(addprefix qga/qapi-generated/, $(GENERATED_QGA_FILES))

Would it be worth using two separate variable names (maybe 
GENERATED_QGA_BASEFILES for the first list) rather than exploiting the 
arcane knowledge that consecutive use of := causes GNU make to rewrite 
an existing variable with new contents?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



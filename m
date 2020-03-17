Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5560DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227A620714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFhFHeZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227A620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIrX-0003C6-7e
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEIqV-0002c7-3o
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEIqT-0002vB-Ao
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:29:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEIqQ-0002s0-UD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584476986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fql/aSsYoPJE+3XBg9d3K3lHv5LukSkUA7LnoVpal/E=;
 b=hFhFHeZ56q9gixwzZ+45XGYMdFh49vq8c3TtbiuIv9KEqyEsbHbEFcv2M3eYIXOR1oHL0F
 T3pUa3ROgDuDYJOsWFhrnwEo1K/3EpWnIFWjPHJPIZ2tbaSxGXmBxdsLqCWVurK0YetZ8R
 3CERJOxeXM63K71JrcA79K0sdB02/aQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-6sj3JSZBMfOLIhlB4yIH_w-1; Tue, 17 Mar 2020 16:29:44 -0400
X-MC-Unique: 6sj3JSZBMfOLIhlB4yIH_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7850C8017CC;
 Tue, 17 Mar 2020 20:29:43 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC2EF19C4F;
 Tue, 17 Mar 2020 20:29:42 +0000 (UTC)
Subject: Re: [PATCH v4 24/34] qapi: Replace qmp_dispatch()'s TODO comment by
 an explanation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200317115459.31821-25-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f1ea0df3-0d0f-6878-38bc-3b8753a78d48@redhat.com>
Date: Tue, 17 Mar 2020 15:29:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317115459.31821-25-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 6:54 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/qmp-dispatch.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 91e50fa0dd..44fc368d61 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -162,7 +162,11 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
>           g_assert(!ret);
>           return NULL;
>       } else if (!ret) {
> -        /* TODO turn into assertion */
> +        /*
> +         * When the command's schema has no 'returns', cmd->fn()
> +         * leaves @ret null.  The QMP spec calls for an empty object
> +         * then; supply it.
> +         */
>           ret = QOBJECT(qdict_new());
>       }

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



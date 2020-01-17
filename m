Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F8C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D46C206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBW9OaN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D46C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSZf-0003NS-GZ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1isSYj-0002jG-GU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1isSYh-0004yG-JN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:25:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1isSYh-0004xZ-Fc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579271110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yNx0ZTf2K3z2aWImeXwFN8gQ+h7JLlcAwfIVJBV19w=;
 b=UBW9OaN+G3F+eDJPFbTNeJ35j6t3F2wi26CndU/cXMG+kpdp9DPBoCSjAWTB6oHrr7IKS0
 MjFcBuv72z4GPrQkhpdv4BacDqIQFoab3SxUkg69OSewOugeGMXB03WOacx0WhJDo8mS3a
 VuCk2iERF+GD1bDs5PMQbT1AgV0ykho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-UWirfdaMNpKL8xt8P9glKg-1; Fri, 17 Jan 2020 09:25:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60FBA800591;
 Fri, 17 Jan 2020 14:25:04 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1AB56609E;
 Fri, 17 Jan 2020 14:24:55 +0000 (UTC)
Subject: Re: [PATCH v6 03/11] scripts: add coccinelle script to use auto
 propagated errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200110194158.14190-1-vsementsov@virtuozzo.com>
 <20200110194158.14190-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4e41cb43-4efb-9cc9-c685-d25e4ddf8fbb@redhat.com>
Date: Fri, 17 Jan 2020 08:24:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110194158.14190-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UWirfdaMNpKL8xt8P9glKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 1:41 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Rather light on the commit message. If nothing else, a comment about 
typical command-line usage would be helpful (yes, it's in the patch 
body, but sometimes I just refer to git log).

> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 532b9afb9e..dcfb77e107 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -141,6 +141,9 @@
>    *         ...
>    *     }
>    *
> + * For mass conversion use script
> + *   scripts/coccinelle/auto-propagated-errp.cocci
> + *
>    *
>    * Receive and accumulate multiple errors (first one wins):
>    *     Error *err = NULL, *local_err = NULL;
> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coccinelle/auto-propagated-errp.cocci
> new file mode 100644
> index 0000000000..6c72a5049f
> --- /dev/null
> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
> @@ -0,0 +1,139 @@
> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
> +//

> +// Usage example:
> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
> +//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
> +//  blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc]
> +
> +@@
> +// Add invocation to errp-functions where necessary
> +// We should skip functions with "Error *const *errp"
> +// parameter, but how to do it with coccinelle?
> +// I don't know, so, I skip them by function name regex.
> +// It's safe: if we not skip some functions with

s/not/did not/

> +// "Error *const *errp", ERRP_AUTO_PROPAGATE invocation
> +// will fail to compile, because of const violation.
> +identifier fn !~ "error_append_.*_hint";
> +identifier local_err, errp;
> +@@
> +
> + fn(..., Error **errp, ...)
> + {
> ++   ERRP_AUTO_PROPAGATE();
> +    <+...
> +        when != ERRP_AUTO_PROPAGATE();
> +(
> +    error_append_hint(errp, ...);
> +|
> +    error_prepend(errp, ...);
> +|
> +    Error *local_err = NULL;
> +)
> +    ...+>
> + }
> +

Looks like it should catch all functions that require adding the macro.

> +@rule1@
> +// We do not inherit from previous rule, as we want to match
> +// also functions, which already had ERRP_AUTO_PROPAGATE
> +// invocation.

Grammar suggestion:

// We want to patch error propagation in functions regardless of
// whether the function already uses ERRP_AUTO_PROPAGATE, hence
// this one does not inherit from the first rule.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


